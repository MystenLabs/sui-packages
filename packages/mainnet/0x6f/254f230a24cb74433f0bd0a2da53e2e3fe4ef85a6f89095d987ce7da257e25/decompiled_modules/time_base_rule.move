module 0x6f254f230a24cb74433f0bd0a2da53e2e3fe4ef85a6f89095d987ce7da257e25::time_base_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        sales_start_time: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0x2::clock::Clock, arg3: u64) {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg3, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{sales_start_time: arg3};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun prove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= sales_start_time<T0>(arg0), 1);
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    public fun sales_start_time<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : u64 {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).sales_start_time
    }

    // decompiled from Move bytecode v6
}

