module 0x62beebf553880f0f0d7feb318bec8836381bd5e7d27a78f87c5800a7fc53d4c0::alke {
    struct ALKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALKE>(arg0, 6, b"ALKE", b"Alkebulan", x"496e2074686520736861646f7773206f6620746865206d61726b65742c20616d6964737420746865206368616f7320616e6420746865206e6f6973652c20746865726520657869737473206120636f696e2e0a0a41205472696275746520746f20416c6b6562756c616e3a204120636f696e20696e73706972656420627920746865206c616e6420776865726520686973746f72792077617320626f726e2c20776865726520636976696c697a6174696f6e20666972737420726f73652c20616e64207768657265206d7973746572696573207374696c6c206c696e6765722062656e656174682074686520737572666163652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/testing_e07c42546d.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

