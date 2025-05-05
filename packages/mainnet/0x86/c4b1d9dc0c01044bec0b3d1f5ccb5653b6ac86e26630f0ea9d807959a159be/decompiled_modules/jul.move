module 0x86c4b1d9dc0c01044bec0b3d1f5ccb5653b6ac86e26630f0ea9d807959a159be::jul {
    struct JUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUL>(arg0, 6, b"JUL", b"Julix", b"Julix's avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigabalsojtlwtto7o3fzsvi2rh374uuadnwkvxu6dgcwkkssf6bka")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

