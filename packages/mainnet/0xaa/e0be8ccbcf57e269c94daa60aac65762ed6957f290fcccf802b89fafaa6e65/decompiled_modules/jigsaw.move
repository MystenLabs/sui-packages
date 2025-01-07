module 0xaae0be8ccbcf57e269c94daa60aac65762ed6957f290fcccf802b89fafaa6e65::jigsaw {
    struct JIGSAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGSAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGSAW>(arg0, 6, b"JigSaw", b"Sui JigSaw", x"2042696c6c79207468652050757070657420686173206172726976656420746f2074616b65206f76657220535549206d656d6520636f696e732120576974682068697320637265657079206772696e20616e6420726564207472696379636c652c20686573206865726520746f207475726e20657665727920747261646520696e746f206120746872696c6c696e6720616476656e747572652e202043616e20796f752068616e646c652074686520726964652c206f722077696c6c2042696c6c79206c6561766520796f752077616e74696e67206d6f72653f204469766520696e20666f7220736f6d65207370696e652d74696e676c696e672066756e206f6e20535549552120200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd1_Pimv_Mudiwvsfs_QU_Mzxz52_RW_5_X_Ga3_QVGQV_8y_Dv8cc_SU_8221c70371.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGSAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIGSAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

