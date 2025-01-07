module 0xe124f89b876e76d2952e607da082e466566eb7daaee011bbaa816e5799c9f71d::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"Sui Slime", b"Slime Token is a vibrant and innovative cryptocurrency designed to provide a fun yet functional approach to digital finance. With a sleek, blue-themed identity, Slime Token is built on the SUI network, offering fast, secure, and decentralized transactions. Its slimy, liquid-like visuals represent its fluidity and adaptability in the ever-evolving crypto space. Slime Token aims to engage a wide range of users, from crypto enthusiasts to newcomers, while supporting decentralized finance (DeFi) applications and community-driven projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuplikan_layar_2024_10_16_223103_e8dccbd502.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

