module 0xfaed053883a89552b89491533ecd661e6d161e03b171c994cf72e611d503c7e5::realshit {
    struct REALSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALSHIT>(arg0, 6, b"REALSHIT", b"Real Shit Coin", x"546865206d6f737420686f6e65737420636f696e20696e2063727970746f2e0a426f726e20696e2074686520746f696c65742c20626c657373656420627920746865206d656d6520676f64732e0a476c6f77696e6720776974682074727574682e20506f776572656420627920707572652042532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_c_e_2025_07_22_043521_5151eff5cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALSHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

