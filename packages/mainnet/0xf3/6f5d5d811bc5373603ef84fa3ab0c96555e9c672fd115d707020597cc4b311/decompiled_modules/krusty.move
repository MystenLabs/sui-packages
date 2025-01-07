module 0xf36f5d5d811bc5373603ef84fa3ab0c96555e9c672fd115d707020597cc4b311::krusty {
    struct KRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRUSTY>(arg0, 6, b"Krusty", b"Krusty on SUI", b"Krusty on sui. We will send it to milli", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/krusty_8cff8ffa9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

