module 0x36ad292784993e767ad66d8c9f98060a45f8748f3b05a5e10ab5b9039cb7d20a::conveyor {
    struct Conveyor<phantom T0, phantom T1, phantom T2> {
        balance: 0x2::balance::Balance<T2>,
        extra_info: 0x2::bag::Bag,
    }

    public fun new<T0: drop, T1: drop, T2>(arg0: &T0, arg1: 0x2::balance::Balance<T2>, arg2: &mut 0x2::tx_context::TxContext) : Conveyor<T0, T1, T2> {
        Conveyor<T0, T1, T2>{
            balance    : arg1,
            extra_info : 0x2::bag::new(arg2),
        }
    }

    public fun borrow_extra_info<T0: drop, T1: drop, T2>(arg0: &mut Conveyor<T0, T1, T2>, arg1: &T1) : &0x2::bag::Bag {
        &arg0.extra_info
    }

    public fun borrow_extra_info_mut<T0: drop, T1: drop, T2>(arg0: &mut Conveyor<T0, T1, T2>, arg1: &T1) : &mut 0x2::bag::Bag {
        &mut arg0.extra_info
    }

    public fun burn<T0: drop, T1: drop, T2>(arg0: Conveyor<T0, T1, T2>, arg1: &T1) : 0x2::balance::Balance<T2> {
        let Conveyor {
            balance    : v0,
            extra_info : v1,
        } = arg0;
        0x2::bag::destroy_empty(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

