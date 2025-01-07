module 0x27e28232bcf88db5987d15360b898b3ff5aac5427f464cedd060020f6cd94a6d::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"Sui Bull", b"We are bullish on SUI network, let's pump it together, pour all your bullishness here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbull_cc65dd2c30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

