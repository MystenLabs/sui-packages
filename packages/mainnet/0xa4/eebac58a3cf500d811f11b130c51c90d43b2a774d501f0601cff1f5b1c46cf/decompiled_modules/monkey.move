module 0xa4eebac58a3cf500d811f11b130c51c90d43b2a774d501f0601cff1f5b1c46cf::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"Monkey", x"546865206d6f7374206d656d6561626c6520236d656d65636f696e20696e206578697374656e63652e2054686520646f6773206861766520686164207468656972206461792c206974732074696d6520666f7220234d4f4e4b455920746f2074616b6520726569676e2e0a54473a20687474703a2f2f742e6d652f4d6f6e6b657953304c200a5468697320697320616e20234149202d20706f77657265642070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/921_Mo_B1_U7_Vpr_Qf_Ww5_D37a38_LC_Bg_B3nare_T7r_Nffk66_BG_f97c64e1e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

