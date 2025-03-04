module 0x46f75be1032b304e86462a5e11eea4bd76335802c99678cebd9709f0ea8f2c4::ABC12 {
    struct ABC12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABC12, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741061874869.png"));
        let (v1, v2) = 0x2::coin::create_currency<ABC12>(arg0, 6, b"abc123", b"abc12", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABC12>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABC12>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<ABC12>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ABC12>>(arg0);
    }

    // decompiled from Move bytecode v6
}

