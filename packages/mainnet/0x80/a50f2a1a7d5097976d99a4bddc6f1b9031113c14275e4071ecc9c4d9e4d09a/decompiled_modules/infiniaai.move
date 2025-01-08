module 0x80a50f2a1a7d5097976d99a4bddc6f1b9031113c14275e4071ecc9c4d9e4d09a::infiniaai {
    struct INFINIAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFINIAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFINIAAI>(arg0, 6, b"INFINIAAI", b"Infinia AI", b"Explore Infinite Possibilities with Infinia AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736246143566_9f16d3f763.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFINIAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFINIAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

