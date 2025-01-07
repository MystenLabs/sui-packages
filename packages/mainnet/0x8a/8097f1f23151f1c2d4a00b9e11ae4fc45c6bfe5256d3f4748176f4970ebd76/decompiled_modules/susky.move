module 0x8a8097f1f23151f1c2d4a00b9e11ae4fc45c6bfe5256d3f4748176f4970ebd76::susky {
    struct SUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSKY>(arg0, 6, b"SUSKY", b"The Husky of Sui", b"SUSKY (The Husky of Sui) is here to lead the pack on the Sui Network. This husky is loyal, fierce, and ready to run wild.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zodiac000z_mascot_logo_design_of_a_husky_with_sunglassescoin_ra_85b76b38_5c49_416d_9d39_8d3e0c496256_2_6f372d391e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

