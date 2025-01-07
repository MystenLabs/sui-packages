module 0x99353f52689d4c3dedb3676b3a3fc0163b3c70f3658adace65df94f9b92cbc13::RamCrierHorns {
    struct RAMCRIERHORNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMCRIERHORNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMCRIERHORNS>(arg0, 0, b"COS", b"RamCrier Horns", b"Song of mourning... yes, pride... moan of the pitiful who know of only what, not why...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_RamCrier_Horns.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAMCRIERHORNS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMCRIERHORNS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

