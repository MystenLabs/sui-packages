module 0x73c46d6b146aa5eed3754e6146459f9128eba95ed1efffe6b33b099343608e16::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"rugNTUG", b"if you like solana you'll love this", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiepbtenn46aczeskisvhcq4sqyjcnuqv65uv52362cby4tfsy4npi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

