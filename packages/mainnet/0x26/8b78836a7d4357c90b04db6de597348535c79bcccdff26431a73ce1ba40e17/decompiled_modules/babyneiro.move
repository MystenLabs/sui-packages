module 0x268b78836a7d4357c90b04db6de597348535c79bcccdff26431a73ce1ba40e17::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 6, b"BabyNeiro", b"Baby Neiro", x"42616279204e6569726f20697320616e2061646f7261626c65206c6974746c6520646f672077686f7365206e616d65206d65616e73202274686520687565206f6620736f756e642e222020526573637565642066726f6d206120646966666963756c7420706173742c20736865206e6f7720656e6a6f79732061206c6966652066696c6c65642077697468206c6f766520616e642068617070696e6573732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zq_X_Qj351bu_Tk9xx_AKTX_1vn_Vn_XBU_3_V_Ko_Gxea_DJ_29j_Vgu_B_6dfad09de2.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

