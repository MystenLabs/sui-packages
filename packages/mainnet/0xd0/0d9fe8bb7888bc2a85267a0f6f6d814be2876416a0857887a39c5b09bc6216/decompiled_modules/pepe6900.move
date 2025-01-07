module 0xd00d9fe8bb7888bc2a85267a0f6f6d814be2876416a0857887a39c5b09bc6216::pepe6900 {
    struct PEPE6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE6900>(arg0, 6, b"PEPE6900", b"PEPE6900 SUI", x"5570746f6265723f204e6f2c2046726f67746f6265722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_Fw_Wx_Na_EAAW_1_AV_ca468abd75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

