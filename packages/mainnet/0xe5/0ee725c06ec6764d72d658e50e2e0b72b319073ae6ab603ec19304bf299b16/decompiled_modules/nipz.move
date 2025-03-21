module 0xe50ee725c06ec6764d72d658e50e2e0b72b319073ae6ab603ec19304bf299b16::nipz {
    struct NIPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1742528948509.jpg"));
        let (v1, v2) = 0x2::coin::create_currency<NIPZ>(arg0, 6, b"NIPZ", b"Nipz", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIPZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIPZ>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<NIPZ>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NIPZ>>(arg0);
    }

    // decompiled from Move bytecode v6
}

