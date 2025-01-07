module 0x56cd0f027356f23c33a655f8e0213b4a683bea96961e308291c1384fd1b7b69d::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"ROBOT MUSK", x"54686973206973206d79206d6f737420696465616c20616e64206661766f7269746520636172206e6f770a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202d2d456c6f6e204d75736b0a0a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f31383434383431363735373434383337383437", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zoxu_U_Va_MA_Ad9p_Y_29e7b83a1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

