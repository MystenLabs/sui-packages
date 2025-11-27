module 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::Version, arg1: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg2: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::ObligationKey, arg3: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg4: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD> {
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::assert_current_version(arg0);
        assert!(!0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::is_paused(arg3), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::version::Version, arg1: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg2: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::ObligationKey, arg3: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg4: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::is_paused(arg3), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation, arg1: &0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::ObligationKey, arg2: &mut 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::Market, arg3: &0xc06e61fa92a4cf89151c4bf1be7db533419f6b14a1c4a155a6b700d0fc9524e7::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD> {
        assert!(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::borrow_locked(arg0) == false, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::uid(arg2), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::interest_model::min_borrow_amount(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::interest_model(arg2, v0)) + v2, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::borrow_too_small_error());
        assert!((0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market_dynamic_keys::BorrowLimitKey, u128>(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::uid(arg2), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market_dynamic_keys::borrow_limit_key(v0)), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::borrow_limit_reached_error());
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::handle_outflow<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::handle_borrow(arg2, arg4, v1, arg7);
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::init_debt(arg0, arg2, v0);
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::borrow_withdraw_evaluator::max_borrow_amount<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::borrow_too_much_error());
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x65b7b808b75dbbe391abe0188e973975192f678cfdb97056ed3d33b033a8a342::fixed_point32_empower::gt(0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::borrow_too_much_error());
        0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::market::add_borrow_fee<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(0x2::coin::split<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

