module 0xc28f4c48bb228ff55b1beee2398c37701fc3bef9394a54c4012213a56f6d47ee::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"HIPPO", b"Sui hippo", b"The drippiest HIPPO on CT First mover of SUI THE HIPPO THAT HOPS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieerompv67pwcbrlky2r2qxyev2somfekrzjg2xc2asoidxfn7ykq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIPPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

