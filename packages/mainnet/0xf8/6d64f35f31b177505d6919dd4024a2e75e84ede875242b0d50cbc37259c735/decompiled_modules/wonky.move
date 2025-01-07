module 0xf86d64f35f31b177505d6919dd4024a2e75e84ede875242b0d50cbc37259c735::wonky {
    struct WONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONKY>(arg0, 6, b"Wonky", b"WonkyCat", x"546865206e6577657374206d656d6520636f696e206f6e20245355492e20426520746865206e6175676874792043617420696e204d616b65202353756920477265617420416761696e20776974682024574f4e4b592e2054473a68747470733a2f2f742e6d652f2b4d6270595744384a71415a6a4e6a6c6b204c41554e434820536f6f4e20235355c4b00a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731093154453.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WONKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

