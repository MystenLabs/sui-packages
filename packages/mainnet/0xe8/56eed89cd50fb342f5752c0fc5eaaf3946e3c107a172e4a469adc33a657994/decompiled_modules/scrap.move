module 0xe856eed89cd50fb342f5752c0fc5eaaf3946e3c107a172e4a469adc33a657994::scrap {
    struct SCRAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAP>(arg0, 3, b"SCRAP", b"Scrap", x"536372617020e280942073616c766167656420706c61746520616e64206769726465722066726f6d20746865205761737465732e204d696e656420627920726967732c2062616e6b656420617420746865206e696768746c7920666c7573682c207370656e742061742074686520666f756e64727920616e6420666f7267652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://boombots-production.up.railway.app/art/resources/scrap.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCRAP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

