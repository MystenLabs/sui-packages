module 0x12c633904b813bf7d28f7d7c9fa880e8e1552e8341f3f9d0a93ffe180fde96d8::common_event {
    struct SomisTradeEvent has copy, drop {
        version: u64,
        action: 0x1::ascii::String,
        wallet: address,
        nft: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    public fun emit_somis_trade_event<T0: store + key, T1>(arg0: 0x1::ascii::String, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SomisTradeEvent{
            version  : 1,
            action   : arg0,
            wallet   : 0x2::tx_context::sender(arg3),
            nft      : arg1,
            price    : arg2,
            nft_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<SomisTradeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

