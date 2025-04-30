module 0xd04ab0a2935d2cb6b0a2c1a5eb0afa4c92fd8b58b4bee74f4eaa22d55e2a100::blst {
    struct BLST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLST>(arg0, 6, b"BLST", b"BlastoSui", b"BlastoSui (BLST) is a community driven meme token inspired by the legendary aquatic warrior archetype. Embodying strength, resilience, and a torrent of innovation, BLST aims to unite fans of gaming, digital art, and decentralized finance. Dive into the BlastoCoin universe and ride the waves of the crypto revolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3_0211be9d54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLST>>(v1);
    }

    // decompiled from Move bytecode v6
}

