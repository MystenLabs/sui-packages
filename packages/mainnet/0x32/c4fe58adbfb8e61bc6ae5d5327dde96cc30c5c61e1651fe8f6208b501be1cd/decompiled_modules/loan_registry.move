module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::loan_registry {
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
        collateral_amount: u64,
        collateral: 0x1::option::Option<0x2::balance::Balance<T1>>,
        lender: address,
        borrower: address,
        start_timestamp: u64,
        liquidation: 0x1::option::Option<Liquidation<T0, T1>>,
        repay_balance: 0x2::balance::Balance<T0>,
        status: 0x1::string::String,
    }

    struct RequestCreateLoanEvent has copy, drop {
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
        lender: address,
        lend_chain_borrower: address,
        collateral_amount: u64,
        lend_token: 0x1::string::String,
        collateral_token: 0x1::string::String,
        loan_id: 0x2::object::ID,
        repay_amount: u64,
        status: 0x1::string::String,
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

    struct LiquidatingCollateralLoanEvent has copy, drop {
        loan_id: 0x2::object::ID,
        liquidating_price: u64,
        liquidating_at: u64,
        collateral_chain_id: u16,
        collateral_amount: u64,
        collateral_token: 0x1::string::String,
    }

    struct LiquidatedCollateralLoanEvent has copy, drop {
        lender: address,
        lend_chain_borrower: address,
        loan_id: 0x2::object::ID,
        swapped_amount: u64,
        status: 0x1::string::String,
        liquidated_price: u64,
        liquidated_tx: 0x1::string::String,
        remaining_fund_to_borrower: u64,
    }

    struct RequestCancelCollateralHolderEvent has copy, drop {
        collateral_chain_id: u16,
        collateral_chain_address: 0x1::string::String,
        offer_id: 0x2::object::ID,
        lend_chain_borrower: address,
    }

    struct DepositCollateralLoanEvent has copy, drop {
        collateral_chain_id: u16,
        collateral_chain_address: 0x1::string::String,
        loan_id: 0x2::object::ID,
        deposit_amount: u64,
        collateral_amount: u64,
        collateral_token: 0x1::string::String,
        lend_chain_borrower: address,
    }

    struct WithdrawCollateralLoanEvent has copy, drop {
        collateral_chain_id: u16,
        collateral_chain_address: 0x1::string::String,
        loan_id: 0x2::object::ID,
        withdraw_amount: u64,
        collateral_amount: u64,
        collateral_token: 0x1::string::String,
        lend_chain_borrower: address,
    }

    public(friend) fun add_collateral_balance<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(0x1::option::borrow_mut<0x2::balance::Balance<T1>>(&mut arg0.collateral), arg1);
        arg0.collateral_amount = arg0.collateral_amount + 0x2::balance::value<T1>(&arg1);
    }

    public fun amount<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.amount
    }

    public fun borrower<T0, T1>(arg0: &Loan<T0, T1>) : address {
        arg0.borrower
    }

    public fun collateral_amount<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.collateral_amount
    }

    public(friend) fun deposit_collateral<T0, T1>(arg0: &Loan<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64) {
        let v0 = DepositCollateralEvent{
            tier_id              : arg1,
            lend_offer_id        : arg0.offer_id,
            interest             : arg0.interest,
            borrow_amount        : arg0.amount,
            lender_fee_percent   : arg2,
            duration             : arg0.duration,
            lend_token           : arg4,
            lender               : arg0.lender,
            loan_offer_id        : 0x2::object::id<Loan<T0, T1>>(arg0),
            borrower             : arg0.borrower,
            collateral_token     : arg5,
            collateral_amount    : arg6,
            status               : arg0.status,
            borrower_fee_percent : arg3,
            timestamp            : arg7,
        };
        0x2::event::emit<DepositCollateralEvent>(v0);
    }

    public fun duration<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.duration
    }

    public(friend) fun finish_liquidate_loan_offer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::string::String) {
        let v0 = 0x1::option::borrow_mut<Liquidation<T0, T1>>(&mut arg0.liquidation);
        v0.liquidated_price = 0x1::option::some<u64>(arg3);
        v0.liquidated_tx = 0x1::option::some<0x1::string::String>(arg4);
        arg0.status = 0x1::string::utf8(b"Liquidated");
        let v1 = LiquidatedCollateralLoanEvent{
            lender                     : arg0.lender,
            lend_chain_borrower        : arg0.borrower,
            loan_id                    : 0x2::object::id<Loan<T0, T1>>(arg0),
            swapped_amount             : arg1,
            status                     : arg0.status,
            liquidated_price           : arg3,
            liquidated_tx              : arg4,
            remaining_fund_to_borrower : arg2,
        };
        0x2::event::emit<LiquidatedCollateralLoanEvent>(v1);
    }

    public fun interest<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.interest
    }

    public fun is_borrower_paid_status<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"BorrowerPaid")
    }

    public fun is_expired_loan_offer<T0, T1>(arg0: &Loan<T0, T1>, arg1: u64) : bool {
        arg1 >= arg0.start_timestamp + arg0.duration
    }

    public fun is_fund_transferred_status<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"FundTransferred")
    }

    public fun is_holding_collateral<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        0x1::option::is_some<0x2::balance::Balance<T1>>(&arg0.collateral)
    }

    public fun is_liquidated_status<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"Liquidated")
    }

    public fun is_liquidating_status<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"Liquidating")
    }

    public fun is_matched_status<T0, T1>(arg0: &Loan<T0, T1>) : bool {
        arg0.status == 0x1::string::utf8(b"Matched")
    }

    public fun is_valid_collateral_amount<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T0>, arg4: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::Asset<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) : bool {
        let v0 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::decimals<T0>(arg3);
        let v1 = 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::asset::decimals<T1>(arg4);
        let v2 = if (v0 > v1) {
            (v0 as u64)
        } else {
            (v1 as u64)
        };
        0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::get_value_by_usd<T1>(arg6, v2, arg2, arg4, arg7) * (0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::utils::default_rate_factor() as u128) / 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::price_feed::get_value_by_usd<T0>(arg5, v2, arg1, arg3, arg7) >= (arg0 as u128)
    }

    public fun lender<T0, T1>(arg0: &Loan<T0, T1>) : address {
        arg0.lender
    }

    public(friend) fun new_loan<T0, T1>(arg0: 0x1::option::Option<0x2::balance::Balance<T1>>, arg1: u64, arg2: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Loan<T0, T1> {
        let v0 = Loan<T0, T1>{
            id                : 0x2::object::new(arg7),
            offer_id          : 0x2::object::id<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2),
            interest          : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::interest<T0>(arg2),
            amount            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::amount<T0>(arg2),
            duration          : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::duration<T0>(arg2),
            collateral_amount : arg1,
            collateral        : arg0,
            lender            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(arg2),
            borrower          : arg3,
            start_timestamp   : arg4,
            liquidation       : 0x1::option::none<Liquidation<T0, T1>>(),
            repay_balance     : 0x2::balance::zero<T0>(),
            status            : 0x1::string::utf8(b"Matched"),
        };
        let v1 = RequestCreateLoanEvent{
            loan_id           : 0x2::object::id<Loan<T0, T1>>(&v0),
            offer_id          : 0x2::object::id<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg2),
            amount            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::amount<T0>(arg2),
            duration          : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::duration<T0>(arg2),
            collateral_amount : arg1,
            lend_token        : arg5,
            collateral_token  : arg6,
            lender            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(arg2),
            borrower          : arg3,
            start_timestamp   : arg4,
        };
        0x2::event::emit<RequestCreateLoanEvent>(v1);
        v0
    }

    public fun new_loan_key<T0, T1>(arg0: 0x2::object::ID) : LoanKey<T0, T1> {
        LoanKey<T0, T1>{loan_id: arg0}
    }

    public fun offer_id<T0, T1>(arg0: &Loan<T0, T1>) : 0x2::object::ID {
        arg0.offer_id
    }

    public(friend) fun repay<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        arg0.status = 0x1::string::utf8(b"BorrowerPaid");
        let v0 = BorrowerPaidEvent{
            lender              : arg0.lender,
            lend_chain_borrower : arg0.borrower,
            collateral_amount   : arg2,
            lend_token          : arg3,
            collateral_token    : arg4,
            loan_id             : 0x2::object::id<Loan<T0, T1>>(arg0),
            repay_amount        : arg1,
            status              : arg0.status,
        };
        0x2::event::emit<BorrowerPaidEvent>(v0);
    }

    public(friend) fun request_cancel_collateral_holder(arg0: u16, arg1: 0x1::string::String, arg2: 0x2::object::ID, arg3: address) {
        let v0 = RequestCancelCollateralHolderEvent{
            collateral_chain_id      : arg0,
            collateral_chain_address : arg1,
            offer_id                 : arg2,
            lend_chain_borrower      : arg3,
        };
        0x2::event::emit<RequestCancelCollateralHolderEvent>(v0);
    }

    public(friend) fun start_liquidate_loan_offer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: u16, arg4: 0x1::string::String) {
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
        arg0.status = 0x1::string::utf8(b"Liquidating");
        let v2 = LiquidatingCollateralLoanEvent{
            loan_id             : 0x2::object::id<Loan<T0, T1>>(arg0),
            liquidating_price   : arg1,
            liquidating_at      : arg2,
            collateral_chain_id : arg3,
            collateral_amount   : arg0.collateral_amount,
            collateral_token    : arg4,
        };
        0x2::event::emit<LiquidatingCollateralLoanEvent>(v2);
    }

    public fun start_timestamp<T0, T1>(arg0: &Loan<T0, T1>) : u64 {
        arg0.start_timestamp
    }

    public(friend) fun sub_collateral_balance<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        arg0.collateral_amount = arg0.collateral_amount - arg1;
        0x2::balance::split<T1>(0x1::option::borrow_mut<0x2::balance::Balance<T1>>(&mut arg0.collateral), arg1)
    }

    public(friend) fun system_finish_loan<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64) {
        arg0.status = 0x1::string::utf8(b"Finished");
        let v0 = FinishedLoanEvent{
            loan_id                : 0x2::object::id<Loan<T0, T1>>(arg0),
            offer_id               : arg0.offer_id,
            repay_to_lender_amount : arg1,
            lender                 : arg0.lender,
            borrower               : arg0.borrower,
        };
        0x2::event::emit<FinishedLoanEvent>(v0);
    }

    public(friend) fun system_fund_transfer<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.status = 0x1::string::utf8(b"FundTransferred");
        let v0 = FundTransferredEvent{
            loan_id          : 0x2::object::id<Loan<T0, T1>>(arg0),
            offer_id         : arg0.offer_id,
            amount           : arg0.amount,
            duration         : arg0.duration,
            lend_token       : arg1,
            collateral_token : arg2,
            lender           : arg0.lender,
            borrower         : arg0.borrower,
        };
        0x2::event::emit<FundTransferredEvent>(v0);
    }

    public(friend) fun system_open_loan<T0, T1>(arg0: &0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>, arg1: 0x2::balance::Balance<T1>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Loan<T0, T1> {
        Loan<T0, T1>{
            id                : 0x2::object::new(arg4),
            offer_id          : 0x2::object::id<0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::Offer<T0>>(arg0),
            interest          : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::interest<T0>(arg0),
            amount            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::amount<T0>(arg0),
            duration          : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::duration<T0>(arg0),
            collateral_amount : 0x2::balance::value<T1>(&arg1),
            collateral        : 0x1::option::some<0x2::balance::Balance<T1>>(arg1),
            lender            : 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::offer_registry::lender<T0>(arg0),
            borrower          : arg2,
            start_timestamp   : arg3,
            liquidation       : 0x1::option::none<Liquidation<T0, T1>>(),
            repay_balance     : 0x2::balance::zero<T0>(),
            status            : 0x1::string::utf8(b"FundTransferred"),
        }
    }

    public(friend) fun update_deposit_collateral_cross_chain<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: u16, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        arg0.collateral_amount = arg2;
        let v0 = DepositCollateralLoanEvent{
            collateral_chain_id      : arg3,
            collateral_chain_address : arg4,
            loan_id                  : 0x2::object::id<Loan<T0, T1>>(arg0),
            deposit_amount           : arg1,
            collateral_amount        : arg2,
            collateral_token         : arg5,
            lend_chain_borrower      : arg0.borrower,
        };
        0x2::event::emit<DepositCollateralLoanEvent>(v0);
    }

    public(friend) fun update_withdraw_collateral_cross_chain<T0, T1>(arg0: &mut Loan<T0, T1>, arg1: u64, arg2: u64, arg3: u16, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        arg0.collateral_amount = arg2;
        let v0 = WithdrawCollateralLoanEvent{
            collateral_chain_id      : arg3,
            collateral_chain_address : arg4,
            loan_id                  : 0x2::object::id<Loan<T0, T1>>(arg0),
            withdraw_amount          : arg1,
            collateral_amount        : arg2,
            collateral_token         : arg5,
            lend_chain_borrower      : arg0.borrower,
        };
        0x2::event::emit<WithdrawCollateralLoanEvent>(v0);
    }

    public(friend) fun withdraw_collateral<T0, T1>(arg0: &Loan<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = WithdrawCollateralEvent{
            loan_id                     : 0x2::object::id<Loan<T0, T1>>(arg0),
            borrower                    : arg0.borrower,
            withdraw_amount             : arg1,
            remaining_collateral_amount : arg2,
            timestamp                   : arg3,
        };
        0x2::event::emit<WithdrawCollateralEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

