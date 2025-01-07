module 0x3be44379210546280b90feb0f9e21ad74165919e6e6ddac53f396cad5e594097::catbull {
    struct CATBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBULL>(arg0, 6, b"CatBull", b"Cat Bull king", b"Built on sui, Meme Cat Token offers the chance to be part of a fun, dynamic ecosystem with unlimited potential. Backed by a strong and growing community, this token is designed for serious investors who love a lighthearted approach to financial freedom. Join us in riding the wave of meme culture while securing your position in the future of digital assets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_9_Me_Kn_WQA_Eno5k_d96c6b0833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

