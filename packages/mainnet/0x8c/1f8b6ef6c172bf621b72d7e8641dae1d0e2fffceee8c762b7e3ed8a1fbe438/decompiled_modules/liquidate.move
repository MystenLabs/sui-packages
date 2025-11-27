module 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun liquidate<T0>(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::Version, arg1: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg2: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg3: 0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>, arg4: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::assert_current_version(arg0);
        assert!(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::liquidate_locked(arg1) == false, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::obligation_locked());
        assert!(0x2::coin::value<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::accrue_all_interests(arg2, v1);
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::liquidation_evaluator::liquidation_amounts<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::unable_to_liquidate_error());
        let (_, _, v7) = 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::debt(arg1, 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>());
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::decrease_debt(arg1, 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(), v2);
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::decrease_debt_interest(arg1, 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(), 0x2::math::min(v7, v2));
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, v7, arg7);
        let v8 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::price::get_price(arg5, 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v8);
        (0x2::coin::from_balance<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::Version, arg1: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg2: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg3: 0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>, arg4: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

