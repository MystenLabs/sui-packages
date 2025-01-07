module 0x80bb5ab43bacb2a66187162881e592cfe0003815fdbe01394c7ca8554d5f035f::nana {
    struct NANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANA>(arg0, 6, b"NANA", b"BANANACOIN", x"42616e616e61436f696e20697320612066756e20616e6420696e6e6f766174697665206d656d65636f696e20666f6375736564206f6e20636f6d6d756e69747920616e6420686f646c657220726577617264732e2057697468206d7973746572696f7573206576656e747320616e6420612070726f6d6973696e6720726f61646d61702c2069742061696d7320746f207472616e73666f726d20746865206d61726b657420776974682068756d6f7220616e6420637265617469766974792120f09f8d8c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731465881046.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

