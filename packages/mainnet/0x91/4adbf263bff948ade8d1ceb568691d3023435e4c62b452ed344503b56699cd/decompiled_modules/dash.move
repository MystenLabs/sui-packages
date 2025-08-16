module 0x914adbf263bff948ade8d1ceb568691d3023435e4c62b452ed344503b56699cd::dash {
    struct DASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASH>(arg0, 6, b"DASH", b"Alpha Dash", b"Get Latest Trends in the Trenches. Token gated features : whale watch and meme mind share", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbrockyjyznc2euj3ui4gkkx4sb4xecwwprzcfw6tibmnhqwfgc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

