module 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message {
    struct Message<phantom T0, phantom T1> {
        info: 0x2::bag::Bag,
    }

    public fun new<T0: drop, T1: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Message<T0, T1> {
        Message<T0, T1>{info: 0x2::bag::new(arg1)}
    }

    public fun borrow_info<T0: drop, T1: drop>(arg0: &mut Message<T0, T1>, arg1: &T1) : &0x2::bag::Bag {
        &arg0.info
    }

    public fun borrow_info_mut<T0: drop, T1: drop>(arg0: &mut Message<T0, T1>, arg1: &T1) : &mut 0x2::bag::Bag {
        &mut arg0.info
    }

    public fun burn_and_get_info<T0: drop, T1: drop>(arg0: Message<T0, T1>, arg1: &T1) : 0x2::bag::Bag {
        let Message { info: v0 } = arg0;
        v0
    }

    public fun set_info<T0: drop, T1: drop, T2: copy + drop + store, T3: store>(arg0: &mut Message<T0, T1>, arg1: &T0, arg2: T2, arg3: T3) {
        0x2::bag::add<T2, T3>(&mut arg0.info, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

