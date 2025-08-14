module 0x26e47e5750d2f91b1afdb36a0aebfd8bebfdd4c643f5edb1207253d4314c3e9e::yy_balance {
    struct YyBalance<phantom T0> has key {
        id: 0x2::object::UID,
        yy_balace: 0x2::balance::Balance<T0>,
    }

    public(friend) fun extract_yy<T0>(arg0: &mut YyBalance<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.yy_balace;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 111);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), arg1);
    }

    public fun init_new_resource<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = YyBalance<T0>{
            id        : 0x2::object::new(arg0),
            yy_balace : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<YyBalance<T0>>(v0);
    }

    public(friend) fun recharge_yy<T0>(arg0: &mut YyBalance<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.yy_balace, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

