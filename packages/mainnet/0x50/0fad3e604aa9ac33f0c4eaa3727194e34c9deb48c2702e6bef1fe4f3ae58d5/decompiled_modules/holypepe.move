module 0x500fad3e604aa9ac33f0c4eaa3727194e34c9deb48c2702e6bef1fe4f3ae58d5::holypepe {
    struct HOLYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYPEPE>(arg0, 6, b"HOLYPEPE", b"HOLY PEPE SUI", b"Holy Pepe is a meme coin inspired by the legendary Pepe the Frog, with a divine twist. Combining humor and meme culture, it brings together a community of enthusiasts looking to have fun while exploring the holy potential of meme-based crypto. Powered by laughs and a sense of reverence for internet culture, Holy Pepe aims to go viral and reach meme heaven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_9_b77150360b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

