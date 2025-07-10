module 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset {
    struct Asset<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T2>,
        extra_info: 0x2::bag::Bag,
    }

    public fun new<T0: drop, T1: drop, T2>(arg0: &T0, arg1: 0x2::balance::Balance<T2>, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0, T1, T2> {
        Asset<T0, T1, T2>{
            balance    : arg1,
            extra_info : 0x2::bag::new(arg2),
        }
    }

    public fun borrow_extra_info<T0: drop, T1: drop, T2>(arg0: &mut Asset<T0, T1, T2>, arg1: &T1) : &0x2::bag::Bag {
        &arg0.extra_info
    }

    public fun borrow_extra_info_mut<T0: drop, T1: drop, T2>(arg0: &mut Asset<T0, T1, T2>, arg1: &T1) : &mut 0x2::bag::Bag {
        &mut arg0.extra_info
    }

    public fun burn<T0: drop, T1: drop, T2>(arg0: Asset<T0, T1, T2>, arg1: &T1) : 0x2::balance::Balance<T2> {
        let Asset {
            balance    : v0,
            extra_info : v1,
        } = arg0;
        0x2::bag::destroy_empty(v1);
        v0
    }

    public fun set_extra_info<T0: drop, T1: drop, T2, T3: copy + drop + store, T4: store>(arg0: &mut Asset<T0, T1, T2>, arg1: &T0, arg2: T3, arg3: T4) {
        0x2::bag::add<T3, T4>(&mut arg0.extra_info, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

