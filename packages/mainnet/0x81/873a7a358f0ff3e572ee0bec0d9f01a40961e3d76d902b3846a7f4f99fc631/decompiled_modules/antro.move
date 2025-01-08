module 0x81873a7a358f0ff3e572ee0bec0d9f01a40961e3d76d902b3846a7f4f99fc631::antro {
    struct ANTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTRO>(arg0, 6, b"ANTRO", b"AntroOne", x"416e206578706572696d656e74206f6e2068756d616e2d726f626f7420696e746572616374696f6e206261736564206f6e2068656176696c79206d6f64696669656420496e4d6f6f762e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_VV_Wx_Wrcgv_Eav_C9_C_Yk_Ptaj7_J_Umf_Rj_Eskd6_J_Ydg4awrv_Ki_02317cd885.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

