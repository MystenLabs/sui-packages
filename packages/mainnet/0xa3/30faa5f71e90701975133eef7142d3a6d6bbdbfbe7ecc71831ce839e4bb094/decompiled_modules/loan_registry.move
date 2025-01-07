module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::loan_registry {
    struct Liquidation<phantom T0, phantom T1> has drop, store {
        liquidating_at: u64,
        liquidating_price: u64,
        liquidated_tx: 0x1::option::Option<0x1::string::String>,
        liquidated_price: 0x1::option::Option<u64>,
    }

    struct LoanKey<phantom T0, phantom T1> has copy, drop, store {
        loan_id: 0x2::object::ID,
    }

    struct Loan<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        offer_id: 0x2::object::ID,
        interest: u64,
        amount: u64,
        duration: u64,
        collateral: 0x2::balance::Balance<T1>,
        lender: address,
        borrower: address,
        start_timestamp: u64,
        liquidation: 0x1::option::Option<Liquidation<T0, T1>>,
        repay_balance: 0x2::balance::Balance<T0>,
        status: 0x1::string::String,
    }

    struct RequestLoanEvent has copy, drop {
        loan_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
        collateral_amount: u64,
        lend_token: 0x1::string::String,
        collateral_token: 0x1::string::String,
        lender: address,
        borrower: address,
        start_timestamp: u64,
    }

    struct FundTransferredEvent has copy, drop {
        loan_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
        lend_token: 0x1::string::String,
        collateral_token: 0x1::string::String,
        lender: address,
        borrower: address,
    }

    struct BorrowerPaidEvent has copy, drop {
        loan_id: 0x2::object::ID,
        repay_amount: u64,
        collateral_amount: u64,
        lend_token: 0x1::string::String,
        collateral_token: 0x1::string::String,
        borrower: address,
    }

    struct FinishedLoanEvent has copy, drop {
        loan_id: 0x2::object::ID,
        offer_id: 0x2::object::ID,
        repay_to_lender_amount: u64,
        lender: address,
        borrower: address,
    }

    struct WithdrawCollateralEvent has copy, drop {
        loan_id: 0x2::object::ID,
        borrower: address,
        withdraw_amount: u64,
        remaining_collateral_amount: u64,
        timestamp: u64,
    }

    struct DepositCollateralEvent has copy, drop {
        tier_id: 0x2::object::ID,
        lend_offer_id: 0x2::object::ID,
        interest: u64,
        borrow_amount: u64,
        lender_fee_percent: u64,
        duration: u64,
        lend_token: 0x1::string::String,
        lender: address,
        loan_offer_id: 0x2::object::ID,
        borrower: address,
        collateral_token: 0x1::string::String,
        collateral_amount: u64,
        status: 0x1::string::String,
        borrower_fee_percent: u64,
        timestamp: u64,
    }

    struct LiquidatingCollateralEvent has copy, drop {
        loan_id: 0x2::object::ID,
        liquidating_price: u64,
        liquidating_at: u64,
    }

    struct LiquidatedCollateralEvent has copy, drop {
        lender: address,
        borrower: address,
        loan_id: 0x2::object::ID,
        collateral_swapped_amount: u64,
        status: 0x1::string::String,
        liquidated_price: u64,
        liquidated_tx: 0x1::string::String,
        remaining_fund_to_borrower: u64,
    }

    public(friend) fun deposit_collateral<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64) {
        assert!(arg0.status == 0x1::string::utf8(b"FundTransferred"), 3);
        0x2::balance::join<T1>(&mut arg0.collateral, 0x2::coin::into_balance<T1>(arg1));
        let v0 = DepositCollateralEvent{
            tier_id              : arg2,
            lend_offer_id        : arg0.offer_id,
            interest             : arg0.interest,
            borrow_amount        : arg0.amount,
            lender_fee_percent   : arg3,
            duration             : arg0.duration,
            lend_token           : arg5,
            lender               : arg0.lender,
            loan_offer_id        : 0x2::object::id<Loan<T0, T1>>(arg0),
            borrower             : arg0.borrower,
            collateral_token     : arg6,
            collateral_amount    : 0x2::balance::value<T1>(&arg0.collateral),
            status               : arg0.status,
            borrower_fee_percent : arg4,
            timestamp            : arg7,
        };
        0x2::event::emit<DepositCollateralEvent>(v0);
    }

    public fun is_expired_loan_offer<T0, T1>(arg0: &Loan<T0, T1>, arg1: u64) : bool {
        arg1 >= arg0.start_timestamp + arg0.duration
    }

    public fun is_valid_collateral_amount<T0, T1>(arg0: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg1: u64, arg2: u64, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) : bool {
        let v0 = 0x2::coin::get_decimals<T0>(arg3);
        let v1 = 0x2::coin::get_decimals<T1>(arg4);
        let v2 = if (v0 > v1) {
            (v0 as u64)
        } else {
            (v1 as u64)
        };
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::price_feed::get_value_by_usd<T1>(arg6, v2, arg2, arg4, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::max_price_age_seconds(arg0), arg7) * (10000 as u128) / 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::price_feed::get_value_by_usd<T0>(arg5, v2, arg1, arg3, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::max_price_age_seconds(arg0), arg7) >= (0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::min_health_ratio(arg0) as u128)
    }

    public(friend) fun new_loan<T0, T1>(arg0: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg1: 0x2::coin::Coin<T1>, arg2: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>, arg3: address, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Loan<T0, T1> {
        assert!(is_valid_collateral_amount<T0, T1>(arg0, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::amount<T0>(arg2), 0x2::coin::value<T1>(&arg1), arg4, arg5, arg6, arg7, arg9), 1);
        let v0 = Loan<T0, T1>{
            id              : 0x2::object::new(arg10),
            offer_id        : 0x2::object::id<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg2),
            interest        : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::interest<T0>(arg2),
            amount          : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::amount<T0>(arg2),
            duration        : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::duration<T0>(arg2),
            collateral      : 0x2::coin::into_balance<T1>(arg1),
            lender          : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::lender<T0>(arg2),
            borrower        : arg3,
            start_timestamp : arg8,
            liquidation     : 0x1::option::none<Liquidation<T0, T1>>(),
            repay_balance   : 0x2::balance::zero<T0>(),
            status          : 0x1::string::utf8(b"Matched"),
        };
        let v1 = RequestLoanEvent{
            loan_id           : 0x2::object::id<Loan<T0, T1>>(&v0),
            offer_id          : 0x2::object::id<0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::Offer<T0>>(arg2),
            amount            : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::amount<T0>(arg2),
            duration          : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::duration<T0>(arg2),
            collateral_amount : 0x2::coin::value<T1>(&arg1),
            lend_token        : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T0>(),
            collateral_token  : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::utils::get_type<T1>(),
            lender            : 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::offer_registry::lender<T0>(arg2),
            borrower          : arg3,
            start_timestamp   : arg8,
        };
        0x2::event::emit<RequestLoanEvent>(v1);
        v0
    }

    public fun new_loan_key<T0, T1>(arg0: 0x2::object::ID) : LoanKey<T0, T1> {
        LoanKey<T0, T1>{loan_id: arg0}
    }

    public fun offer_id<T0, T1>(arg0: &Loan<T0, T1>) : 0x2::object::ID {
        arg0.offer_id
    }

    public(friend) fun repay<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::Custodian<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: address, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7 == arg0.borrower, 2);
        assert!(arg0.status == 0x1::string::utf8(b"FundTransferred"), 3);
        assert!(arg0.start_timestamp + arg0.duration * 1000 > arg8, 5);
        let v0 = ((((arg0.amount * arg0.interest / 10000 * arg0.duration) as u128) / (31536000 as u128)) as u64);
        let v1 = ((((v0 * arg3) as u128) / (10000 as u128)) as u64);
        let v2 = arg0.amount + v1 + v0;
        assert!(0x2::coin::value<T0>(&arg2) == v2, 4);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg9), arg6);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::add_treasury_balance<T0>(arg1, 0x2::balance::split<T0>(&mut v3, v1));
        let v4 = 0x2::balance::value<T1>(&arg0.collateral);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.collateral, v4), arg9), arg7);
        arg0.status = 0x1::string::utf8(b"BorrowerPaid");
        let v5 = BorrowerPaidEvent{
            loan_id           : 0x2::object::id<Loan<T0, T1>>(arg0),
            repay_amount      : v2,
            collateral_amount : v4,
            lend_token        : arg4,
            collateral_token  : arg5,
            borrower          : arg7,
        };
        0x2::event::emit<BorrowerPaidEvent>(v5);
    }

    fun start_liquidate_loan_offer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<Liquidation<T0, T1>>(&arg0.liquidation)) {
            let v0 = Liquidation<T0, T1>{
                liquidating_at    : arg2,
                liquidating_price : arg1,
                liquidated_tx     : 0x1::option::none<0x1::string::String>(),
                liquidated_price  : 0x1::option::none<u64>(),
            };
            arg0.liquidation = 0x1::option::some<Liquidation<T0, T1>>(v0);
        } else {
            let v1 = 0x1::option::borrow_mut<Liquidation<T0, T1>>(&mut arg0.liquidation);
            v1.liquidating_at = arg2;
            v1.liquidating_price = arg1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.collateral, 0x2::balance::value<T1>(&arg0.collateral)), arg4), arg3);
        arg0.status = 0x1::string::utf8(b"Liquidating");
        let v2 = LiquidatingCollateralEvent{
            loan_id           : 0x2::object::id<Loan<T0, T1>>(arg0),
            liquidating_price : arg1,
            liquidating_at    : arg2,
        };
        0x2::event::emit<LiquidatingCollateralEvent>(v2);
    }

    public(friend) fun start_liquidate_loan_offer_expired<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.status == 0x1::string::utf8(b"FundTransferred"), 3);
        assert!(is_expired_loan_offer<T0, T1>(arg0, v0), 11);
        start_liquidate_loan_offer<T0, T1>(arg0, 0, v0, arg1, arg3);
    }

    public(friend) fun start_liquidate_loan_offer_health<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"FundTransferred"), 3);
        assert!(!is_valid_collateral_amount<T0, T1>(arg1, arg0.amount, 0x2::balance::value<T1>(&arg0.collateral), arg2, arg3, arg4, arg5, arg7), 10);
        let (v0, _, _) = 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::price_feed::get_price(arg5, 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::max_price_age_seconds(arg1), arg7);
        start_liquidate_loan_offer<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg7), arg6, arg8);
    }

    public(friend) fun system_finish_loan<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: &mut 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::Custodian<T0>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"BorrowerPaid") || arg0.status == 0x1::string::utf8(b"Liquidated"), 3);
        let v0 = ((((arg0.amount * arg0.interest / 10000 * arg0.duration) as u128) / (31536000 as u128)) as u64);
        let v1 = ((((v0 * arg4) as u128) / (10000 as u128)) as u64);
        let v2 = arg0.amount + v0 - v1;
        assert!(0x2::coin::value<T0>(&arg2) == v2 + v1, 4);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::custodian::add_treasury_balance<T0>(arg1, 0x2::balance::split<T0>(&mut v3, v1));
        0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), arg0.lender);
        arg0.status = 0x1::string::utf8(b"Finished");
        let v4 = FinishedLoanEvent{
            loan_id                : 0x2::object::id<Loan<T0, T1>>(arg0),
            offer_id               : arg0.offer_id,
            repay_to_lender_amount : v2,
            lender                 : arg0.lender,
            borrower               : arg0.borrower,
        };
        0x2::event::emit<FinishedLoanEvent>(v4);
    }

    public(friend) fun system_fund_transfer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"Matched"), 3);
        let v0 = arg0.borrower;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        arg0.status = 0x1::string::utf8(b"FundTransferred");
        let v1 = FundTransferredEvent{
            loan_id          : 0x2::object::id<Loan<T0, T1>>(arg0),
            offer_id         : arg0.offer_id,
            amount           : arg0.amount,
            duration         : arg0.duration,
            lend_token       : arg2,
            collateral_token : arg3,
            lender           : arg0.lender,
            borrower         : v0,
        };
        0x2::event::emit<FundTransferredEvent>(v1);
    }

    public(friend) fun system_liquidate_loan_offer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String) {
        assert!(arg0.status == 0x1::string::utf8(b"Liquidating"), 3);
        assert!(0x1::option::is_some<Liquidation<T0, T1>>(&arg0.liquidation), 7);
        let v0 = 0x1::option::borrow_mut<Liquidation<T0, T1>>(&mut arg0.liquidation);
        v0.liquidated_price = 0x1::option::some<u64>(arg4);
        v0.liquidated_tx = 0x1::option::some<0x1::string::String>(arg5);
        let v1 = ((((arg0.amount * arg0.interest / 10000 * arg0.duration) as u128) / (31536000 as u128)) as u64);
        let v2 = arg3 - arg0.amount + ((((v1 * arg2) as u128) / (10000 as u128)) as u64) + v1;
        assert!(0x2::coin::value<T0>(&arg1) == v2, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.borrower);
        arg0.status = 0x1::string::utf8(b"Liquidated");
        let v3 = LiquidatedCollateralEvent{
            lender                     : arg0.lender,
            borrower                   : arg0.borrower,
            loan_id                    : 0x2::object::id<Loan<T0, T1>>(arg0),
            collateral_swapped_amount  : arg3,
            status                     : arg0.status,
            liquidated_price           : arg4,
            liquidated_tx              : arg5,
            remaining_fund_to_borrower : v2,
        };
        0x2::event::emit<LiquidatedCollateralEvent>(v3);
    }

    public(friend) fun withdraw_collateral<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: &0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::configuration::Configuration, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x1::string::utf8(b"FundTransferred"), 3);
        let v0 = 0x2::balance::value<T1>(&arg0.collateral);
        assert!(v0 >= arg6, 9);
        let v1 = v0 - arg6;
        assert!(is_valid_collateral_amount<T0, T1>(arg1, arg0.amount, v1, arg2, arg3, arg4, arg5, arg8), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.collateral, arg6), arg9), 0x2::tx_context::sender(arg9));
        let v2 = WithdrawCollateralEvent{
            loan_id                     : 0x2::object::id<Loan<T0, T1>>(arg0),
            borrower                    : arg0.borrower,
            withdraw_amount             : arg6,
            remaining_collateral_amount : v1,
            timestamp                   : arg7,
        };
        0x2::event::emit<WithdrawCollateralEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

