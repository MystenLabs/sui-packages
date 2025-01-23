module 0xa8bcc632d167c8de374324de898e807bfc3a326a23db2ef92f38d54d61a8cd16::stkn {
    struct STKN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STKN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STKN>(arg0, 6, b"STKN", b"STOKNs", x"546865206669727374206d656d65636f696e206465706c6f796564206f6e205355492e200a4261636b65642062792074686520495020746f20746865206d656d652e200a53746f6e6b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X2_Twitter_com_Gd5i3_GU_Xg_AA_8tlv_gif_3091bfb1ca.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STKN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STKN>>(v1);
    }

    // decompiled from Move bytecode v6
}

