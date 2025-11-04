module 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price {
    struct RawPrice has copy, drop, store {
        price: u128,
        expiry: u64,
    }

    struct Price<phantom T0, phantom T1> has copy, drop {
        price: u128,
        expiry: u64,
        is_inversed: bool,
    }

    public fun get_base_name<T0, T1>(arg0: &Price<T0, T1>) : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    public fun get_expiry<T0, T1>(arg0: &Price<T0, T1>) : u64 {
        arg0.expiry
    }

    public fun get_inverse_price<T0, T1>(arg0: &Price<T0, T1>) : Price<T1, T0> {
        Price<T1, T0>{
            price       : 1000000000000000000 * 1000000000000000000 / arg0.price,
            expiry      : arg0.expiry,
            is_inversed : true,
        }
    }

    public fun get_price<T0, T1>(arg0: &Price<T0, T1>) : u128 {
        arg0.price
    }

    public fun get_quote_name<T0, T1>(arg0: &Price<T0, T1>) : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())
    }

    public fun get_raw<T0, T1>(arg0: &Price<T0, T1>) : RawPrice {
        RawPrice{
            price  : arg0.price,
            expiry : arg0.expiry,
        }
    }

    public fun get_valid_price<T0, T1>(arg0: &Price<T0, T1>, arg1: &0x2::clock::Clock) : u128 {
        assert!(arg0.expiry < 0x2::clock::timestamp_ms(arg1), 0);
        arg0.price
    }

    public fun into_price<T0, T1>(arg0: &RawPrice) : Price<T0, T1> {
        Price<T0, T1>{
            price       : arg0.price,
            expiry      : arg0.expiry,
            is_inversed : false,
        }
    }

    public fun is_expired<T0, T1>(arg0: &Price<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry < 0x2::clock::timestamp_ms(arg1)
    }

    public fun is_inversed<T0, T1>(arg0: &Price<T0, T1>) : bool {
        arg0.is_inversed
    }

    public fun new_price<T0, T1>(arg0: u128, arg1: u64) : Price<T0, T1> {
        Price<T0, T1>{
            price       : arg0,
            expiry      : arg1,
            is_inversed : false,
        }
    }

    // decompiled from Move bytecode v6
}

