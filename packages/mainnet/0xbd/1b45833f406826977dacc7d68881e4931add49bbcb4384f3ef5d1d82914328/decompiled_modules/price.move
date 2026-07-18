module 0xbd1b45833f406826977dacc7d68881e4931add49bbcb4384f3ef5d1d82914328::price {
    struct Price has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        value_e6: u64,
        publish_time_ms: u64,
    }

    public fun assert_coin<T0>(arg0: &Price) {
        assert!(arg0.coin_type == 0x1::type_name::with_defining_ids<T0>(), 2);
    }

    public fun assert_fresh(arg0: &Price, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.publish_time_ms, 0);
        assert!(v0 - arg0.publish_time_ms <= arg2, 0);
    }

    public fun coin_type(arg0: &Price) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64) : Price {
        assert!(arg0 > 0, 1);
        Price{
            coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            value_e6        : arg0,
            publish_time_ms : arg1,
        }
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun quote_value_e6<T0>(arg0: &Price, arg1: u64, arg2: u8) : u64 {
        assert_coin<T0>(arg0);
        (((arg1 as u128) * (arg0.value_e6 as u128) / (pow10((arg2 as u64)) as u128)) as u64)
    }

    public fun value_e6(arg0: &Price) : u64 {
        arg0.value_e6
    }

    // decompiled from Move bytecode v7
}

