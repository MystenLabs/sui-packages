module 0x8b55fbdf71d05cf0d4c4b2ea5d2ba1be14911ab146548ac16a05c21a745f4682::Red_Dot {
    struct RED_DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RED_DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RED_DOT>(arg0, 9, b"RD", b"Red Dot", b"red dot man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9090/kit/TemporaryCoinAvatar/01K3QSSZEKNJY1337YVMGX1FP7.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED_DOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RED_DOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

