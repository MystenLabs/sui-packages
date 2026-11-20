module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::forced_deleverage {
    struct ForcedDeleverageEvent has copy, drop {
        executor: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_amount: u64,
        seized_amount: u64,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun forced_deleverage<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        assert_forced_deleverage_authority(arg2, arg7);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg1) == false, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_locked());
        assert!(0x2::coin::value<T0>(&arg3) > 0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unable_to_force_deleverage_error());
        let v2 = 0x2::coin::into_balance<T0>(arg3);
        let v3 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::accrue_all_interests(arg2, v3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::accrue_interests(arg1, arg2);
        let (v4, v5) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::forced_deleverage_evaluator::calculate_forced_deleverage_amounts<T0, T1>(arg1, arg4, arg5, arg6, 0x2::balance::value<T0>(&v2));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::decrease_debt(arg1, v0, v4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_repay<T0>(arg2, 0x2::balance::split<T0>(&mut v2, v4), v3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_inflow<T0>(arg2, v4, v3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_withdraw_collateral<T1>(arg2, v5, v3);
        let v6 = ForcedDeleverageEvent{
            executor         : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1),
            debt_type        : v0,
            collateral_type  : v1,
            repay_amount     : v4,
            seized_amount    : v5,
            debt_price       : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg5, v0, arg6),
            collateral_price : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg5, v1, arg6),
            timestamp        : v3,
        };
        0x2::event::emit<ForcedDeleverageEvent>(v6);
        (0x2::coin::from_balance<T0>(v2, arg7), 0x2::coin::from_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::withdraw_collateral<T1>(arg1, v5), arg7))
    }

    fun assert_forced_deleverage_authority(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::forced_deleverage_authority_registry_key();
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg0);
        assert!(0x2::dynamic_field::exists_<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::ForcedDeleverageAuthorityRegistryKey>(v1, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unauthorized_forced_deleverage_error());
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::ForcedDeleverageAuthorityRegistryKey, 0x2::vec_set::VecSet<address>>(v1, v0), &v2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unauthorized_forced_deleverage_error());
    }

    public entry fun forced_deleverage_entry<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = forced_deleverage<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v7
}

