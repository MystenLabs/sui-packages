module 0xa384fb7a33ca3d9e6ea0e7abfd9ac587c31e20e574d8daa227a07622378b42e::drako {
    struct DRAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAKO>(arg0, 6, b"Drako", b"Drako The Dragon", x"244472616b6f2049732061206d656d6520636f696e2077697468206e6f20696e7472696e7369632076616c7565206f720a6578706563746174696f6e206f662066696e616e6369616c2072657475726e20616e6420697320666f7220656e7465727461696e6d656e740a707572706f736573206f6e6c792e2054726164696e672063727970746f2c20657370656369616c6c79206d656d6520636f696e732c0a696e766f6c766573207369676e69666963616e74207269736b20616e6420706f74656e7469616c206361706974616c206c6f7373", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemoldhwpbpdvwohtjonyp7gbpsugavsrtesaiser5wymbmkvbyza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

