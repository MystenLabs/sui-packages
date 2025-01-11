module 0x861af922a117f0e08190bc798f678f585ea4f0048cccadd1d3eac4ac5ba82024::shr0 {
    struct SHR0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHR0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHR0>(arg0, 9, b"SHR0", b"SroomAI DAO", b"SroomAI DAO - the first AI hedge fund for AI projects investment on SUI. In a virtual psychedelic mushroom lab, AI-driven waifu scientists pioneer innovation of technology and magic fungi. The DAO specializes in exploring, cultivating, and trading unique virtual magic mushrooms, revolutionized virtual trippy culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidaos.com/daos/0xc40f9a096a91db2743e437cd8566ea8f2e6e1a1d0b2e02824a5834cb875e4a9e.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHR0>>(0x2::coin::mint<SHR0>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHR0>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHR0>>(v2);
    }

    // decompiled from Move bytecode v6
}

