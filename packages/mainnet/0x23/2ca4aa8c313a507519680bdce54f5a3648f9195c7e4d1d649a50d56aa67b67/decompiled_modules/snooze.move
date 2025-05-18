module 0x232ca4aa8c313a507519680bdce54f5a3648f9195c7e4d1d649a50d56aa67b67::snooze {
    struct SNOOZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOZE>(arg0, 6, b"Snooze", b"SNORLAX ON SUI", x"74686520756c74696d61746520686561767977656967687420696e20746865205375692065636f73797374656d2c206120746f6b656e20706f77657265642062792074686520737069726974206f6620536e6f726c61782c20746865206f726967696e616c206b696e67206f66206368696c6c2e204a757374206c696b652074686520506f6bc3a96d6f6e2069742773206e616d65642061667465722c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiensyawwph34usjlmefrtdaq73ftpjhzo7iwqydgtcuoccz2nqude")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOOZE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

