require 'date'
require 'csv'

# CLASSES

class Doctor
    attr_reader :rate_multiplier, :grade_hourly_rate, :employer_name
    
    def initialize(attributes = {})
        @id = attributes[:id]
        @grade_title = attributes[:grade_title]
        @grade_hourly_rate = attributes[:grade_hourly_rate]
        @employer_name = attributes[:employer_name]
        @employer_type = attributes[:employer_type]
        @rate_multiplier = attributes[:rate_multiplier]
    end
end

class Department
    attr_reader :rate_multiplier, :name

    def initialize(attributes = {})
        @id = attributes[:id]
        @name = attributes[:name]
        @rate_multiplier = attributes[:rate_multiplier] || 1
    end
end

class Shift
    attr_accessor :id
    attr_reader :start_datetime, :end_datetime, :total_hours, :rate_multiplier, :total_payment, :doctor, :department

    def initialize(attributes = {})
        @id = attributes[:id]
        @start_datetime = attributes[:start_datetime]
        @end_datetime = attributes[:end_datetime]
        
        @department = attributes[:department]
        @doctor = attributes[:doctor]


        @total_hours = set_total_hours
        @rate_multiplier = set_rate_multiplier
        @total_payment = set_total_payment
    end

    private

    def set_total_hours
        ((@end_datetime - @start_datetime) * 24).to_f
    end

    def set_rate_multiplier
        @doctor.rate_multiplier * @department.rate_multiplier
    end

    def set_total_payment
        @doctor.grade_hourly_rate * @total_hours * @rate_multiplier
    end
end

class ShiftRepository
    def initialize
        @shifts = []
        @next_id = 1
    end

    def create(shift)
        shift.id = @next_id
        @shifts << shift
        @next_id += 1
    end

    def export_csv
        CSV.open('shifts.csv', 'wb') do |csv|
            csv << ['shift_id', 'start_date', 'start_time', 'end_date', 'end_time', 'total_hours', 'rate_paid_at', 'total_payment', 'employer_name', 'department_name' ]
            @shifts.each do |shift|
                csv << [shift.id, shift.start_datetime.strftime("%d/%m/%Y"), shift.start_datetime.strftime("%H:%M"), shift.end_datetime.strftime("%d/%m/%Y"), shift.end_datetime.strftime("%H:%M"), shift.total_hours, shift.rate_multiplier.round(2), shift.total_payment, shift.doctor.employer_name, shift.department.name]
            end
        end
    end
end

doctor = Doctor.new({
    id: 1,
    grade_title: 'GP',
    grade_hourly_rate: 45,
    employer_name: 'MWF Agency',
    employer_type: 'agency',
    rate_multiplier: 1.3,
    })
    
department = Department.new({
    id: 1,
    name: 'Accident and Emergency',
    rate_multiplier: 1.5,
    })

shift = Shift.new({
    id: 1,
    start_datetime: DateTime.new(2018,10,17,9),
    end_datetime: DateTime.new(2018,10,17,15),
    department: department,
    doctor: doctor,
    })

shift2 = Shift.new({
    id: 1,
    start_datetime: DateTime.new(2018,10,17,9),
    end_datetime: DateTime.new(2018,10,17,15),
    department: department,
    doctor: doctor,
    })
    

shift_repository = ShiftRepository.new
shift_repository.create(shift)
shift_repository.create(shift2)
shift_repository.export_csv



# p doctor
# p '- - -'
# p department
# p '- - -'
# p shift
# p '- - -'
# p shift_repository
        
        

        

# # INSTANTIATIONS

# # SHIFTS

# # All shifts start on 17/10/2018

# # Shift 1
# # Shift 1: 09:00 -> 15:00
# # “General Medicine” department and has no extra multiplier

# # Shift 2
# # Shift 2: 20:00 -> 08:00
# # “Accident and Emergency” department and pays the enhanced rate multiplier of 1.5

