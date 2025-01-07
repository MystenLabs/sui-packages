module 0xeae47982ad92c197edd1ef1c872f2eea53fff960eb54c6d364d82930bdd3f60d::cabals {
    struct CABALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CABALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CABALS>(arg0, 6, b"Cabals", b"Cabals DAO", x"436162616c732061726520616e6f6e796d6f75732e0a0a224f72646f20414220436162616c7322206973206f7572206d6f74746f2c7472616e736c6174656420746f20e2809c4f726465722066726f6d20436162616c732ce2809d20697320616c736f206173736f636961746564207769746820616e6f74686572206c6174696e20706872617365224c757820496e2054656e6562726973222c7768696368207472616e736c6174657320746f20e2809c4c696768742066726f6d204461726b6e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730470349006.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CABALS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CABALS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

