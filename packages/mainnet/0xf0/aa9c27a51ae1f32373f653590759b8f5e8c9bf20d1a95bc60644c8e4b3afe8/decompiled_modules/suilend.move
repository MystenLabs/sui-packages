module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::suilend {
    struct SuilendPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        deposited: u64,
        position_cap: 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::ObligationOwnerCap<T0>,
        owner: address,
    }

    public fun claim_rewards<T0, T1>(arg0: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::Config, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::PoolRegistry, arg2: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg3: &SuilendPosition<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_not_paused(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_version(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"suilend"));
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::claim_rewards<T0, T1>(arg2, &arg3.position_cap, arg7, arg4, arg5, arg6, arg8)
    }

    public fun claim_rewards_and_deposit<T0, T1>(arg0: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::Config, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::PoolRegistry, arg2: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg3: &SuilendPosition<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_not_paused(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_version(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"suilend"));
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::claim_rewards_and_deposit<T0, T1>(arg2, 0x2::object::id<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::ObligationOwnerCap<T0>>(&arg3.position_cap), arg8, arg4, arg6, arg7, arg5, arg9);
    }

    public fun create_pool<T0>(arg0: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::AdminCap, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::Config, arg2: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::PoolRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_not_paused(arg1);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_version(arg1);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"suilend"));
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::events::emit_pool_created(0x1::string::utf8(b"suilend"), 0x2::object::id_from_address(@0x0), 0x1::type_name::get<T0>());
    }

    public fun create_position<T0>(arg0: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position_registry::PositionRegistry, arg1: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg2: &mut 0x2::tx_context::TxContext) : SuilendPosition<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SuilendPosition<T0>{
            id           : 0x2::object::new(arg2),
            deposited    : 0,
            position_cap : 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::create_obligation<T0>(arg1, arg2),
            owner        : v0,
        };
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::events::emit_position_created(0x1::string::utf8(b"suilend"), 0x2::object::id<SuilendPosition<T0>>(&v1), 0x2::object::id<SuilendPosition<T0>>(&v1), v0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::position_registry::register_position(arg0, 0x1::string::utf8(b"suilend"), v0, 0x2::object::id<SuilendPosition<T0>>(&v1));
        v1
    }

    public fun deposit<T0, T1>(arg0: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::Config, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::PoolRegistry, arg2: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg3: &mut SuilendPosition<T0>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_not_paused(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_version(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"suilend"));
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(v1 == arg3.owner, 4);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg2, arg4, &arg3.position_cap, arg6, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg2, arg4, arg6, arg5, arg7), arg7);
        arg3.deposited = arg3.deposited + v0;
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::events::emit_deposited(0x1::string::utf8(b"suilend"), 0x2::object::id<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>>(arg2), v1, v0, 0x2::clock::timestamp_ms(arg6));
    }

    public fun user_supply_amount<T0, T1>(arg0: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg1: &SuilendPosition<T0>, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::compound_interest<T0>(arg0, arg2, arg3);
        let v0 = 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::obligation::deposited_ctoken_amount<T0, T1>(0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::obligation<T0>(arg0, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::obligation_id<T0>(&arg1.position_cap)));
        (0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::decimal::floor(0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::decimal::mul(0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::decimal::from(v0), 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::reserve::ctoken_ratio<T0>(0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::reserve<T0, T1>(arg0)))), v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::Config, arg1: &0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::PoolRegistry, arg2: &mut 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>, arg3: &mut SuilendPosition<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::RateLimiterExemption<T0, T1>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_not_paused(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::assert_version(arg0);
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"suilend"));
        assert!(arg5 > 0, 1);
        let (v0, v1) = user_supply_amount<T0, T1>(arg2, arg3, arg4, arg8);
        assert!(v0 >= arg5, 2);
        let v2 = (((arg3.deposited as u128) * (arg5 as u128) / (v0 as u128)) as u64);
        let v3 = if (arg5 > v2) {
            arg5 - v2
        } else {
            0
        };
        let v4 = 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::calculate_fee(v3, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::protocol_fee_bps(arg0));
        let v5 = arg5 - v4;
        assert!(v5 >= arg6, 5);
        let v6 = 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg2, arg4, arg8, 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::withdraw_ctokens<T0, T1>(arg2, arg4, &arg3.position_cap, arg8, (((v1 as u128) * (arg5 as u128) / (v0 as u128)) as u64), arg9), arg7, arg9);
        if (v4 > 0) {
            0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::config::deposit_fees<T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(&mut v6), v4));
            0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::events::emit_protocol_fees_collected(0x1::string::utf8(b"suilend"), 0x2::object::id<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>>(arg2), v4, 0x2::clock::timestamp_ms(arg8));
        };
        0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::events::emit_withdrawn(0x1::string::utf8(b"suilend"), 0x2::object::id<0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::lending_market::LendingMarket<T0>>(arg2), 0x2::tx_context::sender(arg9), v5, v4, 0x2::clock::timestamp_ms(arg8));
        v6
    }

    // decompiled from Move bytecode v6
}

