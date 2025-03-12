module 0xaf1ae87e20e1c21ffcfeeed41a61ae7b8a39f0eb4be282ba125ef01ab676bf5f::test2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741770641735.png"));
        let (v1, v2) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"test2", b"test2", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST2>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TEST2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST2>>(arg0);
    }

    // decompiled from Move bytecode v6
}

