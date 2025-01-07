module 0x9b7e30c5f2e3bfc1d3505f89964028bb9e43d56f2f899f79c5e456ed7d87902b::funtom {
    struct FUNTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNTOM>(arg0, 6, b"Funtom", b"$Funtom", x"4465782061676772656761746f722c537761702c4661726d2026204c61756e6368706164206d656d65636f696e207375690a46726f6d204d656d657320746f204d696c6c696f6e733a2046756e746f6d7320416c6c2d696e2d4f6e652043727970746f20487562204f6e2023537569204e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_DM_Zy_Y5_I_400x400_b37d967798.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNTOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNTOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

