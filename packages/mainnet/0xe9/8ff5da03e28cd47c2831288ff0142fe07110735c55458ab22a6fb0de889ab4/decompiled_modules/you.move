module 0xe98ff5da03e28cd47c2831288ff0142fe07110735c55458ab22a6fb0de889ab4::you {
    struct YOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOU>(arg0, 6, b"YOU", b"You", x"414920415343494920596f7520706c617920546f6e792c206120666f75727465656e2d79656172206f6c642074686965662077686f206e6565647320736f6d652068656c70206c6f6f74696e6720746865206c6567656e64617279204f616b76696c6c65204d616e6f722e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcwdau_Gi2pn5_MDB_97_GDAKLU_Rc_P2_Msv_BM_2p7u_Hud_Bep_A4g_532d50a6ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

