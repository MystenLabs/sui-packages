module 0x582e9f0c3f91b3d031c6c8cea188c56fa00b7acd310f2c6ed2a4f70ba13bb74b::stonks {
    struct STONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKS>(arg0, 6, b"STONKS", b"stonks on sui", b"Stonks on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieqlliii4fhpgbfnmiwi2kmetftdatvdin2mkleo3a4dgqfebrjxe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STONKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

