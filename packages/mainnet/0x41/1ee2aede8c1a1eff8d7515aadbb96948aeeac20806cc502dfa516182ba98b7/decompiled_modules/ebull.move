module 0x411ee2aede8c1a1eff8d7515aadbb96948aeeac20806cc502dfa516182ba98b7::ebull {
    struct EBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBULL>(arg0, 9, b"EBULL", b"EBULL", b"EBULL? Buterin?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHeEgAtveTQ-0UZwOIWYOFUZKHDuGhYfbipQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EBULL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

