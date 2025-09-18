module 0xefbc6055462cd073a9b103d5ccbd763b466531b91440546f9f5dd7697f9acdeb::weird {
    struct WEIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIRD>(arg0, 6, b"WEIRD", b"SuWeird", b"Suweird is a decentralized memecoin on the Sui blockchain, launched fairly through bonding curves to ensure equal access for all. More than just a meme, Suweird blends community-driven growth with transparent tokenomics and the upcoming NFT ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiavv47aslqj4dptwbgudaa64ngzrltpy5mzphknpd7c72gs64c7fa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEIRD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

