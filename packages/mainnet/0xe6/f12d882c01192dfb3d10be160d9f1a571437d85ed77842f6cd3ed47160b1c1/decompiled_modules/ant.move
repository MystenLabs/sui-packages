module 0xe6f12d882c01192dfb3d10be160d9f1a571437d85ed77842f6cd3ed47160b1c1::ant {
    struct ANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT>(arg0, 6, b"ANT", b"Ant by Claude", b"First coin to be launched on Sui through @Anthropic's latest Claude feature: 'Computer Use' (with verifiable proof).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/amt_5d60442c7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

