module 0xbdbae396af85c40e831c36f04e8750216037aac7381ac10db61f16783c43c389::aiv {
    struct AIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIV>(arg0, 6, b"AIV", b"Ai Verse", b"Ai Verse is a project combining the power of AI and metaverse. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736464078973.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

