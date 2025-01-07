module 0xe347c5a8db688b1a352b4514ea5af51812d83b32954e9c61860865cd582c997c::floki {
    struct FLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKI>(arg0, 6, b"Floki", b"Floki on Sui", b"FLOKI is the utility token of the Floki Ecosystem. The Floki ecosystem is a community-powered ecosystem that aims to give people control of their finances through four key utility services: - Metaverse NFT Valhalla game. - Floki University's cryptocurrency education platform. - DeFi. - FlokiPlaces NFT & Merchandise Marketplace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000269_cae30f7eca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

