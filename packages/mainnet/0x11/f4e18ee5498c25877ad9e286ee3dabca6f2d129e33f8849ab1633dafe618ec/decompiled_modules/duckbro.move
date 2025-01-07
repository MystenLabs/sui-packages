module 0x11f4e18ee5498c25877ad9e286ee3dabca6f2d129e33f8849ab1633dafe618ec::duckbro {
    struct DUCKBRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKBRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKBRO>(arg0, 6, b"DUCKBRO", b"Duck Bro", x"4475636b42726f2069732074686520636f696e207468617420776164646c65730a7468726f756768207468652063727970746f20776f726c6420776974680a68756d6f722c20636861726d2c20616e642061206c6974746c652073706c6173680a6f662061747469747564652e20466f7267657420626f72696e67206f6c640a696e766573746d656e747367657420726561647920746f207377696d0a776974682074686520636f6f6c657374206475636b20696e2074686520706f6e6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003354_be9d1c0fbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKBRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKBRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

