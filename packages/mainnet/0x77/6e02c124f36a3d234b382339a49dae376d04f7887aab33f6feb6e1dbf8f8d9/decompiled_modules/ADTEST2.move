module 0x776e02c124f36a3d234b382339a49dae376d04f7887aab33f6feb6e1dbf8f8d9::ADTEST2 {
    struct ADTEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADTEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADTEST2>(arg0, 8, b"ADTEST2", b"ADTEST2", b"AGORA is a token that aims to facilitate community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeief6mcru55intv6lf2ohnlfzxclpqlxr4yxkctevi6zpsdclh32eq.ipfs.w3s.link/agora-logo_-_Brian_Oh.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADTEST2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADTEST2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

