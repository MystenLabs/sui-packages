module 0xb3ca73b837f4ed5acf420bf6c27c13d94d9676114ddfd93eef75e3aec81abee6::cpt {
    struct CPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPT>(arg0, 6, b"CPT", b"Community Power Token", x"435054206973206120636f6d6d756e6974792d666f637573656420746f6b656e2064657369676e656420746f20656d706f77657220616e6420696e63656e746976697a65206163746976652070617274696369706174696f6e2c20636f6e747269627574696f6e2c20616e6420676f7665726e616e63652077697468696e20746865205375692065636f73797374656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000457681_1509baf3e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

