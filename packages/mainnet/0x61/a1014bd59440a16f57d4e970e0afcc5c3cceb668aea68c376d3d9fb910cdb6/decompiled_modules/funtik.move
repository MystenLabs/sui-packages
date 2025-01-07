module 0x61a1014bd59440a16f57d4e970e0afcc5c3cceb668aea68c376d3d9fb910cdb6::funtik {
    struct FUNTIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNTIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNTIK>(arg0, 9, b"FUNTIK", b"FUNTIK", b"Funtik here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdKH8kTHA8iXPer2X7mZ6Sf-2aHj5Ph7FdoQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUNTIK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNTIK>>(v2, @0x51bc74eda8ab48e3c07b1aaf855540f1d2f46b779a2d2577b2bc74a0e3257350);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNTIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

