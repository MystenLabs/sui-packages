module 0x6be1699c3afd5b9480572ca58d7f31c2d85c9509c3f14165d5f45f294cba03cf::dumbo {
    struct DUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBO>(arg0, 6, b"DUMBO", b"Dumbo Octo", b" Dumbo octopus refers not just to one species but to an entire genus of deep-sea umbrella octopuses, noted for their fins that resemble Dumbo the elephants ears (of Disney fame).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Credit_NOAA_Ocean_Exploration_Research_c687c6f0c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

