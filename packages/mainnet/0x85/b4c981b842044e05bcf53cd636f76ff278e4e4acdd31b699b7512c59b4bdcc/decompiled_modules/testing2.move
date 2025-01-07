module 0x85b4c981b842044e05bcf53cd636f76ff278e4e4acdd31b699b7512c59b4bdcc::testing2 {
    struct TESTING2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING2>(arg0, 6, b"Testing2", b"Test", b"testingwithhat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732583544940.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTING2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

