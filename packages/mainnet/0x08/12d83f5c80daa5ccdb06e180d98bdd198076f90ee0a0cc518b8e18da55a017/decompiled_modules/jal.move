module 0x812d83f5c80daa5ccdb06e180d98bdd198076f90ee0a0cc518b8e18da55a017::jal {
    struct JAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAL>(arg0, 6, b"JAL", b"jeeters are losers", x"706c65617365206c6574e280997320737461727420686f6c64696e67204d696e74656420627920405072656369646f626f7373206f6e204172656e612e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737049884025.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

