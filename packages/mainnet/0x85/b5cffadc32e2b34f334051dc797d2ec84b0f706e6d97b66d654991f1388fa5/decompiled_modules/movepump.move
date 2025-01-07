module 0x85b5cffadc32e2b34f334051dc797d2ec84b0f706e6d97b66d654991f1388fa5::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 6, b"MOVEPUMP", b"MOVE PUMP", x"496e74726f647563696e67206120636f696e207468617420796f752063616e20747261646520696e7374616e746c792077697468206a757374206f6e6520636c69636b206f6e2074686520537569206e6574776f726b2c20616c6c20666f7220612074696e7920666565210a546865204669727374204d656d652046616972204c61756e636820506c6174666f726d206f6e20535549204e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yc_H_Xpyb_YA_Auypp_87b3b966b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

