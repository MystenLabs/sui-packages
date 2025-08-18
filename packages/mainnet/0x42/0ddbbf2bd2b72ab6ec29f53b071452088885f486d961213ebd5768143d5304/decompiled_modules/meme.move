module 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MemeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        is_create_enabled: bool,
        minimum_version: u64,
        virtual_sui_amount: u64,
        curve_supply: u64,
        listing_fee: u64,
        swap_fee_bps: u64,
        migration_fee: u64,
        creator_fee: u64,
        treasury: address,
    }

    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amount: u64,
        token_balance: 0x2::balance::Balance<T0>,
        available_token_reserves: u64,
        creator: address,
        curve_type: u8,
        status: u8,
        pool_creation_cap: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap,
    }

    struct BondingCurveEndedEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sui_amount: u64,
        coin_amount: u64,
    }

    struct MigrateReceipt {
        curve_id: 0x2::object::ID,
    }

    struct DevOrder has store {
        buy_coin: 0x2::coin::Coin<0x2::sui::SUI>,
        token_amount: u64,
    }

    struct DevOrderV2 has store {
        buy_coin: 0x2::coin::Coin<0x2::sui::SUI>,
        token_amount: u64,
        creator: address,
    }

    public fun accept_connector<T0>(arg0: &mut MemeConfig, arg1: 0x2::transfer::Receiving<0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector::Connector<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg0);
    }

    public fun accept_connector_v2<T0>(arg0: &mut MemeConfig, arg1: 0x2::transfer::Receiving<0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v2::ConnectorV2<T0>>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg0);
    }

    public fun accept_connector_v3<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut MemeConfig, arg7: 0x2::transfer::Receiving<0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::ConnectorV3<T0>>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg6);
        let v0 = 0x2::transfer::public_receive<0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::ConnectorV3<T0>>(&mut arg6.id, arg7);
        let v1 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::get_temp_id<T0>(&v0);
        assert!(0x2::dynamic_field::exists_<u64>(&arg6.id, v1), 7);
        let DevOrderV2 {
            buy_coin     : v2,
            token_amount : v3,
            creator      : v4,
        } = 0x2::dynamic_field::remove<u64, DevOrderV2>(&mut arg6.id, v1);
        let v5 = v2;
        assert!(0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::get_creator<T0>(&v0) == v4, 11);
        let v6 = create_bonding_curve_v3<T0>(arg0, arg1, arg8, v0, arg6, arg9);
        if (0x2::coin::value<0x2::sui::SUI>(&v5) > 0) {
            let v7 = &mut v6;
            let (v8, v9) = buy_returns_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v7, arg6, v5, v3, v3, v4, true, arg9);
            delete_or_return<0x2::sui::SUI>(v8, v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, v4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        0x2::transfer::share_object<BondingCurve<T0>>(v6);
    }

    public entry fun buy<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut BondingCurve<T0>, arg7: &MemeConfig, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = buy_returns<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        delete_or_return<0x2::sui::SUI>(v0, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg11);
    }

    public fun buy_returns<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut BondingCurve<T0>, arg7: &MemeConfig, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: address, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        buy_returns_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, false, arg12)
    }

    fun buy_returns_internal<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg3: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::clock::Clock, arg6: &mut BondingCurve<T0>, arg7: &MemeConfig, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: u64, arg10: u64, arg11: address, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        enforce_config_version(arg7);
        assert!(arg6.status == 0, 1);
        assert!(arg10 <= arg9, 10);
        let v0 = 0x2::balance::value<T0>(&arg6.token_balance);
        let v1 = arg6.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg6.sui_balance);
        let v2 = 0x1::u64::min(arg9, arg6.available_token_reserves);
        let v3 = v2;
        let v4 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_amount_in(v2, v1, v0);
        let v5 = v4;
        let v6 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_fee_amount(v4, arg7.swap_fee_bps);
        let v7 = v6;
        if (0x2::coin::value<0x2::sui::SUI>(&arg8) < v4 + v6) {
            let v8 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_fee_amount(0x2::coin::value<0x2::sui::SUI>(&arg8), arg7.swap_fee_bps);
            v7 = v8;
            let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg8) - v8;
            v5 = v9;
            let v10 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_amount_out(v9, v1, v0);
            v3 = v10;
            assert!(v10 >= arg10, 2);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, v7, arg13), @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b);
        0x2::coin::put<0x2::sui::SUI>(&mut arg6.sui_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg8, v5, arg13));
        let v11 = 0x2::coin::take<T0>(&mut arg6.token_balance, v3, arg13);
        arg6.available_token_reserves = arg6.available_token_reserves - 0x2::coin::value<T0>(&v11);
        if (arg6.available_token_reserves == 0) {
            arg6.status = 2;
            migrate_to_dex<T0>(arg7, arg6, arg0, arg1, arg2, arg3, arg4, arg5, arg13);
            0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::events::emit_complete<T0>(get_id<T0>(arg6));
        };
        0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::events::emit_buy<T0>(get_id<T0>(arg6), v5 + v7, v3, get_price_per_token_scaled<T0>(arg6), get_price_per_token_scaled<T0>(arg6), arg11, arg12, arg6.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg6.sui_balance), 0x2::balance::value<T0>(&arg6.token_balance), arg6.available_token_reserves);
        (arg8, v11)
    }

    fun calculate_sqrt_price(arg0: u64, arg1: u64) : u128 {
        let v0 = 0x1::u128::sqrt((arg0 as u128) * 18446744073709551615 / (arg1 as u128) * 18446744073709551616);
        let v1 = if (v0 < 4295048016) {
            4295048016
        } else {
            v0
        };
        if (v1 > 79226673515401279992447579055) {
            79226673515401279992447579055
        } else {
            v1
        }
    }

    fun create_bonding_curve_v3<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::ConnectorV3<T0>, arg4: &MemeConfig, arg5: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        enforce_config_version(arg4);
        let (v0, v1, v2, v3, v4, v5, v6) = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::connector_v3::deconstruct<T0>(arg3);
        let v7 = v6;
        0x2::object::delete(v0);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg0, arg1, &mut v7, arg5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg0, arg1, 200, &v8, arg5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(v7);
        let v9 = BondingCurve<T0>{
            id                       : 0x2::object::new(arg5),
            sui_balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amount       : arg4.virtual_sui_amount,
            token_balance            : v1,
            available_token_reserves : arg4.curve_supply,
            creator                  : v5,
            curve_type               : 0,
            status                   : 0,
            pool_creation_cap        : v8,
        };
        0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::events::emit_curve_create<T0>(get_id<T0>(&v9), v5, 0x2::coin::get_name<T0>(arg2), 0x2::coin::get_symbol<T0>(arg2), 0x2::coin::get_description<T0>(arg2), 0x2::coin::get_icon_url<T0>(arg2), v2, v3, v4);
        v9
    }

    public fun delete_or_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    fun enforce_config_version(arg0: &MemeConfig) {
        assert!(3 >= arg0.minimum_version, 0);
    }

    public fun get_id<T0>(arg0: &BondingCurve<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun get_price_per_token_scaled<T0>(arg0: &BondingCurve<T0>) : u64 {
        if (0x2::balance::value<T0>(&arg0.token_balance) == 0) {
            return 0
        };
        ((((arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) as u128) * 1000000000 / (0x2::balance::value<T0>(&arg0.token_balance) as u128)) as u64)
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = MemeConfig{
            id                 : 0x2::object::new(arg1),
            version            : 3,
            is_create_enabled  : true,
            minimum_version    : 3,
            virtual_sui_amount : 588000000000,
            curve_supply       : 800000000000000,
            listing_fee        : 0,
            swap_fee_bps       : 100,
            migration_fee      : 300000000000,
            creator_fee        : 50000000000,
            treasury           : @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b,
        };
        0x2::transfer::share_object<MemeConfig>(v1);
    }

    fun max_tick() : 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::I32 {
        0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::from(443636)
    }

    public fun migrate_to_dex<T0>(arg0: &MemeConfig, arg1: &mut BondingCurve<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance);
        let v1 = 0x2::balance::value<T0>(&arg1.token_balance);
        let v2 = 2000000000000;
        let v3 = v0 - v2 - arg0.migration_fee - arg0.creator_fee;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v3), arg8), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg0.migration_fee), arg8), arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, arg0.creator_fee), arg8), arg1.creator);
        let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2_with_creation_cap<T0, 0x2::sui::SUI>(arg2, arg3, &mut arg1.pool_creation_cap, 200, calculate_sqrt_price(v2, v1), 0x1::string::utf8(b"SUI-Token Full Range Pool - from Eric"), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::as_u32(0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::mul(0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::div(min_tick(), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::from(200)), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::from(200))), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::as_u32(0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::mul(0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::div(max_tick(), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::from(200)), 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::from(200))), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_balance, v1), arg8), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_balance, v2), arg8), arg6, arg5, true, arg7, arg8);
        let v7 = v4;
        let v8 = BondingCurveEndedEvent{
            coin_id          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id : 0x2::object::uid_to_inner(&arg1.id),
            pool_id          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v7),
            sui_amount       : v0,
            coin_amount      : v1,
        };
        0x2::event::emit<BondingCurveEndedEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v7, arg8), arg0.treasury);
    }

    fun min_tick() : 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::I32 {
        0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::i32::neg_from(443636)
    }

    public fun place_dev_order(arg0: &mut MemeConfig, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        enforce_config_version(arg0);
        assert!(arg0.is_create_enabled, 9);
        let v0 = &mut arg0.id;
        assert!(!0x2::dynamic_field::exists_<u64>(v0, arg1), 8);
        let v1 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_amount_in(arg3, arg0.virtual_sui_amount, 1000000000000000);
        let v2 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_fee_amount(v1, arg0.swap_fee_bps);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.listing_fee + v1 + v2, 5);
        if (arg0.listing_fee > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg0.listing_fee, arg4), arg0.treasury);
        };
        let v3 = 0x2::tx_context::sender(arg4);
        let v4 = DevOrderV2{
            buy_coin     : 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1 + v2, arg4),
            token_amount : arg3,
            creator      : v3,
        };
        delete_or_return<0x2::sui::SUI>(arg2, v3);
        0x2::dynamic_field::add<u64, DevOrderV2>(v0, arg1, v4);
    }

    public entry fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: &MemeConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_returns<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun sell_returns<T0>(arg0: &mut BondingCurve<T0>, arg1: &MemeConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        enforce_config_version(arg1);
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_amount_out(v0, 0x2::balance::value<T0>(&arg0.token_balance), arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance));
        arg0.available_token_reserves = arg0.available_token_reserves + v0;
        0x2::coin::put<T0>(&mut arg0.token_balance, arg2);
        let v2 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::math::get_fee_amount(v1, arg1.swap_fee_bps), arg4), @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= arg3, 2);
        0x420ddbbf2bd2b72ab6ec29f53b071452088885f486d961213ebd5768143d5304::events::emit_sell<T0>(get_id<T0>(arg0), 0x2::coin::value<0x2::sui::SUI>(&v2), v0, get_price_per_token_scaled<T0>(arg0), get_price_per_token_scaled<T0>(arg0), arg0.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.available_token_reserves);
        v2
    }

    public fun set_create_enabled(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: bool) {
        enforce_config_version(arg1);
        arg1.is_create_enabled = arg2;
    }

    public fun update_creator_fee(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        arg1.creator_fee = arg2;
    }

    public fun update_listing_fee(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        arg1.listing_fee = arg2;
    }

    public fun update_migration_fee(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        arg1.migration_fee = arg2;
    }

    public fun update_minimum_version(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        assert!(arg2 >= arg1.minimum_version, 0);
        arg1.minimum_version = arg2;
    }

    public fun update_swap_fee_bps(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        assert!(arg2 < 10000, 4);
        arg1.swap_fee_bps = arg2;
    }

    public fun update_treasury(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: address) {
        enforce_config_version(arg1);
        arg1.treasury = arg2;
    }

    public fun update_virtual_sui_amount(arg0: &AdminCap, arg1: &mut MemeConfig, arg2: u64) {
        enforce_config_version(arg1);
        arg1.virtual_sui_amount = arg2;
    }

    // decompiled from Move bytecode v6
}

