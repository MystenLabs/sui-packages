module 0x7e49943d1aaea655392ba2284818a97923422f50f27d11dafd9c6ca7075ff174::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u16,
        min_amount: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 5000, 1);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp  : arg2,
            min_amount : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    fun calculate_royalty(arg0: u64, arg1: u16, arg2: u64) : u64 {
        let v0 = (((arg0 as u128) * (arg1 as u128) / 10000) as u64);
        if (v0 < arg2) {
            arg2
        } else {
            v0
        }
    }

    public fun get_config<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : (u16, u64) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        (v1.amount_bp, v1.min_amount)
    }

    public fun get_royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        calculate_royalty(arg1, v1.amount_bp, v1.min_amount)
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= calculate_royalty(0x2::transfer_policy::paid<T0>(arg1), v1.amount_bp, v1.min_amount), 0);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v2, arg0, arg2);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    // decompiled from Move bytecode v6
}

