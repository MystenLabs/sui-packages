module 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::bonding_curve {
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
    }

    public entry fun buy_exact_tokens(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(!arg0.graduated, 8);
        assert!(arg0.tokens_sold_on_curve < 800000000000000000, 9);
        assert!(arg2 <= 800000000000000000 - arg0.tokens_sold_on_curve, 4);
        assert!(0x2::coin::value<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&arg0.token_reserve) >= arg2, 7);
        let v0 = calculate_sui_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, arg2);
        let v1 = v0 * 10000 / (10000 - arg0.fee_bps + arg0.platform_fee_bps);
        assert!(v1 <= arg3, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 3);
        let v2 = v1 * arg0.fee_bps / 10000;
        let v3 = v1 * arg0.platform_fee_bps / 10000;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg9), arg0.admin);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v3, arg9), arg0.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>>(0x2::coin::split<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&mut arg0.token_reserve, arg2, arg9), 0x2::tx_context::sender(arg9));
        arg0.tokens_sold_on_curve = arg0.tokens_sold_on_curve + arg2;
        arg0.sui_collected = arg0.sui_collected + v0;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0, arg9));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg9));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v4 = arg0.tokens_sold_on_curve >= 800000000000000000 && !arg0.pool_created;
        let v5 = BuyEvent{
            amount               : arg2,
            sui_paid             : v1,
            platform_fee         : v2 + v3,
            tokens_sold_on_curve : arg0.tokens_sold_on_curve,
            sui_collected        : arg0.sui_collected,
            sender               : 0x2::tx_context::sender(arg9),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury),
            ready_for_graduation : v4,
        };
        0x2::event::emit<BuyEvent>(v5);
        try_graduate(arg0, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun buy_with_sui(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100000, 6);
        assert!(v0 <= 100000000000, 6);
        assert!(!arg0.graduated, 8);
        assert!(arg0.tokens_sold_on_curve < 800000000000000000, 9);
        let v1 = arg0.fee_bps + arg0.platform_fee_bps;
        let v2 = 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::safe_math::checked_mul(v0, v1);
        assert!(0x1::option::is_some<u64>(&v2), 1);
        let v3 = 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::safe_math::checked_sub(v0, 0x1::option::extract<u64>(&mut v2) / 10000);
        assert!(0x1::option::is_some<u64>(&v3), 1);
        let v4 = 0x1::option::extract<u64>(&mut v3);
        let v5 = calculate_tokens_for_sui(arg0.tokens_sold_on_curve, arg0.sui_collected, v4);
        assert!(v5 >= arg2, 10);
        assert!(0x2::coin::value<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&arg0.token_reserve) >= v5, 7);
        let (v6, v7, v8) = if (arg0.tokens_sold_on_curve + v5 > 800000000000000000) {
            let v9 = 800000000000000000 - arg0.tokens_sold_on_curve;
            let v10 = calculate_sui_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, v9);
            let v11 = 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::safe_math::checked_mul(v10, 10000);
            assert!(0x1::option::is_some<u64>(&v11), 1);
            let v12 = 0x1::option::extract<u64>(&mut v11) / (10000 - v1);
            assert!(v0 >= v12, 3);
            (v9, v10, v12)
        } else {
            (v5, v4, v0)
        };
        let v13 = v8 * arg0.fee_bps / 10000;
        let v14 = v8 * arg0.platform_fee_bps / 10000;
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v13, arg8), arg0.admin);
        };
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v14, arg8), arg0.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>>(0x2::coin::split<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&mut arg0.token_reserve, v6, arg8), 0x2::tx_context::sender(arg8));
        arg0.tokens_sold_on_curve = arg0.tokens_sold_on_curve + v6;
        arg0.sui_collected = arg0.sui_collected + v7;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v7, arg8));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v15 = arg0.tokens_sold_on_curve >= 800000000000000000 && !arg0.pool_created;
        let v16 = BuyEvent{
            amount               : v6,
            sui_paid             : v8,
            platform_fee         : v13 + v14,
            tokens_sold_on_curve : arg0.tokens_sold_on_curve,
            sui_collected        : arg0.sui_collected,
            sender               : 0x2::tx_context::sender(arg8),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury),
            ready_for_graduation : v15,
        };
        0x2::event::emit<BuyEvent>(v16);
        try_graduate(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
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

    public entry fun create_bonding_curve(arg0: &0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::admin_registry::AdminRegistry, arg1: 0x2::coin::TreasuryCap<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 6);
        assert!(arg3 <= 10000, 6);
        let v0 = BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>{
            id                   : 0x2::object::new(arg4),
            tokens_sold_on_curve : 0,
            sui_collected        : 0,
            treasury             : arg1,
            token_reserve        : 0x2::coin::mint<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&mut arg1, 800000000000000000, arg4),
            sui_treasury         : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg4),
            pool_created         : false,
            graduated            : false,
            pool_id              : 0x1::option::none<address>(),
            admin                : 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::admin_registry::get_admin(arg0),
            fee_bps              : arg2,
            platform_fee_bps     : arg3,
        };
        0x2::transfer::public_share_object<BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>>(v0);
    }

    public entry fun emergency_withdraw(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13);
        assert!(arg0.graduated, 14);
        let v0 = 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::safe_math::checked_sub(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury), 100000);
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

    public entry fun graduate_to_dex(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 13);
        assert!(!arg0.graduated, 8);
        assert!(arg0.tokens_sold_on_curve >= 800000000000000000, 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) >= 2000000000000, 3);
        try_graduate(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sell_tokens(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: &mut 0x2::coin::Coin<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg2: u64, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(0x2::coin::value<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(arg1) >= arg2, 7);
        assert!(!arg0.graduated, 8);
        assert!(arg0.tokens_sold_on_curve > 0, 15);
        assert!(arg2 <= arg0.tokens_sold_on_curve, 15);
        let v0 = calculate_sui_return_for_tokens(arg0.tokens_sold_on_curve, arg0.sui_collected, arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury);
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
        assert!(v3 >= arg3, 10);
        let v4 = v3 * (arg0.fee_bps + arg0.platform_fee_bps) / 10000;
        let v5 = v3 * arg0.fee_bps / 10000;
        let v6 = v3 * arg0.platform_fee_bps / 10000;
        let v7 = 0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::safe_math::checked_sub(v3, v4);
        assert!(0x1::option::is_some<u64>(&v7), 1);
        let v8 = 0x1::option::extract<u64>(&mut v7);
        0x2::coin::join<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&mut arg0.token_reserve, 0x2::coin::split<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(arg1, arg2, arg9));
        arg0.tokens_sold_on_curve = arg0.tokens_sold_on_curve - arg2;
        arg0.sui_collected = arg0.sui_collected - v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v8, arg9), 0x2::tx_context::sender(arg9));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v5, arg9), arg0.admin);
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v6, arg9), arg0.admin);
        };
        let v9 = SellEvent{
            amount               : arg2,
            sui_returned         : v3,
            platform_fee         : v4,
            net_refund           : v8,
            tokens_sold_on_curve : arg0.tokens_sold_on_curve,
            sui_collected        : arg0.sui_collected,
            sender               : 0x2::tx_context::sender(arg9),
            treasury_balance     : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury),
        };
        0x2::event::emit<SellEvent>(v9);
    }

    public entry fun set_fee_bps(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 13);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    fun try_graduate(arg0: &mut BondingCurve<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.pool_created || arg0.graduated) {
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) < 2000000000000) {
            return
        };
        arg0.pool_created = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 200000000000, arg6), arg0.admin);
        if (0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::create_pool::init_cetus_pool(arg0.admin, 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 1800000000000, arg6), 0x2::coin::mint<0x1c47458369f8958ce5d319d1d811615ab535354e3038dc297c94b9d5016d054f::meme_token::MEME_TOKEN>(&mut arg0.treasury, 200000000000000000, arg6), arg2, arg1, arg4, arg5, arg3, arg6)) {
            arg0.graduated = true;
            let v0 = GraduationEvent{
                pool_id          : @0x0,
                platform_fee     : 200000000000,
                liquidity_sui    : 1800000000000,
                liquidity_tokens : 200000000000000000,
                tokens_sold      : arg0.tokens_sold_on_curve,
                sui_collected    : arg0.sui_collected,
                sender           : 0x2::tx_context::sender(arg6),
            };
            0x2::event::emit<GraduationEvent>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

