module 0xcf6978908c251ad263fe93e47e3f65a91fc049833a4b854b677ee7020d131817::als {
    struct ALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALS>(arg0, 6, b"ALS", b"AKa Lab Sui", b"AKA Ventures is a venture capital firm focusing exclusively on early-stage blockchain project decentralized finance, Fintech startup, NFT, Gamefi and Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akalabs_c251d9bd37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

