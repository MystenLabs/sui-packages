module 0x326c89d2c617aeef06a38d4ce3348420f768ecf4ca45b865c9ae636189efa878::huahua {
    struct HUAHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUAHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUAHUA>(arg0, 6, b"HuaHua", b"HuaHua On Sui", x"240a487561487561", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f_KHPN_7_I2_400x400_93037e9930.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUAHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUAHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

