module 0x6455428357b855e8489eb3f6f129d429c9e9a55316b866532806d4b5a13dd7d5::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"Suix", b"$SUIX Will be the number one meme coin on Sui. HODL tight and SEND it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1781292643345.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

