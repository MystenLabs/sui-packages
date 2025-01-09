module 0x82cf206a4dcbd7a8ec7dd4467d695c640ce8b551f70d3b5ed0a96f1bf7b95e11::beth {
    struct BETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETH>(arg0, 6, b"BETH", b"AI BEETHOVEN", x"244245544820207c205472616e73666f726d696e6720245355492063686172747320696e746f2042656574686f76656e2d696e7370697265642073796d70686f6e6965732e0a0a576865726520626c6f636b636861696e206d6565747320636c6173736963616c2067656e697573207c204372656174656420627920244f53495249207c204e6f207574696c6974792c206a757374206d75736963616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaa228b0e90f6e7748795bf2e2c0f219aafe95af7b0ce55e9c5bbff0f6e1bfb11_beth_beth_ab82bccc54.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

