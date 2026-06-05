module 0xcf0f4be1aa3df7d71d0736c663953b8aae7c4613e86e4bae02cc00f9c7c3fde0::jur {
    struct JUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUR>(arg0, 9, b"JUR", b"JURRIEN", b"Test token created via noodles-sdk script", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JUR>>(0x2::coin::mint<JUR>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

