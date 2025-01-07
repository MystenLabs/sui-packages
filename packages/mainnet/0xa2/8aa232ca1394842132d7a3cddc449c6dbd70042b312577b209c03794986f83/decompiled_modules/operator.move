module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::operator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun remove_price_feed_id(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: 0x1::string::String) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::remove_price_feed_id(arg2, arg3);
    }

    public entry fun update_price_feed_id(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::update_price_feed_id(arg2, arg3, arg4);
    }

    public entry fun start_liquidate_loan_offer_expired<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg4);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::start_liquidate_loan_offer_expired<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::hot_wallet(arg2), arg5, arg6);
    }

    public entry fun start_liquidate_loan_offer_health<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg4: 0x2::object::ID, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::is_valid_lend_coin<T0>(arg2), 5);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::is_valid_collateral_coin<T1>(arg2), 6);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::price_feed::is_valid_price_info_object<T0>(arg7, arg2, arg5), 3);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::price_feed::is_valid_price_info_object<T1>(arg8, arg2, arg6), 4);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg4);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::start_liquidate_loan_offer_health<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), arg2, arg5, arg6, arg7, arg8, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::hot_wallet(arg2), arg9, arg10);
    }

    entry fun system_close_active_loan<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::system_close_active_loan<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg3)), 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun system_finish_loan<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::Custodian<T0>, arg4: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg5);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg4, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::system_finish_loan<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg4, v0), arg3, arg6, arg7, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::lender_fee_percent(arg2), arg8);
    }

    public entry fun system_fund_transfer<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg3);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg2, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::system_fund_transfer<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg2, v0), arg4, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>(), 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T1>(), arg5);
    }

    public entry fun system_liquidate_loan_offer<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: 0x1::string::String) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg4);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::system_liquidate_loan_offer<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg3, v0), arg5, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::borrower_fee_percent(arg2), arg6, arg7, arg8);
    }

    public entry fun system_liquidate_loan_offer_to_custodian<T0, T1>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::Custodian<T0>, arg4: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg5: 0x2::object::ID, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::new_loan_key<T0, T1>(arg5);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg4, v0), 2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::system_liquidate_loan_offer_to_custodian<T0, T1>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::LoanKey<T0, T1>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry::Loan<T0, T1>>(arg4, v0), arg3, arg6, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::borrower_fee_percent(arg2), arg7, arg8, arg9, arg10);
    }

    public entry fun system_cancel_offer<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        let v0 = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer_key<T0>(arg3);
        assert!(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::contain<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg2, v0), 1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::system_cancel_offer<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg2, v0), arg4, arg5, arg6);
    }

    entry fun system_close_offer<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x2::object::ID) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::system_close_offer<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::OfferKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::new_offer_key<T0>(arg3)));
    }

    public entry fun add_configuration_token<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::add_token<T0>(arg2, arg3, arg4, arg5);
    }

    public entry fun delete_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x1::string::String) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::delete<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::remove<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTierKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTier<T0>>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::new_asset_tier_key<T0>(arg3)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0x93aa0e1a1caf47ec9092a2bf4faa145bf79282923be206c9b4cb235b47cde837);
    }

    public entry fun init_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::add<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTierKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTier<T0>>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::new_asset_tier_key<T0>(arg3), 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::new<T0>(arg3, arg4, arg5, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>(), arg6));
    }

    public entry fun init_system<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::new(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::new(arg8);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::new<T0>(arg8);
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun remove_configuration_token<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: 0x1::string::String) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::remove_token<T0>(arg2, arg3);
    }

    public entry fun update_asset_tier<T0>(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::State, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::update<T0>(0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::state::borrow_mut<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTierKey<T0>, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::AssetTier<T0>>(arg2, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier::new_asset_tier_key<T0>(arg3)), arg4, arg5);
    }

    public entry fun update_configuration(arg0: &OperatorCap, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::Version, arg2: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: u64) {
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::version::assert_current_version(arg1);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::update(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

