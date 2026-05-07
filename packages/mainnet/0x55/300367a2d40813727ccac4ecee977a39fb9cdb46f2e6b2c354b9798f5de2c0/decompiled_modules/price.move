module 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price {
    struct Price has copy, drop, store {
        price: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64,
        conf: u64,
        expo: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64,
        timestamp: u64,
    }

    public fun get_conf(arg0: &Price) : u64 {
        arg0.conf
    }

    public fun get_expo(arg0: &Price) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        arg0.expo
    }

    public fun get_price(arg0: &Price) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        arg0.price
    }

    public fun get_timestamp(arg0: &Price) : u64 {
        arg0.timestamp
    }

    public fun new(arg0: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64, arg1: u64, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64, arg3: u64) : Price {
        Price{
            price     : arg0,
            conf      : arg1,
            expo      : arg2,
            timestamp : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

