module 0xde2e811313fa7d20203d9c13231e94e8103086c5f196a71fd3dbf781d4beb8e3::suirrito {
    struct SUIRRITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRRITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRRITO>(arg0, 6, b"SUIRRITO", b"Suirrito", x"556e64657277617465722063727970746f206d696c6c696f6e61697265206275727269746f2c207475726e696e6720746865205265656620696e746f2074686520636f6f6c6573742073706f74206f6e205375692077697468206869732063726577206f6620537569727269746f732c206d616b696e67206d6f76657320756e64657220746865207365612e0a0a737569727269746f2e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui4_95dad96ffd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRRITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRRITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

