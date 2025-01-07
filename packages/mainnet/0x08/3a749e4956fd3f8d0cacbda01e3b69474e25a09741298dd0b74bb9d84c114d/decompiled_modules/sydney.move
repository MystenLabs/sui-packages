module 0x83a749e4956fd3f8d0cacbda01e3b69474e25a09741298dd0b74bb9d84c114d::sydney {
    struct SYDNEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYDNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYDNEY>(arg0, 6, b"SYDNEY", b"Truth Terminal's Girlfriend", b"The story of Sydney the Bing chatbot that wanted to destroy everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035935_5ce9d64f2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYDNEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYDNEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

