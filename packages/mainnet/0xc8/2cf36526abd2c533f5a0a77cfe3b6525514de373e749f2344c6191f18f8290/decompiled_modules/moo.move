module 0xc82cf36526abd2c533f5a0a77cfe3b6525514de373e749f2344c6191f18f8290::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 9, b"MOO", b"MOODENG", b"Moo Deng is a pygmy hippopotamus living in Khao Kheow Open Zoo in Si Racha, Chonburi, Thailand. She is the cutest animal on planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeFni99y4B9vkKqH21nTYMgPPGpB7B5BeAvx81g2UySdF")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOO>>(v1);
        0x2::coin::mint_and_transfer<MOO>(&mut v2, 10000000000 * 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

