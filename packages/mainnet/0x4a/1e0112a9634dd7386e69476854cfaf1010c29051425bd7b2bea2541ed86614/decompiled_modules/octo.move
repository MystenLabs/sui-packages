module 0x4a1e0112a9634dd7386e69476854cfaf1010c29051425bd7b2bea2541ed86614::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"OCTO", b"OCTO Labs", b"OCTO Labs is a dynamic blockchain ecosystem offering high-reward DeFi solutions, play-to-earn NFT games, and a fair, transparent tokenomics model, all underpinned by our ocean-themed narrative. octo-labs.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ol_lg_b31bc22b59.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

