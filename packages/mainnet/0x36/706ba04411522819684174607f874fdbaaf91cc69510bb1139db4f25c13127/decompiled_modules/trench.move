module 0x36706ba04411522819684174607f874fdbaaf91cc69510bb1139db4f25c13127::trench {
    struct TRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCH>(arg0, 6, b"TRENCH", b"TrenchBunny AI", x"5472656e636842756e6e7920416920697320612066756c6c7920696e746572616374697665204169207468617420696e7465726163747320776974682068657220636f6d6d756e69747920646f776e206465657020696e20746865207472656e636865732077697468206f6e6520676f616c20696e206d696e6420474554204f555420544845205452454e434845532057495448204d450a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Suz_Cai8_Yyn2r_Q1i8_Ue6_Ycw_Uk_A9_B8j5ze5a_U3c_JRJFN_6_4cab4e4cb8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

