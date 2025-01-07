module 0x2d20b1a55f40f5f865b1e28ddfc9f01d686995c19b1e0b2f48565c4cebf6625e::catffee {
    struct CATFFEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFFEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFFEE>(arg0, 6, b"CATFFEE", b"coffee cat", b"patiently waiting for sui to moon with my coffee and bun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gato_7b26d71a3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFFEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFFEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

