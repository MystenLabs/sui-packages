module 0x1122bb9f1fbd168cce4c2325c3da7d636081078d23e560472781816d8e1897e3::price {
    struct Price has copy, drop, store {
        value_e6: u64,
        publish_time_ms: u64,
    }

    public fun assert_fresh(arg0: &Price, arg1: &0x2::clock::Clock, arg2: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.publish_time_ms, 0);
        assert!(v0 - arg0.publish_time_ms <= arg2, 0);
    }

    public fun new(arg0: u64, arg1: u64) : Price {
        assert!(arg0 > 0, 1);
        Price{
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

    public fun quote_value_e6(arg0: &Price, arg1: u64, arg2: u8) : u64 {
        (((arg1 as u128) * (arg0.value_e6 as u128) / (pow10((arg2 as u64)) as u128)) as u64)
    }

    public fun value_e6(arg0: &Price) : u64 {
        arg0.value_e6
    }

    // decompiled from Move bytecode v7
}

