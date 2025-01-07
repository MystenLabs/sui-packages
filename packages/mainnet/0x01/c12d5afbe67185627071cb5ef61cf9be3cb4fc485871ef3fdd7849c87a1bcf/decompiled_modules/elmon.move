module 0x1c12d5afbe67185627071cb5ef61cf9be3cb4fc485871ef3fdd7849c87a1bcf::elmon {
    struct ELMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMON>(arg0, 6, b"ELMON", b"Elemon Token", b"Elemon is inspired by the mysterious and beautiful world of Elematris, our mission is to build a comprehensive platform of digital monsters that will enable millions of individuals to participate in the NFT and blockchain-based gaming world in a simple, creative, and enjoyable way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elemon_578f68161d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

