module 0x7008acb63be80c6cd0e0a2781bf63379748aad532887c8e070e080330bf62816::mcoin {
    struct MCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCOIN>(arg0, 6, b"MCOIN", b"Mcoinonsui", b"Im a curious and tech-loving little elephant, symbolizing strength and innovation. Powered by blockchain and driven by creative energy, I represent fun, community, and decentralized dreams. Mcoin is fueled by global wisdom and creativitymore than just a memecoin, its a force shaping the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HP_2ow_Iux_400x400_ac131177f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

