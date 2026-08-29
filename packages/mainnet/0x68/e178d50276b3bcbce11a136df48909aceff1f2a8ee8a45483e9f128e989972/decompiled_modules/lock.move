module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::lock {
    struct LpLock<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        token: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        beneficiary: address,
        unlock_ms: u64,
    }

    struct BluefinPositionLock has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        position: 0x1::option::Option<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        beneficiary: address,
        unlock_ms: u64,
    }

    public(friend) fun abort_legacy_collect() {
        abort 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::use_split_collect()
    }

    public fun beneficiary<T0, T1>(arg0: &LpLock<T0, T1>) : address {
        arg0.beneficiary
    }

    public fun bluefin_lock_beneficiary(arg0: &BluefinPositionLock) : address {
        arg0.beneficiary
    }

    public fun bluefin_lock_has_position(arg0: &BluefinPositionLock) : bool {
        0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position)
    }

    public fun bluefin_lock_pool_id(arg0: &BluefinPositionLock) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun bluefin_lock_spot_id(arg0: &BluefinPositionLock) : 0x2::object::ID {
        arg0.bluefin_pool_id
    }

    public fun bluefin_lock_unlock_ms(arg0: &BluefinPositionLock) : u64 {
        arg0.unlock_ms
    }

    public fun claim_bluefin_position(arg0: &mut BluefinPositionLock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        assert!(arg0.unlock_ms != 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::still_locked());
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::still_locked());
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_beneficiary());
        assert!(0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_lp_claim(0x2::object::id<BluefinPositionLock>(arg0), arg0.pool_id, 0x2::tx_context::sender(arg2), 0, 0);
        0x1::option::extract<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position)
    }

    public fun claim_lp<T0, T1>(arg0: &mut LpLock<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::still_locked());
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::not_beneficiary());
        let v0 = 0x2::balance::value<T0>(&arg0.token);
        let v1 = 0x2::balance::value<T1>(&arg0.quote);
        assert!(v0 > 0 || v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_lp_claim(0x2::object::id<LpLock<T0, T1>>(arg0), arg0.pool_id, 0x2::tx_context::sender(arg2), v0, v1);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v0), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote, v1), arg2))
    }

    public fun collect_bluefin_fees<T0, T1>(arg0: &mut BluefinPositionLock, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) {
        abort_legacy_collect();
    }

    public fun collect_lp_fees<T0, T1>(arg0: &mut BluefinPositionLock, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg5: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::Pit<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.position), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_claim());
        let v0 = arg0.beneficiary;
        let (_, _, v3, v4) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::bluefin::collect_fee<T0, T1>(arg1, arg2, arg3, 0x1::option::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.position));
        let v5 = v4;
        let v6 = v3;
        let (v7, v8, v9) = split_std_lp_quote(0x2::balance::value<T1>(&v5), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::std_creator_bps(arg4), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::std_platform_bps(arg4), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::std_pit_bps(arg4));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::take_platform<T1>(arg4, 0x2::balance::split<T1>(&mut v5, v8));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pit::take_fee<T1>(arg5, 0x2::balance::split<T1>(&mut v5, v9));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_collect_lp_fees(0x2::object::id<BluefinPositionLock>(arg0), v0, 0x2::balance::value<T0>(&v6), v7, v8, v9);
        send_residual<T0>(v6, v0, arg6);
        send_residual<T1>(v5, v0, arg6);
    }

    public fun lock_graduated_lp<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>>(arg0);
        let v1 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::creator<T0, T1>(arg0);
        let (v2, v3) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::take_reserves_for_lock<T0, T1>(arg0);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::clock::timestamp_ms(arg2) + 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::lp_lock_ms(arg1);
        let v7 = LpLock<T0, T1>{
            id          : 0x2::object::new(arg3),
            pool_id     : v0,
            token       : v5,
            quote       : v4,
            beneficiary : v1,
            unlock_ms   : v6,
        };
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_lock(0x2::object::id<LpLock<T0, T1>>(&v7), v0, v1, v6, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4));
        0x2::transfer::share_object<LpLock<T0, T1>>(v7);
    }

    fun metadata_url<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : vector<u8> {
        let v0 = 0x2::coin::get_icon_url<T0>(arg0);
        if (0x1::option::is_some<0x2::url::Url>(&v0)) {
            let v2 = 0x1::option::destroy_some<0x2::url::Url>(v0);
            0x1::ascii::into_bytes(0x2::url::inner_url(&v2))
        } else {
            0x1::option::destroy_none<0x2::url::Url>(v0);
            b""
        }
    }

    public fun pool_id<T0, T1>(arg0: &LpLock<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun quote_value<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote)
    }

    public fun seed_and_lock_bluefin<T0>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, 0x2::sui::SUI>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::bluefin::creation_fee_amount<0x2::sui::SUI>(arg3);
        assert!(v0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        let v2 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::quote_reserves<T0, 0x2::sui::SUI>(arg0);
        assert!(v2 > v1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::insufficient_liquidity());
        let (v3, v4) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::take_reserves_for_lock<T0, 0x2::sui::SUI>(arg0);
        let v5 = v4;
        let (_, _, _, _) = seed_and_lock_internal<T0, 0x2::sui::SUI>(0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, 0x2::sui::SUI>>(arg0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::creator<T0, 0x2::sui::SUI>(arg0), 0x2::clock::timestamp_ms(arg2) + 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::lp_lock_ms(arg1), arg2, arg3, arg4, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1), v3, v5, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::sqrt_price_x64(0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::token_reserves<T0, 0x2::sui::SUI>(arg0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::virtual_quote<T0, 0x2::sui::SUI>(arg0) + v2), arg6);
    }

    public fun seed_and_lock_bluefin_with_fee<T0, T1>(arg0: &mut 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = take_creation_fee(arg3, arg6, v0, arg7);
        let (v2, v3) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::take_reserves_for_lock<T0, T1>(arg0);
        let (_, _, _, _) = seed_and_lock_internal<T0, T1>(0x2::object::id<0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::Pool<T0, T1>>(arg0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::creator<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg2) + 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::lp_lock_ms(arg1), arg2, arg3, arg4, arg5, v1, v2, v3, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::sqrt_price_x64(0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::token_reserves<T0, T1>(arg0), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::virtual_quote<T0, T1>(arg0) + 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::pool::quote_reserves<T0, T1>(arg0)), arg7);
    }

    public(friend) fun seed_and_lock_internal<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID, u64) {
        let v0 = 0x2::balance::value<T0>(&arg8);
        let v1 = 0x2::balance::value<T1>(&arg9);
        assert!(v0 > 0 && v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::insufficient_liquidity());
        let (v2, v3) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::bluefin::full_range_tick_bits(arg4);
        let v4 = 0x2::coin::get_symbol<T0>(arg5);
        let v5 = *0x1::ascii::as_bytes(&v4);
        0x1::vector::append<u8>(&mut v5, b"-");
        let v6 = 0x2::coin::get_symbol<T1>(arg6);
        0x1::vector::append<u8>(&mut v5, *0x1::ascii::as_bytes(&v6));
        let v7 = 0x2::coin::get_symbol<T0>(arg5);
        let v8 = 0x2::coin::get_symbol<T1>(arg6);
        let (v9, v10, _, _, v13, v14) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::bluefin::create_and_seed<T0, T1, 0x2::sui::SUI>(arg3, arg4, v5, metadata_url<T0>(arg5), *0x1::ascii::as_bytes(&v7), 0x2::coin::get_decimals<T0>(arg5), metadata_url<T0>(arg5), *0x1::ascii::as_bytes(&v8), 0x2::coin::get_decimals<T1>(arg6), metadata_url<T1>(arg6), arg10, arg7, v2, v3, arg8, arg9, v1, false, arg11);
        let v15 = v10;
        send_residual<T0>(v13, arg1, arg11);
        send_residual<T1>(v14, arg1, arg11);
        let v16 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v15);
        let v17 = BluefinPositionLock{
            id              : 0x2::object::new(arg11),
            pool_id         : arg0,
            bluefin_pool_id : v9,
            position        : 0x1::option::some<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v15),
            beneficiary     : arg1,
            unlock_ms       : arg2,
        };
        let v18 = 0x2::object::id<BluefinPositionLock>(&v17);
        if (arg2 != 0) {
            0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_bluefin_lock(v18, arg0, arg1, arg2, v0, v1, v9, v16);
        };
        0x2::transfer::share_object<BluefinPositionLock>(v17);
        (v18, v9, v16, arg2)
    }

    fun send_residual<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    fun send_residual_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public(friend) fun split_std_lp_quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(arg0, arg1, 10000);
        let v1 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(arg0, arg2, 10000);
        let v2 = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::math::mul_div(arg0, arg3, 10000);
        (v0 + arg0 - v0 - v1 - v2, v1, v2)
    }

    public(friend) fun take_creation_fee(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let (v0, v1) = 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::bluefin::creation_fee_amount<0x2::sui::SUI>(arg0);
        assert!(v0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::invalid_fee());
        let v2 = if (v1 == 0) {
            0x2::balance::zero<0x2::sui::SUI>()
        } else {
            0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg3))
        };
        send_residual_coin<0x2::sui::SUI>(arg1, arg2);
        v2
    }

    public fun token_value<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.token)
    }

    public fun unlock_ms<T0, T1>(arg0: &LpLock<T0, T1>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v7
}

