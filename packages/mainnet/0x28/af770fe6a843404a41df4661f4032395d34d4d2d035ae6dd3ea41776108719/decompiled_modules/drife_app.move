module 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::drife_app {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AppStorage has key {
        id: 0x2::object::UID,
        registered_riders: 0x2::table::Table<address, bool>,
        registered_drivers: 0x2::table::Table<address, bool>,
        registered_countries: 0x2::table::Table<0x1::string::String, bool>,
        registered_cities: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct VehicleCategory has store {
        name: 0x1::string::String,
        deprecation_flag: bool,
        minimum_fare: u64,
        base_fare: u64,
        distance_fare: u64,
        time_fare: u64,
        waiting_charge: u64,
        destination_change_charge: u64,
    }

    struct CityConfig has store, key {
        id: 0x2::object::UID,
        city_code: 0x1::string::String,
        num_vehicle_category: u8,
        vehicle_category_info: 0x2::table::Table<u8, VehicleCategory>,
        rides: 0x2::table::Table<0x2::object::ID, address>,
        min_distance: u64,
        cancellation_fee: u64,
        tax: u64,
        base_waiting_time: u64,
        deprecation_flag: bool,
    }

    struct CountryConfig has store, key {
        id: 0x2::object::UID,
        country_name: 0x1::string::String,
        cities: vector<0x2::object::ID>,
        deprecation_flag: bool,
    }

    struct Rider has key {
        id: 0x2::object::UID,
        rider_address: address,
        latest_ride: 0x1::option::Option<0x2::object::ID>,
        nonce: u64,
    }

    struct Driver has key {
        id: 0x2::object::UID,
        driver_address: address,
        latest_ride: 0x1::option::Option<0x2::object::ID>,
    }

    struct Ride has store, key {
        id: 0x2::object::UID,
        state: u16,
        rider: address,
        estimated_distance: u64,
        estimated_time: u64,
        fare: 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare,
        vehicle_category: u8,
        counter_quotes: vector<CounterQuote>,
        driver: 0x1::option::Option<address>,
        stop_durations: vector<u64>,
        stop: Stop,
        next_stop: u64,
        base_waiting_time: u64,
        final_distance: u64,
        final_time: u64,
    }

    struct CounterQuote has copy, drop, store {
        percent: vector<u8>,
        driver: address,
    }

    struct Stop has copy, drop, store {
        stop_started: u64,
        stop_ended: u64,
    }

    struct RideCreated has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
        timestamp: u64,
    }

    struct RideStarted has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
        driver: address,
        timestamp: u64,
    }

    struct RideCancelled has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
        driver: 0x1::option::Option<address>,
        timestamp: u64,
    }

    struct RideCompleted has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
        driver: address,
        timestamp: u64,
    }

    struct CounterQuoteAdded has copy, drop {
        ride_id: 0x2::object::ID,
        driver: address,
        percent: vector<u8>,
        timestamp: u64,
    }

    struct RiderRegistered has copy, drop {
        rider: address,
    }

    struct DriverRegistered has copy, drop {
        driver: address,
    }

    struct StopRequested has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
    }

    struct ResumeStopRequested has copy, drop {
        ride_id: 0x2::object::ID,
        rider: address,
    }

    public fun add_city_config(arg0: &AdminCap, arg1: &mut AppStorage, arg2: &mut CountryConfig, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.registered_cities, arg3), 48);
        let v0 = CityConfig{
            id                    : 0x2::object::new(arg8),
            city_code             : arg3,
            num_vehicle_category  : 0,
            vehicle_category_info : 0x2::table::new<u8, VehicleCategory>(arg8),
            rides                 : 0x2::table::new<0x2::object::ID, address>(arg8),
            min_distance          : arg4,
            cancellation_fee      : arg5,
            tax                   : arg6,
            base_waiting_time     : arg7,
            deprecation_flag      : false,
        };
        0x2::table::add<0x1::string::String, bool>(&mut arg1.registered_cities, arg3, false);
        0x1::vector::push_back<0x2::object::ID>(&mut arg2.cities, 0x2::object::id<CityConfig>(&v0));
        0x2::transfer::share_object<CityConfig>(v0);
    }

    public fun add_country(arg0: &AdminCap, arg1: &mut AppStorage, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.registered_countries, arg2), 68);
        let v0 = CountryConfig{
            id               : 0x2::object::new(arg3),
            country_name     : arg2,
            cities           : 0x1::vector::empty<0x2::object::ID>(),
            deprecation_flag : false,
        };
        0x2::table::add<0x1::string::String, bool>(&mut arg1.registered_countries, arg2, false);
        0x2::transfer::share_object<CountryConfig>(v0);
    }

    public fun add_stop(arg0: &mut Rider, arg1: &mut Ride, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg6)), 67);
        let v0 = arg1.state == 6 || arg1.state == 13 || arg1.state == 14 || arg1.state == 15;
        assert!(!v0, 17);
        assert!(arg0.rider_address == arg1.rider, 3);
        assert!(0x1::vector::length<u64>(&arg1.stop_durations) < 5, 7);
        let v1 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v2 = 0x1::string::utf8(b"AddStop");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        arg0.nonce = arg0.nonce + 1;
        let v3 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg5, &v3, &v1), 35);
        0x1::vector::push_back<u64>(&mut arg1.stop_durations, arg2);
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::estimate_fare(&mut arg1.fare, arg1.estimated_distance, arg1.estimated_time, arg3, arg4, get_ride_stops_waiting_time(arg1.stop_durations, 0x1::vector::length<u64>(&arg1.stop_durations), arg1.base_waiting_time));
    }

    public fun add_vehicle_category_info(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u8, arg3: 0x1::string::String, arg4: vector<u64>) {
        assert!(!0x2::table::contains<u8, VehicleCategory>(&arg1.vehicle_category_info, arg2), 2);
        if (0x2::table::is_empty<u8, VehicleCategory>(&arg1.vehicle_category_info)) {
            assert!(arg2 == 0, 65);
        };
        if (arg2 > 0) {
            assert!(0x2::table::contains<u8, VehicleCategory>(&arg1.vehicle_category_info, arg2 - 1), 65);
        };
        assert!(0x1::vector::length<u64>(&arg4) == 6, 46);
        arg1.num_vehicle_category = arg1.num_vehicle_category + 1;
        let v0 = VehicleCategory{
            name                      : arg3,
            deprecation_flag          : false,
            minimum_fare              : *0x1::vector::borrow<u64>(&arg4, 0),
            base_fare                 : *0x1::vector::borrow<u64>(&arg4, 1),
            distance_fare             : *0x1::vector::borrow<u64>(&arg4, 2),
            time_fare                 : *0x1::vector::borrow<u64>(&arg4, 3),
            waiting_charge            : *0x1::vector::borrow<u64>(&arg4, 4),
            destination_change_charge : *0x1::vector::borrow<u64>(&arg4, 5),
        };
        0x2::table::add<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2, v0);
    }

    public fun admin_cancel_ride(arg0: &AdminCap, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) : u64 {
        assert!(arg1.state != 6, 6);
        assert!(arg1.state != 15, 6);
        assert!(arg1.state != 14, 6);
        assert!(arg1.state != 13, 6);
        let v0 = calculate_cancel_fee(arg1, arg3, arg4, 0, arg2);
        arg1.state = 15;
        let v1 = RideCancelled{
            ride_id   : 0x2::object::id<Ride>(arg1),
            rider     : arg1.rider,
            driver    : arg1.driver,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RideCancelled>(v1);
        v0
    }

    public fun admin_end_ride(arg0: &AdminCap, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        assert!(arg1.state != 15, 22);
        assert!(arg1.state != 14, 22);
        assert!(arg1.state != 13, 22);
        assert!(arg1.state != 6, 45);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        arg1.stop_durations = arg5;
        arg1.next_stop = 0x1::vector::length<u64>(&arg5);
        complete_ride(arg1, arg3, arg4, arg6, arg7, arg8, arg9, arg2);
    }

    fun calculate_cancel_fee(arg0: &mut Ride, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        if (arg0.state == 3 || arg0.state == 17) {
            v0 = 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::calculate_final_fare(&mut arg0.fare, arg1, arg2, get_ride_stops_waiting_time(arg0.stop_durations, arg0.next_stop, arg0.base_waiting_time), arg3);
        } else if (arg0.state == 4 || arg0.state == 18) {
            arg0.stop.stop_ended = 0x2::clock::timestamp_ms(arg4) / 60000;
            *0x1::vector::borrow_mut<u64>(&mut arg0.stop_durations, arg0.next_stop - 1) = arg0.stop.stop_ended - arg0.stop.stop_started;
            v0 = 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::calculate_final_fare(&mut arg0.fare, arg1, arg2, get_ride_stops_waiting_time(arg0.stop_durations, arg0.next_stop, arg0.base_waiting_time), arg3);
        };
        v0
    }

    public fun calculate_fares(arg0: &mut Rider, arg1: &mut CountryConfig, arg2: &CityConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) : vector<u64> {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg11)), 67);
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.cities, &v0), 69);
        assert!(0x1::vector::length<u64>(&arg9) <= 5, 23);
        let v1 = 0x2::bcs::to_bytes<address>(&arg0.rider_address);
        let v2 = 0x1::string::utf8(b"CalculateFare");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg2.city_code));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        let v3 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg10, &v3, &v1), 66);
        arg0.nonce = arg0.nonce + 1;
        let v4 = 0;
        while (v4 < 0x2::table::length<u8, VehicleCategory>(&arg2.vehicle_category_info)) {
            0x2::dynamic_field::remove_if_exists<u8, 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare>(&mut arg0.id, (v4 as u8));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0;
        while (v6 < arg2.num_vehicle_category) {
            if (0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).deprecation_flag == true) {
                v6 = v6 + 1;
                continue
            };
            let v7 = 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::mint(0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).name, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).base_fare, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).minimum_fare, arg2.min_distance, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).distance_fare, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).time_fare, 0, 0, 0, 0, arg5, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).waiting_charge, 0x2::table::borrow<u8, VehicleCategory>(&arg2.vehicle_category_info, v6).destination_change_charge, 0, arg2.tax, arg6, arg7, arg8);
            0x2::dynamic_field::add<u8, 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare>(&mut arg0.id, v6, v7);
            0x1::vector::push_back<u64>(&mut v5, 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::estimate_fare(&mut v7, arg3, arg4, 0, 0, get_ride_stops_waiting_time(arg9, 0x1::vector::length<u64>(&arg9), arg2.base_waiting_time)));
            v6 = v6 + 1;
        };
        v5
    }

    public fun change_destination(arg0: &mut Rider, arg1: &mut Ride, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg7)), 67);
        assert!(arg0.rider_address == arg1.rider, 3);
        assert!(arg1.state != 6, 6);
        assert!(arg1.state != 15, 6);
        assert!(arg1.state != 14, 6);
        assert!(arg1.state != 13, 6);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"ChangeDestination");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        arg0.nonce = arg0.nonce + 1;
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg6, &v2, &v0), 40);
        if (arg1.state == 3 || arg1.state == 17 || arg1.state == 4 || arg1.state == 18) {
            0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::apply_destination_change_charge(&mut arg1.fare);
        };
        arg1.estimated_distance = arg2;
        arg1.estimated_time = arg3;
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::estimate_fare(&mut arg1.fare, arg1.estimated_distance, arg1.estimated_time, arg4, arg5, get_ride_stops_waiting_time(arg1.stop_durations, 0x1::vector::length<u64>(&arg1.stop_durations), arg1.base_waiting_time));
    }

    public fun check_app_storage_contains_driver(arg0: &AppStorage, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.registered_drivers, arg1)
    }

    public fun check_app_storage_contains_rider(arg0: &AppStorage, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.registered_riders, arg1)
    }

    fun check_counter_quoted(arg0: address, arg1: vector<CounterQuote>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<CounterQuote>(&arg1)) {
            let v1 = *0x1::vector::borrow<CounterQuote>(&arg1, v0);
            if (v1.driver == arg0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun choose_ride(arg0: &mut Rider, arg1: &mut Ride, arg2: u64, arg3: u64, arg4: bool, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg6)), 67);
        assert!(arg1.state == 1, 19);
        assert!(arg0.rider_address == arg1.rider, 3);
        assert!(arg2 < 0x1::vector::length<CounterQuote>(&arg1.counter_quotes), 52);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"ChooseRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg4));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg5, &v2, &v0), 37);
        let v3 = *0x1::vector::borrow<CounterQuote>(&arg1.counter_quotes, arg2);
        let v4 = 0x2::bcs::to_bytes<address>(&v3.driver);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<bool>(&arg4));
        assert!(v3.percent == 0x1::hash::sha3_256(v4), 13);
        arg1.driver = 0x1::option::some<address>(v3.driver);
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::set_chosen_boost(&mut arg1.fare, arg3);
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::set_chosen_boost_flag(&mut arg1.fare, arg4);
        arg1.state = 2;
    }

    fun complete_ride(arg0: &mut Ride, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        arg0.final_distance = arg1;
        arg0.final_time = arg2;
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::update_additional_charges(&mut arg0.fare, arg3, arg4, arg5, arg6);
        if (arg0.state == 4 || arg0.state == 18) {
            arg0.stop.stop_ended = 0x2::clock::timestamp_ms(arg7) / 60000;
            *0x1::vector::borrow_mut<u64>(&mut arg0.stop_durations, arg0.next_stop - 1) = arg0.stop.stop_ended - arg0.stop.stop_started;
        };
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::calculate_final_fare(&mut arg0.fare, arg1, arg2, get_ride_stops_waiting_time(arg0.stop_durations, arg0.next_stop, arg0.base_waiting_time), 0);
        arg0.state = 6;
        let v0 = RideCompleted{
            ride_id   : 0x2::object::id<Ride>(arg0),
            rider     : arg0.rider,
            driver    : *0x1::option::borrow<address>(&arg0.driver),
            timestamp : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<RideCompleted>(v0);
    }

    public fun counter_quote(arg0: &Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg5)), 67);
        assert!(arg1.state == 0 || arg1.state == 1, 10);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 51);
        assert!(check_counter_quoted(arg0.driver_address, arg1.counter_quotes) == false, 28);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"CounterQuote");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.driver_address));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg4, &v2, &v0), 61);
        let v3 = CounterQuote{
            percent : arg3,
            driver  : arg0.driver_address,
        };
        0x1::vector::push_back<CounterQuote>(&mut arg1.counter_quotes, v3);
        arg1.state = 1;
        let v4 = CounterQuoteAdded{
            ride_id   : 0x2::object::id<Ride>(arg1),
            driver    : arg0.driver_address,
            percent   : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CounterQuoteAdded>(v4);
    }

    public fun delete_driver(arg0: &AdminCap, arg1: &mut AppStorage, arg2: Driver) {
        assert!(0x2::table::contains<address, bool>(&arg1.registered_drivers, arg2.driver_address), 54);
        0x2::table::remove<address, bool>(&mut arg1.registered_drivers, arg2.driver_address);
        let Driver {
            id             : v0,
            driver_address : _,
            latest_ride    : _,
        } = arg2;
        0x2::object::delete(v0);
    }

    public fun delete_rider(arg0: &AdminCap, arg1: &mut AppStorage, arg2: Rider) {
        assert!(0x2::table::contains<address, bool>(&arg1.registered_riders, arg2.rider_address), 53);
        0x2::table::remove<address, bool>(&mut arg1.registered_riders, arg2.rider_address);
        let Rider {
            id            : v0,
            rider_address : _,
            latest_ride   : _,
            nonce         : _,
        } = arg2;
        0x2::object::delete(v0);
    }

    public fun deprecate_city_config(arg0: &AdminCap, arg1: &mut AppStorage, arg2: &mut CountryConfig, arg3: &mut CityConfig) {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.registered_countries, arg2.country_name), 70);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.registered_cities, arg3.city_code), 69);
        0x2::table::remove<0x1::string::String, bool>(&mut arg1.registered_cities, arg3.city_code);
        arg3.deprecation_flag = true;
    }

    public fun deprecate_vehicle_category(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u8) {
        assert!(!0x2::table::contains<u8, VehicleCategory>(&arg1.vehicle_category_info, arg2), 2);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).deprecation_flag = true;
    }

    public fun driver_arrived(arg0: &Driver, arg1: &mut Ride, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg3)), 67);
        assert!(arg1.state == 5, 47);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 3);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"ReadyToStart");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v0), 63);
        arg1.state = 19;
    }

    public fun driver_cancel_ride(arg0: &mut Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg6)), 67);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        assert!(arg1.state != 6, 6);
        assert!(arg1.state != 15, 6);
        assert!(arg1.state != 14, 6);
        assert!(arg1.state != 13, 6);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"DriverCancelRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg5, &v2, &v0), 39);
        let v3 = calculate_cancel_fee(arg1, arg3, arg4, 0, arg2);
        arg1.state = 14;
        let v4 = RideCancelled{
            ride_id   : 0x2::object::id<Ride>(arg1),
            rider     : arg1.rider,
            driver    : arg1.driver,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RideCancelled>(v4);
        v3
    }

    public fun driver_head_to_pick_up(arg0: &mut Driver, arg1: &mut Ride, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg3)), 67);
        assert!(arg1.state == 2, 20);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"DriverHeadToPickUp");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v0), 62);
        arg1.state = 5;
        arg0.latest_ride = 0x1::option::some<0x2::object::ID>(0x2::object::id<Ride>(arg1));
    }

    public fun end_ride(arg0: &mut Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg10)), 67);
        assert!(arg1.state != 15, 22);
        assert!(arg1.state != 14, 22);
        assert!(arg1.state != 13, 22);
        assert!(arg1.state != 6, 45);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"EndRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg9, &v2, &v0), 41);
        complete_ride(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg2);
    }

    public fun get_app_storage_id(arg0: &AppStorage) : 0x2::object::ID {
        0x2::object::id<AppStorage>(arg0)
    }

    public fun get_city_config_cancellation_fee(arg0: &CityConfig) : u64 {
        arg0.cancellation_fee
    }

    public fun get_city_config_city_code(arg0: &CityConfig) : 0x1::string::String {
        arg0.city_code
    }

    public fun get_city_config_id(arg0: &CityConfig) : 0x2::object::ID {
        0x2::object::id<CityConfig>(arg0)
    }

    public fun get_city_config_min_distance(arg0: &CityConfig) : u64 {
        arg0.min_distance
    }

    public fun get_city_config_num_vehicle_category(arg0: &CityConfig) : u8 {
        arg0.num_vehicle_category
    }

    public fun get_city_config_tax(arg0: &CityConfig) : u64 {
        arg0.tax
    }

    public fun get_counter_quote_driver(arg0: &CounterQuote) : address {
        arg0.driver
    }

    public fun get_counter_quote_percent(arg0: &CounterQuote) : vector<u8> {
        arg0.percent
    }

    public fun get_driver_address(arg0: &Driver) : address {
        arg0.driver_address
    }

    public fun get_driver_from_ride(arg0: &Ride) : 0x1::option::Option<address> {
        arg0.driver
    }

    public fun get_driver_latest_ride(arg0: &Driver) : 0x1::option::Option<0x2::object::ID> {
        arg0.latest_ride
    }

    public fun get_ride_chosen_vehicle(arg0: &Ride) : u8 {
        arg0.vehicle_category
    }

    public fun get_ride_counter_quotes(arg0: &Ride) : vector<CounterQuote> {
        arg0.counter_quotes
    }

    public fun get_ride_estimated_distance(arg0: &Ride) : u64 {
        arg0.estimated_distance
    }

    public fun get_ride_estimated_time(arg0: &Ride) : u64 {
        arg0.estimated_time
    }

    public fun get_ride_fare(arg0: &Ride) : 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare {
        arg0.fare
    }

    public fun get_ride_final_distance(arg0: &Ride) : u64 {
        arg0.final_distance
    }

    public fun get_ride_final_time(arg0: &Ride) : u64 {
        arg0.final_time
    }

    public fun get_ride_next_stop(arg0: &Ride) : u64 {
        arg0.next_stop
    }

    public fun get_ride_state(arg0: &Ride) : u16 {
        arg0.state
    }

    public fun get_ride_stop_durations(arg0: &Ride) : vector<u64> {
        arg0.stop_durations
    }

    fun get_ride_stops_waiting_time(arg0: vector<u64>, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= 0x1::vector::length<u64>(&arg0), 49);
        let v0 = 0;
        if (0x1::vector::length<u64>(&arg0) > 0) {
            let v1 = 0;
            while (v1 < arg1) {
                let v2 = *0x1::vector::borrow<u64>(&arg0, v1);
                if (v2 <= arg2) {
                    v1 = v1 + 1;
                    continue
                };
                let v3 = v0 + v2;
                v0 = v3 - 3;
                v1 = v1 + 1;
            };
        };
        v0
    }

    public fun get_rider_address(arg0: &Rider) : address {
        arg0.rider_address
    }

    public fun get_rider_from_ride(arg0: &Ride) : address {
        arg0.rider
    }

    public fun get_rider_latest_ride(arg0: &Rider) : 0x1::option::Option<0x2::object::ID> {
        arg0.latest_ride
    }

    public fun get_rider_nonce(arg0: &Rider) : u64 {
        arg0.nonce
    }

    public fun get_stop_duration(arg0: vector<u64>, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0, arg1)
    }

    public fun get_vehicle_category_details(arg0: &CityConfig, arg1: u8) : (0x1::string::String, vector<u64>, bool) {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).minimum_fare);
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).base_fare);
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).distance_fare);
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).time_fare);
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).waiting_charge);
        0x1::vector::push_back<u64>(&mut v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).destination_change_charge);
        (0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).name, v0, 0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).deprecation_flag)
    }

    public fun get_vehicle_category_info_base_fare(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).base_fare
    }

    public fun get_vehicle_category_info_deprecation_flag(arg0: &CityConfig, arg1: u8) : bool {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).deprecation_flag
    }

    public fun get_vehicle_category_info_destination_change_charge(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).destination_change_charge
    }

    public fun get_vehicle_category_info_distance_fare(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).distance_fare
    }

    public fun get_vehicle_category_info_minimum_fare(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).minimum_fare
    }

    public fun get_vehicle_category_info_name(arg0: &CityConfig, arg1: u8) : 0x1::string::String {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).name
    }

    public fun get_vehicle_category_info_time_fare(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).time_fare
    }

    public fun get_vehicle_category_info_waiting_charge(arg0: &CityConfig, arg1: u8) : u64 {
        0x2::table::borrow<u8, VehicleCategory>(&arg0.vehicle_category_info, arg1).waiting_charge
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = AppStorage{
            id                   : 0x2::object::new(arg0),
            registered_riders    : 0x2::table::new<address, bool>(arg0),
            registered_drivers   : 0x2::table::new<address, bool>(arg0),
            registered_countries : 0x2::table::new<0x1::string::String, bool>(arg0),
            registered_cities    : 0x2::table::new<0x1::string::String, bool>(arg0),
        };
        0x2::transfer::share_object<AppStorage>(v1);
    }

    fun is_owner(arg0: address, arg1: address) : bool {
        if (arg0 == arg1) {
            return true
        };
        false
    }

    public fun register_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun register_driver(arg0: &AdminCap, arg1: &mut AppStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg1.registered_drivers, arg2), 31);
        assert!(!0x2::table::contains<address, bool>(&arg1.registered_riders, arg2), 32);
        let v0 = Driver{
            id             : 0x2::object::new(arg3),
            driver_address : arg2,
            latest_ride    : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Driver>(v0);
        0x2::table::add<address, bool>(&mut arg1.registered_drivers, arg2, false);
        let v1 = DriverRegistered{driver: arg2};
        0x2::event::emit<DriverRegistered>(v1);
    }

    public fun register_rider(arg0: &AdminCap, arg1: &mut AppStorage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg1.registered_riders, arg2), 29);
        assert!(!0x2::table::contains<address, bool>(&arg1.registered_drivers, arg2), 30);
        let v0 = Rider{
            id            : 0x2::object::new(arg3),
            rider_address : arg2,
            latest_ride   : 0x1::option::none<0x2::object::ID>(),
            nonce         : 0,
        };
        0x2::transfer::share_object<Rider>(v0);
        0x2::table::add<address, bool>(&mut arg1.registered_riders, arg2, false);
        let v1 = RiderRegistered{rider: arg2};
        0x2::event::emit<RiderRegistered>(v1);
    }

    public fun remove_stop(arg0: &mut Rider, arg1: &mut Ride, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg6)), 67);
        let v0 = arg1.state == 6 || arg1.state == 13 || arg1.state == 14 || arg1.state == 15 || arg1.state == 4 || arg1.state == 18 || arg1.state == 17;
        assert!(!v0, 18);
        assert!(0x1::vector::length<u64>(&arg1.stop_durations) > 0, 9);
        assert!(arg2 >= arg1.next_stop, 18);
        assert!(arg0.rider_address == arg1.rider, 3);
        let v1 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v2 = 0x1::string::utf8(b"RemoveStop");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        arg0.nonce = arg0.nonce + 1;
        let v3 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg5, &v3, &v1), 36);
        0x1::vector::remove<u64>(&mut arg1.stop_durations, arg2);
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::estimate_fare(&mut arg1.fare, arg1.estimated_distance, arg1.estimated_time, arg3, arg4, get_ride_stops_waiting_time(arg1.stop_durations, 0x1::vector::length<u64>(&arg1.stop_durations), arg1.base_waiting_time));
    }

    public fun request_resume(arg0: &mut Rider, arg1: &mut Ride, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg3)), 67);
        assert!(arg1.state == 4, 12);
        assert!(arg0.rider_address == arg1.rider, 3);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"RequestResume");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        arg0.nonce = arg0.nonce + 1;
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v0), 59);
        arg1.state = 18;
        let v3 = ResumeStopRequested{
            ride_id : 0x2::object::id<Ride>(arg1),
            rider   : arg0.rider_address,
        };
        0x2::event::emit<ResumeStopRequested>(v3);
    }

    public fun request_ride(arg0: &mut Rider, arg1: &mut CountryConfig, arg2: &mut CityConfig, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: vector<u64>, arg7: u8, arg8: u64, arg9: u64, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg11)), 67);
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.cities, &v0), 69);
        assert!(0x1::vector::length<u64>(&arg6) <= 5, 23);
        assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg7) == true, 71);
        let v1 = 0x2::bcs::to_bytes<address>(&arg0.rider_address);
        let v2 = 0x1::string::utf8(b"RequestRide");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg2.city_code));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        let v3 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg10, &v3, &v1), 33);
        arg0.nonce = arg0.nonce + 1;
        let v4 = 0x2::dynamic_field::remove<u8, 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare>(&mut arg0.id, arg7);
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::update_boost_percent(&mut v4, arg9);
        let v5 = 0;
        while (v5 < 0x2::table::length<u8, VehicleCategory>(&arg2.vehicle_category_info)) {
            0x2::dynamic_field::remove_if_exists<u8, 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::Fare>(&mut arg0.id, (v5 as u8));
            v5 = v5 + 1;
        };
        let v6 = Stop{
            stop_started : 0,
            stop_ended   : 0,
        };
        let v7 = Ride{
            id                 : 0x2::object::new(arg11),
            state              : 0,
            rider              : arg0.rider_address,
            estimated_distance : arg4,
            estimated_time     : arg5,
            fare               : v4,
            vehicle_category   : arg7,
            counter_quotes     : 0x1::vector::empty<CounterQuote>(),
            driver             : 0x1::option::none<address>(),
            stop_durations     : arg6,
            stop               : v6,
            next_stop          : 0,
            base_waiting_time  : arg2.base_waiting_time,
            final_distance     : 0,
            final_time         : 0,
        };
        0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare::estimate_fare(&mut v4, arg4, arg5, 0, 0, get_ride_stops_waiting_time(arg6, 0x1::vector::length<u64>(&arg6), arg2.base_waiting_time));
        arg0.latest_ride = 0x1::option::some<0x2::object::ID>(0x2::object::id<Ride>(&v7));
        0x2::table::add<0x2::object::ID, address>(&mut arg2.rides, 0x2::object::id<Ride>(&v7), v7.rider);
        let v8 = RideCreated{
            ride_id   : 0x2::object::id<Ride>(&v7),
            rider     : 0x2::tx_context::sender(arg11),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::transfer::share_object<Ride>(v7);
        0x2::event::emit<RideCreated>(v8);
    }

    public fun request_stop(arg0: &mut Rider, arg1: &mut Ride, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg3)), 67);
        assert!(arg1.state == 3, 11);
        assert!(arg0.rider_address == arg1.rider, 3);
        assert!(0x1::vector::length<u64>(&arg1.stop_durations) > 0, 9);
        assert!(arg1.next_stop < 0x1::vector::length<u64>(&arg1.stop_durations), 42);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"RequestStop");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.nonce));
        arg0.nonce = arg0.nonce + 1;
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v2, &v0), 57);
        arg1.state = 17;
        let v3 = StopRequested{
            ride_id : 0x2::object::id<Ride>(arg1),
            rider   : arg0.rider_address,
        };
        0x2::event::emit<StopRequested>(v3);
    }

    public fun resume_ride(arg0: &Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg4)), 67);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        assert!(arg1.state == 18, 44);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"ResumeRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v2, &v0), 60);
        arg1.stop.stop_ended = 0x2::clock::timestamp_ms(arg2) / 60000;
        *0x1::vector::borrow_mut<u64>(&mut arg1.stop_durations, arg1.next_stop - 1) = arg1.stop.stop_ended - arg1.stop.stop_started;
        arg1.state = 3;
    }

    public fun rider_cancel_ride(arg0: &mut Rider, arg1: &mut CountryConfig, arg2: &CityConfig, arg3: &mut Ride, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.cities, &v0), 69);
        assert!(is_owner(arg0.rider_address, 0x2::tx_context::sender(arg8)), 67);
        assert!(arg0.rider_address == arg3.rider, 3);
        assert!(arg3.state != 6, 6);
        assert!(arg3.state != 15, 6);
        assert!(arg3.state != 14, 6);
        assert!(arg3.state != 13, 6);
        let v1 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg3.id);
        let v2 = 0x1::string::utf8(b"RiderCancelRide");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg2.city_code));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg6));
        let v3 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg7, &v3, &v1), 38);
        let v4 = calculate_cancel_fee(arg3, arg5, arg6, arg2.cancellation_fee, arg4);
        arg3.state = 13;
        let v5 = RideCancelled{
            ride_id   : 0x2::object::id<Ride>(arg3),
            rider     : arg3.rider,
            driver    : arg3.driver,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<RideCancelled>(v5);
        v4
    }

    public fun start_ride(arg0: &Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg4)), 67);
        assert!(arg1.state == 19, 21);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"StartRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v2, &v0), 64);
        arg1.state = 3;
        let v3 = RideStarted{
            ride_id   : 0x2::object::id<Ride>(arg1),
            rider     : arg1.rider,
            driver    : *0x1::option::borrow<address>(&arg1.driver),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RideStarted>(v3);
    }

    public fun stop_ride(arg0: &Driver, arg1: &mut Ride, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0.driver_address, 0x2::tx_context::sender(arg4)), 67);
        assert!(arg1.state == 17, 43);
        assert!(0x1::option::is_some<address>(&arg1.driver), 24);
        assert!(arg0.driver_address == *0x1::option::borrow<address>(&arg1.driver), 4);
        let v0 = 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id);
        let v1 = 0x1::string::utf8(b"StopRide");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = x"61aa7e0f8be10e5ff65c77ec9f8f9bc425664344c1fa3840fd39d998f86f4f66";
        assert!(0x2::ed25519::ed25519_verify(&arg3, &v2, &v0), 58);
        arg1.stop.stop_started = 0x2::clock::timestamp_ms(arg2) / 60000;
        arg1.next_stop = arg1.next_stop + 1;
        arg1.state = 4;
    }

    public fun update_cancellation_fee(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u64) {
        arg1.cancellation_fee = arg2;
    }

    public fun update_city_config(arg0: &AdminCap, arg1: &mut AppStorage, arg2: &mut CountryConfig, arg3: &mut CityConfig, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        arg3.min_distance = arg5;
        arg3.tax = arg7;
        arg3.cancellation_fee = arg6;
        arg3.base_waiting_time = arg8;
        arg3.city_code = arg4;
    }

    public fun update_min_distance(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u64) {
        arg1.min_distance = arg2;
    }

    public fun update_tax(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u64) {
        arg1.tax = arg2;
    }

    public fun update_vehicle_info_value(arg0: &AdminCap, arg1: &mut CityConfig, arg2: u8, arg3: 0x1::string::String, arg4: vector<u64>) {
        assert!(0x2::table::contains<u8, VehicleCategory>(&arg1.vehicle_category_info, arg2), 1);
        assert!(0x1::vector::length<u64>(&arg4) == 6, 46);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).name = arg3;
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).minimum_fare = *0x1::vector::borrow<u64>(&arg4, 0);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).base_fare = *0x1::vector::borrow<u64>(&arg4, 1);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).distance_fare = *0x1::vector::borrow<u64>(&arg4, 2);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).time_fare = *0x1::vector::borrow<u64>(&arg4, 3);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).waiting_charge = *0x1::vector::borrow<u64>(&arg4, 4);
        0x2::table::borrow_mut<u8, VehicleCategory>(&mut arg1.vehicle_category_info, arg2).destination_change_charge = *0x1::vector::borrow<u64>(&arg4, 5);
    }

    // decompiled from Move bytecode v6
}

