module 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::bonding_curve {
    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        userOf: 0x2::vec_map::VecMap<address, u64>,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        coin_vault: 0x2::balance::Balance<T0>,
        to_dex_vault: 0x2::balance::Balance<T0>,
        users_vault: 0x2::balance::Balance<T0>,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        bonding_curve_amount: u64,
        ended: bool,
        first_buy: bool,
        maxTx: bool,
        to_dex_liquidity_pbs: u64,
        pool_creation_cap: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap,
    }

    struct BondingCurveCreatedEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        creator: address,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        total_supply: u64,
        bonding_curve_amount: u64,
        to_dex_amount: u64,
        maxTx: bool,
        first_buy: bool,
    }

    struct SwapEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        user: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        is_buy: bool,
        first_buy: bool,
    }

    struct BondingCurveEndedEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sui_reserve: u64,
        coin_reserve: u64,
    }

    struct BondingCurveCompletedEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        sui_reserve: u64,
        coin_reserve: u64,
    }

    public fun buy_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(!arg0.ended, 0);
        assert!(arg0.first_buy, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 100000000, 4);
        let (v1, v2, v3) = if (arg2) {
            let v4 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            let (v5, v6, v7) = quote_amount_out<T0>(arg0, arg4, v4, true);
            let v8 = v4;
            if (v6 < v4) {
                v8 = v6;
            };
            assert!(v5 >= arg3, 2);
            (v8, v5, v7)
        } else {
            let (v9, v10, v11) = quote_amount_in<T0>(arg0, arg4, arg3, true);
            let v12 = arg3;
            if (v10 < arg3) {
                v12 = v10;
            };
            assert!(v9 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 5);
            (v9, v12, v11)
        };
        let v13 = v1 - v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v13));
        let v14 = 0x2::balance::split<T0>(&mut arg0.coin_vault, v2);
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve + v13;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve - v2;
        let v15 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg6),
            amount_in            : v13,
            amount_out           : v2,
            fee                  : v3,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : true,
            first_buy            : false,
        };
        0x2::event::emit<SwapEvent>(v15);
        if (0x2::balance::value<T0>(&arg0.coin_vault) == 0) {
            arg0.ended = true;
        };
        let v16 = 0x2::balance::value<T0>(&v14);
        if (!0x2::vec_map::contains<address, u64>(&arg0.userOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.userOf, v0, v16);
            if (arg0.maxTx == true) {
                assert!(v16 <= 10000000000000000, 8);
            };
        } else {
            let v17 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.userOf, &v0);
            *v17 = *v17 + v16;
            if (arg0.maxTx == true) {
                assert!(*v17 <= 10000000000000000, 8);
            };
        };
        0x2::balance::join<T0>(&mut arg0.users_vault, v14);
        0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v3)
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

    public fun create_<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg2: 0x2::coin::TreasuryCap<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        let v0 = arg3 - arg4;
        let v1 = 0x2::coin::mint_balance<T0>(&mut arg2, arg3);
        let v2 = arg6 + arg4;
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg0, arg1, &mut arg2, arg11);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg0, arg1, 200, &v3, arg11);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg2);
        let v4 = BondingCurve<T0>{
            id                   : 0x2::object::new(arg11),
            creator              : 0x2::tx_context::sender(arg11),
            userOf               : 0x2::vec_map::empty<address, u64>(),
            sui_vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            coin_vault           : v1,
            to_dex_vault         : 0x2::balance::split<T0>(&mut v1, v0),
            users_vault          : 0x2::balance::zero<T0>(),
            virtual_sui_reserve  : arg7,
            virtual_coin_reserve : v2,
            bonding_curve_amount : arg4,
            ended                : false,
            first_buy            : false,
            maxTx                : arg8,
            to_dex_liquidity_pbs : arg5,
            pool_creation_cap    : v3,
        };
        let v5 = BondingCurveCreatedEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&v4.id),
            creator              : 0x2::tx_context::sender(arg11),
            virtual_sui_reserve  : arg7,
            virtual_coin_reserve : v2,
            total_supply         : arg3,
            bonding_curve_amount : arg4,
            to_dex_amount        : v0,
            maxTx                : arg8,
            first_buy            : false,
        };
        0x2::event::emit<BondingCurveCreatedEvent>(v5);
        v4
    }

    public fun distribute_all_users<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ended, 0);
        let v0 = 0x2::vec_map::keys<address, u64>(&arg0.userOf);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            let v2 = *0x1::vector::borrow<address>(&v0, v1);
            if (0x2::vec_map::contains<address, u64>(&arg0.userOf, &v2)) {
                let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.userOf, &v2);
                *v3 = 0;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.users_vault, *v3), arg1), v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun distribute_user<T0>(arg0: &mut BondingCurve<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.ended, 0);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.userOf, &arg1), 9);
        let v0 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.userOf, &arg1);
        *v0 = 0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.users_vault, *v0), arg2)
    }

    public fun first_buy_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(!arg0.ended, 0);
        assert!(!arg0.first_buy, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 100000000, 4);
        let (v1, v2, v3) = if (arg2) {
            let v4 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            let (v5, v6, v7) = quote_amount_out<T0>(arg0, arg4, v4, true);
            let v8 = v4;
            if (v6 < v4) {
                v8 = v6;
            };
            assert!(v5 >= arg3, 2);
            (v8, v5, v7)
        } else {
            let (v9, v10, v11) = quote_amount_in<T0>(arg0, arg4, arg3, true);
            let v12 = arg3;
            if (v10 < arg3) {
                v12 = v10;
            };
            assert!(v9 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 5);
            (v9, v12, v11)
        };
        let v13 = v1 - v3;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v13));
        let v14 = 0x2::balance::split<T0>(&mut arg0.coin_vault, v2);
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve + v13;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve - v2;
        arg0.first_buy = true;
        let v15 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg6),
            amount_in            : v13,
            amount_out           : v2,
            fee                  : v3,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : true,
            first_buy            : true,
        };
        0x2::event::emit<SwapEvent>(v15);
        if (0x2::balance::value<T0>(&arg0.coin_vault) == 0) {
            arg0.ended = true;
        };
        let v16 = 0x2::balance::value<T0>(&v14);
        if (!0x2::vec_map::contains<address, u64>(&arg0.userOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.userOf, v0, v16);
            if (arg0.maxTx == true) {
                assert!(v16 <= 10000000000000000, 8);
            };
        } else {
            let v17 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.userOf, &v0);
            *v17 = *v17 + v16;
            if (arg0.maxTx == true) {
                assert!(*v17 <= 10000000000000000, 8);
            };
        };
        0x2::balance::join<T0>(&mut arg0.users_vault, v14);
        0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v3)
    }

    public fun get_bonding_curve<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault), 0x2::balance::value<T0>(&arg0.coin_vault), 0x2::balance::value<T0>(&arg0.to_dex_vault), arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg0.bonding_curve_amount, arg0.ended)
    }

    fun max_tick() : 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::I32 {
        0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::from(443636)
    }

    public fun migrate_start<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.ended, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.to_dex_vault);
        let v1 = 0x2::balance::split<T0>(&mut arg0.to_dex_vault, v0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v2);
        let v4 = BondingCurveCompletedEvent{
            coin_id          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            sui_reserve      : v2,
            coin_reserve     : v0,
        };
        0x2::event::emit<BondingCurveCompletedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, 40000000), arg1), @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2 * 2 / 100), arg1), arg0.creator);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2 * 8 / 100), arg1), @0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b);
        (0x2::coin::from_balance<T0>(v1, arg1), 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg1))
    }

    public fun migrate_to_dex<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
        let v1 = 0x2::balance::value<T0>(&arg0.to_dex_vault);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2_with_creation_cap<T0, 0x2::sui::SUI>(arg1, arg2, &mut arg0.pool_creation_cap, 200, calculate_sqrt_price(v0, v1), 0x1::string::utf8(b"SUI-Token Full Range Pool - from Eric"), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::as_u32(0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::mul(0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::div(min_tick(), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::from(200)), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::from(200))), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::as_u32(0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::mul(0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::div(max_tick(), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::from(200)), 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::from(200))), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.to_dex_vault, v1), arg7), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v0), arg7), arg5, arg4, true, arg6, arg7);
        let v5 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v5);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v4);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg3, v5, arg7), arg0.creator);
    }

    fun min_tick() : 0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::I32 {
        0xf3c1d092bfb7fcea3c1147289b5763cb6973436bd4a0ea6a012605dfce4f2905::i32::neg_from(443636)
    }

    public fun quote_amount_in<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = arg2;
        let (v1, v2) = if (arg3) {
            let v3 = 0x2::balance::value<T0>(&arg0.coin_vault);
            if (v3 < arg2) {
                v0 = v3;
            };
            quote_amount_in_(v0, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3)
        } else {
            let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
            if (v4 < arg2 + (((arg2 as u128) * (arg1 as u128) / ((10000 - arg1) as u128)) as u64)) {
                v0 = (((v4 as u128) * ((10000 - arg1) as u128) / 10000) as u64);
            };
            quote_amount_in_(v0, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3)
        };
        assert!(v1 != 0 && v2 != 0, 11);
        (v1, v0, v2)
    }

    public fun quote_amount_in_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        if (arg4) {
            let v2 = (((arg1 as u128) * (arg0 as u128) / ((arg2 - arg0) as u128)) as u64) + 1;
            let v3 = (((v2 as u128) * (arg3 as u128) / ((10000 - arg3) as u128)) as u64);
            (v2 + v3, v3)
        } else {
            let v4 = (((arg0 as u128) * (arg3 as u128) / ((10000 - arg3) as u128)) as u64);
            let v5 = arg0 + v4;
            ((((v5 as u128) * (arg1 as u128) / ((arg2 - v5) as u128)) as u64) + 1, v4)
        }
    }

    public fun quote_amount_out<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = arg2;
        let (v1, v2) = if (arg3) {
            let (v3, v4) = quote_amount_out_(arg2, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
            let v5 = v3;
            let v6 = v4;
            let v7 = 0x2::balance::value<T0>(&arg0.coin_vault);
            if (v7 < v3) {
                v5 = v7;
                let (v8, v9) = quote_amount_in_(v7, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
                v6 = v9;
                v0 = v8;
            };
            (v5, v6)
        } else {
            let (v10, v11) = quote_amount_out_(arg2, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
            let v12 = v10;
            let v13 = v11;
            let v14 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
            if (v14 < v10 + v11) {
                let v15 = (((v14 as u128) * ((10000 - v11) as u128) / 10000) as u64);
                v12 = v15;
                let (v16, v17) = quote_amount_in_(v15, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
                v13 = v17;
                v0 = v16;
            };
            (v12, v13)
        };
        assert!(v1 != 0 && v2 != 0, 11);
        (v1, v0, v2)
    }

    public fun quote_amount_out_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        if (arg4) {
            let v2 = (((arg0 as u128) * (arg3 as u128) / 10000) as u64);
            let v3 = arg0 - v2;
            ((((v3 as u128) * (arg2 as u128) / ((arg1 + v3) as u128)) as u64), v2)
        } else {
            let v4 = (((arg0 as u128) * (arg2 as u128) / ((arg1 + arg0) as u128)) as u64);
            let v5 = (((v4 as u128) * (arg3 as u128) / 10000) as u64) + 1;
            (v4 - v5, v5)
        }
    }

    public fun sell_<T0>(arg0: &mut BondingCurve<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.ended, 0);
        assert!(arg0.first_buy, 1);
        let (v0, v1, v2) = if (arg2) {
            let v3 = arg1;
            let (v4, v5, v6) = quote_amount_out<T0>(arg0, arg4, arg1, false);
            if (v5 < arg1) {
                v3 = v5;
            };
            assert!(v4 >= arg3, 2);
            (v3, v4, v6)
        } else {
            let v7 = arg3;
            let (v8, v9, v10) = quote_amount_in<T0>(arg0, arg4, arg3, false);
            if (v9 < arg3) {
                v7 = v9;
            };
            assert!(v8 <= arg1, 5);
            (v8, v7, v10)
        };
        let v11 = v1 + v2;
        let v12 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.userOf, &v12), 9);
        let v13 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.userOf, &v12);
        assert!(*v13 >= arg1, 11);
        *v13 = *v13 - arg1;
        0x2::balance::join<T0>(&mut arg0.coin_vault, 0x2::balance::split<T0>(&mut arg0.users_vault, arg1));
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve - v11;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve + v0;
        let v14 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg5),
            amount_in            : v0,
            amount_out           : v11,
            fee                  : v2,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : false,
            first_buy            : false,
        };
        0x2::event::emit<SwapEvent>(v14);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v1), arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v2))
    }

    // decompiled from Move bytecode v6
}

