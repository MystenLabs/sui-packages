module 0x1b168ccad0f422949b507278caab4f0681603807ae02c68fd5f77346454325b4::shower {
    struct SHOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWER>(arg0, 6, b"SHOWER", b"SUI SHOWER", b"Its time to take a shower", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigqp4vc6wvcch2sanpfgzbh4fflar7f43vasow3awft55pmhynfi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOWER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

