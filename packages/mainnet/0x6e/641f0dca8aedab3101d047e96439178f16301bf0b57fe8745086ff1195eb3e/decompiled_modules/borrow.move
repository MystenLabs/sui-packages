module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow {
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

    public fun borrow<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        let (v0, v1) = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg5, 0, 0, arg6, arg7, arg8);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public entry fun borrow_entry<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal<T0>(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg2), 0x2::tx_context::sender(arg9)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::whitelist_error());
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::borrow_locked(arg0) == false, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::obligation_locked());
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::is_base_asset_active(arg2, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::base_asset_not_active_error());
        let v1 = 0x2::clock::timestamp_ms(arg8) / 1000;
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg0, arg1);
        assert!(!0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg0, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unable_to_borrow_a_collateral_coin());
        assert!(arg4 > 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::min_borrow_amount(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::interest_model(arg2, v0)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::borrow_too_small_error());
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_outflow<T0>(arg2, arg4, v1);
        let v2 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::handle_borrow<T0>(arg2, arg4, v1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::init_debt(arg0, arg2, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg0, arg2, arg3, arg7, arg8), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::borrow_too_much_error());
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::increase_debt(arg0, v0, arg4);
        let v3 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>())));
        let v4 = if (arg6 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v3, arg6, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::fee_rate_base())
        } else {
            0
        };
        let v5 = if (arg5 > 0) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v3, arg5, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::fee_rate_base())
        } else {
            0
        };
        let v6 = v3 - v4 - v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v6), arg9), *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::BorrowFeeRecipientKey, address>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::uid(arg2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::borrow_fee_recipient_key()));
        let v7 = BorrowEventV3{
            borrower            : 0x2::tx_context::sender(arg9),
            obligation          : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0),
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

    public fun borrow_with_referral<T0, T1: drop>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::BorrowReferral<T0, T1>, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::assert_current_version(arg0);
        let (v0, v1) = borrow_internal<T0>(arg1, arg2, arg3, arg4, arg6, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::borrow_fee_discount<T0, T1>(arg5), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::referral_share<T0, T1>(arg5), arg7, arg8, arg9);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::increase_borrowed<T0, T1>(arg5, arg6);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_referral::put_referral_fee<T0, T1>(arg5, v1);
        0x2::coin::from_balance<T0>(v0, arg9)
    }

    // decompiled from Move bytecode v6
}

