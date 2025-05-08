module 0xd4ac21eec2333f627fc6a39b08f1d64a395f0393060e0e7d80d17d05d34ea7b4::mto {
    struct MTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTO>(arg0, 6, b"MTO", b"Matrix Oracle", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieulnc4z3uaqjhtjie4y52if4m3jwgmzctoe64qisbaqfb4fb6d4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

