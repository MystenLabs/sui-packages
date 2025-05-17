module 0x9ac0e1c35ad3bc04cd5230a5045207d954d2ebe6f340245329fede976d6fe825::boa {
    struct BOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOA>(arg0, 6, b"BOA", b"BOA ON SUI", b"BOAa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigevebvqlyznfh26t3pt4eav2ev2tb4jenbhr7mqtkkhi7inlawyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

