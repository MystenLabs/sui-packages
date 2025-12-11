module 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::vault {
    struct LiquidityRange has drop, store {
        lower_offset: u32,
        upper_offset: u32,
        rebalance_threshold: u32,
    }

    struct ClmmVault has store {
        pool_id: 0x2::object::ID,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        liquidity_range: LiquidityRange,
        wrapped_position: 0x1::option::Option<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>,
    }

    struct MigrateLiquidity has copy, drop {
        old_position: 0x2::object::ID,
        new_position: 0x2::object::ID,
        new_staked_position: 0x2::object::ID,
        old_tick_lower: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        old_tick_upper: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_tick_upper: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        new_tick_lower: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32,
        amount_a: u64,
        amount_b: u64,
    }

    public fun borrow_staked_position(arg0: &ClmmVault) : &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position)
    }

    public fun coin_types(arg0: &ClmmVault) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_a, arg0.coin_b)
    }

    public fun collect_pool_reward<T0, T1, T2>(arg0: &ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::get_pool_reward<T0, T1, T2>(arg3, arg4, arg2, arg1, arg5, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), arg6)
    }

    public fun collect_position_reward<T0, T1, T2, T3>(arg0: &ClmmVault, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::Minter<T2>, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0x2::coin::into_balance<T3>(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::minter::get_position_reward<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), arg5, arg6))
    }

    fun create_staked_position<T0, T1>(arg0: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg1: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = next_position_range(arg5, arg6, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::tick_spacing<T0, T1>(arg4), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg4));
        let v2 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg2, arg4, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v0), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(v1), arg10);
        let v3 = &mut v2;
        let v4 = &mut arg7;
        let v5 = &mut arg8;
        let (_, _, _) = increase_liquidity_internal<T0, T1>(arg2, arg3, arg4, v3, v4, v5, arg9);
        (0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::deposit_position<T0, T1>(arg2, arg0, arg1, arg4, v2, arg9, arg10), arg7, arg8)
    }

    public fun decrease_liquidity<T0, T1>(arg0: &mut ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::decrease_liquidity<T0, T1>(arg2, arg1, arg3, arg4, arg5, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), arg6, arg7, arg8)
    }

    public fun get_liquidity_range(arg0: &ClmmVault) : (u32, u32, u32) {
        (arg0.liquidity_range.lower_offset, arg0.liquidity_range.upper_offset, arg0.liquidity_range.rebalance_threshold)
    }

    public fun get_position_liquidity<T0, T1>(arg0: &ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>) : u128 {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::borrow_position<T0, T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position)))
    }

    public fun get_position_tick_range<T0, T1>(arg0: &ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::borrow_position<T0, T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position)))
    }

    public fun increase_liquidity<T0, T1>(arg0: &mut ClmmVault, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &mut 0x2::balance::Balance<T0>, arg7: &mut 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64, u128) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::withdraw_position<T0, T1>(arg4, arg3, arg5, 0x1::option::extract<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position), arg8, arg9);
        let v1 = &mut v0;
        let (v2, v3, v4) = increase_liquidity_internal<T0, T1>(arg1, arg2, arg5, v1, arg6, arg7, arg8);
        0x1::option::fill<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position, 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::deposit_position<T0, T1>(arg1, arg3, arg4, arg5, v0, arg8, arg9));
        (v2, v3, v4)
    }

    fun increase_liquidity_internal<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg3: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) : (u64, u64, u128) {
        let v0 = 0x2::balance::value<T0>(arg4);
        let v1 = 0x2::balance::value<T1>(arg5);
        let v2 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg2);
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_sqrt_price<T0, T1>(arg2);
        let (v4, v5) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(arg3);
        let (v6, _, v8) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::clmm_math::get_liquidity_by_amount(v4, v5, v2, v3, v0, true);
        let v9 = if (v8 <= v1) {
            v6
        } else {
            let (v10, _, _) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::clmm_math::get_liquidity_by_amount(v4, v5, v2, v3, v1, false);
            v10
        };
        if (v9 == 0) {
            return (0, 0, 0)
        };
        let v13 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, v9, arg6);
        let (v14, v15) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::add_liquidity_pay_amount<T0, T1>(&v13);
        assert!(v14 <= v0, 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::amount_in_above_max_limit());
        assert!(v15 <= v1, 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::amount_in_above_max_limit());
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::repay_add_liquidity<T0, T1>(arg0, arg2, 0x2::balance::split<T0>(arg4, v14), 0x2::balance::split<T1>(arg5, v15), v13);
        (v14, v15, v9)
    }

    public fun is_stopped(arg0: &ClmmVault) : bool {
        0x1::option::is_none<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position)
    }

    public fun liquidity_value<T0, T1>(arg0: &ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg2: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>) : (u64, u64) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::borrow_position<T0, T1>(arg1, 0x1::option::borrow<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position));
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(v0);
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::clmm_math::get_amount_by_liquidity(v1, v2, 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_tick_index<T0, T1>(arg2), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::current_sqrt_price<T0, T1>(arg2), 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(v0), false)
    }

    public fun new<T0, T1>(arg0: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg1: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg2: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg3: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg5: u32, arg6: u32, arg7: u32, arg8: 0x2::balance::Balance<T0>, arg9: 0x2::balance::Balance<T1>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : ClmmVault {
        let v0 = LiquidityRange{
            lower_offset        : arg5,
            upper_offset        : arg6,
            rebalance_threshold : arg7,
        };
        let (v1, v2, v3) = create_staked_position<T0, T1>(arg2, arg3, arg0, arg1, arg4, v0.lower_offset, v0.upper_offset, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg11), 0x2::tx_context::sender(arg11));
        ClmmVault{
            pool_id          : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>>(arg4),
            coin_a           : 0x1::type_name::with_defining_ids<T0>(),
            coin_b           : 0x1::type_name::with_defining_ids<T1>(),
            liquidity_range  : v0,
            wrapped_position : 0x1::option::some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(v1),
        }
    }

    public fun next_position_range(arg0: u32, arg1: u32, arg2: u32, arg3: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) : (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32) {
        (round_tick_to_spacing(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(arg3, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from_u32(arg0)), arg2), round_tick_to_spacing(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::add(arg3, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from_u32(arg1)), arg2))
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun pool_id(arg0: &ClmmVault) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun rebalance<T0, T1>(arg0: &mut ClmmVault, arg1: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg2: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg3: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg4: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg9: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, MigrateLiquidity) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::withdraw_position<T0, T1>(arg2, arg1, arg5, 0x1::option::extract<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position), arg10, arg11);
        let (v1, v2) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::tick_range(&v0);
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&v0);
        if (v3 > 0) {
            let (v4, v5) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fee<T0, T1>(arg3, arg5, &v0, true);
            0x2::balance::join<T0>(&mut arg6, v4);
            0x2::balance::join<T1>(&mut arg7, v5);
            let (v6, v7) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::remove_liquidity<T0, T1>(arg3, arg4, arg5, &mut v0, v3, arg10);
            0x2::balance::join<T0>(&mut arg6, v6);
            0x2::balance::join<T1>(&mut arg7, v7);
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::close_position<T0, T1>(arg3, arg5, v0);
        let v8 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::open_position<T0, T1>(arg3, arg5, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg8), 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::as_u32(arg9), arg11);
        let v9 = &mut v8;
        let v10 = &mut arg6;
        let v11 = &mut arg7;
        let (_, _, _) = increase_liquidity_internal<T0, T1>(arg3, arg4, arg5, v9, v10, v11, arg10);
        let v15 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::deposit_position<T0, T1>(arg3, arg1, arg2, arg5, v8, arg10, arg11);
        0x1::option::fill<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position, v15);
        let v16 = MigrateLiquidity{
            old_position        : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&v0),
            new_position        : 0x2::object::id<0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::Position>(&v8),
            new_staked_position : 0x2::object::id<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&v15),
            old_tick_lower      : v1,
            old_tick_upper      : v2,
            new_tick_upper      : arg9,
            new_tick_lower      : arg8,
            amount_a            : 0x2::balance::value<T0>(&arg6),
            amount_b            : 0x2::balance::value<T1>(&arg7),
        };
        (arg6, arg7, v16)
    }

    public fun rebalance_threshold(arg0: &ClmmVault) : u32 {
        arg0.liquidity_range.rebalance_threshold
    }

    fun round_tick_to_spacing(arg0: 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32, arg1: u32) : 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::I32 {
        if (0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::is_neg(arg0)) {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::add(arg0, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(arg0) % arg1))
        } else {
            0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::sub(arg0, 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::from_u32(0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::i32::abs_u32(arg0) % arg1))
        }
    }

    public fun start_vault<T0, T1>(arg0: &mut ClmmVault, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x1::option::is_none<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_started());
        let (v0, v1, v2) = create_staked_position<T0, T1>(arg3, arg4, arg1, arg2, arg5, arg0.liquidity_range.lower_offset, arg0.liquidity_range.upper_offset, arg6, arg7, arg8, arg9);
        0x1::option::fill<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position, v0);
        (v1, v2)
    }

    public fun stop_vault<T0, T1>(arg0: &mut ClmmVault, arg1: &0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::config::GlobalConfig, arg2: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::rewarder::RewarderGlobalVault, arg3: &0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::distribution_config::DistributionConfig, arg4: &mut 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::Gauge<T0, T1>, arg5: &mut 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x1::option::is_some<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&arg0.wrapped_position), 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::vault_stopped());
        let v0 = 0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::withdraw_position<T0, T1>(arg4, arg3, arg5, 0x1::option::extract<0xebd610a15f0caa02527f4544eaf56fb4655ef493e8654f44a14220e442245d2e::gauge::StakedPosition>(&mut arg0.wrapped_position), arg6, arg7);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::position::liquidity(&v0);
        if (v3 > 0) {
            let (v4, v5) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::collect_fee<T0, T1>(arg1, arg5, &v0, true);
            0x2::balance::join<T0>(&mut v1, v4);
            0x2::balance::join<T1>(&mut v2, v5);
            let (v6, v7) = 0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::remove_liquidity<T0, T1>(arg1, arg2, arg5, &mut v0, v3, arg6);
            0x2::balance::join<T0>(&mut v1, v6);
            0x2::balance::join<T1>(&mut v2, v7);
        };
        0xaa3ae572fb09f157d7368ce22c6b7f33fde0fe74cba75ae9679af52088b57bb0::pool::close_position<T0, T1>(arg1, arg5, v0);
        (v1, v2)
    }

    public fun update_liquidity_offset(arg0: &mut ClmmVault, arg1: u32, arg2: u32) {
        assert!(arg1 > 0 && arg2 > 0, 0x9a7f6bb7cdad3343846381f4a0b43552adee23fd051fd450532bbd5981f0ac96::error::invalid_liquidity_range());
        arg0.liquidity_range.lower_offset = arg1;
        arg0.liquidity_range.upper_offset = arg2;
    }

    public fun update_rebalance_threshold(arg0: &mut ClmmVault, arg1: u32) {
        arg0.liquidity_range.rebalance_threshold = arg1;
    }

    // decompiled from Move bytecode v6
}

