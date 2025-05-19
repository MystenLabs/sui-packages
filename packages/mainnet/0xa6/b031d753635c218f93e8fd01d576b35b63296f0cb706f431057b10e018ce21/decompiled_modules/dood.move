module 0xa6b031d753635c218f93e8fd01d576b35b63296f0cb706f431057b10e018ce21::dood {
    struct DOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOD>(arg0, 6, b"Dood", b"Doodles", b"Yes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxxsx7zdmwwau7kgdzu5qywe5xenxtkbrw5ynhccnhym2ews5v6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

