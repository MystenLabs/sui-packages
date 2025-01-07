module 0x7bbd05340399270be5df8a633cec57720b10e51d61f87dc02e9c59f6a9f25a14::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", b" BUBL on SUI", x"546869732066756e6e7920627562626c652077617320626f726e20696e20746865207375622d6d6172696e65207472656e63686573206f6620746865207375692065636f73797374656d20616e6420676f65732068617264207768656e206272696e67696e67207a65726f207574696c6974792e0a0a6865277320616c736f20636c6576657220616e642063616d652075702077697468206d656d656d616368696e652e2e2e0a0a6275626c206973206c6f76652c206275626c206973206c6966652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731333761579.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

