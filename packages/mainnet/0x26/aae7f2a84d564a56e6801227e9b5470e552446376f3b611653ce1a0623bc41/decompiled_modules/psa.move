module 0x26aae7f2a84d564a56e6801227e9b5470e552446376f3b611653ce1a0623bc41::psa {
    struct PSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSA>(arg0, 6, b"PSA", b"PEPE SAD ALONE", x"225768656e20796f7520696e7665737420696e2061206d656d6520636f696e20616e642069742061637475616c6c79206d6f6f6e732e2e2e2062757420796f75207374696c6c2068617665206e6f2069646561207768617420697420646f65732e20205065706520686f6c64696e67206469616d6f6e642068616e64732c207175657374696f6e696e67207265616c6974792e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vwi_Q7_Hkmc_Xpi7d_K_Tf1u_J_Vre3e_X_Ga7_Jrzg4_Cjn_Pt2j7py_9834c04eb2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

