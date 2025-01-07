module 0x8cbd74f409dda2c796694db8d38537d65853ac4d7609d705ce0d823e9d41fc11::donke {
    struct DONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKE>(arg0, 6, b"DONKE", b"DONKE SUI", b"$DONKE is the wildest, meme-lovin' degen on the SUI pasture! Grab yer golden carrots and join the mayhem. It's all about wild bets, crazy memes, and market moves more unpredictable than a donkey on roller skates.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yiji6_TWUA_Ae0_QG_4dbc84c562.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

