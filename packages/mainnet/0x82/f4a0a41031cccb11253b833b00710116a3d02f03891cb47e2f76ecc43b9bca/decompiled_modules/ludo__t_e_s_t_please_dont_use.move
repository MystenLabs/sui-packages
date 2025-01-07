module 0x82f4a0a41031cccb11253b833b00710116a3d02f03891cb47e2f76ecc43b9bca::ludo__t_e_s_t_please_dont_use {
    struct LUDO__T_E_S_T_PLEASE_DONT_USE has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"NOUSEIT", b"TEST please dont use", b"The following contract regulates the functioning of Ludo Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: LUDO__T_E_S_T_PLEASE_DONT_USE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<LUDO__T_E_S_T_PLEASE_DONT_USE>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<LUDO__T_E_S_T_PLEASE_DONT_USE>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::set_rules<LUDO__T_E_S_T_PLEASE_DONT_USE>(&mut v4, &v3, arg1);
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::create_protected_treasury_policy_caps<LUDO__T_E_S_T_PLEASE_DONT_USE>(v0, v3, arg1);
        0x2::token::share_policy<LUDO__T_E_S_T_PLEASE_DONT_USE>(v4);
    }

    // decompiled from Move bytecode v6
}

