module 0xa5d38816d636b3dde0284602cb23269132cc01f33b1800de520222ae1d7020b1::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop sui", x"0a0a426c6f6f7020697320204f6e65206f6620746865206d6f737420637574657374206d656d6520746861742069732020526570726573656e747374696e6720746865206a6967676c7920616e64207761726d2073696465206f662074686520537569206d656d65207370616365207769746820686973206f72616e67652c20736f66742c20617070656172616e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241104_175603_125_058dd6e55f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

