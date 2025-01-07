module 0xd0db74ec644f1763c986e46c2d0e164f3bf9c8ea81771fdcb103ed5750821593::agnus {
    struct AGNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGNUS>(arg0, 6, b"AGNUS", b"Sui Black Agnus", b"Sui Black Agnus ($AGNUS) is a revolutionary SUI project that combines the viral energy of meme culture with the transformative power of decentralized finance. Designed to be both a fun and rewarding experience for its holders, AGNUS aims to break the mold of traditional meme tokens by providing real-world financial utility while maintaining the light-hearted spirit of the internets most beloved memes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ti8_Ilw5_R_400x400_0c6a3ed663.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

