module 0x4ed7e26f0cf93b8c3a5e123016196f4f6b9e2f7db5323f51aebbb0a56f9fd9b0::royalty_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        basis_points: u16,
        recipient: address,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            basis_points : 200,
            recipient    : arg2,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun pay<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == royalty_due<T0>(arg0, 0x2::transfer_policy::paid<T0>(arg1)), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1.recipient);
        let v2 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v2, arg1);
    }

    public fun royalty_due<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        (((arg1 as u128) * (0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).basis_points as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v7
}

