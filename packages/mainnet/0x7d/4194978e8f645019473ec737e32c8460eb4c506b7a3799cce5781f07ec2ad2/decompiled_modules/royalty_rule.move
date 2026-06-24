module 0x7d4194978e8f645019473ec737e32c8460eb4c506b7a3799cce5781f07ec2ad2::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        basis_points: u16,
        min_amount: u64,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: u64) {
        assert!(arg2 <= 10000, 0);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            basis_points : arg2,
            min_amount   : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun fee_amount(arg0: u16, arg1: u64, arg2: u64) : u64 {
        let v0 = arg2 * (arg0 as u64) / 10000;
        if (v0 < arg1) {
            arg1
        } else {
            v0
        }
    }

    public fun pay<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == fee_amount(v1.basis_points, v1.min_amount, 0x2::transfer_policy::paid<T0>(arg1)), 1);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, Rule>(v2, arg0, arg2);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v3, arg1);
    }

    public fun withdraw_royalties<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer_policy::withdraw<T0>(arg0, arg1, 0x1::option::none<u64>(), arg2)
    }

    // decompiled from Move bytecode v7
}

