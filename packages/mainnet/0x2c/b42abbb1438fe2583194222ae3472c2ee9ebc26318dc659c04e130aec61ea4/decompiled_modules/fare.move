module 0x2cb42abbb1438fe2583194222ae3472c2ee9ebc26318dc659c04e130aec61ea4::fare {
    struct Fare has copy, drop, store {
        vehicle_category_name: 0x1::string::String,
        base_fare: u64,
        minimum_fare: u64,
        base_distance: u64,
        distance_fare: u64,
        time_fare: u64,
        boost_percent: u64,
        chosen_boost: u64,
        chosen_boost_flag: bool,
        estimated_fare: u64,
        final_fare: u64,
        additional_charges: u64,
        waiting_charge: u64,
        destination_change_charge: u64,
        apply_destination_charges: bool,
        discounted_deductions: u64,
        tax: u64,
        toll_fee: u64,
        rta_fee: u64,
        booking_fee: u64,
        decimals: u64,
    }

    fun add_boost_and_tax(arg0: &Fare, arg1: u64) : u64 {
        if (arg0.apply_destination_charges) {
            arg1 = arg1 + arg0.destination_change_charge;
        };
        let v0 = arg1 + arg0.boost_percent * arg1 / 100;
        if (arg0.chosen_boost_flag) {
            arg1 = v0 + arg0.chosen_boost * v0 / 100;
        } else {
            arg1 = v0 - arg0.chosen_boost * v0 / 100;
        };
        arg1 + arg0.tax * arg1 / 100
    }

    fun apply_boost(arg0: &Fare, arg1: u64) : u64 {
        if (arg0.chosen_boost_flag) {
            let v0 = arg0.chosen_boost * arg1 / 100;
            arg1 = arg1 + v0;
        } else {
            let v1 = arg0.chosen_boost * arg1 / 100;
            arg1 = arg1 - v1;
        };
        arg1
    }

    public(friend) fun apply_destination_change_charge(arg0: &mut Fare) {
        arg0.apply_destination_charges = true;
    }

    public(friend) fun calculate_final_fare(arg0: &mut Fare, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg1 > arg0.base_distance) {
            arg1 - arg0.base_distance
        } else {
            0
        };
        let v1 = apply_boost(arg0, 0x2::math::max(arg0.base_fare + v0 * arg0.distance_fare + arg2 * arg0.time_fare + arg0.rta_fee + arg0.toll_fee + 10000, arg0.minimum_fare)) - arg0.discounted_deductions;
        arg0.final_fare = v1;
        v1
    }

    public fun chosen_boost(arg0: &Fare) : u64 {
        arg0.chosen_boost
    }

    public fun chosen_boost_flag(arg0: &Fare) : bool {
        arg0.chosen_boost_flag
    }

    public fun decimals(arg0: &Fare) : u64 {
        arg0.decimals
    }

    public(friend) fun estimate_fare(arg0: &mut Fare, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = if (arg1 > arg0.base_distance) {
            arg1 - arg0.base_distance
        } else {
            0
        };
        let v1 = apply_boost(arg0, 0x2::math::max(arg0.base_fare + v0 * arg0.distance_fare + arg2 * arg0.time_fare + arg0.rta_fee + arg0.toll_fee + 10000, arg0.minimum_fare)) - arg0.discounted_deductions;
        arg0.estimated_fare = v1;
        v1
    }

    public fun estimated_fare(arg0: &Fare) : u64 {
        arg0.estimated_fare
    }

    public fun final_fare(arg0: &Fare) : u64 {
        arg0.final_fare
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64) : Fare {
        Fare{
            vehicle_category_name     : arg0,
            base_fare                 : arg1,
            minimum_fare              : arg2,
            base_distance             : arg3,
            distance_fare             : arg4,
            time_fare                 : arg5,
            boost_percent             : arg6,
            chosen_boost              : arg7,
            chosen_boost_flag         : false,
            estimated_fare            : arg8,
            final_fare                : arg9,
            additional_charges        : arg10,
            waiting_charge            : arg11,
            destination_change_charge : arg12,
            apply_destination_charges : false,
            discounted_deductions     : arg13,
            tax                       : arg14,
            toll_fee                  : arg15,
            rta_fee                   : arg16,
            booking_fee               : arg17,
            decimals                  : 100,
        }
    }

    public(friend) fun set_chosen_boost(arg0: &mut Fare, arg1: u64) {
        arg0.chosen_boost = arg1;
    }

    public(friend) fun set_chosen_boost_flag(arg0: &mut Fare, arg1: bool) {
        arg0.chosen_boost_flag = arg1;
    }

    public(friend) fun update_additional_charges(arg0: &mut Fare, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.additional_charges = arg1;
        arg0.toll_fee = arg2;
        arg0.rta_fee = arg3;
        arg0.booking_fee = arg4;
    }

    public(friend) fun update_boost_percent(arg0: &mut Fare, arg1: u64) {
        arg0.boost_percent = arg1;
    }

    public(friend) fun update_discounted_deductions(arg0: &mut Fare, arg1: u64) {
        arg0.discounted_deductions = arg1;
    }

    public(friend) fun update_estimated_fare(arg0: &mut Fare, arg1: u64) {
        arg0.estimated_fare = arg1;
    }

    public(friend) fun update_final_fare(arg0: &mut Fare, arg1: u64) {
        arg0.final_fare = arg1;
    }

    // decompiled from Move bytecode v6
}

