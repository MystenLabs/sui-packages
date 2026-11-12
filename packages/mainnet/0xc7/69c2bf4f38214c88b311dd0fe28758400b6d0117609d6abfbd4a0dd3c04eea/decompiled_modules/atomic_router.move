module 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_router {
    struct SwapContext<phantom T0, phantom T1> {
        obligation: 0x2::object::ID,
        loan: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>,
        remaining_debt: 0x2::coin::Coin<T0>,
        flash_raw: u64,
        repay_raw: u64,
        collateral_raw: u64,
        protocol_collateral_raw: u64,
    }

    struct AtomicRouterResult has copy, drop {
        vault_id: 0x2::object::ID,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        flash_raw: u64,
        repay_raw: u64,
        collateral_raw: u64,
        protocol_collateral_raw: u64,
        profit_raw: u64,
        liquidated: bool,
        result_code: u8,
    }

    public fun begin<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SwapContext<T0, T1>) {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg8);
        assert!(!0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::liquidate_locked(arg2), 0);
        assert!(arg6 > 0, 0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market_and_obligation(arg1, arg3, arg2, arg7);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidation_evaluator::calculate_liquidation_amounts<T0, T1>(arg2, arg3, arg4, arg5, arg7, arg6);
        assert!(v0 > 0 && v1 > 0, 0);
        let (v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::borrow_flash_loan<T0>(arg1, arg3, v0, arg8);
        let (v5, v6) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::liquidate::liquidate<T0, T1>(arg1, arg2, arg3, v3, arg4, arg5, arg7, arg8);
        let v7 = v6;
        let v8 = v5;
        let v9 = v0 - 0x2::coin::value<T0>(&v8);
        let v10 = 0x2::coin::value<T1>(&v7);
        assert!(v9 > 0 && v10 > 0, 0);
        let v11 = SwapContext<T0, T1>{
            obligation              : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2),
            loan                    : v4,
            remaining_debt          : v8,
            flash_raw               : v0,
            repay_raw               : v9,
            collateral_raw          : v10,
            protocol_collateral_raw : v2,
        };
        (v7, v11)
    }

    public fun finish<T0, T1>(arg0: &mut 0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: 0x2::coin::Coin<T0>, arg4: SwapContext<T0, T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::assert_authorized(arg0, arg6);
        let SwapContext {
            obligation              : v0,
            loan                    : v1,
            remaining_debt          : v2,
            flash_raw               : v3,
            repay_raw               : v4,
            collateral_raw          : v5,
            protocol_collateral_raw : v6,
        } = arg4;
        let v7 = v2;
        let v8 = v1;
        0x2::coin::join<T0>(&mut v7, arg3);
        let v9 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_loan_amount<T0>(&v8) + 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::flash_loan_fee<T0>(&v8);
        assert!(v9 <= 18446744073709551615 - arg5, 1);
        assert!(0x2::coin::value<T0>(&v7) >= v9 + arg5, 1);
        0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::flash_loan::repay_flash_loan<T0>(arg1, arg2, 0x2::coin::split<T0>(&mut v7, v9, arg6), v8, arg6);
        let v10 = AtomicRouterResult{
            vault_id                : 0x2::object::id<0xc7f7c2720fff9454db35fda838e432afb640c33a0c4b9ac1ea2cc36f1a293876::atomic_vault::LiquidationVault>(arg0),
            obligation              : v0,
            debt_type               : 0x1::type_name::get<T0>(),
            collateral_type         : 0x1::type_name::get<T1>(),
            flash_raw               : v3,
            repay_raw               : v4,
            collateral_raw          : v5,
            protocol_collateral_raw : v6,
            profit_raw              : 0x2::coin::value<T0>(&v7),
            liquidated              : true,
            result_code             : 0,
        };
        0x2::event::emit<AtomicRouterResult>(v10);
    }

    // decompiled from Move bytecode v7
}

