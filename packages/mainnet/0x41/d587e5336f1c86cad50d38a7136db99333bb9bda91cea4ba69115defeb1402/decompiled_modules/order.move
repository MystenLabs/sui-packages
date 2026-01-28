module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::order {
    struct Order<phantom T0> {
        coin: 0x2::coin::Coin<T0>,
        expiry_ms: u64,
        min_amount_out: u64,
        nonce: 0x1::string::String,
    }

    public fun amount_in<T0>(arg0: &Order<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.coin)
    }

    public fun assert_can_execute<T0>(arg0: &Order<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.expiry_ms >= 0x2::clock::timestamp_ms(arg1), 13835621194214277123);
    }

    public fun expiry_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.expiry_ms
    }

    public(friend) fun finalize<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock) : 0x2::coin::Coin<T0> {
        assert_can_execute<T0>(&arg0, arg1);
        let Order {
            coin           : v0,
            expiry_ms      : _,
            min_amount_out : _,
            nonce          : _,
        } = arg0;
        v0
    }

    public fun min_amount_out<T0>(arg0: &Order<T0>) : u64 {
        arg0.min_amount_out
    }

    public fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) : Order<T0> {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4), 13835339671992795137);
        assert!(arg2 > 0, 13835902626241445893);
        Order<T0>{
            coin           : arg0,
            expiry_ms      : arg1,
            min_amount_out : arg2,
            nonce          : arg3,
        }
    }

    public fun nonce<T0>(arg0: &Order<T0>) : 0x1::string::String {
        arg0.nonce
    }

    // decompiled from Move bytecode v6
}

