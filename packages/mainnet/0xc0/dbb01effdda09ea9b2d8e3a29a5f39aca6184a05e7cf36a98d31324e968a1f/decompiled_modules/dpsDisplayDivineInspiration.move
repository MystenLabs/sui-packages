module 0xc0dbb01effdda09ea9b2d8e3a29a5f39aca6184a05e7cf36a98d31324e968a1f::dpsDisplayDivineInspiration {
    struct DPSDISPLAYDIVINEINSPIRATION has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPSDISPLAYDIVINEINSPIRATION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPSDISPLAYDIVINEINSPIRATION>(arg0, 0, b"COS", b"dp's Display, Divine Inspiration", b"The time has come to tell us a story...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_dps_Display_Divine_Inspiration.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DPSDISPLAYDIVINEINSPIRATION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPSDISPLAYDIVINEINSPIRATION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

