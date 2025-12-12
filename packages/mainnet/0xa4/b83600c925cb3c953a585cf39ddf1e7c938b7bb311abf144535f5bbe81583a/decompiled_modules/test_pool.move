module 0xa4b83600c925cb3c953a585cf39ddf1e7c938b7bb311abf144535f5bbe81583a::test_pool {
    struct TestPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        t1: 0x2::balance::Balance<T0>,
        t2: 0x2::balance::Balance<T1>,
        whitelist: vector<address>,
    }

    public fun add_t1<T0, T1>(arg0: &mut TestPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
        0x2::balance::join<T0>(&mut arg0.t1, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun add_t2<T0, T1>(arg0: &mut TestPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
        0x2::balance::join<T1>(&mut arg0.t2, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TestPool<T0, T1>{
            id        : 0x2::object::new(arg0),
            t1        : 0x2::balance::zero<T0>(),
            t2        : 0x2::balance::zero<T1>(),
            whitelist : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<TestPool<T0, T1>>(v0);
    }

    public fun receive_t1<T0, T1>(arg0: &mut TestPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
        add_t2<T0, T1>(arg0, arg1, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.t1, arg2), arg3)
    }

    public fun receive_t2<T0, T1>(arg0: &mut TestPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 0);
        add_t1<T0, T1>(arg0, arg1, arg3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.t2, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

