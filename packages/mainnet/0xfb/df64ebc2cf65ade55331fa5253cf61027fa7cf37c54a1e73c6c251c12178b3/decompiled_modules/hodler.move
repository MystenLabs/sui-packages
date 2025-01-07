module 0xfbdf64ebc2cf65ade55331fa5253cf61027fa7cf37c54a1e73c6c251c12178b3::hodler {
    struct HODLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HODLER>(arg0, 9, b"HODLER", b"Sui Hodler", b"Sui Hodler is a decentralized token designed for long-term supporters of the SUI blockchain. Built for fast, secure, and scalable transactions, it rewards dedicated holders while powering a robust DeFi ecosystem. With its focus on growth and stability, Sui Hodler encourages users to invest in the future of decentralized finance and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834156836427059200/VCgpGbZp.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HODLER>(&mut v2, 700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

