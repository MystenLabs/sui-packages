module 0x9374ea2d80554a3e9bc6efda6248950cf5f6484f791dc24d8cdff1a536ddbd17::hypesp {
    struct HYPESP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPESP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPESP>(arg0, 6, b"HypeSP", b"Hype Sui Pump", b"How You Please Everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2023_02_28_21_13_01_3b3134d552.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPESP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPESP>>(v1);
    }

    // decompiled from Move bytecode v6
}

