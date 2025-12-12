module 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::Version, arg1: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg2: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::ObligationKey, arg3: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg4: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::is_paused(arg3), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::market_paused_error());
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::assert_current_version(arg0);
        assert!(arg5 > 0, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::zero_amount_error());
        assert!(0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::withdraw_collateral_locked(arg1) == false, 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::obligation_locked());
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::assert_key_match(arg1, arg2);
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::withdraw_collateral_too_much_error());
        let v0 = 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun withdraw_collateral_entry<T0>(arg0: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::version::Version, arg1: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::Obligation, arg2: &0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::obligation::ObligationKey, arg3: &mut 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::Market, arg4: &0x2eb052455f68f40bef97c5f858769d45cfe664c4cb7c4db58bc9aab1b1e0abf6::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::market::is_paused(arg3), 0x36e0fceb2d14ee3926315a26508a4c1dd8518e7eb9f35d9cdc7109116624f581::error::market_paused_error());
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

