module 0xd099e087f81f19b17b6f4017d5facc8c457f0045df27eb78affc7af1fbb4aa2b::bumbo {
    struct BUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMBO>(arg0, 6, b"BUMBO", b"Bumbo", b"BUMBO is the best friend of FWOG the frog, forming an unstoppable duo in their wild adventures. BUMBO, a reckless degenerate tadpole, is obsessed with the thrill of gambling. Always swimming through chaos, BUMBO drinks the infamous Aptos water for fun. Though BUMBOs tiny form might look harmless, behind those wide eyes lies a wild heart, always ready to go all-in for the ultimate rush.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Naps_A2_Vy_B_Tdb8p_B_En3v_ZX_Gxso9_L124h1_L6s_Zdpvg_FKPQ_516fda9e9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

