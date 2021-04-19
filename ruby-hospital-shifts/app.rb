# CLASSES

# Opted to create a shared Doctor class rather than separate PermanentDoctor and AgencyDoctor
# classes inheriting from a Doctor class. I imagine you might want to use the same Doctor
# instance for all of a doctor's data regardless of whether they're working as a locum or
# permanently at any given time.

class Doctor
    def initialize(attributes = {})
        @id = attributes[:id]
        @grade_title = attributes[:grade_title]
        @grade_hourly_rate = attributes[:grade_hourly_rate]
        @employer_name = attributes[:employer_name]
        @employer_type = attributes[:employer_type]
        @rate_multiplier = set_rate_multiplier
    end

    private

    def set_rate_multiplier
        @employer_type == 'agency' ? 1.5 : 1
    end
end

class Department
    def initialize(attributes = {})
        @id = attributes[:id]
        @name = attributes[:name]
        @rate_multiplier = attributes[:rate_multiplier] || 1
    end
end


class Shift
    def initialize(attributes = {})
        @id = attributes[:id]
        @start_date = attributes[:start_date]
        @start_time = attributes[:start_time]
        @end_date = attributes[:end_date]
        @end_time = attributes[:end_time]
        
        @department = attributes[:department]
        @doctor = attributes[:doctor]


        @total_hours = set_total_hours
        @rate_multipier = set_rate_multiplier
        @total_payment = set_total_payment

    end

    private

    def set_total_hours
    
        # set total hours from dates and times
    
    end

    def set_rate_multiplier

        # Calculate rate_multipier from Department and Doctor rate multipliers

    end

    def set_total_payment

        # Calculate total payment from hourly_rate and rate_multiplier

    end
end











doctor = Doctor.new({
    id: 1,
    grade_title: 'GP',
    grade_hourly_rate: 45,
    employer_name: 'MWF Agency',
    employer_type: 'agency',
    rate_multiplier: 1,
    })
    
department = Department.new({
    id: 1,
    name: 'General Medicine',
    rate_multiplier: 1.5,
    })
    
    p doctor
    p department
    
        
        
# class ShiftRepository
#     # @shifts = []

#     # Private save_csv method
# end

        
        

        

# # INSTANTIATIONS

# # SHIFTS

# # All shifts start on 17/10/2018

# # Shift 1
# # Shift 1: 09:00 -> 15:00
# # “General Medicine” department and has no extra multiplier

# # Shift 2
# # Shift 2: 20:00 -> 08:00
# # “Accident and Emergency” department and pays the enhanced rate multiplier of 1.5

