module 0xfb3a0fa85c2bf6566ff9fd9414ce21f1a22e158ebfa58a729126e272fda5ae7::dftu {
    struct DFTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFTU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DFTU>(arg0, 6, b"DFTU", b"Don't F*ck This Up! by SuiAI", b"$DFTU is a tribute, a love affair, an ethos and best of all.... a Meme. The idea was born among Real Vision community members who love Crypto and Degening on Memes, NFTs, and Meme Coins. With $DFTU we aim to further the simple yet impactful message: 'Don't F*ck This Up!'. This is the opportunity of a lifetime to have fun, buy memes and wear diamonds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dftu_raoul_banner_0_5x_966b43a4_21594034b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DFTU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFTU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

