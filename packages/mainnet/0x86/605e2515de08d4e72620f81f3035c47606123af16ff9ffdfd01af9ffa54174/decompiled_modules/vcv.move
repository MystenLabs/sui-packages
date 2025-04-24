module 0x86605e2515de08d4e72620f81f3035c47606123af16ff9ffdfd01af9ffa54174::vcv {
    struct VCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCV>(arg0, 9, b"VCV", b"vxcv", b"dsafsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamm-assets.s3.amazonaws.com/token-icon.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

