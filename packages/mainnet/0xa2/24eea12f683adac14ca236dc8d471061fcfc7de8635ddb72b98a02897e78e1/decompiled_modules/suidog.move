module 0xa224eea12f683adac14ca236dc8d471061fcfc7de8635ddb72b98a02897e78e1::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUI DOG", x"41206f6e652d6f662d612d6b696e642c20646f672d7468656d6564206d656d6520636f696e206f6e207468652053756920626c6f636b636861696e212057652772652061696d696e6720746f2062652074686520746f7020646f67206f6e20235375692e2047657420696e206561726c7920776974682020535549444f474520616e64206a6f696e20746865207061636b210a0a4f4720537569444f47", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_12_22_17_41_84de646b8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

