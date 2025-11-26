module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::ObligationKey, arg3: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg3), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::assert_current_version(arg0);
        assert!(arg5 > 0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::zero_amount_error());
        assert!(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::withdraw_collateral_locked(arg1) == false, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::obligation_locked());
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::assert_key_match(arg1, arg2);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::withdraw_collateral_too_much_error());
        let v0 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun withdraw_collateral_entry<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::version::Version, arg1: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg2: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::ObligationKey, arg3: &mut 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg4: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::is_paused(arg3), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::error::market_paused_error());
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

