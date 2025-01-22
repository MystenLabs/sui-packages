module 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::price_data {
    struct PriceData has store {
        feed_id: vector<u8>,
        value: u256,
        timestamp: u64,
        write_timestamp: u64,
    }

    public fun default(arg0: vector<u8>) : PriceData {
        PriceData{
            feed_id         : arg0,
            value           : 0,
            timestamp       : 0,
            write_timestamp : 0,
        }
    }

    public fun feed_id(arg0: &PriceData) : vector<u8> {
        arg0.feed_id
    }

    public fun price(arg0: &PriceData) : u256 {
        arg0.value
    }

    public fun price_and_timestamp(arg0: &PriceData) : (u256, u64) {
        (arg0.value, arg0.timestamp)
    }

    public fun timestamp(arg0: &PriceData) : u64 {
        arg0.timestamp
    }

    public(friend) fun update(arg0: &mut PriceData, arg1: vector<u8>, arg2: u256, arg3: u64, arg4: u64) {
        arg0.feed_id = arg1;
        arg0.value = arg2;
        arg0.timestamp = arg3;
        arg0.write_timestamp = arg4;
    }

    public fun write_timestamp(arg0: &PriceData) : u64 {
        arg0.write_timestamp
    }

    // decompiled from Move bytecode v6
}

