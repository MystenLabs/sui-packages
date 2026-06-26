module 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_loan_position {
    struct LoanPosition has key {
        id: 0x2::object::UID,
        request_id: u64,
        borrower: address,
        lender: address,
        principal: u64,
        interest_rate_schedule: vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>,
        interest_due: u64,
        interest_locked: bool,
        collateral_amount: u64,
        collateral_policy: u8,
        liquidation_trigger: u8,
        opened_at_ms: u64,
        due_at_ms: u64,
        repaid_amount: u64,
        status: u8,
        last_price: u64,
        last_price_ts_ms: u64,
        lender_is_vault: bool,
        vault_id: 0x1::option::Option<0x2::object::ID>,
        liquidation_price: 0x1::option::Option<u64>,
        oracle_feed_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun create_for_match(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>, arg5: u64, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: bool, arg11: 0x1::option::Option<0x2::object::ID>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<0x2::object::ID>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg14);
        let v1 = LoanPosition{
            id                     : 0x2::object::new(arg15),
            request_id             : arg0,
            borrower               : arg1,
            lender                 : arg2,
            principal              : arg3,
            interest_rate_schedule : arg4,
            interest_due           : 0,
            interest_locked        : false,
            collateral_amount      : arg5,
            collateral_policy      : arg6,
            liquidation_trigger    : arg7,
            opened_at_ms           : v0,
            due_at_ms              : v0 + arg8 * 1000,
            repaid_amount          : 0,
            status                 : 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_active(),
            last_price             : arg9,
            last_price_ts_ms       : v0,
            lender_is_vault        : arg10,
            vault_id               : arg11,
            liquidation_price      : arg12,
            oracle_feed_id         : arg13,
        };
        0x2::transfer::share_object<LoanPosition>(v1);
        0x2::object::id<LoanPosition>(&v1)
    }

    public fun get_borrower(arg0: &LoanPosition) : address {
        arg0.borrower
    }

    public fun get_collateral_amount(arg0: &LoanPosition) : u64 {
        arg0.collateral_amount
    }

    public fun get_collateral_policy(arg0: &LoanPosition) : u8 {
        arg0.collateral_policy
    }

    public fun get_due_at_ms(arg0: &LoanPosition) : u64 {
        arg0.due_at_ms
    }

    public fun get_interest_due(arg0: &LoanPosition) : u64 {
        arg0.interest_due
    }

    public fun get_interest_rate_schedule(arg0: &LoanPosition) : vector<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier> {
        let v0 = 0x1::vector::empty<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&arg0.interest_rate_schedule)) {
            0x1::vector::push_back<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&mut v0, *0x1::vector::borrow<0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::InterestRateTier>(&arg0.interest_rate_schedule, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_last_price(arg0: &LoanPosition) : u64 {
        arg0.last_price
    }

    public fun get_lender(arg0: &LoanPosition) : address {
        arg0.lender
    }

    public fun get_liquidation_price(arg0: &LoanPosition) : 0x1::option::Option<u64> {
        arg0.liquidation_price
    }

    public fun get_liquidation_trigger(arg0: &LoanPosition) : u8 {
        arg0.liquidation_trigger
    }

    public fun get_opened_at_ms(arg0: &LoanPosition) : u64 {
        arg0.opened_at_ms
    }

    public fun get_oracle_feed_id(arg0: &LoanPosition) : 0x1::option::Option<0x2::object::ID> {
        arg0.oracle_feed_id
    }

    public fun get_principal(arg0: &LoanPosition) : u64 {
        arg0.principal
    }

    public fun get_repaid_amount(arg0: &LoanPosition) : u64 {
        arg0.repaid_amount
    }

    public fun get_request_id(arg0: &LoanPosition) : u64 {
        arg0.request_id
    }

    public fun get_status(arg0: &LoanPosition) : u8 {
        arg0.status
    }

    public fun get_vault_id(arg0: &LoanPosition) : 0x1::option::Option<0x2::object::ID> {
        arg0.vault_id
    }

    public fun is_interest_locked(arg0: &LoanPosition) : bool {
        arg0.interest_locked
    }

    public fun is_vault_loan(arg0: &LoanPosition) : bool {
        arg0.lender_is_vault
    }

    public(friend) fun lock_interest(arg0: &mut LoanPosition, arg1: u64) {
        assert!(!arg0.interest_locked, 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.interest_due = arg1;
        arg0.interest_locked = true;
    }

    public(friend) fun mark_bought_out(arg0: &mut LoanPosition, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = arg0.status;
        assert!(v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_defaulted() || v0 == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_liquidated(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_bought_out();
        arg0.last_price = arg1;
        arg0.last_price_ts_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun mark_default(arg0: &mut LoanPosition, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_defaulted();
        arg0.last_price = arg1;
        arg0.last_price_ts_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun mark_liquidated(arg0: &mut LoanPosition, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        arg0.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_liquidated();
        arg0.last_price = arg1;
        arg0.last_price_ts_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun mark_repaid_full(arg0: &mut LoanPosition, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0.status == 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_active(), 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_errors::invalid_state());
        let v0 = arg0.principal + arg0.interest_due;
        arg0.repaid_amount = v0;
        arg0.last_price_ts_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.status = 0x38887fa7aa3bedeb6964bdf271bd1415b032b8606fcc23ec687c13ddfde8721b::concord_types::loan_repaid();
        v0
    }

    // decompiled from Move bytecode v7
}

