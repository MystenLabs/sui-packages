module 0xc4e8a742c7fe544ec47b18d991e75625a1400152120257fd5806babd8f505e6::rpc {
    struct RPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPC>(arg0, 6, b"RPC", b"RainbowPizzaCat", x"4920534f206d697373207768656e2074686520696e7465726e6574207573656420746f206c6f6f6b206c696b652074686973200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250113_234502_376_db867bcf0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

