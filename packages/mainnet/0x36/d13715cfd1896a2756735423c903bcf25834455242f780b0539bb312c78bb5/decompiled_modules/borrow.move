module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg2: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::ObligationKey, arg3: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg4: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD> {
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::assert_current_version(arg0);
        assert!(!0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::is_paused(arg3), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::version::Version, arg1: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg2: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::ObligationKey, arg3: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg4: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::is_paused(arg3), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::ObligationKey, arg2: &mut 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg3: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD> {
        assert!(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::borrow_locked(arg0) == false, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::obligation_locked());
        let v0 = 0x1::type_name::get<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::uid(arg2), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::interest_model::min_borrow_amount(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::interest_model(arg2, v0)) + v2, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::borrow_too_small_error());
        assert!((0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market_dynamic_keys::BorrowLimitKey, u128>(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::uid(arg2), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market_dynamic_keys::borrow_limit_key(v0)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::borrow_limit_reached_error());
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::handle_outflow<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::handle_borrow(arg2, arg4, v1, arg7);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::init_debt(arg0, arg2, v0);
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::borrow_withdraw_evaluator::max_borrow_amount<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::borrow_too_much_error());
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::gt(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::borrow_too_much_error());
        0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::add_borrow_fee<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(0x2::coin::split<0xde256d5bdc317176dd69e94d7a3f81453c5a56f4305df746407433c43d05f83b::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

