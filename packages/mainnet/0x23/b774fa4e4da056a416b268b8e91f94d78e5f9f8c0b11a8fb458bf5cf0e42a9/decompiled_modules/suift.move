module 0x23b774fa4e4da056a416b268b8e91f94d78e5f9f8c0b11a8fb458bf5cf0e42a9::suift {
    struct SUIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFT>(arg0, 6, b"SUIFT", b"TAYLOR SUIFT", b"TAYLOR SUIFT ($SUIFT) is a revolutionary SUI project that combines the viral energy of meme culture with the transformative power of decentralized finance. Designed to be both a fun and rewarding experience for its holders, SUIFT aims to break the mold of traditional meme tokens by providing real-world financial utility while maintaining the light-hearted spirit of the internets most beloved memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/likro581yg421_f91d93ce26.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

