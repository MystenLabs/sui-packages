module 0x8b2ce1bda1538e69a66cfd340f294266e82763d12413d89cb3d9abaf552c1d29::royalty {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Configuration has drop, store {
        bps: u16,
        recipient: address,
    }

    struct Paid has copy, drop {
        item: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun due(arg0: u64, arg1: u16) : u64 {
        assert!(arg1 <= 10000, 1);
        ((((arg0 as u128) * (arg1 as u128) + 9999) / 10000) as u64)
    }

    public fun pay<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule, Configuration>(v0, arg0);
        let v2 = due(0x2::transfer_policy::paid<T0>(arg1), v1.bps);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2, 2);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2, arg3), v1.recipient);
        };
        let v3 = Paid{
            item      : 0x2::transfer_policy::item<T0>(arg1),
            recipient : v1.recipient,
            amount    : v2,
        };
        0x2::event::emit<Paid>(v3);
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v4, arg1);
        arg2
    }

    public fun set<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address) {
        assert!(arg2 <= 10000 && arg3 != @0x0, 1);
        if (0x2::transfer_policy::has_rule<T0, Rule>(arg0)) {
            0x2::transfer_policy::remove_rule<T0, Rule, Configuration>(arg0, arg1);
        };
        let v0 = Rule{dummy_field: false};
        let v1 = Configuration{
            bps       : arg2,
            recipient : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Configuration>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v7
}

