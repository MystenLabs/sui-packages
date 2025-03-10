module 0x7c86622623119a1313295a0791c72c2fa74ce90688a858768b824fca828bf403::test12token {
    struct TEST12TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST12TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741590176255.png"));
        let (v1, v2) = 0x2::coin::create_currency<TEST12TOKEN>(arg0, 6, b"TT", b"Test12Token", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST12TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST12TOKEN>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TEST12TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST12TOKEN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

