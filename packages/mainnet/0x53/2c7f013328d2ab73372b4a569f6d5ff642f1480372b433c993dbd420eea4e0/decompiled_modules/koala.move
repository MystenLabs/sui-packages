module 0x532c7f013328d2ab73372b4a569f6d5ff642f1480372b433c993dbd420eea4e0::koala {
    struct KOALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOALA>(arg0, 6, b"KOALA", b"KOALA SUI", x"48692c20496d20244b4f414c41210a0a50656f706c652074656c6c206d652049206c6f6f6b206c696b6520504550452e0a0a492074656c6c207468656d2c2049276d2061204b4f414c4121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fs_A54y_L49_W_Ks7r_Wo_Gv9s_Ucb_SGWCWV_756j_TD_349e6_H2y_W_b8b6c2bfc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

