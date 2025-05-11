module 0x94b90a5edbf07604a28f48f731aa8ca5469b5a6829b3fba7fe8a586cc1a40166::memu {
    struct MEMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMU>(arg0, 6, b"Memu", b"Memumemu", b"Memu is a new species of a water type Pokemon. He doesn't engage in battle. He helps every Pokemon to reach their final phase of evolution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigopxdllvarh2tmvl4i2o7cxlbc4lrdeiccqk4n42q4lo5cc7jyq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

