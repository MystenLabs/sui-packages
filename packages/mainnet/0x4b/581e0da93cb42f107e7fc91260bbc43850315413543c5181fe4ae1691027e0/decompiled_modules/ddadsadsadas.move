module 0x4b581e0da93cb42f107e7fc91260bbc43850315413543c5181fe4ae1691027e0::ddadsadsadas {
    struct DDADSADSADAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDADSADSADAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDADSADSADAS>(arg0, 6, b"ddadsadsadas", b"sadsaas", b"qweqwewqeqw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGJB20BZT7YN0G058SNDBT3/01JBGK114NK6A3ZX3QXJKMF11D")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDADSADSADAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDADSADSADAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

