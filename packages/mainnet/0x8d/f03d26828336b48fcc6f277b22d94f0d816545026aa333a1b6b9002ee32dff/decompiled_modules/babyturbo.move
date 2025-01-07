module 0x8df03d26828336b48fcc6f277b22d94f0d816545026aa333a1b6b9002ee32dff::babyturbo {
    struct BABYTURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTURBO>(arg0, 6, b"BabyTurbo", b"BabyTurboToken", x"4675656c2075702077697468202442616279547572626f20e2809320746865206d656d6520636f696e2074686174e280997320676f742074686520706f77657220746f20626c617374206f66662120204a6f696e2074686520747572626f2066616d696c7920616e64206c6574e2809973207261636520746f20746865206d6f6f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954390971.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYTURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

