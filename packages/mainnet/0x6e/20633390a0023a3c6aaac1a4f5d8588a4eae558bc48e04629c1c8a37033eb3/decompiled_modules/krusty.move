module 0x6e20633390a0023a3c6aaac1a4f5d8588a4eae558bc48e04629c1c8a37033eb3::krusty {
    struct KRUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRUSTY>(arg0, 9, b"KRUSTY", x"f09fa4a14b7275737479", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRUSTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRUSTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

