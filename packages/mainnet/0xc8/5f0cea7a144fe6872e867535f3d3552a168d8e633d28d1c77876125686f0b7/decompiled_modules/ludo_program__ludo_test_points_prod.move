module 0xc85f0cea7a144fe6872e867535f3d3552a168d8e633d28d1c77876125686f0b7::ludo_program__ludo_test_points_prod {
    struct LUDO_PROGRAM__LUDO_TEST_POINTS_PROD has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/65140ca05f63d845dcfa47cd/65140e9b5f63d845dcfc7467_glowlabs_logo-p-3200.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"LTPP", b"Ludo test points prod", b"The following contract regulates the functioning of Ludo program Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: LUDO_PROGRAM__LUDO_TEST_POINTS_PROD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<LUDO_PROGRAM__LUDO_TEST_POINTS_PROD>(arg0, arg1);
        let (v1, v2) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::new_policy<LUDO_PROGRAM__LUDO_TEST_POINTS_PROD>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::set_rules<LUDO_PROGRAM__LUDO_TEST_POINTS_PROD>(&mut v4, &v3, arg1);
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::create_registry<LUDO_PROGRAM__LUDO_TEST_POINTS_PROD>(v0, v3, false, arg1);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::share_policy<LUDO_PROGRAM__LUDO_TEST_POINTS_PROD>(v4);
    }

    // decompiled from Move bytecode v6
}

