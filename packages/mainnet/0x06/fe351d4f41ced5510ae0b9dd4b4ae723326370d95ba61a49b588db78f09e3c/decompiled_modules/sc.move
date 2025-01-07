module 0x6fe351d4f41ced5510ae0b9dd4b4ae723326370d95ba61a49b588db78f09e3c::sc {
    struct SC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SC>(arg0, 6, b"SC", b"Super Cycle", x"5375706572204379636c652c20746865206d6f737420616273757264206865726f2077686f2077696c6c2073617665207468652063727970746f206d61726b65742e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zr3_Z9_Hd_V5wais_WEV_6_FBV_Lj2wikcvh_YN_5v_A_Lkyhr6_Y9r7_edaebc9cf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SC>>(v1);
    }

    // decompiled from Move bytecode v6
}

