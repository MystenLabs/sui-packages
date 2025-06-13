module 0x379aae7e27067d729a3fa670cb0bdb48794f7b12158a74242aa0b907272714b7::odpira {
    struct ODPIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODPIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODPIRA>(arg0, 6, b"ODPIRA", b"OdinPirate", b"OdinPirate to conquer the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibkrqhvdjpkgci3ffq7pdmnxyyfgqqkpgqhwnj5vs7752uxmpgvcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODPIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODPIRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

