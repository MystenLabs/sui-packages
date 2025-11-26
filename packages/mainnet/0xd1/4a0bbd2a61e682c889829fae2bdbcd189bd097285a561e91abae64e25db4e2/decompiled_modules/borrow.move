module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg2: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::ObligationKey, arg3: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg4: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD> {
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::assert_current_version(arg0);
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg3), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg2: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::ObligationKey, arg3: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg4: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg3), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg1: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::ObligationKey, arg2: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg3: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD> {
        assert!(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::borrow_locked(arg0) == false, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::uid(arg2), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::interest_model::min_borrow_amount(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::interest_model(arg2, v0)) + v2, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::borrow_too_small_error());
        assert!((0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market_dynamic_keys::BorrowLimitKey, u128>(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::uid(arg2), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market_dynamic_keys::borrow_limit_key(v0)), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::borrow_limit_reached_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::handle_outflow<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::handle_borrow(arg2, arg4, v1, arg7);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::init_debt(arg0, arg2, v0);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::borrow_withdraw_evaluator::max_borrow_amount<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::borrow_too_much_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x15b4872e304a87fab8b51ff4555e0bc4467fa91d8fb91aef6574d0c8027f3774::fixed_point32_empower::gt(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::borrow_too_much_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::add_borrow_fee<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(0x2::coin::split<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

