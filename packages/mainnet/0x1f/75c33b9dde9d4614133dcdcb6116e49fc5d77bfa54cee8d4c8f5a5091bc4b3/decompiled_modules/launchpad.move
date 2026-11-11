module 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::launchpad {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        supply_sold: u64,
        graduated: bool,
        lp_created: bool,
        vault_id: 0x2::object::ID,
        last_trade_ms: 0x2::table::Table<address, u64>,
        graduated_at_ms: u64,
    }

    struct Create has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        coin_type: 0x1::string::String,
        vault_id: 0x2::object::ID,
    }

    struct Buy has copy, drop {
        pool_id: 0x2::object::ID,
        buyer: address,
        sui_in: u64,
        tokens_out: u64,
        fee_team: u64,
        fee_creator: u64,
        new_supply: u64,
    }

    struct Sell has copy, drop {
        pool_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        sui_out: u64,
        fee_team: u64,
        fee_creator: u64,
        new_supply: u64,
    }

    struct Graduate has copy, drop {
        pool_id: 0x2::object::ID,
        final_supply: u64,
        sui_liquidity: u64,
    }

    struct GraduationLiquidityReconciled has copy, drop {
        pool_id: 0x2::object::ID,
        sui_input: u64,
        sui_deposited: u64,
        sui_returned: u64,
        lp_tokens_minted: u64,
        lp_tokens_deposited: u64,
        lp_tokens_burned: u64,
        final_token_supply: u64,
        cetus_pool_id: 0x2::object::ID,
    }

    public fun is_graduated<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.graduated
    }

    public entry fun buy<T0>(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: &mut BondingCurve<T0>, arg2: &mut 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::assert_version(arg0);
        assert!(!0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::is_paused(arg0), 2);
        assert!(!arg1.graduated, 3);
        assert!(arg3 > 0, 0);
        assert!(arg3 <= 1000000, 15);
        assert!(0x2::object::id<0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault>(arg2) == arg1.vault_id, 9);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<BondingCurve<T0>>(arg1);
        check_and_update_cooldown<T0>(arg1, v0, arg5);
        let v2 = curve_cost(arg1.supply_sold, arg3);
        let v3 = v2 * (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::total_fee_bps() as u128) / (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::fee_denom() as u128);
        let v4 = v2 + v3;
        assert!(v4 <= (0x2::coin::value<0x2::sui::SUI>(&arg4) as u128), 6);
        let v5 = (v4 as u64);
        if (0x2::coin::value<0x2::sui::SUI>(&arg4) > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, 0x2::coin::value<0x2::sui::SUI>(&arg4) - v5, arg6), v0);
        };
        let (v6, v7) = split_fee((v3 as u64));
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v8, (v2 as u64)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v8, v6), arg6), 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::team_wallet(arg0));
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::deposit(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg6));
        arg1.supply_sold = arg1.supply_sold + arg3;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1.treasury_cap, arg3, arg6), v0);
        let v9 = Buy{
            pool_id     : v1,
            buyer       : v0,
            sui_in      : v5,
            tokens_out  : arg3,
            fee_team    : v6,
            fee_creator : v7,
            new_supply  : arg1.supply_sold,
        };
        0x2::event::emit<Buy>(v9);
        if ((0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) as u128) >= 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::graduation_reserve_mist()) {
            arg1.graduated = true;
            arg1.graduated_at_ms = 0x2::clock::timestamp_ms(arg5);
            let v10 = Graduate{
                pool_id       : v1,
                final_supply  : arg1.supply_sold,
                sui_liquidity : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve),
            };
            0x2::event::emit<Graduate>(v10);
        };
    }

    fun check_and_update_cooldown<T0>(arg0: &mut BondingCurve<T0>, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (0x2::table::contains<address, u64>(&arg0.last_trade_ms, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.last_trade_ms, arg1);
            assert!(v0 - *v1 >= 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::trade_cooldown_ms(), 5);
            *v1 = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.last_trade_ms, arg1, v0);
        };
    }

    public entry fun create_pool<T0>(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &mut 0x2::tx_context::TxContext) {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::assert_version(arg0);
        assert!(!0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::is_paused(arg0), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::launch_fee_mist(), 1);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 13);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::team_wallet(arg0));
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::new(v0, arg6);
        let v2 = 0x2::object::id<0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault>(&v1);
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::share(v1);
        let v3 = BondingCurve<T0>{
            id              : 0x2::object::new(arg6),
            creator         : v0,
            treasury_cap    : arg1,
            sui_reserve     : 0x2::balance::zero<0x2::sui::SUI>(),
            supply_sold     : 0,
            graduated       : false,
            lp_created      : false,
            vault_id        : v2,
            last_trade_ms   : 0x2::table::new<address, u64>(arg6),
            graduated_at_ms : 0,
        };
        let v4 = &mut v3;
        register_creation_cap<T0>(v4, arg4, arg5, arg6);
        let v5 = Create{
            pool_id   : 0x2::object::id<BondingCurve<T0>>(&v3),
            creator   : v0,
            coin_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))),
            vault_id  : v2,
        };
        0x2::event::emit<Create>(v5);
        0x2::transfer::share_object<BondingCurve<T0>>(v3);
    }

    public fun creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    public fun current_marketcap_mist<T0>(arg0: &BondingCurve<T0>) : u128 {
        market_cap_mist(arg0.supply_sold)
    }

    public fun current_price_mist<T0>(arg0: &BondingCurve<T0>) : u128 {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::curve_slope_mist() * (arg0.supply_sold as u128)
    }

    fun curve_cost(arg0: u64, arg1: u64) : u128 {
        let v0 = (arg1 as u128);
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::curve_slope_mist() * (v0 * (arg0 as u128) + v0 * (v0 - 1) / 2)
    }

    public entry fun graduate<T0>(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: &mut BondingCurve<T0>, arg2: &mut 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math::expected_sqrt_price_x64<T0>(graduation_price_mist<T0>(arg1), 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math::sui_is_coin_a<T0>());
        let (v1, v2) = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::graduation_math::full_range_ticks(200);
        graduate_internal<T0>(arg0, arg1, arg2, arg3, arg4, 200, v0, v1, v2, 0x1::string::utf8(b""), arg5, arg6);
    }

    public(friend) fun graduate_internal<T0>(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: &mut BondingCurve<T0>, arg2: &mut 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: u32, arg6: u128, arg7: u32, arg8: u32, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::assert_version(arg0);
        assert!(!0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::is_paused(arg0), 2);
        assert!(0x2::object::id<0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault>(arg2) == arg1.vault_id, 9);
        let v0 = 0x2::object::id<BondingCurve<T0>>(arg1);
        assert!((0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) as u128) >= 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::graduation_reserve_mist(), 10);
        assert!(arg1.graduated, 4);
        assert!(!arg1.lp_created, 3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        assert!(v1 > 0, 11);
        assert!(arg1.supply_sold > 0, 12);
        let v2 = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math::sui_is_coin_a<T0>();
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math::assert_price_within_tolerance(0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::price_math::expected_sqrt_price_x64<T0>(graduation_price_mist<T0>(arg1), v2), arg6, 300);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"pool_creation_cap"), 17);
        let v3 = arg1.supply_sold;
        let (v4, v5, v6, v7) = if (v2) {
            let (v8, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<0x2::sui::SUI, T0>(arg3, arg4, 0x2::dynamic_object_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg1.id, b"pool_creation_cap"), arg5, arg6, arg9, arg7, arg8, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v1), arg11), 0x2::coin::mint<T0>(&mut arg1.treasury_cap, v3, arg11), true, arg10, arg11);
            let v11 = v10;
            let v12 = v9;
            let v13 = v8;
            let (v14, v15, v16) = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::graduation_math::reconcile_liquidity_amounts(v1, v3, 0x2::coin::value<0x2::sui::SUI>(&v12), 0x2::coin::value<T0>(&v11));
            assert!(v14 == v1, 16);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(v12));
            0x2::coin::burn<T0>(&mut arg1.treasury_cap, v11);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v13, @0x0);
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v13), v14, v16, v15)
        } else {
            let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::dynamic_object_field::borrow<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg1.id, b"pool_creation_cap"), arg5, arg6, arg9, arg7, arg8, 0x2::coin::mint<T0>(&mut arg1.treasury_cap, v3, arg11), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v1), arg11), false, arg10, arg11);
            let v20 = v19;
            let v21 = v18;
            let v22 = v17;
            let (v23, v24, v25) = 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::graduation_math::reconcile_liquidity_amounts(v1, v3, 0x2::coin::value<0x2::sui::SUI>(&v20), 0x2::coin::value<T0>(&v21));
            assert!(v23 == v1, 16);
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(v20));
            0x2::coin::burn<T0>(&mut arg1.treasury_cap, v21);
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v22, @0x0);
            (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v22), v23, v25, v24)
        };
        arg1.lp_created = true;
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::mark_graduated(arg2, arg10);
        let v26 = Graduate{
            pool_id       : v0,
            final_supply  : arg1.supply_sold,
            sui_liquidity : v5,
        };
        0x2::event::emit<Graduate>(v26);
        let v27 = GraduationLiquidityReconciled{
            pool_id             : v0,
            sui_input           : v1,
            sui_deposited       : v5,
            sui_returned        : v1 - v5,
            lp_tokens_minted    : v3,
            lp_tokens_deposited : v7,
            lp_tokens_burned    : v6,
            final_token_supply  : arg1.supply_sold + v7,
            cetus_pool_id       : v4,
        };
        0x2::event::emit<GraduationLiquidityReconciled>(v27);
    }

    public fun graduated_at_ms<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.graduated_at_ms
    }

    public fun graduation_price_mist<T0>(arg0: &BondingCurve<T0>) : u128 {
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::curve_slope_mist() * (arg0.supply_sold as u128)
    }

    public fun is_lp_created<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.lp_created
    }

    fun market_cap_mist(arg0: u64) : u128 {
        let v0 = (arg0 as u128);
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::curve_slope_mist() * v0 * v0
    }

    fun register_creation_cap<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg1, arg2, &mut arg0.treasury_cap, arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg1, arg2, 200, &v0, arg3);
        0x2::dynamic_object_field::add<vector<u8>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg0.id, b"pool_creation_cap", v0);
    }

    public entry fun sell<T0>(arg0: &0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::Config, arg1: &mut BondingCurve<T0>, arg2: &mut 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = unwind_open<T0>(arg1, arg5);
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::assert_version(arg0);
        assert!(v0 || !0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::is_paused(arg0), 2);
        assert!(v0 || !arg1.graduated, 3);
        if (v0 && !0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::is_graduated(arg2)) {
            0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::mark_graduated(arg2, arg5);
        };
        let v1 = 0x2::coin::value<T0>(&arg3);
        assert!(v1 > 0, 0);
        assert!(v1 <= 1000000, 15);
        assert!(0x2::object::id<0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::CreatorVault>(arg2) == arg1.vault_id, 9);
        assert!(v1 <= arg1.supply_sold, 8);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::object::id<BondingCurve<T0>>(arg1);
        check_and_update_cooldown<T0>(arg1, v2, arg5);
        let v4 = arg1.supply_sold - v1;
        let v5 = curve_cost(v4, v1);
        let v6 = v5 * (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::total_fee_bps() as u128) / (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::fee_denom() as u128);
        assert!(((v5 - v6) as u64) >= arg4, 7);
        0x2::coin::burn<T0>(&mut arg1.treasury_cap, arg3);
        let v7 = (v5 as u64);
        let (v8, v9) = split_fee((v6 as u64));
        let v10 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, v8), arg6), 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::team_wallet(arg0));
        0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::creator_vault::deposit(arg2, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v10, v9), arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v10, arg6), v2);
        arg1.supply_sold = v4;
        let v11 = Sell{
            pool_id     : v3,
            seller      : v2,
            tokens_in   : v1,
            sui_out     : v7 - v8 - v9,
            fee_team    : v8,
            fee_creator : v9,
            new_supply  : v4,
        };
        0x2::event::emit<Sell>(v11);
    }

    fun split_fee(arg0: u64) : (u64, u64) {
        let v0 = (((arg0 as u128) * (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::team_fee_bps() as u128) / (0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::total_fee_bps() as u128)) as u64);
        (v0, arg0 - v0)
    }

    public fun sui_reserve_value<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun supply_sold<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.supply_sold
    }

    fun unwind_open<T0>(arg0: &BondingCurve<T0>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.graduated) {
            if (!arg0.lp_created) {
                0x2::clock::timestamp_ms(arg1) >= arg0.graduated_at_ms + 0x1f75c33b9dde9d4614133dcdcb6116e49fc5d77bfa54cee8d4c8f5a5091bc4b3::global::unwind_delay_ms()
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun vault_id<T0>(arg0: &BondingCurve<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

