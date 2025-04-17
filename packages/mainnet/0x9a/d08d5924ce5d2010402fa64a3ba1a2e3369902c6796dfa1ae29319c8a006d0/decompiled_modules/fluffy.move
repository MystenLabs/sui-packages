module 0x9ad08d5924ce5d2010402fa64a3ba1a2e3369902c6796dfa1ae29319c8a006d0::fluffy {
    struct FLUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFFY>(arg0, 6, b"FLUFFY", b"Moon Fluffy", b"Born from stardust and marshmallow dreams, Moon Fluffy brings magic and sweetness to the SUI blockchain. First marshmallow token on moonbags , created by grok Ai on X.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreighi4xf35anc2xcfpbg4yo35rhccqb2arxuqclbtxtzlt5kptikxq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLUFFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

