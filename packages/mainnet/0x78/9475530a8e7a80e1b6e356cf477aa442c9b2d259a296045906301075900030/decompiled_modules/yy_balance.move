module 0xe83d324d634acbdc3d9e563b42b079ef6c7c5c0049b0039c7a10431bcbcc6f1c::yy_balance {
    struct YyBalance<phantom T0> has key {
        id: 0x2::object::UID,
        yy_balace: 0x2::balance::Balance<T0>,
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

