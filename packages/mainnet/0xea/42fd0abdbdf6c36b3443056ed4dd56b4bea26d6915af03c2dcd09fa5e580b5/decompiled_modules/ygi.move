module 0xea42fd0abdbdf6c36b3443056ed4dd56b4bea26d6915af03c2dcd09fa5e580b5::ygi {
    struct YGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YGI>(arg0, 6, b"YGI", b"YELLOW GROUPER", x"444f4e542042555920204a757374206a6f696e206f757220636f6d6d756e697479200a5745204c4f554e43482041465445522035304d454d4245525447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_27_at_23_08_12_c2d53b8c_4903cc4d01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

