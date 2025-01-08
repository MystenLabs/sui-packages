module 0x2556eaa3f2662ac7ceb778072c654b6738c1c6c5269f55e9d8453aa437f1b29c::mintasyai {
    struct MINTASYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTASYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINTASYAI>(arg0, 6, b"MINTASYAI", b"MintasyAI", x"74686520746f70203130207261726573742067656e65726174696f6e7320696e20525047204d4f44452077696c6c20706c61792061206b657920726f6c6520696e20756e6c6f636b696e67206e657720706f73736962696c6974696573206f6e205355492e0a4d494e54415359414920696e20525047204d4f44452077696c6c20706c61792061206b657920726f6c6520696e20756e6c6f636b696e67206e657720706f73736962696c69746965732e2068747470733a2f2f782e636f6d2f4d696e746173795f41492068747470733a2f2f6d696e7461737961692e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/26361736321575_pic_247a77019f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINTASYAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINTASYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

