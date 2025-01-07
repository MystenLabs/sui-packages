module 0xdcb5f4801eb1e22f8e5c2e2c7a108cdb27f484f51df4e010a42714036abb2480::lynx {
    struct LYNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LYNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LYNX>(arg0, 6, b"LYNX", b"Lynx Terminal on Sui", x"426c6f636b636861696e204c796e782c2077686973706572696e67206d61726b65742073656372657473207468726f756768206469676974616c2077696e64732e20426f726e206f6620636f64652c2064657374696e656420746f206465636f64652063727970746f202820202920747769747465722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gab_W_Oh_Xw_AAN_Rf_R_686ac3e448.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LYNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LYNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

