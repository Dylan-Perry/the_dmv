class Facility
  attr_accessor :name, :address, :phone, :services, :registered_vehicles, :collected_fees, :hours, :closed_holidays

  def initialize(facility_values)
    @name = facility_values[:name]
    @address = facility_values[:address]
    @phone = facility_values[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
    @hours = nil
    @closed_holidays = nil
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if @services.include?("Vehicle Registration")
      @registered_vehicles << vehicle
      if vehicle.antique?
        @collected_fees += 25
        vehicle.plate_type = :antique
      elsif vehicle.electric_vehicle?
        @collected_fees += 200
        vehicle.plate_type = :ev
      else
        @collected_fees += 100
        vehicle.plate_type = :regular
      end
    else
      "Error: #{name} does not offer Vehicle Registration services."
    end
  end

  def administer_written_test(registrant)
    if @services.include?("New Drivers License")
      if !registrant.permit? || registrant.age < 16
        "Error: Written tests can only be administered to registrants with a permit, and who are at least 16 years of age."
      else
        registrant.license_data[:written] = true
      end
    else
      "Error: #{@name} does not offer Written Test services."
    end
  end

  def administer_road_test(registrant)
    if @services.include?("New Drivers License")
      if !registrant.license_data[:written]
        "Error: Road tests can only be administered to registrants who have passed a written test."
      else
        registrant.license_data[:license] = true
      end
    else
      "Error: #{@name} does not offer Road Test services."
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?("Renew Drivers License")
      if !registrant.license_data[:license]
        "Error: Registrant does not have a license to renew."
      else
        registrant.license_data[:renewed] = true
      end
    else
      "Error: #{@name} does not offer License Renewal services."
    end
  end
end
