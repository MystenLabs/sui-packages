module 0x92c20dc1b7e7f6de5f6338219e9d7ceb10837311a56f73f10a7134458e270431::susky {
    struct SUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSKY>(arg0, 6, b"SUSKY", b"The Husky of Sui", b"Meet The Husky of Sui, $SUSKY is here to lead the pack on the Sui Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_mascot_logo_design_of_a_husky_with_sunglassescoin_ra_85b76b38_5c49_416d_9d39_8d3e0c496256_2_eef7fca7ed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

