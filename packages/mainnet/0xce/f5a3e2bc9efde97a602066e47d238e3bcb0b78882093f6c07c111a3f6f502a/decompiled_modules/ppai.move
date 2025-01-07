module 0xcef5a3e2bc9efde97a602066e47d238e3bcb0b78882093f6c07c111a3f6f502a::ppai {
    struct PPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPAI>(arg0, 6, b"PPAI", b"Purple Pudgy Ai", x"507572706c65205075646779204149206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e207468617420626c656e64732074686520776f726c6473206f662063727970746f63757272656e637920616e64206172746966696369616c20696e74656c6c6967656e63652e20537472617020696e20616e6420656e6a6f79207468652072696465207768696c6520746869732041692050756467792074616b6573206f666621210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Rcg_Eb5_Rtsf_Sq6_SR_Ct_Y_Jys_Do3p_Ti_Lg_NDF_2ce5d7_S_Lhre_4632794b49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

