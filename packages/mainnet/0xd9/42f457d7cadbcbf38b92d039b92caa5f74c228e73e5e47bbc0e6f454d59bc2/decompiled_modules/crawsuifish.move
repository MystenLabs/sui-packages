module 0xd942f457d7cadbcbf38b92d039b92caa5f74c228e73e5e47bbc0e6f454d59bc2::crawsuifish {
    struct CRAWSUIFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAWSUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAWSUIFISH>(arg0, 6, b"CRAWSUIFISH", b"CRAWFISH SUI", b"mmm crawzaddy, let's have a boil!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_175824478_b65786c71a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAWSUIFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAWSUIFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

