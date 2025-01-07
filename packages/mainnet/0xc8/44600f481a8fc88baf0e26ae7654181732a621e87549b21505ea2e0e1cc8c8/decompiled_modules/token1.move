module 0xc844600f481a8fc88baf0e26ae7654181732a621e87549b21505ea2e0e1cc8c8::token1 {
    struct TOKEN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN1>(arg0, 6, b"Token1", b"Token", b"Tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732611972571.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

