module 0x26509a6ed7bf512ba8c3b23fc0787c55d08fc2d4bf86b52700b9c614b66e8cf1::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 6, b"PUSSY", b"PussyInBoots", b"PussyInBoots: A playful memecoin blending humor, adventure, and community power. Step into the world of profits and paws.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734872081992.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

