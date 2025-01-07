module 0xc9ef421bcab5b7410dba661d99bf31fe2b29053f8bc777b630988b2a0414559b::obama690 {
    struct OBAMA690 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBAMA690, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBAMA690>(arg0, 6, b"OBAMA690", b"Obama Ai 690", x"5468697320697320746865204172746966696369616c20496e74656c6c6967656e63652077686f2063616e207072656469637420796f75722066757475726520616e64207768656e20796f7520676f6e6e61206469652e205468652041692063616e2074656c6c20796f7572206c6966652073746f727920696e20706173742c2070726573656e7420616e64206675747572652e2041692063616e2074656c6c20796f752077686174207965617220796f7520646965202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wsen_Je_FWC_Bgn_Nwh_Z5aq_LZ_Yd_Rde_Un_Rn3sq_VYU_Dc_Qa2ig_Z_7e6ed8cf46.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBAMA690>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBAMA690>>(v1);
    }

    // decompiled from Move bytecode v6
}

