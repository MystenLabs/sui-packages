module 0x6e9fb23375fa6144693082b2e389ccd0ad13965ca9d9a68f0c3c30453e132e90::ash {
    struct ASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASH>(arg0, 6, b"ASH", b"ASH SUI", b"sdsdsdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigozlr4kqlx5zrbu2gyc2ooqeovw342o5pu7rfig3wryli6lghhla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

