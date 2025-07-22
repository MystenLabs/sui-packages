module 0xb9e781e56d8018c8605369799c63750cacb224eb6306f032a7542c1338c10a1a::checkpoint {
    struct FeeConfig<phantom T0, phantom T1> {
        coin_start_fee_rate: u64,
        coin_end_fee_rate: u64,
        fee_receiver: address,
    }

    struct Payload<phantom T0, phantom T1> {
        coin_start: 0x2::coin::Coin<T0>,
        coin_end: 0x2::coin::Coin<T1>,
        coin_end_min: u64,
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
        add<0x2::coin::Coin<T0>>(v0, 0x2::coin::split<T0>(&mut arg0.coin_start, arg1, arg2));
    }

    public(friend) fun place_next<T0, T1, T2>(arg0: &mut Payload<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        let v0 = &mut arg0.next;
        add<0x2::coin::Coin<T2>>(v0, arg1);
    }

    public fun return_next<T0, T1>(arg0: &mut Payload<T0, T1>) {
        let v0 = &mut arg0.next;
        0x2::coin::join<T1>(&mut arg0.coin_end, remove<0x2::coin::Coin<T1>>(v0));
    }

    public fun settle<T0, T1>(arg0: Payload<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let Payload {
            coin_start   : v0,
            coin_end     : v1,
            coin_end_min : v2,
            next         : v3,
            fee_config   : v4,
        } = arg0;
        let v5 = v1;
        let FeeConfig {
            coin_start_fee_rate : _,
            coin_end_fee_rate   : v7,
            fee_receiver        : v8,
        } = v4;
        let v9 = 0x2::coin::value<T1>(&v5);
        assert!(v9 >= v2, 1);
        assert!(v7 <= 100, 0);
        let v10 = 0x2::coin::split<T1>(&mut v5, v9 * v7 / 10000, arg1);
        destroy(v3);
        if (0x2::coin::value<T1>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, v8);
        } else {
            0x2::coin::destroy_zero<T1>(v10);
        };
        (v0, v5)
    }

    public fun start<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : Payload<T0, T1> {
        assert!(arg3 <= 100, 0);
        let v0 = 0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) * arg3 / 10000, arg6);
        let v1 = Next{contents: 0x2::bag::new(arg6)};
        let v2 = FeeConfig<T0, T1>{
            coin_start_fee_rate : arg3,
            coin_end_fee_rate   : arg4,
            fee_receiver        : arg5,
        };
        let v3 = Payload<T0, T1>{
            coin_start   : arg0,
            coin_end     : arg1,
            coin_end_min : arg2,
            next         : v1,
            fee_config   : v2,
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        v3
    }

    public(friend) fun take_next<T0, T1, T2>(arg0: &mut Payload<T0, T1>) : 0x2::coin::Coin<T2> {
        let v0 = &mut arg0.next;
        remove<0x2::coin::Coin<T2>>(v0)
    }

    // decompiled from Move bytecode v6
}

