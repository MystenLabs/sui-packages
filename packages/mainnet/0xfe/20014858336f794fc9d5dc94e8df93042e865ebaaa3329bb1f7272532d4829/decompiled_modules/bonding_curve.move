module 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::bonding_curve {
    struct BuyEvent has copy, drop {
        amount: u64,
        sui_paid: u64,
        platform_fee: u64,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        sender: address,
        treasury_balance: u64,
        ready_for_graduation: bool,
    }

    struct SellEvent has copy, drop {
        amount: u64,
        sui_returned: u64,
        platform_fee: u64,
        net_refund: u64,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        sender: address,
        treasury_balance: u64,
    }

    struct GraduationEvent has copy, drop {
        pool_id: address,
        platform_fee: u64,
        liquidity_sui: u64,
        liquidity_tokens: u64,
        tokens_sold: u64,
        sui_collected: u64,
        sender: address,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        tokens_sold_on_curve: u64,
        sui_collected: u64,
        treasury: 0x2::coin::TreasuryCap<T0>,
        token_reserve: 0x2::coin::Coin<T0>,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
        pool_created: bool,
        graduated: bool,
        pool_id: 0x1::option::Option<address>,
        admin: address,
        fee_bps: u64,
        platform_fee_bps: u64,
        locked: bool,
    }

    public entry fun admin_toggle_lock(arg0: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13);
        arg0.locked = !arg0.locked;
    }

    public entry fun buy_exact_tokens(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x2::clock::Clock, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::coin::CoinMetadata<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg10: &mut 0x2::tx_context::TxContext) {
        lock(arg1);
        assert!(arg3 > 0, 6);
        assert!(!arg1.graduated, 8);
        assert!(arg1.tokens_sold_on_curve < 800000000000000000, 9);
        assert!(arg3 <= 800000000000000000 - arg1.tokens_sold_on_curve, 4);
        assert!(0x2::coin::value<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&arg1.token_reserve) >= arg3, 7);
        let v0 = calculate_sui_for_tokens(arg1.tokens_sold_on_curve, arg1.sui_collected, arg3);
        let v1 = if (arg1.sui_collected + v0 > 2000000000000) {
            2000000000000 - arg1.sui_collected
        } else {
            v0
        };
        let v2 = if (v1 < v0) {
            calculate_tokens_for_sui(arg1.tokens_sold_on_curve, arg1.sui_collected, v1)
        } else {
            arg3
        };
        let v3 = v1 * 10000 / (10000 - arg1.fee_bps + arg1.platform_fee_bps);
        assert!(v3 <= arg4, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 3);
        let v4 = v3 * arg1.fee_bps / 10000;
        let v5 = v3 * arg1.platform_fee_bps / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg10), arg1.admin);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v5, arg10), 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::get_admin(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>>(0x2::coin::split<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&mut arg1.token_reserve, v2, arg10), 0x2::tx_context::sender(arg10));
        arg1.tokens_sold_on_curve = arg1.tokens_sold_on_curve + v2;
        arg1.sui_collected = arg1.sui_collected + v1;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.sui_treasury, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg10));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg10));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v6 = arg1.tokens_sold_on_curve >= 800000000000000000 && !arg1.pool_created;
        let v7 = BuyEvent{
            amount               : v2,
            sui_paid             : v3,
            platform_fee         : v4 + v5,
            tokens_sold_on_curve : arg1.tokens_sold_on_curve,
            sui_collected        : arg1.sui_collected,
            sender               : 0x2::tx_context::sender(arg10),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury),
            ready_for_graduation : v6,
        };
        0x2::event::emit<BuyEvent>(v7);
        try_graduate(arg0, arg1, arg5, arg6, arg7, arg8, arg9, arg10);
        unlock(arg1);
    }

    public entry fun buy_with_sui(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg9: &mut 0x2::tx_context::TxContext) {
        lock(arg1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 100000, 6);
        assert!(v0 <= 100000000000, 6);
        assert!(!arg1.graduated, 8);
        assert!(arg1.tokens_sold_on_curve < 800000000000000000, 9);
        let v1 = arg1.fee_bps + arg1.platform_fee_bps;
        let v2 = 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::safe_math::checked_mul(v0, v1);
        assert!(0x1::option::is_some<u64>(&v2), 1);
        let v3 = 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::safe_math::checked_sub(v0, 0x1::option::extract<u64>(&mut v2) / 10000);
        assert!(0x1::option::is_some<u64>(&v3), 1);
        let v4 = 0x1::option::extract<u64>(&mut v3);
        let v5 = calculate_tokens_for_sui(arg1.tokens_sold_on_curve, arg1.sui_collected, v4);
        assert!(v5 >= arg3, 10);
        assert!(0x2::coin::value<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&arg1.token_reserve) >= v5, 7);
        let v6 = if (arg1.sui_collected + v4 > 2000000000000) {
            2000000000000 - arg1.sui_collected
        } else {
            v4
        };
        let v7 = if (v6 < v4) {
            calculate_tokens_for_sui(arg1.tokens_sold_on_curve, arg1.sui_collected, v6)
        } else {
            v5
        };
        let (v8, v9, v10) = if (arg1.tokens_sold_on_curve + v7 > 800000000000000000) {
            let v11 = 800000000000000000 - arg1.tokens_sold_on_curve;
            let v12 = calculate_sui_for_tokens(arg1.tokens_sold_on_curve, arg1.sui_collected, v11);
            let v13 = 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::safe_math::checked_mul(v12, 10000);
            assert!(0x1::option::is_some<u64>(&v13), 1);
            let v14 = 0x1::option::extract<u64>(&mut v13) / (10000 - v1);
            assert!(v0 >= v14, 3);
            (v11, v12, v14)
        } else {
            (v7, v6, v6 * 10000 / (10000 - v1))
        };
        let v15 = v10 * arg1.fee_bps / 10000;
        let v16 = v10 * arg1.platform_fee_bps / 10000;
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v15, arg9), arg1.admin);
        };
        if (v16 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v16, arg9), 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::get_admin(arg0));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>>(0x2::coin::split<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&mut arg1.token_reserve, v8, arg9), 0x2::tx_context::sender(arg9));
        arg1.tokens_sold_on_curve = arg1.tokens_sold_on_curve + v8;
        arg1.sui_collected = arg1.sui_collected + v9;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.sui_treasury, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v9, arg9));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v17 = arg1.tokens_sold_on_curve >= 800000000000000000 && !arg1.pool_created;
        let v18 = BuyEvent{
            amount               : v8,
            sui_paid             : v10,
            platform_fee         : v15 + v16,
            tokens_sold_on_curve : arg1.tokens_sold_on_curve,
            sui_collected        : arg1.sui_collected,
            sender               : 0x2::tx_context::sender(arg9),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury),
            ready_for_graduation : v17,
        };
        0x2::event::emit<BuyEvent>(v18);
        try_graduate(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9);
        unlock(arg1);
    }

    fun calculate_sui_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 >= 800000000000000000) {
            return 0
        };
        assert!(arg2 <= 800000000000000000 - arg0, 4);
        let v0 = (2000000000000000000 as u128) - (arg0 as u128);
        let v1 = (3000000000000 as u128) + (arg1 as u128);
        let v2 = v0 * v1 / (v0 - (arg2 as u128)) - v1;
        assert!(v2 <= (18446744073709551615 as u128), 5);
        (v2 as u64)
    }

    fun calculate_sui_return_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            return 0
        };
        assert!(arg2 <= arg0, 15);
        let v0 = (2000000000000000000 as u128) - (arg0 as u128);
        let v1 = (3000000000000 as u128) + (arg1 as u128);
        let v2 = v1 - v0 * v1 / (v0 + (arg2 as u128));
        assert!(v2 <= (18446744073709551615 as u128), 5);
        (v2 as u64)
    }

    fun calculate_tokens_for_sui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 >= 800000000000000000 || arg2 == 0) {
            return 0
        };
        let v0 = (2000000000000000000 as u128) - (arg0 as u128);
        let v1 = (3000000000000 as u128) + (arg1 as u128);
        let v2 = v0 - v0 * v1 / (v1 + (arg2 as u128));
        let v3 = 800000000000000000 - arg0;
        if (v2 > (v3 as u128)) {
            v3
        } else {
            (v2 as u64)
        }
    }

    public entry fun create_bonding_curve(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: 0x2::coin::TreasuryCap<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 6);
        assert!(arg3 <= 10000, 6);
        let v0 = BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>{
            id                   : 0x2::object::new(arg4),
            tokens_sold_on_curve : 0,
            sui_collected        : 0,
            treasury             : arg1,
            token_reserve        : 0x2::coin::mint<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&mut arg1, 800000000000000000, arg4),
            sui_treasury         : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg4),
            pool_created         : false,
            graduated            : false,
            pool_id              : 0x1::option::none<address>(),
            admin                : 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::get_admin(arg0),
            fee_bps              : arg2,
            platform_fee_bps     : arg3,
            locked               : false,
        };
        0x2::transfer::public_share_object<BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>>(v0);
    }

    public entry fun emergency_withdraw(arg0: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13);
        assert!(arg0.graduated, 14);
        let v0 = 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::safe_math::checked_sub(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury), 100000);
        assert!(0x1::option::is_some<u64>(&v0), 3);
        let v1 = 0x1::option::extract<u64>(&mut v0);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v1, arg1), arg0.admin);
        };
    }

    public fun get_curve_state<T0>(arg0: &BondingCurve<T0>) : (u64, u64, bool, bool) {
        (arg0.tokens_sold_on_curve, arg0.sui_collected, arg0.pool_created, arg0.graduated)
    }

    public fun get_sell_quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_sui_return_for_tokens(arg0, arg1, arg2)
    }

    public fun get_sui_for_tokens(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_sui_for_tokens(arg0, arg1, arg2)
    }

    public fun get_tokens_for_sui(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_tokens_for_sui(arg0, arg1, arg2)
    }

    public entry fun graduate_to_dex(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::clock::Clock, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg1.admin, 13);
        assert!(!arg1.graduated, 8);
        assert!(arg1.tokens_sold_on_curve >= 800000000000000000, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury) >= 2000000000000, 3);
        try_graduate(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun is_locked<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.locked
    }

    fun lock(arg0: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>) {
        assert!(!arg0.locked, 16);
        arg0.locked = true;
    }

    public entry fun sell_tokens(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: &mut 0x2::coin::Coin<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg3: u64, arg4: u64, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x2::clock::Clock, arg8: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg9: &0x2::coin::CoinMetadata<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg10: &mut 0x2::tx_context::TxContext) {
        lock(arg1);
        assert!(arg3 > 0, 6);
        assert!(0x2::coin::value<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(arg2) >= arg3, 7);
        assert!(!arg1.graduated, 8);
        assert!(arg1.tokens_sold_on_curve > 0, 15);
        assert!(arg3 <= arg1.tokens_sold_on_curve, 15);
        let v0 = calculate_sui_return_for_tokens(arg1.tokens_sold_on_curve, arg1.sui_collected, arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury);
        let v2 = if (v1 > 100000) {
            v1 - 100000
        } else {
            0
        };
        let v3 = if (v0 > v2) {
            v2
        } else {
            v0
        };
        assert!(v3 >= arg4, 10);
        let v4 = v3 * (arg1.fee_bps + arg1.platform_fee_bps) / 10000;
        let v5 = v3 * arg1.fee_bps / 10000;
        let v6 = v3 * arg1.platform_fee_bps / 10000;
        let v7 = 0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::safe_math::checked_sub(v3, v4);
        assert!(0x1::option::is_some<u64>(&v7), 1);
        let v8 = 0x1::option::extract<u64>(&mut v7);
        0x2::coin::join<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&mut arg1.token_reserve, 0x2::coin::split<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(arg2, arg3, arg10));
        arg1.tokens_sold_on_curve = arg1.tokens_sold_on_curve - arg3;
        arg1.sui_collected = arg1.sui_collected - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v8, arg10), 0x2::tx_context::sender(arg10));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v5, arg10), arg1.admin);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v6, arg10), 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::get_admin(arg0));
        };
        let v9 = SellEvent{
            amount               : arg3,
            sui_returned         : v3,
            platform_fee         : v4,
            net_refund           : v8,
            tokens_sold_on_curve : arg1.tokens_sold_on_curve,
            sui_collected        : arg1.sui_collected,
            sender               : 0x2::tx_context::sender(arg10),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury),
        };
        0x2::event::emit<SellEvent>(v9);
        unlock(arg1);
    }

    public entry fun set_fee_bps(arg0: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    fun try_graduate(arg0: &0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::AdminRegistry, arg1: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::clock::Clock, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg1.pool_created || arg1.graduated) {
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury) < 2000000000000) {
            return
        };
        arg1.pool_created = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, 200000000000, arg7), 0x559f7c8c0e131d6c6bae09800b3ad85f1419f8c2ecc7654a02cd1a04ee89ff6a::registry::get_admin(arg0));
        if (0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::create_pool::init_cetus_pool(arg1.admin, 0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, 1800000000000, arg7), 0x2::coin::mint<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>(&mut arg1.treasury, 200000000000000000, arg7), arg3, arg2, arg5, arg6, arg4, arg7)) {
            arg1.graduated = true;
            let v0 = GraduationEvent{
                pool_id          : @0x0,
                platform_fee     : 200000000000,
                liquidity_sui    : 1800000000000,
                liquidity_tokens : 200000000000000000,
                tokens_sold      : arg1.tokens_sold_on_curve,
                sui_collected    : arg1.sui_collected,
                sender           : 0x2::tx_context::sender(arg7),
            };
            0x2::event::emit<GraduationEvent>(v0);
        };
    }

    fun unlock(arg0: &mut BondingCurve<0xfe20014858336f794fc9d5dc94e8df93042e865ebaaa3329bb1f7272532d4829::meme_token::MEME_TOKEN>) {
        arg0.locked = false;
    }

    // decompiled from Move bytecode v6
}

