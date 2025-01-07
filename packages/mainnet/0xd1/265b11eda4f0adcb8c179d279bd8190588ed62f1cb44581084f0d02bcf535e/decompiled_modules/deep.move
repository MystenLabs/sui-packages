module 0xd1265b11eda4f0adcb8c179d279bd8190588ed62f1cb44581084f0d02bcf535e::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DEEPBOOKONSUI", x"4445455020616e642044656570426f6f6b20563320617265206c697665206f6e20537569204d61696e6e6574210a0a44656570426f6f6b20563320697320746865206d6f737420706572666f726d616e74206f7264657220626f6f6b20696e20446546692c20706f776572656420627920746865204445455020746f6b656e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018320_4bc0208792.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

