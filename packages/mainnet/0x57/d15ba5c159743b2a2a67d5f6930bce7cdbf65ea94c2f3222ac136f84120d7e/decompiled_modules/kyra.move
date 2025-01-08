module 0x57d15ba5c159743b2a2a67d5f6930bce7cdbf65ea94c2f3222ac136f84120d7e::kyra {
    struct KYRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYRA>(arg0, 6, b"KYRA", b"Agent Kyra", b"Your secret AI agent residing among the bits of computation. Sourcing intel in the world of preserving, open source and decentralised AI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1307_b10eab6b99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KYRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

