module 0x5cc8ad9b3d0432356b0e204f41a28dc85edbe9bf2488e48032a53b75f0ef1c1c::current_price {
    struct CurrentPrice has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        price: u64,
        decimals: u8,
        timestamp_ms: u64,
    }

    public fun coin_type(arg0: &CurrentPrice) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun decimals(arg0: &CurrentPrice) : u8 {
        arg0.decimals
    }

    public(friend) fun new_current_price(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u8, arg3: u64) : CurrentPrice {
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

