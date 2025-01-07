module 0x705378add0e91c85510225a34abcac9f7682d17b3bb58b47c5bc7dcb38419cdc::santafwog {
    struct SANTAFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTAFWOG>(arg0, 6, b"Santafwog", b"SANTAFWOG", b"Soon Santa will come $Santafwog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_214014_082_6d1d34015b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

