module 0xcdfffe45aaeaa428545b8259f69b1d5298798f485e10fd436e73b3c2e119960b::brettman {
    struct BRETTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTMAN>(arg0, 6, b"BRETTMAN", b"Brettman", b"Introducing Brettman, the newest memecoin hero to hit the crypto scene! Combining the laid-back charm and humor of Brett from \"Boy's Club\" with the legendary persona and bravery of Batman, Brettman brings a unique and exciting twist to the world of memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Icon_13_300x300_3adfa736a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

