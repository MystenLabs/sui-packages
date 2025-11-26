module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg2: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::ObligationKey, arg3: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg4: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg3), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::assert_current_version(arg0);
        assert!(arg5 > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::zero_amount_error());
        assert!(0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::withdraw_collateral_locked(arg1) == false, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::obligation_locked());
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::assert_key_match(arg1, arg2);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::withdraw_collateral_too_much_error());
        let v0 = 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun withdraw_collateral_entry<T0>(arg0: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::version::Version, arg1: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::Obligation, arg2: &0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::obligation::ObligationKey, arg3: &mut 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::Market, arg4: &0xec7c90d559f9528fa294d749883aa4ebe8f9aecca116b05e407bcfbca0fe3433::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::market::is_paused(arg3), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::market_paused_error());
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

