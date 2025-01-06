module 0x217dc81cec74823511bc39ed0157e251638d6e443250571bf104825459f2699c::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Donald Trump by SuiAI", b"Donald J. Trump, upon resuming the presidency of the United States on January 20, promises to make a significant impact not only on global politics but also on the world of cryptocurrencies. Known for his firm stances and his ability to shape economic narratives, his inauguration signals a potential period of clearer regulations and increased governmental attention to the crypto sector. While some experts see this as an opportunity to further legitimize the market, others warn of possible restrictions that could affect decentralization, one of the fundamental pillars of cryptocurrencies. His approach to the digital economy will be closely watched by investors and enthusiasts, as it could redefine the future of the crypto space on a global scale...#Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/TRUMP_4_bc990ebacc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

