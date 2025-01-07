module 0x5eccdc1747c8ce1e00219f31dd40534dc8460374ff1f30efb0e86bd052bca930::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goat of Sui", x"546865204772656174657374206f6620416c6c2054696d65206f6e2074686520537569204e6574776f726b2c2024474f4154207374616e6473206f6e20746f70206f6620746865206d6f756e7461696e2e205374726f6e672c2073757265666f6f7465642c20616e64206865726520746f20636c61696d207468652063726f776e2e2042652074686520474f4154210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_72_4d1e258293.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

