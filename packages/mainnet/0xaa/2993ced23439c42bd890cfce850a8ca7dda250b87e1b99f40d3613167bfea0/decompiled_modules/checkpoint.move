module 0xaa2993ced23439c42bd890cfce850a8ca7dda250b87e1b99f40d3613167bfea0::checkpoint {
    struct FeeConfig<phantom T0, phantom T1> {
        start_fee_rate: u64,
        end_fee_rate: u64,
        fee_receiver: address,
    }

    struct Payload<phantom T0, phantom T1> {
        balance_start: 0x2::balance::Balance<T0>,
        balance_end: 0x2::balance::Balance<T1>,
        balance_end_min: u64,
        next: Next,
        fee_config: FeeConfig<T0, T1>,
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
            fee_config      : v4,
        } = arg0;
        let v5 = v1;
        let FeeConfig {
            start_fee_rate : _,
            end_fee_rate   : v7,
            fee_receiver   : v8,
        } = v4;
        let v9 = 0x2::balance::value<T1>(&v5);
        assert!(v9 >= v2, 1);
        assert!(v7 <= 100, 0);
        let v10 = 0x2::balance::split<T1>(&mut v5, v9 * v7 / 10000);
        destroy(v3);
        if (0x2::balance::value<T1>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v10, arg1), v8);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
        };
        (v0, v5)
    }

    public fun start<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Payload<T0, T1> {
        assert!(arg3 <= 100, 0);
        let v0 = 0x2::balance::split<T0>(&mut arg0, 0x2::balance::value<T0>(&arg0) * arg3 / 10000);
        let v1 = Next{contents: 0x2::bag::new(arg6)};
        let v2 = FeeConfig<T0, T1>{
            start_fee_rate : arg3,
            end_fee_rate   : arg4,
            fee_receiver   : arg5,
        };
        let v3 = Payload<T0, T1>{
            balance_start   : arg0,
            balance_end     : arg1,
            balance_end_min : arg2,
            next            : v1,
            fee_config      : v2,
        };
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg6), arg5);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        v3
    }

    public(friend) fun take_next<T0, T1, T2>(arg0: &mut Payload<T0, T1>) : 0x2::balance::Balance<T2> {
        let v0 = &mut arg0.next;
        remove<0x2::balance::Balance<T2>>(v0)
    }

    // decompiled from Move bytecode v6
}

