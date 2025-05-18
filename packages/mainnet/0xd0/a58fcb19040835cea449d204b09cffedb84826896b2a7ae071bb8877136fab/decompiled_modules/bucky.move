module 0xd0a58fcb19040835cea449d204b09cffedb84826896b2a7ae071bb8877136fab::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKY>(arg0, 6, b"BUCKY", b"Bucky on SUI", b"Bucky has traveled through the chain multiverse, clearing all chains of the evil 'toad' devs. Bucky's mission is to stop all rug pulls, and SUI is next.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigcenihmbpax6p3xu3z4dzqvczu5fxfj4h3mianu2ixvl6sv2wca4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUCKY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

