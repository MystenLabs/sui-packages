module 0x1fea3e2cfe22a4ed0f4672d3fdc387cbd73dbecde3065cb6c8b112dc633285ce::stratt {
    struct STRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRATT>(arg0, 6, b"STRATT", b"Stratton Dungeon", b"The STRAT Token is the core utility token of the Stratton Pump ecosystem, built on the Sui Network. Designed to drive community engagement and fuel the platforms Web3 gaming economy, STRAT plays a crucial role in rewarding users and sustaining liquidity through Strattons unique Buyback Model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2025_02_20_140129_85530a1350.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

