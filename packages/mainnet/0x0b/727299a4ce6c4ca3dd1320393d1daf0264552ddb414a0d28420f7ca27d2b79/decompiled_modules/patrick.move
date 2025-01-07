module 0xb727299a4ce6c4ca3dd1320393d1daf0264552ddb414a0d28420f7ca27d2b79::patrick {
    struct PATRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PATRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PATRICK>(arg0, 9, b"PATRICK", b"Pop Patrick", b"Pop Patrick is a meme token inspired by Patrick, the lovable starfish from \"SpongeBob SquarePants.\" With a humorous and laid-back theme, PatrickCoin brings a fun and entertaining vibe to the crypto world, making it a playful choice for meme enthusiasts and investors alike.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843609219020546048/8FTxwOco.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PATRICK>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PATRICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PATRICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

