module 0xbdbfd5ce92299fe5003792ebffc139f42512b23cd2468fbf62ff42f68fddcc2e::pbron {
    struct PBRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PBRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PBRON>(arg0, 6, b"PBRON", b"PepBron James", x"5468652048616c6c206f662046616d6520506570652056617269616e742c2050657062726f6e204a616d65732e20496e73706972656420627920746865206c6567656e64617279204c6542726f6e204a616d657320616e64207468652074696d656c6573732061707065616c206f66207468652050657065206d656d652c2050657062726f6e204a616d65732069732061207472696275746520746f2074686520474f4154204261736b657462616c6c20506c6179657220262074686520474f4154206d656d65636f696e206d6173636f742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaj_E9r_Csxv3_L2_S4_QDG_Ee_Dv_C44_Kf_C_Wg_Fv9pe2q_Cs_Qg35y_V_498f1e9afe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PBRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PBRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

