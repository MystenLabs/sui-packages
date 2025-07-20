module 0xac9f70ab81cc6aebb4efe6b6a5349a9f4ab491fd2c591a2027b9985ca825aedd::aa {
    struct AA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AA>(arg0, 6, b"AA", b"a", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250720_173706_com_android_chrome_3935a5d60f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

