module 0xdb211534ed83d4f655027fd575fdd6aa542662a8eeb3ffc0d60c573b1a22cfe1::price_oracle {
    struct PriceObject has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        price: u64,
        timestamp_ms: u64,
        decimals: u8,
    }

    public entry fun create_price_object(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceObject{
            id           : 0x2::object::new(arg4),
            symbol       : 0x1::string::utf8(arg0),
            price        : arg1,
            timestamp_ms : arg2,
            decimals     : arg3,
        };
        0x2::transfer::transfer<PriceObject>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun decimals(arg0: &PriceObject) : u8 {
        arg0.decimals
    }

    public fun price(arg0: &PriceObject) : u64 {
        arg0.price
    }

    public fun symbol(arg0: &PriceObject) : 0x1::string::String {
        arg0.symbol
    }

    public fun timestamp_ms(arg0: &PriceObject) : u64 {
        arg0.timestamp_ms
    }

    public entry fun update_price(arg0: &mut PriceObject, arg1: u64, arg2: u64) {
        arg0.price = arg1;
        arg0.timestamp_ms = arg2;
    }

    // decompiled from Move bytecode v6
}

