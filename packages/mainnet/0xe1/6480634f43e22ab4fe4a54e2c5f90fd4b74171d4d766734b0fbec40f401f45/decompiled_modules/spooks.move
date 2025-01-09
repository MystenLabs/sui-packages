module 0xe16480634f43e22ab4fe4a54e2c5f90fd4b74171d4d766734b0fbec40f401f45::spooks {
    struct SPOOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOKS>(arg0, 6, b"SPOOKS", b"SPOOKS ON SUI", x"2053504f4f4b53206973206c75726b696e6720696e2074686520736861646f77732c20726561647920746f206861756e7420746865206368617274732120436f6d6d756e6974792d44726976656e212053504f4f4b532067726f7773207374726f6e67657220776974682065766572792062656c69657665722e20446f6e742066656172207468652067686f73742c206265636f6d65207468652067686f73742e204a6f696e2053706f6f6b20746f64617920616e64207761746368206974206861756e742074686520746f70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uy_JBP_Shs2_Uk_Q_Dm_G_Gi_Sw_TBUKD_Zk_RG_Rso7_A776q8h_TVB_Ay_b0325d2208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOOKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

