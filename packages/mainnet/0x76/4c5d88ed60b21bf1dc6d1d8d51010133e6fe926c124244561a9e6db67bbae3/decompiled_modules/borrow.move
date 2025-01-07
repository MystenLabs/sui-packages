module 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    struct BorrowEventV2 has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    struct BorrowEventV3 has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        borrow_fee: u64,
        borrow_fee_discount: u64,
        borrow_referral_fee: u64,
        time: u64,
    }

    public fun borrow<T0>(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::Version, arg1: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg2: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::ObligationKey, arg3: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::assert_current_version(arg0);
        let (v0, v1) = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg5, 0, 0, arg6, arg7, arg8);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    fun assert_isolated_asset(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg1: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg2: 0x1::type_name::TypeName) {
        let v0 = true;
        if (0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::is_isolated_asset(arg0, arg2)) {
            let v1 = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt_types(arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
                let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
                if (v3 != arg2) {
                    let (v4, _) = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt(arg1, v3);
                    if (v4 > 0) {
                        v0 = false;
                        break
                    };
                };
                v2 = v2 + 1;
            };
        } else {
            let v6 = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt_types(arg1);
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
                let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v7);
                if (0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::is_isolated_asset(arg0, v8)) {
                    let (v9, _) = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::debt(arg1, v8);
                    if (v9 > 0) {
                        v0 = false;
                        break
                    };
                };
                v7 = v7 + 1;
            };
        };
        assert!(v0, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::unable_to_borrow_other_coin_with_isolated_asset());
    }

    public entry fun borrow_entry<T0>(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::Version, arg1: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg2: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::ObligationKey, arg3: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal<T0>(arg0: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg1: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::ObligationKey, arg2: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::uid(arg2), 0x2::tx_context::sender(arg9)), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::whitelist_error());
        assert!(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::borrow_locked(arg0) == false, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::is_base_asset_active(arg2, v0), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg8) / 1000;
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::assert_key_match(arg0, arg1);
        assert!(!0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::has_coin_x_as_collateral(arg0, v0), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::unable_to_borrow_a_collateral_coin());
        assert_isolated_asset(arg2, arg0, v0);
        assert!(arg4 > 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::interest_model::min_borrow_amount(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::interest_model(arg2, v0)), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::borrow_too_small_error());
        assert!(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::total_global_debt(arg2, v0) + arg4 <= *0x2::dynamic_field::borrow<0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::BorrowLimitKey, u64>(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::uid(arg2), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::borrow_limit_key(v0)), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::borrow_limit_reached_error());
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::handle_outflow<T0>(arg2, arg4, v1);
        let v2 = 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::handle_borrow<T0>(arg2, arg4, v1);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::init_debt(arg0, arg2, v0);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::accrue_interests_and_rewards(arg0, arg2);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::increase_debt(arg0, v0, arg4);
        assert!(0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg7, arg8), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::debt_value::debts_value_usd_with_weight(arg0, arg3, arg2, arg7, arg8)), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::borrow_too_much_error());
        let v3 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::uid(arg2), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>())));
        let v4 = if (arg6 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v3, arg6, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::fee_rate_base())
        } else {
            0
        };
        let v5 = if (arg5 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v3, arg5, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::fee_rate_base())
        } else {
            0
        };
        let v6 = v3 - v4 - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v6), arg9), *0x2::dynamic_field::borrow<0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::BorrowFeeRecipientKey, address>(0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::uid(arg2), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market_dynamic_keys::borrow_fee_recipient_key()));
        let v7 = BorrowEventV3{
            borrower            : 0x2::tx_context::sender(arg9),
            obligation          : 0x2::object::id<0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation>(arg0),
            asset               : v0,
            amount              : arg4,
            borrow_fee          : v6,
            borrow_fee_discount : arg5,
            borrow_referral_fee : v4,
            time                : v1,
        };
        0x2::event::emit<BorrowEventV3>(v7);
        (v2, 0x2::balance::split<T0>(&mut v2, v4))
    }

    public fun borrow_with_referral<T0, T1: drop>(arg0: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::Version, arg1: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::Obligation, arg2: &0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::obligation::ObligationKey, arg3: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &mut 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::BorrowReferral<T0, T1>, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::version::assert_current_version(arg0);
        let (v0, v1) = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg6, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::borrow_fee_discount<T0, T1>(arg5), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::referral_share<T0, T1>(arg5), arg7, arg8, arg9);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::increase_borrowed_v2<T0, T1>(arg5, arg6);
        0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::borrow_referral::put_referral_fee_v2<T0, T1>(arg5, v1);
        0x2::coin::from_balance<T0>(v0, arg9)
    }

    // decompiled from Move bytecode v6
}

