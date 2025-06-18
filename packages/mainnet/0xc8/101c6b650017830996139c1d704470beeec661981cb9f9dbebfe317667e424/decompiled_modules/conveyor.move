module 0xc8101c6b650017830996139c1d704470beeec661981cb9f9dbebfe317667e424::conveyor {
    struct Conveyor<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T2>,
    }

    public fun burn<T0: drop, T1: drop, T2>(arg0: &T1, arg1: Conveyor<T0, T1, T2>) : 0x2::balance::Balance<T2> {
        let Conveyor { balance: v0 } = arg1;
        v0
    }

    public fun new<T0: drop, T1: drop, T2>(arg0: &T0, arg1: 0x2::balance::Balance<T2>) : Conveyor<T0, T1, T2> {
        Conveyor<T0, T1, T2>{balance: arg1}
    }

    // decompiled from Move bytecode v6
}

