module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price {
    struct Price has copy, drop, store {
        price: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64,
        conf: u64,
        expo: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64,
        timestamp: u64,
    }

    public fun get_conf(arg0: &Price) : u64 {
        arg0.conf
    }

    public fun get_expo(arg0: &Price) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64 {
        arg0.expo
    }

    public fun get_price(arg0: &Price) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64 {
        arg0.price
    }

    public fun get_timestamp(arg0: &Price) : u64 {
        arg0.timestamp
    }

    public fun new(arg0: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64, arg1: u64, arg2: 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::i64::I64, arg3: u64) : Price {
        Price{
            price     : arg0,
            conf      : arg1,
            expo      : arg2,
            timestamp : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

