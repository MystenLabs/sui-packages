module 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::bonding_curve {
    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        coin_vault: 0x2::balance::Balance<T0>,
        to_dex_vault: 0x2::balance::Balance<T0>,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        bonding_curve_amount: u64,
        lock_amount: u64,
        lock_period: u64,
        liquidity_seeded_timestamp: u64,
        ended: bool,
        coin_metadata: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::CoinMetadata,
        tick_spacing: u32,
        fee_rate: u64,
        end_sqrt_price: u128,
        to_dex_liquidity_bps: u64,
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
        lock_amount: u64,
        lock_period: u64,
    }

    struct SwapEvent has copy, drop, store {
        coin_id: 0x1::ascii::String,
        bonding_curve_id: 0x2::object::ID,
        user: address,
        amount_in: u64,
        amount_out: u64,
        locked_amount: u64,
        fee: u64,
        virtual_sui_reserve: u64,
        virtual_coin_reserve: u64,
        is_buy: bool,
    }

    public(friend) fun buy_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::CoinMetadata, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::LockedCoin<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.ended, 3);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            let v0 = v3;
            let (v4, v5, v6) = quote_amount_out<T0>(arg0, arg4, v3, true);
            if (v5 < v3) {
                v0 = v5;
            };
            assert!(v4 >= arg3, 2);
            (v0, v4, v6)
        } else {
            let v1 = arg3;
            let (v7, v8, v9) = quote_amount_in<T0>(arg0, arg4, arg3, true);
            if (v8 < arg3) {
                v1 = v8;
            };
            assert!(v7 <= 0x2::coin::value<0x2::sui::SUI>(arg1), 1);
            (v7, v1, v9)
        };
        let v10 = v0 - v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_vault, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v10));
        let v11 = 0x2::balance::split<T0>(&mut arg0.coin_vault, v1);
        let v12 = 0;
        let v13 = arg0.bonding_curve_amount - 0x2::balance::value<T0>(&arg0.coin_vault);
        let v14 = if (v13 >= arg0.lock_amount) {
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::zero<T0>(arg8)
        } else {
            let v15 = if (arg0.lock_amount - v13 > v1) {
                v1
            } else {
                arg0.lock_amount - v13
            };
            v12 = v15;
            0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::locked_coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, v15), arg8)
        };
        let v16 = 0x2::coin::from_balance<T0>(v11, arg8);
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve + v10;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve - v1;
        let v17 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg8),
            amount_in            : v10,
            amount_out           : v1,
            locked_amount        : v12,
            fee                  : v2,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : true,
        };
        0x2::event::emit<SwapEvent>(v17);
        let v18 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v2);
        if (0x2::balance::value<T0>(&arg0.coin_vault) == 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v18, seed_to_dex<T0>(arg6, arg0, arg7, arg5, arg8));
        };
        (v16, v14, v18)
    }

    public(friend) fun create_<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u64, arg3: u64, arg4: u32, arg5: u64, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        let v0 = arg2 - arg3;
        let v1 = 0x2::coin::mint_balance<T0>(&mut arg0, arg2);
        let v2 = arg8 + arg3;
        let v3 = 0;
        if (arg11 > 0) {
            let (v4, _) = quote_amount_in_(arg3, arg9, v2, arg12, true);
            let (v6, _) = quote_amount_out_((((v4 as u128) * (arg11 as u128) / (10000 as u128)) as u64), arg9, v2, arg12, true);
            v3 = v6;
        };
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        let v8 = 0x2::coin::get_icon_url<T0>(arg1);
        let v9 = if (0x1::option::is_some<0x2::url::Url>(&v8)) {
            let v10 = 0x1::option::extract<0x2::url::Url>(&mut v8);
            let v11 = 0x2::url::inner_url(&v10);
            *0x1::ascii::as_bytes(&v11)
        } else {
            0x1::vector::empty<u8>()
        };
        let v12 = 0x2::coin::get_symbol<T0>(arg1);
        let v13 = BondingCurve<T0>{
            id                         : 0x2::object::new(arg13),
            sui_vault                  : 0x2::balance::zero<0x2::sui::SUI>(),
            coin_vault                 : v1,
            to_dex_vault               : 0x2::balance::split<T0>(&mut v1, v0),
            virtual_sui_reserve        : arg9,
            virtual_coin_reserve       : arg8 + arg3,
            bonding_curve_amount       : arg3,
            lock_amount                : v3,
            lock_period                : arg10,
            liquidity_seeded_timestamp : 0,
            ended                      : false,
            coin_metadata              : 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata(v9, *0x1::ascii::as_bytes(&v12), 0x2::coin::get_decimals<T0>(arg1)),
            tick_spacing               : arg4,
            fee_rate                   : arg5,
            end_sqrt_price             : arg6,
            to_dex_liquidity_bps       : arg7,
        };
        let v14 = BondingCurveCreatedEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&v13.id),
            creator              : 0x2::tx_context::sender(arg13),
            virtual_sui_reserve  : arg9,
            virtual_coin_reserve : arg8 + arg3,
            total_supply         : arg2,
            bonding_curve_amount : arg3,
            to_dex_amount        : v0,
            lock_amount          : v13.lock_amount,
            lock_period          : arg10,
        };
        0x2::event::emit<BondingCurveCreatedEvent>(v14);
        v13
    }

    public fun get_bonding_curve<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault), 0x2::balance::value<T0>(&arg0.coin_vault), 0x2::balance::value<T0>(&arg0.to_dex_vault), arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg0.bonding_curve_amount, arg0.lock_amount, arg0.lock_period, arg0.liquidity_seeded_timestamp, arg0.ended)
    }

    public fun is_claimable<T0>(arg0: &BondingCurve<T0>, arg1: &0x2::clock::Clock) : bool {
        arg0.ended && arg0.liquidity_seeded_timestamp + arg0.lock_period <= 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun quote_amount_in<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
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
                v0 = (((v4 as u128) * ((10000 - arg1) as u128) / (10000 as u128)) as u64);
            };
            quote_amount_in_(v0, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3)
        };
        assert!(v1 != 0 && v2 != 0, 0);
        (v1, v0, v2)
    }

    public(friend) fun quote_amount_in_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
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

    public(friend) fun quote_amount_out<T0>(arg0: &BondingCurve<T0>, arg1: u64, arg2: u64, arg3: bool) : (u64, u64, u64) {
        let v0 = arg2;
        let (v1, v2) = if (arg3) {
            let (v3, v4) = quote_amount_out_(arg2, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
            let v2 = v4;
            let v1 = v3;
            let v5 = 0x2::balance::value<T0>(&arg0.coin_vault);
            if (v5 < v3) {
                v1 = v5;
                let (v6, v7) = quote_amount_in_(v5, arg0.virtual_sui_reserve, arg0.virtual_coin_reserve, arg1, arg3);
                v2 = v7;
                v0 = v6;
            };
            (v1, v2)
        } else {
            let (v8, v9) = quote_amount_out_(arg2, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
            let v2 = v9;
            let v1 = v8;
            let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_vault);
            if (v10 < v8 + v9) {
                let v11 = (((v10 as u128) * ((10000 - v9) as u128) / (10000 as u128)) as u64);
                v1 = v11;
                let (v12, v13) = quote_amount_in_(v11, arg0.virtual_coin_reserve, arg0.virtual_sui_reserve, arg1, arg3);
                v2 = v13;
                v0 = v12;
            };
            (v1, v2)
        };
        assert!(v1 != 0 && v2 != 0, 0);
        (v1, v0, v2)
    }

    public(friend) fun quote_amount_out_(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (u64, u64) {
        if (arg4) {
            let v2 = (((arg0 as u128) * (arg3 as u128) / (10000 as u128)) as u64);
            let v3 = arg0 - v2;
            ((((v3 as u128) * (arg2 as u128) / ((arg1 + v3) as u128)) as u64), v2)
        } else {
            let v4 = (((arg0 as u128) * (arg2 as u128) / ((arg1 + arg0) as u128)) as u64);
            let v5 = (((v4 as u128) * (arg3 as u128) / (10000 as u128)) as u64) + 1;
            (v4 - v5, v5)
        }
    }

    fun seed_to_dex<T0>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut BondingCurve<T0>, arg2: 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::CoinMetadata, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (_, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_pool_creation_fee_amount<0x2::sui::SUI>(arg0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_vault);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_vault, v2);
        let v4 = 0x2::balance::split<0x2::sui::SUI>(&mut v3, (((v2 as u128) * ((10000 - arg1.fee_rate) as u128) / (10000 as u128)) as u64));
        let v5 = *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_symbol(&arg2);
        0x1::vector::append<u8>(&mut v5, b"-");
        0x1::vector::append<u8>(&mut v5, *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_symbol(&arg1.coin_metadata));
        let (_, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_tick_range(arg0);
        let v8 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v7, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(v7, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1.tick_spacing)));
        let (_, v10, _, _, v13, v14) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<0x2::sui::SUI, T0, 0x2::sui::SUI>(arg3, arg0, v5, b"", *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_symbol(&arg2), 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_decimals(&arg2), *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_url(&arg2), *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_symbol(&arg1.coin_metadata), 0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_decimals(&arg1.coin_metadata), *0x1fdb64400d1f6d0906e940a0cb80d6950000af3078e7464ba9f021a74c939677::utils::coin_metadata_url(&arg1.coin_metadata), arg1.tick_spacing, arg1.fee_rate, arg1.end_sqrt_price, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_vault, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v8), v3, 0x2::balance::split<T0>(&mut arg1.to_dex_vault, 0x2::balance::value<T0>(&arg1.to_dex_vault)), v2, true, arg4);
        arg1.liquidity_seeded_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg1.ended = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg4), @0x0);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v10, @0x0);
        0x2::balance::join<0x2::sui::SUI>(&mut v4, v13);
        v4
    }

    public(friend) fun sell_<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(!arg0.ended, 3);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x2::coin::value<T0>(arg1);
            let v0 = v3;
            let (v4, v5, v6) = quote_amount_out<T0>(arg0, arg4, v3, false);
            if (v5 < v3) {
                v0 = v5;
            };
            assert!(v4 >= arg3, 2);
            (v0, v4, v6)
        } else {
            let v1 = arg3;
            let (v7, v8, v9) = quote_amount_in<T0>(arg0, arg4, arg3, false);
            if (v8 < arg3) {
                v1 = v8;
            };
            assert!(v7 <= 0x2::coin::value<T0>(arg1), 1);
            (v7, v1, v9)
        };
        let v10 = v1 + v2;
        0x2::balance::join<T0>(&mut arg0.coin_vault, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), v0));
        arg0.virtual_sui_reserve = arg0.virtual_sui_reserve - v10;
        arg0.virtual_coin_reserve = arg0.virtual_coin_reserve + v0;
        let v11 = SwapEvent{
            coin_id              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve_id     : 0x2::object::uid_to_inner(&arg0.id),
            user                 : 0x2::tx_context::sender(arg5),
            amount_in            : v0,
            amount_out           : v10,
            locked_amount        : 0,
            fee                  : v2,
            virtual_sui_reserve  : arg0.virtual_sui_reserve,
            virtual_coin_reserve : arg0.virtual_coin_reserve,
            is_buy               : false,
        };
        0x2::event::emit<SwapEvent>(v11);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v1), arg5), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_vault, v2))
    }

    // decompiled from Move bytecode v6
}

