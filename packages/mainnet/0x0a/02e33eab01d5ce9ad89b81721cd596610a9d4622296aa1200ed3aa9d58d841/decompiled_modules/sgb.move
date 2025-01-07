module 0xa02e33eab01d5ce9ad89b81721cd596610a9d4622296aa1200ed3aa9d58d841::sgb {
    struct SGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGB>(arg0, 6, b"SGB", b"784", x"5468652073746f727920626568696e6420537569207069636b696e672023203738342061732069747320676c6f62616c206964656e746966696572206f6620636f696e5f7479706520666f72206b65792064657269766174696f6e2070617468732028534c49502d30303434290a0a3738342069732053756920696e207468652074656c6570686f6e65206b6579706164", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732088575206.31")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

