module 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint {
    struct Payload<phantom T0, phantom T1> {
        balance_start: 0x2::balance::Balance<T0>,
        balance_end: 0x2::balance::Balance<T1>,
        balance_end_min: u64,
        next: Next,
    }

    struct Next {
        contents: 0x2::bag::Bag,
    }

    struct NextKey has copy, drop, store {
        dummy_field: bool,
    }

    fun add<T0: store>(arg0: &mut Next, arg1: T0) {
        let v0 = NextKey{dummy_field: false};
        0x2::bag::add<NextKey, T0>(&mut arg0.contents, v0, arg1);
    }

    fun remove<T0: store>(arg0: &mut Next) : T0 {
        let v0 = NextKey{dummy_field: false};
        0x2::bag::remove<NextKey, T0>(&mut arg0.contents, v0)
    }

    fun destroy(arg0: Next) {
        let Next { contents: v0 } = arg0;
        0x2::bag::destroy_empty(v0);
    }

    public fun load_next<T0, T1>(arg0: &mut Payload<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.next;
        add<0x2::balance::Balance<T0>>(v0, 0x2::balance::split<T0>(&mut arg0.balance_start, arg1));
    }

    public(friend) fun place_next<T0, T1, T2>(arg0: &mut Payload<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = &mut arg0.next;
        add<0x2::balance::Balance<T2>>(v0, arg1);
    }

    public fun return_next<T0, T1>(arg0: &mut Payload<T0, T1>) {
        let v0 = &mut arg0.next;
        0x2::balance::join<T1>(&mut arg0.balance_end, remove<0x2::balance::Balance<T1>>(v0));
    }

    public fun settle<T0, T1>(arg0: Payload<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let Payload {
            balance_start   : v0,
            balance_end     : v1,
            balance_end_min : v2,
            next            : v3,
        } = arg0;
        let v4 = v1;
        assert!(0x2::balance::value<T1>(&v4) >= v2, 0);
        destroy(v3);
        (v0, v4)
    }

    public fun start<T0, T1>(arg0: &mut 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::partner::ProtocolFeeBag, arg1: &0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::partner::PartnerCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Payload<T0, T1> {
        if (arg5 != 0) {
            0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::partner::charge_fee<T0>(&mut arg2, arg0, arg1, arg5, arg6, arg7);
        };
        let v0 = Next{contents: 0x2::bag::new(arg7)};
        Payload<T0, T1>{
            balance_start   : arg2,
            balance_end     : arg3,
            balance_end_min : arg4,
            next            : v0,
        }
    }

    public(friend) fun take_next<T0, T1, T2>(arg0: &mut Payload<T0, T1>) : 0x2::balance::Balance<T2> {
        let v0 = &mut arg0.next;
        remove<0x2::balance::Balance<T2>>(v0)
    }

    // decompiled from Move bytecode v6
}

