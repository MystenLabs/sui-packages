module 0x379a67dcdde8c392a1b47644f70ebeffa45e933c6c0db7c42ba8411ea58842ed::PH {
    struct PH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PH>(arg0, 6, b"Phantom", b"PH", b"Playground", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PH>>(v1);
    }

    // decompiled from Move bytecode v6
}

