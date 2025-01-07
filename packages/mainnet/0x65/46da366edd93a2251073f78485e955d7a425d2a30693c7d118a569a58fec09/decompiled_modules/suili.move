module 0x6546da366edd93a2251073f78485e955d7a425d2a30693c7d118a569a58fec09::suili {
    struct SUILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILI>(arg0, 6, b"SUILI", b"Suiliphant", b"Suiliphant is a charming memecoin on the Sui blockchain, inspired by the majestic and wise elephant. With its strong foundation and fun, community-driven approach, Suiliphant stands tall as a symbol of loyalty, teamwork, and long-term growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_08_14_14_32_b046b322ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

