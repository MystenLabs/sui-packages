module 0xdbf5cec32864f6398710f6c8c830a862b1a2692395b22178f681c013e1b7ca33::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"WOTAH SUI", b"Eva gotten thirsty on a hot day? Grab a wotah bo'oh! It's the perfect companion for all ya hydration needs. Keep one handy, and you'll nevah be parched again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wotahb_715067af8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

