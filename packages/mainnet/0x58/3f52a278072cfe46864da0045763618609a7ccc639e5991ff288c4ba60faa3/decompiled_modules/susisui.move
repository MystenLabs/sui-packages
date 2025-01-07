module 0x583f52a278072cfe46864da0045763618609a7ccc639e5991ff288c4ba60faa3::susisui {
    struct SUSISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSISUI>(arg0, 6, b"SUSISUI", b"Susi sui", x"63686164206172746966696369616c206e61747572616c20696e74656c6c6967656e63650a58203a2068747470733a2f2f782e636f6d2f737573695f696e7465726e0a54454c454752414d3a2068747470733a2f2f742e6d652f737573695f7465726d696e616c0a574542534954453a2068747470733a2f2f737573692e61692f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241214_101517_076_c3dc8914c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

