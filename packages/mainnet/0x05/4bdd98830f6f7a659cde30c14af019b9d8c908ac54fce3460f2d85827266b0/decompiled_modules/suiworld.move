module 0x54bdd98830f6f7a659cde30c14af019b9d8c908ac54fce3460f2d85827266b0::suiworld {
    struct SUIWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIWORLD>(arg0, 6, b"SUIWORLD", b"Suiworld", b"Suiworld is a fun and interactive meme coin inspired by the chaotic world of internet culture. Join the Suiworld community today and embrace the randomness of memes and crypto combined! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/cCBZCJ.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIWORLD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWORLD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

