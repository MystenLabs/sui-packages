module 0x6b9a5437601cd074eee0f7ffc9878df9f7aa32b3dcb4b725791ad7645dcf155f::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYE>(arg0, 6, b"EYE", b"SUI11UMINATI", b"CHECK THIS EYE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xbc6ea276863701a6251dca99acaa7b268398424d890185b34262894a6237f56b_eye_eye_c8864a5152.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

