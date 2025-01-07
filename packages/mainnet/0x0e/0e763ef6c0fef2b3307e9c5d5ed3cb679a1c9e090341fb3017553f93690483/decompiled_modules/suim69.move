module 0xe0e763ef6c0fef2b3307e9c5d5ed3cb679a1c9e090341fb3017553f93690483::suim69 {
    struct SUIM69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM69>(arg0, 6, b"SUIM69", b"SUIROOM 6900", x"53554920524f4f4d203639303020446576656c6f70656420627920414920526f6f6d20616e6420636f6f706572617465642077697468206d6f766570756d700a414920526f6f6d206c65766572616765732074686520706f776572206f66206172746966696369616c20696e74656c6c6967656e636520746f20656e7375726520746f702d6e6f74636820736563757269747920666f72206576657279207472616e73616374696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_05_41_9bd5a8aa3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM69>>(v1);
    }

    // decompiled from Move bytecode v6
}

