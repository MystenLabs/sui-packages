module 0x487060bb768cafc2da5a17d66d4251ac3558ebf2165b9b4cd8ff583b6a6310ce::fack {
    struct FACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACK>(arg0, 6, b"FACK", b"FIRE ACK", b"FUD BUY FUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732140909641.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

