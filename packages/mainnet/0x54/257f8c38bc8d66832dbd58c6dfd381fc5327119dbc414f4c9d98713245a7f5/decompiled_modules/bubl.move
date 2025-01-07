module 0x54257f8c38bc8d66832dbd58c6dfd381fc5327119dbc414f4c9d98713245a7f5::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBL>(arg0, 6, b"BUBL", x"427562626c65f09faba7", x"446f6ee2809974206d697373206f7574206f6e207468652066756e2e20537461792074756e656420666f7220626f746820746865204275626c506c6f7065722072656c6561736520616e6420746865206578636974696e67207468696e677320746f20636f6d6520e28094206c6574e28099732073656520696620796f752063616e202861637475616c6c792920706f702074686f736520627562626c657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731118953800.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

