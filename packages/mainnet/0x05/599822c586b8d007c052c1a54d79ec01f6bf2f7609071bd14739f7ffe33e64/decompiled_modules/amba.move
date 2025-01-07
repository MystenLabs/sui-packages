module 0x5599822c586b8d007c052c1a54d79ec01f6bf2f7609071bd14739f7ffe33e64::amba {
    struct AMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBA>(arg0, 6, b"AMBA", b"AMUBA SUI", b"AMBA is meme coin with strong community and spreading fast to the meme coin world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/amuba_coin_9f44dbdf33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

