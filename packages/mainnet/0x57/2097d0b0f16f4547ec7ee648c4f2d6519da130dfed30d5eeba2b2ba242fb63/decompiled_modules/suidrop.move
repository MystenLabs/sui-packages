module 0x572097d0b0f16f4547ec7ee648c4f2d6519da130dfed30d5eeba2b2ba242fb63::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SUIDROP", b"SUI DROP", b"SUI Drop is NFT Airdrop Platform, enables users to easily craft their exclusive collections and implement dynamic campaign tactics for distributing NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_29_22_15_52_80b98b305c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

