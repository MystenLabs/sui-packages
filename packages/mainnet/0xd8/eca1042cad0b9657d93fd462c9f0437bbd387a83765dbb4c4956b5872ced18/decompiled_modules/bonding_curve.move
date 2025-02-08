module 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve {
    struct BondingCurveStartCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        bonding_curve_id: 0x2::object::ID,
        coin_metadata_id: 0x2::object::ID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct BondingCurves has key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, bool>,
        completed_list: 0x2::table::Table<0x2::object::ID, bool>,
        coin_type_list: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        name_symbol_registry: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        pending_fee: u64,
        total_fee: u64,
        start_sqrt_price: u128,
        end_sqrt_price: u128,
        current_sqrt_price: u128,
        liquidity: u128,
        status: u8,
        media_metadata: MediaMetadata,
        volume: u128,
        creator: address,
        clmm_pool_id: 0x1::option::Option<0x2::object::ID>,
        url: 0x1::option::Option<0x2::url::Url>,
    }

    struct MediaMetadata has copy, drop, store {
        website: 0x1::string::String,
        twitter: 0x1::string::String,
        discord: 0x1::string::String,
        telegram: 0x1::string::String,
    }

    struct CreateBondingCurveEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        treasury_cap_id: 0x2::object::ID,
        coin_metadata_id: 0x2::object::ID,
        bonding_curve_id: 0x2::object::ID,
        start_cap_id: 0x2::object::ID,
        creator: address,
        media_metadata: MediaMetadata,
        name: 0x1::string::String,
        decimal: u8,
        symbol: 0x1::ascii::String,
        url: 0x1::option::Option<0x2::url::Url>,
        sig: 0x1::string::String,
    }

    struct StartBondingCurveEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        fee_type: 0x1::type_name::TypeName,
        fee_amount: u64,
    }

    struct SwapEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        amount: u64,
        by_amount_in: bool,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        expect_rate_limit: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        timestamp: u64,
        current_sqrt_price: u128,
        after_sqrt_price: u128,
        swapper: address,
    }

    struct ClaimSwapFeeEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ClaimClmmFeeEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        amount_a: u64,
        amount_b: u64,
    }

    struct ClaimClmmRewardEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        rewarder: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct BurnLpEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        lp_position: 0x2::object::ID,
        lp_proof_to_protocol: bool,
        lp_burn_proof: 0x2::object::ID,
    }

    struct CompleteBondingCurveEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        clmm_pool: 0x2::object::ID,
        lp_position: 0x2::object::ID,
        timestamp: u64,
    }

    struct InitEvent has copy, drop {
        bonding_curves_id: 0x2::object::ID,
    }

    struct CompleteEvent has copy, drop {
        bonding_curve_id: 0x2::object::ID,
    }

    struct UpdateUrlEvent has copy, drop {
        bonding_curves_id: 0x2::object::ID,
        old_url: 0x1::option::Option<0x2::url::Url>,
        new_url: 0x1::option::Option<0x2::url::Url>,
    }

    fun swap<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: bool, arg6: bool, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        assert!(arg1.status == 1, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::status_not_raising());
        let (v0, v1, v2, v3) = if (arg5) {
            0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::math::buy(arg1.current_sqrt_price, arg1.end_sqrt_price, arg1.liquidity, arg4, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::swap_fee_rate(arg0), arg6)
        } else {
            0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::math::sell(arg1.current_sqrt_price, arg1.start_sqrt_price, arg1.liquidity, arg4, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::swap_fee_rate(arg0), arg6)
        };
        arg1.pending_fee = arg1.pending_fee + v3;
        arg1.total_fee = arg1.total_fee + v3;
        arg1.current_sqrt_price = v2;
        if (arg1.current_sqrt_price == arg1.end_sqrt_price) {
            arg1.status = 2;
            let v4 = CompleteEvent{bonding_curve_id: 0x2::object::id<BondingCurve<T0>>(arg1)};
            0x2::event::emit<CompleteEvent>(v4);
        };
        if (arg5) {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor(((v0 + v3) as u128), 100000000000000000000, (v1 as u128)) <= arg7, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::slippage_error());
        } else {
            assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v1 as u128), 100000000000000000000, (v0 as u128)) >= arg7, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::slippage_error());
        };
        let (v5, v6, v7) = if (arg5) {
            let v8 = v0 + v3;
            0x2::coin::destroy_zero<T0>(arg2);
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v8, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::amount_in_not_enough());
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v8, arg9)));
            (arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg9), v8)
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
            assert!(0x2::coin::value<T0>(&arg2) >= v0, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::amount_in_not_enough());
            0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg9)));
            (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v1), arg9), arg2, v1 + v3)
        };
        arg1.volume = arg1.volume + (v7 as u128);
        let v9 = if (arg5) {
            0x1::type_name::get<0x2::sui::SUI>()
        } else {
            0x1::type_name::get<T0>()
        };
        let v10 = if (arg5) {
            0x1::type_name::get<T0>()
        } else {
            0x1::type_name::get<0x2::sui::SUI>()
        };
        let v11 = if (arg5) {
            v0 + v3
        } else {
            v0
        };
        let v12 = SwapEvent{
            bonding_curve_id   : 0x2::object::id<BondingCurve<T0>>(arg1),
            amount             : arg4,
            by_amount_in       : arg6,
            from               : v9,
            target             : v10,
            expect_rate_limit  : arg7,
            amount_in          : v11,
            amount_out         : v1,
            fee_amount         : v3,
            timestamp          : 0x2::clock::timestamp_ms(arg8) / 1000,
            current_sqrt_price : arg1.current_sqrt_price,
            after_sqrt_price   : v2,
            swapper            : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<SwapEvent>(v12);
        (v5, v6)
    }

    public fun burn_lp<T0, T1, T2>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T2>, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.id, 0x1::string::utf8(b"ClmmPosition")), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::bonding_curve_not_migrated());
        let v0 = 0x2::dynamic_object_field::remove<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.id, 0x1::string::utf8(b"ClmmPosition"));
        let v1 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp<T0, T1>(arg2, arg3, v0, arg4);
        let v2 = if (0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::is_protocol_owned_lp(arg0)) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.id, 0x1::string::utf8(b"LPBurnProof"), v1);
            true
        } else {
            0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(v1, arg1.creator);
            false
        };
        arg1.status = 4;
        let v3 = BurnLpEvent{
            bonding_curve_id     : 0x2::object::id<BondingCurve<T2>>(arg1),
            lp_position          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            lp_proof_to_protocol : v2,
            lp_burn_proof        : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v1),
        };
        0x2::event::emit<BurnLpEvent>(v3);
    }

    public fun claim_clmm_fee<T0, T1, T2>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut BondingCurve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_manager_role(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T2>(arg2, arg4, arg5, 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg3.id, 0x1::string::utf8(b"LPBurnProof")), arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = ClaimClmmFeeEvent{
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg3),
            clmm_pool        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5),
            coin_a           : 0x1::type_name::get<T1>(),
            coin_b           : 0x1::type_name::get<T2>(),
            amount_a         : 0x2::coin::value<T1>(&v3),
            amount_b         : 0x2::coin::value<T2>(&v2),
        };
        0x2::event::emit<ClaimClmmFeeEvent>(v4);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::distribute_earnings<T1>(arg1, 0x2::coin::into_balance<T1>(v3));
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::distribute_earnings<T2>(arg1, 0x2::coin::into_balance<T2>(v2));
    }

    public fun claim_clmm_reward<T0, T1, T2, T3>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &mut BondingCurve<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_manager_role(arg0, 0x2::tx_context::sender(arg8));
        let v0 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_reward<T1, T2, T3>(arg2, arg4, arg5, 0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg3.id, 0x1::string::utf8(b"LPBurnProof")), arg6, arg7, arg8);
        let v1 = ClaimClmmRewardEvent{
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg3),
            clmm_pool        : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5),
            rewarder         : 0x1::type_name::get<T3>(),
            amount           : 0x2::coin::value<T3>(&v0),
        };
        0x2::event::emit<ClaimClmmRewardEvent>(v1);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::distribute_earnings<T3>(arg1, 0x2::coin::into_balance<T3>(v0));
    }

    public fun claim_fee<T0>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::distribute_earnings<T0>(arg1, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::claim_fee<T0>(arg0, arg2));
    }

    public fun claim_swap_fee<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::FeeVault, arg2: &mut BondingCurve<T0>, arg3: &0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_claim_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = arg2.pending_fee;
        arg2.pending_fee = 0;
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::fee_vault::distribute_earnings<0x2::sui::SUI>(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_balance, v0));
        let v1 = ClaimSwapFeeEvent{
            coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
            amount    : v0,
        };
        0x2::event::emit<ClaimSwapFeeEvent>(v1);
    }

    public fun create_bonding_curve<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0x1::option::Option<0x2::url::Url>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) : BondingCurveStartCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, arg1, arg2, arg3, arg4, arg10);
        let v2 = v1;
        let v3 = v0;
        let v4 = MediaMetadata{
            website  : 0x1::string::utf8(arg5),
            twitter  : 0x1::string::utf8(arg6),
            discord  : 0x1::string::utf8(arg7),
            telegram : 0x1::string::utf8(arg8),
        };
        let v5 = BondingCurve<T0>{
            id                 : 0x2::object::new(arg10),
            balance            : 0x2::balance::zero<T0>(),
            sui_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            pending_fee        : 0,
            total_fee          : 0,
            start_sqrt_price   : 0,
            end_sqrt_price     : 0,
            current_sqrt_price : 0,
            liquidity          : 0,
            status             : 0,
            media_metadata     : v4,
            volume             : 0,
            creator            : 0x2::tx_context::sender(arg10),
            clmm_pool_id       : 0x1::option::none<0x2::object::ID>(),
            url                : arg4,
        };
        let v6 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&v2);
        let v7 = 0x2::object::id<BondingCurve<T0>>(&v5);
        let v8 = BondingCurveStartCap<T0>{
            id               : 0x2::object::new(arg10),
            bonding_curve_id : v7,
            coin_metadata_id : v6,
            treasury_cap     : v3,
        };
        0x2::transfer::public_share_object<BondingCurve<T0>>(v5);
        let v9 = CreateBondingCurveEvent{
            coin_type        : 0x1::type_name::get<T0>(),
            treasury_cap_id  : 0x2::object::id<0x2::coin::TreasuryCap<T0>>(&v3),
            coin_metadata_id : v6,
            bonding_curve_id : v7,
            start_cap_id     : 0x2::object::id<BondingCurveStartCap<T0>>(&v8),
            creator          : 0x2::tx_context::sender(arg10),
            media_metadata   : v4,
            name             : 0x2::coin::get_name<T0>(&v2),
            decimal          : 0x2::coin::get_decimals<T0>(&v2),
            symbol           : 0x2::coin::get_symbol<T0>(&v2),
            url              : 0x2::coin::get_icon_url<T0>(&v2),
            sig              : arg9,
        };
        0x2::event::emit<CreateBondingCurveEvent>(v9);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v8
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BondingCurves{
            id                   : 0x2::object::new(arg0),
            list                 : 0x2::table::new<0x2::object::ID, bool>(arg0),
            completed_list       : 0x2::table::new<0x2::object::ID, bool>(arg0),
            coin_type_list       : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            name_symbol_registry : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = InitEvent{bonding_curves_id: 0x2::object::id<BondingCurves>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<BondingCurves>(v0);
    }

    public fun is_name_symbol_exist(arg0: &BondingCurves, arg1: 0x1::string::String, arg2: 0x1::ascii::String) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.name_symbol_registry, new_key_from_name_symbol(arg1, arg2))
    }

    public fun migrate_liquidity_to_clmm<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurves, arg2: &mut BondingCurve<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        if (arg2.status != 2) {
            return
        };
        arg2.status = 3;
        let v0 = 0x2::object::id<BondingCurve<T0>>(arg2);
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.list, v0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.completed_list, v0, true);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::get_tick_at_sqrt_price(arg2.current_sqrt_price);
        let v4 = arg2.current_sqrt_price;
        let (_, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v2), v3, v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_delta_b(arg2.start_sqrt_price, arg2.end_sqrt_price, arg2.liquidity, true), false);
        let v8 = 0x2::balance::value<T0>(&arg2.balance);
        let (v9, v10, v11) = if (v8 > v6 && 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance) > v7) {
            (v6, v7, false)
        } else {
            let (_, v13, v14) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(v2), v3, v4, v8, true);
            (v13, v14, true)
        };
        let (v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(200);
        let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2_with_creation_cap<T0, 0x2::sui::SUI>(arg3, arg4, 0x2::dynamic_object_field::borrow<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg2.id, 0x1::string::utf8(b"ClmmPoolCreationCap")), 200, arg2.current_sqrt_price, 0x1::string::utf8(b""), v15, v16, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v9), arg9), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.sui_balance, v10), arg9), arg6, arg7, v11, arg8, arg9);
        let v20 = v17;
        0x2::coin::destroy_zero<T0>(v18);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v19);
        let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v20);
        arg2.clmm_pool_id = 0x1::option::some<0x2::object::ID>(v21);
        let v22 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg5, v20, arg9);
        let v23 = if (0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::is_protocol_owned_lp(arg0)) {
            0x2::dynamic_object_field::add<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg2.id, 0x1::string::utf8(b"LPBurnProof"), v22);
            true
        } else {
            0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(v22, arg2.creator);
            false
        };
        arg2.status = 4;
        let v24 = BurnLpEvent{
            bonding_curve_id     : 0x2::object::id<BondingCurve<T0>>(arg2),
            lp_position          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v20),
            lp_proof_to_protocol : v23,
            lp_burn_proof        : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v22),
        };
        0x2::event::emit<BurnLpEvent>(v24);
        let v25 = CompleteBondingCurveEvent{
            bonding_curve_id : v0,
            clmm_pool        : v21,
            lp_position      : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v20),
            timestamp        : 0x2::clock::timestamp_ms(arg8) / 1000,
        };
        0x2::event::emit<CompleteBondingCurveEvent>(v25);
    }

    fun new_key_from_name_symbol(arg0: 0x1::string::String, arg1: 0x1::ascii::String) : 0x2::object::ID {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::ascii::as_bytes(&arg1));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>, u8) {
        let v0 = *0x1::vector::borrow<u8>(&arg0, 0);
        if (v0 == 1) {
            let v5 = x"01";
            let v6 = b"";
            let v7 = 0x1::vector::length<u8>(&arg0);
            let v8 = 1;
            while (v8 < v7) {
                if (v8 <= v7 - 33 - 1) {
                    0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&arg0, v8));
                } else {
                    0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&arg0, v8));
                };
                v8 = v8 + 1;
            };
            0x1::vector::remove<u8>(&mut v5, 0);
            (0x2::address::from_bytes(0x2::hash::blake2b256(&v5)), v5, v6, 1)
        } else {
            assert!(v0 == 0, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::scheme_not_support());
            let v9 = x"00";
            let v10 = b"";
            let v11 = 0x1::vector::length<u8>(&arg0);
            let v12 = 1;
            while (v12 < v11) {
                if (v12 <= v11 - 32 - 1) {
                    0x1::vector::push_back<u8>(&mut v10, *0x1::vector::borrow<u8>(&arg0, v12));
                } else {
                    0x1::vector::push_back<u8>(&mut v9, *0x1::vector::borrow<u8>(&arg0, v12));
                };
                v12 = v12 + 1;
            };
            0x1::vector::remove<u8>(&mut v9, 0);
            (0x2::address::from_bytes(0x2::hash::blake2b256(&v9)), v9, v10, 0)
        }
    }

    public fun start_bonding_curve<T0, T1>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurves, arg2: BondingCurveStartCap<T0>, arg3: &mut BondingCurve<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x2::coin::CoinMetadata<T0>, arg8: &0x2::clock::Clock, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        let BondingCurveStartCap {
            id               : v0,
            bonding_curve_id : v1,
            coin_metadata_id : _,
            treasury_cap     : v3,
        } = arg2;
        let v4 = v3;
        0x2::object::delete(v0);
        let v5 = 0x2::coin::get_name<T0>(arg7);
        let v6 = 0x2::coin::get_symbol<T0>(arg7);
        assert!(!is_name_symbol_exist(arg1, v5, v6), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::name_symbol_key_already_exists());
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.name_symbol_registry, new_key_from_name_symbol(v5, v6), true);
        let (v7, _, v9) = verify_internal(arg0, 0x1::ascii::into_bytes(0x2::url::inner_url(0x1::option::borrow<0x2::url::Url>(&arg3.url))), &arg9);
        assert!(v9 + 300 >= 0x2::clock::timestamp_ms(arg8) / 1000, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::signature_expired());
        assert!(v7, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::invalid_signature());
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.list, v1, true);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.coin_type_list, 0x1::type_name::get<T0>(), 0x2::object::id<BondingCurve<T0>>(arg3));
        let v10 = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::init_fee<T1>(arg0);
        assert!(0x2::coin::value<T1>(&arg4) == v10, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::incorrect_fee_amount());
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::receive_fee<T1>(arg0, 0x2::coin::into_balance<T1>(arg4));
        let (v11, v12, v13, v14) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::bonding_curve_config(arg0);
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::coin::mint_balance<T0>(&mut v4, v14));
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg5, arg6, &mut v4, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg5, arg6, 200, &v15, arg10);
        0x2::dynamic_object_field::add<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&mut arg3.id, 0x1::string::utf8(b"ClmmPoolCreationCap"), v15);
        let (v16, v17) = 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::math::get_init_liquidity_from_sui(v11, v12, v13);
        assert!(v14 >= v17, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::init_curve_config_error());
        arg3.start_sqrt_price = v11;
        arg3.current_sqrt_price = v11;
        arg3.end_sqrt_price = v12;
        arg3.liquidity = v16;
        arg3.status = 1;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(v4);
        let v18 = StartBondingCurveEvent{
            bonding_curve_id : v1,
            fee_type         : 0x1::type_name::get<T1>(),
            fee_amount       : v10,
        };
        0x2::event::emit<StartBondingCurveEvent>(v18);
    }

    public fun str_to_u64(arg0: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0x1::string::length(arg0);
        if (v0 == 0) {
            return 0x1::option::none<u64>()
        };
        let v1 = *0x1::string::as_bytes(arg0);
        0x1::vector::reverse<u8>(&mut v1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v1);
            if (v4 < 48 || v4 > 57) {
                return 0x1::option::none<u64>()
            };
            let v5 = ((v4 - 48) as u64);
            if (v2 > 18446744073709551615 / 10 || v2 == 18446744073709551615 / 10 && v5 > 18446744073709551615 % 10) {
                return 0x1::option::none<u64>()
            };
            let v6 = v2 * 10;
            v2 = v6 + v5;
            v3 = v3 + 1;
        };
        0x1::option::some<u64>(v2)
    }

    public fun swap_exact_input_meme<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        swap<T0>(arg0, arg1, arg2, v0, arg3, false, true, arg4, arg5, arg6)
    }

    public fun swap_exact_input_sui<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg6);
        swap<T0>(arg0, arg1, v0, arg2, arg3, true, true, arg4, arg5, arg6)
    }

    public fun swap_exact_output_meme<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<T0>(arg6);
        swap<T0>(arg0, arg1, v0, arg2, arg3, true, false, arg4, arg5, arg6)
    }

    public fun swap_exact_output_sui<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg6);
        swap<T0>(arg0, arg1, arg2, v0, arg3, false, false, arg4, arg5, arg6)
    }

    fun update_url<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x1::ascii::String) {
        arg0.url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg1));
        let v0 = UpdateUrlEvent{
            bonding_curves_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            old_url           : arg0.url,
            new_url           : arg0.url,
        };
        0x2::event::emit<UpdateUrlEvent>(v0);
    }

    public fun update_url_by_creator<T0, T1>(arg0: &mut 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x1::ascii::String, arg3: &mut 0x2::coin::Coin<T1>, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg1.creator, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::not_creator());
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_url_update_flag(arg0, arg1.status);
        let (v0, _, v2) = verify_internal(arg0, 0x1::ascii::into_bytes(arg2), &arg4);
        assert!(v2 + 300 >= 0x2::clock::timestamp_ms(arg5) / 1000, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::signature_expired());
        assert!(v0, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::invalid_signature());
        if (arg1.status == 1) {
            0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::receive_fee<T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::update_fee<T1>(arg0), arg6)));
        };
        update_url<T0>(arg1, arg2);
    }

    public fun update_url_by_manager<T0>(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: &mut BondingCurve<T0>, arg2: 0x1::ascii::String, arg3: &0x2::tx_context::TxContext) {
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_valid_package(arg0);
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_manager_role(arg0, 0x2::tx_context::sender(arg3));
        update_url<T0>(arg1, arg2);
    }

    fun verify_internal(arg0: &0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::Configs, arg1: vector<u8>, arg2: &0x1::string::String) : (bool, address, u64) {
        let v0 = 0x1::string::length(arg2);
        let v1 = 0x1::string::substring(arg2, 0, v0 - 10);
        let v2 = 0x1::string::substring(arg2, v0 - 10, v0);
        let v3 = str_to_u64(&v2);
        assert!(0x1::option::is_some<u64>(&v3), 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::invalid_signature());
        let v4 = 0x1::option::extract<u64>(&mut v3);
        let (v5, v6, v7, v8) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(&v1)));
        let v9 = v7;
        let v10 = v6;
        0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::config::assert_upload_role(arg0, v5);
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<u64>(&v4));
        let (v11, v4) = if (v8 == 0) {
            (0x2::ed25519::ed25519_verify(&v9, &v10, &arg1), v4)
        } else {
            assert!(v8 == 1, 0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::errors::scheme_not_support());
            (0x2::ecdsa_k1::secp256k1_verify(&v9, &v10, &arg1, 1), v4)
        };
        (v11, v5, v4)
    }

    // decompiled from Move bytecode v6
}

