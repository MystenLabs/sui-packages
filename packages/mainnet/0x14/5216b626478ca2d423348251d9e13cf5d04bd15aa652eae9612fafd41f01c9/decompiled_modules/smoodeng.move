module 0x145216b626478ca2d423348251d9e13cf5d04bd15aa652eae9612fafd41f01c9::smoodeng {
    struct SMOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOODENG>(arg0, 9, b"SMOODENG", b"Baby MooDeng", b"This is BMOODENG, a good hippo  We believe that meme coins epitomize the power of community and togetherness and that people can achieve greatness and freedom through decentralization and trust in code.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Moo1Mo9CqjQdyMwYAky5mVvf2eU5LiZiexRGFzQ1cqc.png?size=lg&key=903e1a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOODENG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOODENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

