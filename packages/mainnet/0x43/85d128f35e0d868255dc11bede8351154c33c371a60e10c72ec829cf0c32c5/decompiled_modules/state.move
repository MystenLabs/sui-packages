module 0xdf0ed7f86a6ff414a0a39c6fc140e6d8ebe8da2b7136f33fe6179cefc71abbcc::state {
    struct ExtensionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ExtensionStateV1<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_owner_cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        coin_types: vector<0x1::type_name::TypeName>,
        reserve_indexes: vector<u64>,
        deposits_enabled: bool,
    }

    public(friend) fun new<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &mut 0x2::tx_context::TxContext) : ExtensionStateV1<T0> {
        ExtensionStateV1<T0>{
            id                   : 0x2::object::new(arg1),
            obligation_owner_cap : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg0, arg1),
            coin_types           : 0x1::vector::empty<0x1::type_name::TypeName>(),
            reserve_indexes      : vector[],
            deposits_enabled     : true,
        }
    }

    public(friend) fun claim_rewards<T0, T1, T2>(arg0: &ExtensionStateV1<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &v0;
        let v2 = &arg0.coin_types;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3) == v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v4)) {
                    abort 13835622070387736581
                };
                return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T2>(arg1, &arg0.obligation_owner_cap, arg3, *0x1::vector::borrow<u64>(&arg0.reserve_indexes, 0x1::option::extract<u64>(&mut v4)), arg2, true, arg4)
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun create_extension_key() : ExtensionKey {
        ExtensionKey{dummy_field: false}
    }

    public(friend) fun deposit_into_extension<T0, T1>(arg0: &mut ExtensionStateV1<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.deposits_enabled, 13835340745734750211);
        let v0 = arg1;
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = &arg0.coin_types;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3) == &v1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 8 */
                if (0x1::option::is_none<u64>(&v4)) {
                    let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(v0);
                    let v6 = 0;
                    let v7;
                    while (v6 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v5)) {
                        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::coin_type<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(v5, v6));
                        if (&v8 == &v1) {
                            v7 = 0x1::option::some<u64>(v6);
                            /* label 16 */
                            if (0x1::option::is_none<u64>(&v7)) {
                                abort 13835904236854312967
                            };
                            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.coin_types, v1);
                            0x1::vector::push_back<u64>(&mut arg0.reserve_indexes, 0x1::option::extract<u64>(&mut v7));
                            /* label 20 */
                            let v9 = *0x1::vector::borrow<u64>(&arg0.reserve_indexes, 0x1::vector::length<0x1::type_name::TypeName>(&arg0.coin_types) - 1);
                            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, v9, &arg0.obligation_owner_cap, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg1, v9, arg3, arg2, arg4), arg4);
                            return
                        };
                        v6 = v6 + 1;
                    };
                    v7 = 0x1::option::none<u64>();
                    /* goto 16 */
                } else {
                    /* goto 20 */
                };
            } else {
                v3 = v3 + 1;
            };
        };
        v4 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public(friend) fun destroy<T0>(arg0: ExtensionStateV1<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_value_usd<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0)), 13835058480483926017);
        let ExtensionStateV1 {
            id                   : v0,
            obligation_owner_cap : v1,
            coin_types           : _,
            reserve_indexes      : _,
            deposits_enabled     : _,
        } = arg0;
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>>(v1, @0x0);
        0x2::object::delete(v0);
    }

    public(friend) fun disable_deposits<T0>(arg0: &mut ExtensionStateV1<T0>) {
        arg0.deposits_enabled = false;
    }

    public(friend) fun enable_deposits<T0>(arg0: &mut ExtensionStateV1<T0>) {
        arg0.deposits_enabled = true;
    }

    public(friend) fun take_profit<T0, T1>(arg0: &ExtensionStateV1<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (arg3 == 0 || !0x1::vector::contains<0x1::type_name::TypeName>(&arg0.coin_types, &v0)) {
            return 0x2::coin::zero<T1>(arg4)
        };
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v1);
        let v3 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)))), v2));
        if (v3 > arg3) {
            let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(v1);
            return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v4, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v4, &arg0.obligation_owner_cap, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v3 - arg3), v2)), arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4)
        };
        0x2::coin::zero<T1>(arg4)
    }

    public(friend) fun total_active_liquidity<T0, T1>(arg0: &ExtensionStateV1<T0>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap)));
        if (v0 == 0) {
            return 0
        };
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(v0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1))))
    }

    public(friend) fun withdraw_from_extension<T0, T1>(arg0: &ExtensionStateV1<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg1);
        let v1 = 0x1::u64::min(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<T0>(v0))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.obligation_owner_cap))));
        if (v1 == 0) {
            return 0x2::coin::zero<T1>(arg4)
        };
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::array_index<T0>(v0);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg1, v2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, v2, &arg0.obligation_owner_cap, arg3, v1, arg4), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4)
    }

    // decompiled from Move bytecode v6
}

