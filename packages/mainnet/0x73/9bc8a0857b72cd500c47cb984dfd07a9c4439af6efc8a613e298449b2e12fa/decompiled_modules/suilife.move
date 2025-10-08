module 0x739bc8a0857b72cd500c47cb984dfd07a9c4439af6efc8a613e298449b2e12fa::suilife {
    struct SUILIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIFE>(arg0, 6, b"Suilife", b"Sui life", x"6e2074686973206572612066696c6c656420776974682067617320616e6420647265616d732c20537569204c696665207374616e647320666f7220616e2061747469747564653a0a4e6f20636f6d7065746974696f6e2c206e6f20726574726561742c206e6f2070616e69632020737465616479206c696b6520666c7569642c20736f66742079657420756e627265616b61626c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_179_4abc936d36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

