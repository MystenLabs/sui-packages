module 0xda07c3343f1dc2393545175eb39bee8dc4a3378d5f36ddb212f6d23e6f06b6b2::dsai {
    struct DSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DSAI>(arg0, 6, b"DSAI", b"dog sleep ai ", b"the sleeping of dog ai .first staff sleep on sui.IS not a token IS just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000024535_df6c7e2a65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

