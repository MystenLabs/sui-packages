module 0x1df9a387fb9aac4fe39bb33c3049705f9c74e73a80d04db25164a7c139b870da::suigi {
    struct SUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGI>(arg0, 6, b"SUIGI", b"Luigi on Sui", b"SUIGI CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c4e0365edc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

