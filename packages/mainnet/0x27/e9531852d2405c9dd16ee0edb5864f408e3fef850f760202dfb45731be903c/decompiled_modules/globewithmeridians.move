module 0x27e9531852d2405c9dd16ee0edb5864f408e3fef850f760202dfb45731be903c::globewithmeridians {
    struct GLOBEWITHMERIDIANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOBEWITHMERIDIANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GLOBEWITHMERIDIANS>(arg0, 6, b"GLOBEWITHMERIDIANS", b"GLOBE WITH MERIDIANS", b"SuiEmoji Globe with Meridians", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/globewithmeridians.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLOBEWITHMERIDIANS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOBEWITHMERIDIANS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

