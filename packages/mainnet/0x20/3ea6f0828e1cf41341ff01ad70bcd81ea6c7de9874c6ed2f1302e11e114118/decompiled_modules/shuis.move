module 0x203ea6f0828e1cf41341ff01ad70bcd81ea6c7de9874c6ed2f1302e11e114118::shuis {
    struct SHUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIS>(arg0, 6, b"SHUIS", b"SHUIS SUI", b"On the Sui Blockchain, $SHUIS is NFT-based digital assets designed for seamless exploration of virtual water environments. This $SHUIS allow users to navigate oceans and rivers in the metaverse, unlocking exclusive missions and rewards. Fast and eco-friendly transactions on Sui make trading and upgrading $SHUIS efficient, symbolizing both utility and prestige in the digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHUI_1_d4ef109f20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

