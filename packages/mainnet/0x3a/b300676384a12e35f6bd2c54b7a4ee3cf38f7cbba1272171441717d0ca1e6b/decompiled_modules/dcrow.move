module 0x3ab300676384a12e35f6bd2c54b7a4ee3cf38f7cbba1272171441717d0ca1e6b::dcrow {
    struct DCROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCROW>(arg0, 6, b"DCROW", b"Diddy's Crow", b"Pecking balls left and right!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diddy_s_crow_jpg_c4039f18d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

