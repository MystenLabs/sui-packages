module 0x2b20ed839c3a4f40af00e1ab85ade04c437bb086a443b25586556f2693358965::ludo_program__new__coin__prod {
    struct LUDO_PROGRAM__NEW__COIN__PROD has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"NCP", b"New Coin Prod", b"The following contract regulates the functioning of Ludo program Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: LUDO_PROGRAM__NEW__COIN__PROD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<LUDO_PROGRAM__NEW__COIN__PROD>(arg0, arg1);
        let (v1, v2) = 0x2::token::new_policy<LUDO_PROGRAM__NEW__COIN__PROD>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::set_rules<LUDO_PROGRAM__NEW__COIN__PROD>(&mut v4, &v3, arg1);
        0x746d4e65fe817d0528d097a5e44de2a2266373fb45dc902886a870ad664188a0::core::create_protected_treasury_policy_caps<LUDO_PROGRAM__NEW__COIN__PROD>(v0, v3, arg1);
        0x2::token::share_policy<LUDO_PROGRAM__NEW__COIN__PROD>(v4);
    }

    // decompiled from Move bytecode v6
}

