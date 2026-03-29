module 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::price {
    struct Price has copy, drop, store {
        price: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64,
        conf: u64,
        expo: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64,
        timestamp: u64,
    }

    public fun get_conf(arg0: &Price) : u64 {
        arg0.conf
    }

    public fun get_expo(arg0: &Price) : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64 {
        arg0.expo
    }

    public fun get_price(arg0: &Price) : 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64 {
        arg0.price
    }

    public fun get_timestamp(arg0: &Price) : u64 {
        arg0.timestamp
    }

    public fun new(arg0: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64, arg1: u64, arg2: 0x1359dac4d63abc896caa6a8971e4affec7c75590944ca33186c48c614a80583a::i64::I64, arg3: u64) : Price {
        Price{
            price     : arg0,
            conf      : arg1,
            expo      : arg2,
            timestamp : arg3,
        }
    }

    // decompiled from Move bytecode v6
}

