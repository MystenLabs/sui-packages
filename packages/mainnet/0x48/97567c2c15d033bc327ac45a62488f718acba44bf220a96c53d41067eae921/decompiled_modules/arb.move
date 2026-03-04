module 0x4897567c2c15d033bc327ac45a62488f718acba44bf220a96c53d41067eae921::arb {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_min_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun balance_to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun split_balance<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, arg1), arg2)
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
    }

    public fun zero_balance<T0>() : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

