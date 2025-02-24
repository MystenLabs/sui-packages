module 0xdb686a4c451225624c3dfdc5dacbf8ff11538629a45a141f43ba4851352cdcee::testludoprogram_minigametestpoint {
    struct TESTLUDOPROGRAM_MINIGAMETESTPOINT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/DALLE%202025-01-28%2023.37.50%20-%20A%20creative%20and%20minimalist%20restaurant%20logo%20featuring%20a%20stylized%20bowl%20of%20noodles%20with%20steam%20and%20chopsticks%20designed%20in%20an%20orange%20and%20grey%20color%20palette-hrsn7TwbVZYdALfJlnjuanRkKCbISX.png" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dxzj0lxt4bkn6mwx.public.blob.vercel-storage.com/DALLE%202025-01-28%2023.37.50%20-%20A%20creative%20and%20minimalist%20restaurant%20logo%20featuring%20a%20stylized%20bowl%20of%20noodles%20with%20steam%20and%20chopsticks%20designed%20in%20an%20orange%20and%20grey%20color%20palette-hrsn7TwbVZYdALfJlnjuanRkKCbISX.png"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 18, b"MGTS", b"Mini Game Test Point", b"The following contract regulates the functioning of Test-Ludo Program Loyalty Tokens", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: TESTLUDOPROGRAM_MINIGAMETESTPOINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<TESTLUDOPROGRAM_MINIGAMETESTPOINT>(arg0, arg1);
        let (v1, v2) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::new_policy<TESTLUDOPROGRAM_MINIGAMETESTPOINT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::set_rules<TESTLUDOPROGRAM_MINIGAMETESTPOINT>(&mut v4, &v3, arg1);
        0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core::create_registry<TESTLUDOPROGRAM_MINIGAMETESTPOINT>(v0, v3, true, arg1);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::share_policy<TESTLUDOPROGRAM_MINIGAMETESTPOINT>(v4);
    }

    // decompiled from Move bytecode v6
}

