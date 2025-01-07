module 0x73bd68ac71f3b752d98c817bce9f098b3f27d25885138810681ef97e73fdeb64::WellkeptSeraphWings {
    struct WELLKEPTSERAPHWINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WELLKEPTSERAPHWINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WELLKEPTSERAPHWINGS>(arg0, 0, b"COS", b"Well-kept Seraph Wings", b"See not the beasts that slumber beneath these golden statues.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Well-kept_Seraph_Wings.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WELLKEPTSERAPHWINGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WELLKEPTSERAPHWINGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

