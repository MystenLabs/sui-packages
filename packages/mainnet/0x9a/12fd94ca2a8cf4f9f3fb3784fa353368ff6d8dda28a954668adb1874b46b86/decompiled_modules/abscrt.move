module 0x9a12fd94ca2a8cf4f9f3fb3784fa353368ff6d8dda28a954668adb1874b46b86::abscrt {
    struct ABSCRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABSCRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABSCRT>(arg0, 6, b"Abscrt", b"Abstraction", b"Abstraction refers to the concept of simplifying complex systems or ideas by focusing on the essential characteristics and ignoring irrelevant details.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732854499834.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABSCRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABSCRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

