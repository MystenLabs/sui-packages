module 0x22c95e0164d9dde403b95e5640d3ff9064ea93c7599e56231da630661e459af4::laguna {
    struct LAGUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAGUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAGUNA>(arg0, 6, b"LAGUNA", b"LAGUNA ON SUI", b"$LAGUNA is the mermaid memecoin of the blockchainmystical, alluring, and unstoppable like the tides. Inspired by the shimmering beauty of tropical lagoons where mermaids are said to dwell, $LAGUNA brings the magic of the deep sea to the crypto world. This is more than just a coinit's a siren's call to dreamers, degens, and ocean lovers alike. Once you dive in, there's no turning back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123_8cd58ed1a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAGUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAGUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

