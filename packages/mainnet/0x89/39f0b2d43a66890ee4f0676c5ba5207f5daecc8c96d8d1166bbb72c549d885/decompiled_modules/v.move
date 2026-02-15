module 0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::v {
    struct L {
        a: u64,
    }

    struct V<phantom T0> has key {
        id: 0x2::object::UID,
        b: 0x2::balance::Balance<T0>,
    }

    public fun cv<T0>(arg0: &0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::a::AC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = V<T0>{
            id : 0x2::object::new(arg1),
            b  : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<V<T0>>(v0);
    }

    public fun d<T0>(arg0: &mut V<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::c::C, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::c::t(arg2);
        let v1 = v0;
        if (0x2::tx_context::sender(arg3) == 0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::c::a(arg2) && 0x2::balance::value<T0>(&arg1) < v0) {
            v1 = 0;
        };
        0x2::balance::join<T0>(&mut arg0.b, arg1);
        0x2::balance::split<T0>(&mut arg1, v1)
    }

    public fun w<T0>(arg0: &mut V<T0>, arg1: &0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::a::AC, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.b, 0x2::balance::value<T0>(&arg0.b)), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun x<T0>(arg0: &mut V<T0>, arg1: u64) : (0x2::balance::Balance<T0>, L) {
        let v0 = L{a: arg1};
        (0x2::balance::split<T0>(&mut arg0.b, arg1), v0)
    }

    public fun y<T0>(arg0: &mut V<T0>, arg1: 0x2::balance::Balance<T0>, arg2: L) {
        let L { a: v0 } = arg2;
        assert!(0x2::balance::value<T0>(&arg1) >= v0, 0);
        0x2::balance::join<T0>(&mut arg0.b, arg1);
    }

    // decompiled from Move bytecode v6
}

