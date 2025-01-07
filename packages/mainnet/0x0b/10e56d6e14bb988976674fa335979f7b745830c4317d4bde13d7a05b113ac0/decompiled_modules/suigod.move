module 0xb10e56d6e14bb988976674fa335979f7b745830c4317d4bde13d7a05b113ac0::suigod {
    struct SUIGOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOD>(arg0, 6, b"SUIGOD", b"Poseidon", b"Poseidon is the god who gives water, which means life, to everyone, but he can also take it away if he's not happy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBKG7QA987KP3W1K106AB7VM/01JBKG9BPKKB1XDPY7QDMWWTW4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

