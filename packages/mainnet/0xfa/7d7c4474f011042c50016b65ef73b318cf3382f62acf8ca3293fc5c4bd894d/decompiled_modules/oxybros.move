module 0xfa7d7c4474f011042c50016b65ef73b318cf3382f62acf8ca3293fc5c4bd894d::oxybros {
    struct OXYBROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXYBROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXYBROS>(arg0, 6, b"OxyBROS", b"Oxygen Bros", x"4f6e65207075666620617420612074696d652c206769766573206e6577206c69666520746f20746865206d656d6520636f696e2067616d652e2057656c636f6d65204f787967656e0a42726f732c206865726520746f2070756d7020757020796f7572206c756e677320616e6420626167732e20466f7267657420677261766974797468697320746f6b656e20697320676f6e6e610a546865206d6f6f6e2077652063616e206174206c656173742068617665206c6f7473206f662066726573682061697220746f2066696c6c206f7572206c756e6773206f6e206f75722077617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004231_6f0a01e501.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXYBROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OXYBROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

