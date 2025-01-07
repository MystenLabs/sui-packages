module 0x764a8b8a0f0c63a25497f88b60263b627507807a69e5b61bcc97e01d8dd5cdc8::snack {
    struct SNACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNACK>(arg0, 6, b"SNACK", b"SuiSnack", x"537569536e61636b2069732074686520636f696e2064656469636174656420666f722074686f73652077686f2773206469657420636f6e73697374206f662061746c656173742035302520736e61636b730a496620752063616e2072656c61746520796f75206d75737420626520612070617274206f66207468697320636f6d6d756e6974790a4a6f696e206f75722074656c656772616d20616e64206c65747320736861726520746865206a6f7920746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_3b6368f2ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

