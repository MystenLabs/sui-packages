module 0xddaa9182907d79f590b6326f085df79f829b2b8583f66a2d953438e2daecb9a2::build_slot_floor_price_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        floor_price: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{floor_price: arg2};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0xb199d43324ac809f6869dd0b6cac6e1641023c5895853ca13ff5e01d1cfa2d73::marketplace::FloorInfo<T0>) {
        if (0xb199d43324ac809f6869dd0b6cac6e1641023c5895853ca13ff5e01d1cfa2d73::marketplace::floor_coin_type<T0>(&arg2) != 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<0x4c981f3ff786cdb9e514da897ab8a953647dae2ace9679e8358eec1e3e8871ac::dmc::DMC>()))) {
            let v0 = Rule{dummy_field: false};
            assert!(0xb199d43324ac809f6869dd0b6cac6e1641023c5895853ca13ff5e01d1cfa2d73::marketplace::floor_price<T0>(&arg2) >= 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).floor_price, 0);
        };
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg1);
    }

    // decompiled from Move bytecode v6
}

