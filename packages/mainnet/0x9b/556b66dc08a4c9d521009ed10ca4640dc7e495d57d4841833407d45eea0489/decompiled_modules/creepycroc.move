module 0x9b556b66dc08a4c9d521009ed10ca4640dc7e495d57d4841833407d45eea0489::creepycroc {
    struct CREEPYCROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREEPYCROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREEPYCROC>(arg0, 6, b"CreepyCroc", b"Creepy Croc", x"2a2a4372656570792043726f632a2a20736c696e6b73207468726f7567682074686520736861646f77732c20676c6f77696e6720726564206579657320616e642073686172702066616e677320726561647920746f20737472696b65212054686973206d697363686965766f757320626162792063726f63206861756e747320746865206e696768742c206372656570696e672073696c656e746c7920666f722074686520706572666563742048616c6c6f7765656e207363617265210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma_YVQ_7sz_EJV_2eju_Ai64_CXJ_Jd_Uo815_Z_Xh_Kp6_Hf_WD_Wf_ZEBL_f0b53754ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREEPYCROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREEPYCROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

