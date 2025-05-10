module 0xc96dd1439ebd78b87cea86c65e88cc7949d578a4cd5cd59ce9e3cf72905e872c::bulba {
    struct BULBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBA>(arg0, 6, b"BULBA", b"Bulbasui", b"The OG veggy frog of Sui! $BULBA blends Bulbasaur vibes with Sui-chain spice. No devs, no roadmap just meme magic and pure community power. Catch it before", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif7xa2cqyqauckenfkw7y355t5fx4y7pbm2vrldzt53guqejhfpyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

