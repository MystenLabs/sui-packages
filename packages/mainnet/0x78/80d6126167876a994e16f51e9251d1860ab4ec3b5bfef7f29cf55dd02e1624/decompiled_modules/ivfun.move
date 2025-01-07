module 0x7880d6126167876a994e16f51e9251d1860ab4ec3b5bfef7f29cf55dd02e1624::ivfun {
    struct IVFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVFUN>(arg0, 9, b"IVFUN", b"IvFun", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd3a56c3-5b0a-482a-a702-0556dd75cbc8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

