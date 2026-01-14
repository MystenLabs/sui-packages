module 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::lending {
    struct DepositEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct DepositOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        sender: address,
        to: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayOnBehalfOfEvent has copy, drop {
        reserve: u8,
        sender: address,
        user: address,
        amount: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        sender: address,
        liquidate_user: address,
        liquidate_amount: u64,
    }

    struct LiquidationEvent has copy, drop {
        sender: address,
        user: address,
        collateral_asset: u8,
        collateral_price: u256,
        collateral_amount: u64,
        treasury: u64,
        debt_asset: u8,
        debt_price: u256,
        debt_amount: u64,
    }

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun base_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::verify_emode_support(arg2, arg6, arg4, false, true);
        verify_market_storage_pool<T0>(arg2, arg3);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, arg6, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg3, arg5) as u256));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_borrow_event(arg4, arg6, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance<T0>(arg3, arg5, arg6)
    }

    fun base_borrow_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::verify_emode_support(arg2, arg6, arg4, false, true);
        verify_market_storage_pool<T0>(arg2, arg3);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, arg6, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg3, arg5) as u256));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_borrow_event(arg4, arg6, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance_v2<T0>(arg3, arg5, arg6, arg7, arg8)
    }

    fun base_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::balance::Balance<T0>) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg1);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg1);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::verify_emode_support(arg1, arg4, arg3, true, false);
        verify_market_storage_pool<T0>(arg1, arg2);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_balance<T0>(arg2, arg5, arg4);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_deposit<T0>(arg0, arg1, arg3, arg4, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg2, v0) as u256));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_deposit_event(arg3, arg4, v0, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg1));
    }

    fun base_flash_loan<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: address, arg3: u64) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        verify_market_flash_loan_config_pool<T0>(arg0, arg1);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::loan<T0>(arg0, arg1, arg2, arg3)
    }

    fun base_flash_loan_v2<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: address, arg3: u64, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        verify_market_flash_loan_config_pool<T0>(arg0, arg1);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::loan_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun base_flash_repay<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>, arg4: address, arg5: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        verify_market_storage_pool<T0>(arg1, arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::repay<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun base_liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_liquidatable(arg2, arg8, arg9);
        verify_market_storage_pool<T0>(arg2, arg4);
        verify_market_storage_pool<T1>(arg2, arg7);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_balance<T0>(arg4, arg5, arg8);
        let (v1, v2, v3) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg9, arg6, arg3, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg4, v0) as u256));
        let v4 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T1>(arg7, (v3 as u64));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_treasury<T1>(arg7, v4);
        let v5 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T1>(arg7, (v1 as u64));
        let v6 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T0>(arg4, (v2 as u64));
        let (_, v8, _) = 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::get_token_price(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_oracle_id(arg2, arg6));
        let (_, v11, _) = 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::get_token_price(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_oracle_id(arg2, arg3));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_liquidation_event(arg8, arg9, arg6, v8, v5 + v4, v4, arg3, v11, v0 - v6, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance<T0>(arg4, v6, arg8), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance<T1>(arg7, v5, arg8))
    }

    fun base_liquidation_call_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: address, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_liquidatable(arg2, arg8, arg9);
        verify_market_storage_pool<T0>(arg2, arg4);
        verify_market_storage_pool<T1>(arg2, arg7);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_balance<T0>(arg4, arg5, arg8);
        let (v1, v2, v3) = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg9, arg6, arg3, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg4, v0) as u256));
        let v4 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T1>(arg7, (v3 as u64));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_treasury<T1>(arg7, v4);
        let v5 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T1>(arg7, (v1 as u64));
        let v6 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T0>(arg4, (v2 as u64));
        let (_, v8, _) = 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::get_token_price(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_oracle_id(arg2, arg6));
        let (_, v11, _) = 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::get_token_price(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_oracle_id(arg2, arg3));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_liquidation_event(arg8, arg9, arg6, v8, v5 + v4, v4, arg3, v11, v0 - v6, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance_v2<T0>(arg4, v6, arg8, arg10, arg11), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance_v2<T1>(arg7, v5, arg8, arg10, arg11))
    }

    fun base_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: address) : 0x2::balance::Balance<T0> {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        verify_market_storage_pool<T0>(arg2, arg3);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::deposit_balance<T0>(arg3, arg5, arg6);
        let v1 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T0>(arg3, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_repay<T0>(arg0, arg1, arg2, arg4, arg6, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg3, v0) as u256)) as u64));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_repay_event(arg4, arg6, v0 - v1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        if (v1 > 0) {
            return 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::direct_withdraw_balance_v2<T0>(arg3, v1, arg6)
        };
        0x2::balance::zero<T0>()
    }

    fun base_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        verify_market_storage_pool<T0>(arg2, arg3);
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T0>(arg3, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, arg6, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg3, arg5) as u256)));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_withdraw_event(arg4, arg6, arg6, v0, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance<T0>(arg3, v0, arg6)
    }

    fun base_withdraw_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::when_not_paused(arg2);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::version_verification(arg2);
        verify_market_storage_pool<T0>(arg2, arg3);
        let v0 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::unnormal_amount<T0>(arg3, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, arg6, (0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::normal_amount<T0>(arg3, arg5) as u256)));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_withdraw_event(arg4, arg6, arg6, v0, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::withdraw_balance_v2<T0>(arg3, v0, arg6, arg7, arg8)
    }

    public(friend) fun borrow_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public(friend) fun borrow_coin_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        base_borrow_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public(friend) fun borrow_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6))
    }

    public(friend) fun borrow_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_borrow_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6), arg7, arg8)
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::create_account_cap(arg0)
    }

    public fun delete_account(arg0: 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) {
        abort 0
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun deposit_coin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg6), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg4, arg5, arg6));
    }

    public(friend) fun deposit_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, arg4, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg5, arg6, arg7));
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_deposit_on_behalf_of_event(arg3, 0x2::tx_context::sender(arg7), arg4, arg6, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg1));
    }

    public(friend) fun deposit_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg5), 0x2::coin::into_balance<T0>(arg4));
    }

    public fun enter_emode(arg0: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::enter_emode(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun enter_emode_with_account_cap(arg0: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: u64, arg2: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::enter_emode(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg2));
    }

    public fun exit_emode(arg0: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &mut 0x2::tx_context::TxContext) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::exit_emode(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun exit_emode_with_account_cap(arg0: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::exit_emode(arg0, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg1));
    }

    public fun flash_loan_with_account_cap<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: u64, arg3: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        base_flash_loan<T0>(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg3), arg2)
    }

    public fun flash_loan_with_account_cap_v2<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: u64, arg3: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        base_flash_loan_v2<T0>(arg0, arg1, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg3), arg2, arg4, arg5)
    }

    public fun flash_loan_with_ctx<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        base_flash_loan<T0>(arg0, arg1, 0x2::tx_context::sender(arg3), arg2)
    }

    public fun flash_loan_with_ctx_v2<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>) {
        let v0 = 0x2::tx_context::sender(arg4);
        base_flash_loan_v2<T0>(arg0, arg1, v0, arg2, arg3, arg4)
    }

    public fun flash_repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>, arg4: 0x2::balance::Balance<T0>, arg5: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_flash_repay<T0>(arg0, arg1, arg2, arg3, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg5), arg4)
    }

    public fun flash_repay_with_ctx<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg3: 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Receipt<T0>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_flash_repay<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg5), arg4)
    }

    public(friend) fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg5, arg9, arg10), arg6, arg7, 0x2::tx_context::sender(arg10), arg8);
        (v1, v0)
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: u8, arg6: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: u64, arg10: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun liquidation_non_entry<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::sender(arg9), arg8);
        (v1, v0)
    }

    public(friend) fun liquidation_non_entry_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, v2) = base_liquidation_call_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10);
        (v2, v1)
    }

    public(friend) fun liquidation_v2<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: u8, arg4: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg5, arg9, arg11);
        let (v2, v3) = base_liquidation_call_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, v1, arg6, arg7, v0, arg8, arg10, arg11);
        (v3, v2)
    }

    public(friend) fun repay_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg5, arg6, arg7), 0x2::tx_context::sender(arg7))
    }

    public(friend) fun repay_on_behalf_of_user<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: address, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::utils::split_coin_to_balance<T0>(arg6, arg7, arg8), arg5);
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::event::emit_repay_on_behalf_of_event(arg4, 0x2::tx_context::sender(arg8), arg5, arg7 - 0x2::balance::value<T0>(&v0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg2));
        v0
    }

    public(friend) fun repay_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6))
    }

    public fun update_state_of_all(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::update_state_of_all(arg0, arg1);
    }

    public fun update_state_of_user(arg0: &0x2::clock::Clock, arg1: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg2: address) {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::logic::update_state_of_user(arg0, arg1, arg2);
    }

    public fun verify_market_flash_loan_config_pool<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::Config, arg1: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>) {
        assert!(0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::flash_loan::get_market_id(arg0) == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::get_market_id<T0>(arg1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::unmatched_market_id());
    }

    public fun verify_market_storage_pool<T0>(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg1: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>) {
        assert!(0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::get_market_id(arg0) == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::get_market_id<T0>(arg1), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::unmatched_market_id());
    }

    fun when_not_paused(arg0: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage) {
        assert!(!0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::pause(arg0), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::paused());
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun withdraw_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public(friend) fun withdraw_coin_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x3::sui_system::SuiSystemState, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        base_withdraw_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public(friend) fun withdraw_with_account_cap<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6))
    }

    public(friend) fun withdraw_with_account_cap_v2<T0>(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::storage::Storage, arg3: &mut 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::AccountCap, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_withdraw_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::account::account_owner(arg6), arg7, arg8)
    }

    // decompiled from Move bytecode v6
}

