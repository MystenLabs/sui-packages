module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::royalty {
    struct Rule<phantom T0> has drop {
        dummy_field: bool,
    }

    struct Config<phantom T0> has drop, store {
        ref_price: u64,
    }

    struct RoyaltyPaid has copy, drop {
        item: 0x2::object::ID,
        declared: u64,
        basis: u64,
        royalty: u64,
    }

    public fun due<T0, T1>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule<T1>{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, Rule<T1>, Config<T1>>(v0, arg0).ref_price;
        let v2 = if (arg1 > v1) {
            arg1
        } else {
            v1
        };
        (((v2 as u128) * (600 as u128) / 10000) as u64)
    }

    public(friend) fun new_policy<T0, T1>(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>) {
        assert!(arg1 > 0, 700);
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = Rule<T1>{dummy_field: false};
        let v5 = Config<T1>{ref_price: arg1};
        0x2::transfer_policy::add_rule<T0, Rule<T1>, Config<T1>>(v4, &mut v3, &v2, v5);
        (v3, v2)
    }

    public fun pay<T0, T1>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::transfer_policy::paid<T0>(arg1);
        let v1 = due<T0, T1>(arg0, v0);
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 701);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v1, arg3), @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
        let v2 = Rule<T1>{dummy_field: false};
        let v3 = 0x2::transfer_policy::get_rule<T0, Rule<T1>, Config<T1>>(v2, arg0).ref_price;
        let v4 = if (v0 > v3) {
            v0
        } else {
            v3
        };
        let v5 = RoyaltyPaid{
            item     : 0x2::transfer_policy::item<T0>(arg1),
            declared : v0,
            basis    : v4,
            royalty  : v1,
        };
        0x2::event::emit<RoyaltyPaid>(v5);
        let v6 = Rule<T1>{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule<T1>>(v6, arg1);
        arg2
    }

    public fun treasury() : address {
        @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0
    }

    // decompiled from Move bytecode v7
}

