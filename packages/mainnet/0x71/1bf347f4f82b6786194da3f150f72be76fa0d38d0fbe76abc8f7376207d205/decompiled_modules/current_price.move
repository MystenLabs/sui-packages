module 0x711bf347f4f82b6786194da3f150f72be76fa0d38d0fbe76abc8f7376207d205::current_price {
    struct CurrentPrice has copy, drop {
        coin_type: 0x1::ascii::String,
        price: u64,
        decimals: u8,
        timestamp_ms: u64,
    }

    public fun coin_type(arg0: &CurrentPrice) : 0x1::ascii::String {
        arg0.coin_type
    }

    public fun decimals(arg0: &CurrentPrice) : u8 {
        arg0.decimals
    }

    public(friend) fun new_current_price(arg0: 0x1::ascii::String, arg1: u64, arg2: u8, arg3: u64) : CurrentPrice {
        CurrentPrice{
            coin_type    : arg0,
            price        : arg1,
            decimals     : arg2,
            timestamp_ms : arg3,
        }
    }

    public fun price(arg0: &CurrentPrice) : u64 {
        arg0.price
    }

    public fun timestamp_ms(arg0: &CurrentPrice) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

