module 0xceb95c02e1632d73ea8d48a0df9c46cb5b38f56ce03e71b465783df9caf59f03::SQRR {
    struct SQRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQRR>(arg0, 8, b"SQRR", b"SQUARE", b"SQUARE is a token that aims to facilitate community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeief6mcru55intv6lf2ohnlfzxclpqlxr4yxkctevi6zpsdclh32eq.ipfs.w3s.link/agora-logo_-_Brian_Oh.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

