module 0x521b8f57fb629fce2600d3359351a4fb5438f32ffe282b7a4440050fb4f80820::omgf {
    struct OMGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMGF>(arg0, 6, b"OMGF", b"OMGFire", b"OMGF is all you need", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_Tx_Wui_M_Am_1736790682800_raw_min_b9f95f386a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

