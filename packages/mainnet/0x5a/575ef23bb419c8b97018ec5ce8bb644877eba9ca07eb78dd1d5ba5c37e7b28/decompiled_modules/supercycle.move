module 0x5a575ef23bb419c8b97018ec5ce8bb644877eba9ca07eb78dd1d5ba5c37e7b28::supercycle {
    struct SUPERCYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERCYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERCYCLE>(arg0, 6, b"SUPERCYCLE", b"Super Cycle", x"5375706572204379636c652c20746865206d6f737420616273757264206865726f2077686f2077696c6c2073617665207468652063727970746f206d61726b65742e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zr3_Z9_Hd_V5wais_WEV_6_FBV_Lj2wikcvh_YN_5v_A_Lkyhr6_Y9r7_29c2fcade4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERCYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERCYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

