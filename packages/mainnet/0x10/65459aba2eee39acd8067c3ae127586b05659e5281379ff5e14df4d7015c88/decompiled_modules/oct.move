module 0x1065459aba2eee39acd8067c3ae127586b05659e5281379ff5e14df4d7015c88::oct {
    struct OCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCT>(arg0, 6, b"OCT", b"october", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

