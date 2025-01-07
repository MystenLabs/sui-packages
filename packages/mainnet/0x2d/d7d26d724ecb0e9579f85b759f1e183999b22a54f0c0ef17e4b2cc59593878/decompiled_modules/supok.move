module 0x2dd7d26d724ecb0e9579f85b759f1e183999b22a54f0c0ef17e4b2cc59593878::supok {
    struct SUPOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPOK>(arg0, 6, b"Supok", b"Supok The king Sea", x"496620796f75207468696e6b20746865206b696e67206f6620746865206f6365616e2069732074686520736861726b206f7220746865207768616c652c20796f752772652077726f6e672e205468652074727565206b696e67206f6620746865206f6365616e206973205375706f6b2e0a0a5375706f6b2077696c6c206465766f757220736861726b7320616e64207768616c657320776974686f7574206d657263792e0a0a4920616d205375706f6b2c20616e6420492077696c6c2073686f7720796f75206a75737420686f77206772656174206d7920706f7765722069732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/supxnew_8c1f3167b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

