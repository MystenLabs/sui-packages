module 0x62c1560c0f45f6bf27401667bb98baa9b27a2acd48621b159568ef7609eb00c5::catto {
    struct CATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTO>(arg0, 6, b"CATTO", b"DRIPCATTO", b"DRIPCATTODRIPCATTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic4dxlhhhq2lsewzsyqv2zw3ofbkl6q34pzm6voxsbt2wket3hnsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

