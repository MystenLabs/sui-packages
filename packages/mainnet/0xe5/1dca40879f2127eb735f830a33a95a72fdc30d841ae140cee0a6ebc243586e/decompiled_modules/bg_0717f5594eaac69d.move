module 0xe51dca40879f2127eb735f830a33a95a72fdc30d841ae140cee0a6ebc243586e::bg_0717f5594eaac69d {
    struct BG_0717F5594EAAC69D has drop {
        dummy_field: bool,
    }

    fun init(arg0: BG_0717F5594EAAC69D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BG_0717F5594EAAC69D>(arg0, 0, b"BG", b"Blue Gift", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788191425400-43f028d8-497a-432a-9ebc-91909f64efc0.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BG_0717F5594EAAC69D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BG_0717F5594EAAC69D>>(0x2::coin::mint<BG_0717F5594EAAC69D>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BG_0717F5594EAAC69D>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

