module 0x42b9717a472bcbb21b2c0313c6b4b6115c954bdd7b466c3e4430f01a0e1c65f8::token_sui {
    struct TOKEN_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_SUI>(arg0, 9, b"SUICK", b"Suck Sui Coin", b"The official unofficial Sui mascot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/pop-art-pin-up-young-sexy-punk-girl-sucks-lollipop-vector-illustration-heart-90309761.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN_SUI>>(0x2::coin::mint<TOKEN_SUI>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

