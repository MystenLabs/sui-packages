module 0x39b4bad472a7f83d897c7c6859b4157df62f9588cce194316d89793c276c6d6c::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"Puff", b"Puffcat", b"PUFFCAT is a fun, transparent token where the community leads the project's direction with memes, games, giveaways, burns, and a growing culture of cat lovers & crypto fans. No fake promises. No over-engineered utility. Just community, memes, and fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4odnvc2earg4s5zc3in6mnlrr527mtxdafr5d646sgohfaaqn74")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

