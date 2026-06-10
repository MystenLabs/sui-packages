module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger {
    struct MarketingLedger has key {
        id: 0x2::object::UID,
        custody: address,
        version: u64,
        admin: address,
        operator: address,
        signer: address,
        paused: bool,
        mixed_positions_paused: bool,
        max_credit_tier_bps: u64,
        total_credit_issued: u64,
        withdraw_daily_cap: u64,
        withdrawn_today: 0x2::table::Table<u64, u64>,
        yoso_vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        escrow_vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        open_buy_cash_total: u64,
        users: 0x2::table::Table<address, UserCreditState>,
        authorized_credit_creators: 0x2::table::Table<address, bool>,
        positions: 0x2::table::Table<u64, MarketingPosition>,
        buy_requests: 0x2::table::Table<u64, MarketingBuyRequest>,
        sell_requests: 0x2::table::Table<u64, MarketingSellRequest>,
        next_position_id: u64,
        next_buy_request_id: u64,
        next_sell_request_id: u64,
    }

    struct YoCashMigrationState has key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        enabled: bool,
        epoch: u64,
        migrated_users: 0x2::table::Table<address, bool>,
    }

    struct MigrationCap has key {
        id: 0x2::object::UID,
        state_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        epoch: u64,
    }

    struct UserCreditState has copy, drop, store {
        trial_balance: u64,
        profit_to_claim: u64,
        total_withdrawn: u64,
        credit_owed: u64,
        total_credit_received: u64,
        user_nonce: u64,
        credit_tier_nonce: u64,
        admin_clawback: u64,
        blacklisted: bool,
    }

    struct MarketingBuyRequest has copy, drop, store {
        user: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        fill_amount: u64,
        cash_amount: u64,
        credit_amount: u64,
        max_total_yoso_in: u64,
        tier_bps: u64,
        maker_order_hash: vector<u8>,
        expiry_ms: u64,
        cancelled: bool,
        executed: bool,
    }

    struct MarketingSellRequest has copy, drop, store {
        user: address,
        position_id: u64,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        shares_in: u64,
        min_total_yoso_out: u64,
        maker_order_hash: vector<u8>,
        expiry_ms: u64,
        cancelled: bool,
        executed: bool,
    }

    struct MarketingPosition has copy, drop, store {
        user: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        remaining_shares: u64,
        remaining_cash_principal: u64,
        remaining_credit_principal: u64,
        pending_sell_shares: u64,
        closed: bool,
        executor: address,
    }

    struct DepositCreditEnvelope has copy, drop, store {
        domain: vector<u8>,
        ledger_id: 0x2::object::ID,
        user: address,
        amount: u64,
        nonce: u64,
        expiry_ms: u64,
    }

    struct CreditTierEnvelope has copy, drop, store {
        domain: vector<u8>,
        ledger_id: 0x2::object::ID,
        user: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        fill_amount: u64,
        max_total_yoso_in: u64,
        maker_order_hash: vector<u8>,
        credit_amount: u64,
        tier_bps: u64,
        nonce: u64,
        expiry_ms: u64,
    }

    struct WithdrawProfitEnvelope has copy, drop, store {
        domain: vector<u8>,
        ledger_id: 0x2::object::ID,
        user: address,
        withdrawal_cap: u64,
        expiry_ms: u64,
    }

    struct CreditDeposited has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
    }

    struct ProfitWithdrawn has copy, drop {
        user: address,
        cash_to_user: u64,
        locked: u64,
        new_total_withdrawn: u64,
    }

    struct ProfitToClaimAccrued has copy, drop {
        user: address,
        amount: u64,
        new_profit_to_claim: u64,
    }

    struct ProfitToClaimSpent has copy, drop {
        user: address,
        amount: u64,
        new_profit_to_claim: u64,
    }

    struct CreditClawedBack has copy, drop {
        user: address,
        amount: u64,
        reason: vector<u8>,
        new_trial_balance: u64,
        new_profit_to_claim: u64,
    }

    struct Blacklisted has copy, drop {
        user: address,
    }

    struct Unblacklisted has copy, drop {
        user: address,
    }

    struct AuthorizedCreditCreatorUpdated has copy, drop {
        creator: address,
        authorized: bool,
    }

    struct OperatorUpdated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct SignerUpdated has copy, drop {
        old_signer: address,
        new_signer: address,
    }

    struct CustodyUpdated has copy, drop {
        old_custody: address,
        new_custody: address,
    }

    struct MarketingLedgerFunded has copy, drop {
        amount: u64,
    }

    struct YoCashMigrationStateInitialized has copy, drop {
        state_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
    }

    struct YoCashMigrationCapCreated has copy, drop {
        cap_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        epoch: u64,
        recipient: address,
    }

    struct YoCashMigrationDisabled has copy, drop {
        state_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        epoch: u64,
    }

    struct YoCashMigrationEpochRotated has copy, drop {
        state_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        old_epoch: u64,
        new_epoch: u64,
    }

    struct UserYoCashMigrated has copy, drop {
        user: address,
        trial_balance: u64,
        profit_to_claim: u64,
        total_withdrawn: u64,
        credit_owed: u64,
        total_credit_received: u64,
    }

    public fun id(arg0: &MarketingLedger) : 0x2::object::ID {
        assert_version(arg0);
        0x2::object::id<MarketingLedger>(arg0)
    }

    public fun admin_decrement_credit(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg4);
        assert!(arg2 > 0, 209);
        let v0 = borrow_user(arg0, arg1);
        assert!(v0.trial_balance >= arg2, 206);
        let v1 = if (v0.trial_balance > v0.profit_to_claim) {
            v0.trial_balance - v0.profit_to_claim
        } else {
            0
        };
        let v2 = if (arg2 > v1) {
            arg2 - v1
        } else {
            0
        };
        v0.trial_balance = v0.trial_balance - arg2;
        if (v2 > 0) {
            v0.profit_to_claim = v0.profit_to_claim - v2;
            let v3 = ProfitToClaimSpent{
                user                : arg1,
                amount              : v2,
                new_profit_to_claim : v0.profit_to_claim,
            };
            0x2::event::emit<ProfitToClaimSpent>(v3);
        };
        v0.admin_clawback = v0.admin_clawback + arg2;
        assert_inv(v0);
        let v4 = if (arg0.total_credit_issued >= arg2) {
            arg0.total_credit_issued - arg2
        } else {
            0
        };
        arg0.total_credit_issued = v4;
        let v5 = CreditClawedBack{
            user                : arg1,
            amount              : arg2,
            reason              : arg3,
            new_trial_balance   : v0.trial_balance,
            new_profit_to_claim : v0.profit_to_claim,
        };
        0x2::event::emit<CreditClawedBack>(v5);
    }

    public(friend) fun apply_position_sale(arg0: &mut MarketingLedger, arg1: MarketingSellRequest, arg2: u64, arg3: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg3) == arg2, 209);
        let v0 = 0x2::table::borrow_mut<u64, MarketingPosition>(&mut arg0.positions, arg1.position_id);
        let v1 = if (v0.user == arg1.user) {
            if (!v0.closed) {
                v0.pending_sell_shares >= arg1.shares_in
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 211);
        let v2 = arg1.shares_in == v0.remaining_shares;
        let v3 = if (v2) {
            v0.remaining_cash_principal
        } else {
            (((v0.remaining_cash_principal as u128) * (arg1.shares_in as u128) / (v0.remaining_shares as u128)) as u64)
        };
        let v4 = if (v2) {
            v0.remaining_credit_principal
        } else {
            (((v0.remaining_credit_principal as u128) * (arg1.shares_in as u128) / (v0.remaining_shares as u128)) as u64)
        };
        let v5 = v3 + v4;
        let v6 = if (v5 == 0) {
            0
        } else {
            (((arg2 as u128) * (v3 as u128) / (v5 as u128)) as u64)
        };
        v0.pending_sell_shares = v0.pending_sell_shares - arg1.shares_in;
        if (v2) {
            v0.remaining_shares = 0;
            v0.remaining_cash_principal = 0;
            v0.remaining_credit_principal = 0;
            v0.closed = true;
        } else {
            v0.remaining_shares = v0.remaining_shares - arg1.shares_in;
            v0.remaining_cash_principal = v0.remaining_cash_principal - v3;
            v0.remaining_credit_principal = v0.remaining_credit_principal - v4;
        };
        split_cash_credit(arg0, arg1.user, arg3, v6, arg2 - v6, v4, arg4)
    }

    fun assert_admin(arg0: &MarketingLedger, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 201);
    }

    fun assert_admin_or_operator(arg0: &MarketingLedger, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin || v0 == arg0.operator, 201);
    }

    fun assert_buy(arg0: &MarketingLedger, arg1: address) {
        assert_live_user(arg0, arg1);
        assert!(!arg0.mixed_positions_paused, 202);
    }

    public(friend) fun assert_executor(arg0: &MarketingLedger, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 201);
    }

    fun assert_inv(arg0: &UserCreditState) {
        assert!(arg0.profit_to_claim <= arg0.trial_balance, 206);
    }

    fun assert_live_user(arg0: &MarketingLedger, arg1: address) {
        assert_version(arg0);
        assert!(!arg0.paused, 202);
        let v0 = get_user(arg0, arg1);
        assert!(!v0.blacklisted, 203);
    }

    fun assert_migration_cap(arg0: &MarketingLedger, arg1: &YoCashMigrationState, arg2: &MigrationCap) {
        assert_migration_state_for_ledger(arg0, arg1);
        assert!(arg1.enabled, 214);
        let v0 = if (arg2.state_id == 0x2::object::id<YoCashMigrationState>(arg1)) {
            if (arg2.ledger_id == 0x2::object::id<MarketingLedger>(arg0)) {
                arg2.epoch == arg1.epoch
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 213);
    }

    fun assert_migration_state_for_ledger(arg0: &MarketingLedger, arg1: &YoCashMigrationState) {
        assert_version(arg0);
        assert!(arg1.ledger_id == 0x2::object::id<MarketingLedger>(arg0), 213);
    }

    fun assert_trade(arg0: &MarketingLedger, arg1: address) {
        assert_live_user(arg0, arg1);
    }

    fun assert_version(arg0: &MarketingLedger) {
        assert!(arg0.version == 1, 200);
    }

    fun bool_table(arg0: &0x2::table::Table<address, bool>, arg1: address) : bool {
        0x2::table::contains<address, bool>(arg0, arg1) && *0x2::table::borrow<address, bool>(arg0, arg1)
    }

    fun borrow_credit(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_vault) >= arg2, 206);
        let v0 = borrow_user(arg0, arg1);
        assert!(v0.trial_balance >= arg2 && v0.trial_balance - arg2 >= v0.profit_to_claim, 206);
        v0.trial_balance = v0.trial_balance - arg2;
        assert_inv(v0);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, arg2), arg3)
    }

    fun borrow_user(arg0: &mut MarketingLedger, arg1: address) : &mut UserCreditState {
        if (!0x2::table::contains<address, UserCreditState>(&arg0.users, arg1)) {
            0x2::table::add<address, UserCreditState>(&mut arg0.users, arg1, zero_user());
        };
        0x2::table::borrow_mut<address, UserCreditState>(&mut arg0.users, arg1)
    }

    public(friend) fun buy_request_data(arg0: MarketingBuyRequest) : (address, u64, 0x2::object::ID, 0x2::object::ID, u8, u64, u64, u64, u64, u64, vector<u8>, u64, bool, bool) {
        (arg0.user, arg0.market_id, arg0.market_object_id, arg0.account_object_id, arg0.outcome, arg0.fill_amount, arg0.cash_amount, arg0.credit_amount, arg0.max_total_yoso_in, arg0.tier_bps, arg0.maker_order_hash, arg0.expiry_ms, arg0.cancelled, arg0.executed)
    }

    public(friend) fun cancel_buy_request(arg0: &mut MarketingLedger, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        let v0 = 0x2::table::borrow_mut<u64, MarketingBuyRequest>(&mut arg0.buy_requests, arg1);
        assert!(v0.user == arg2, 201);
        assert!(!v0.cancelled && !v0.executed, 207);
        v0.cancelled = true;
        let v1 = v0.cash_amount;
        arg0.open_buy_cash_total = arg0.open_buy_cash_total - v1;
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.escrow_vault, v1), arg3)
    }

    public(friend) fun cancel_sell_request(arg0: &mut MarketingLedger, arg1: u64, arg2: address) {
        let v0 = 0x2::table::borrow_mut<u64, MarketingSellRequest>(&mut arg0.sell_requests, arg1);
        assert!(v0.user == arg2, 201);
        assert!(!v0.cancelled && !v0.executed, 207);
        v0.cancelled = true;
        let v1 = v0.position_id;
        0x2::table::borrow_mut<u64, MarketingPosition>(&mut arg0.positions, v1).pending_sell_shares = 0x2::table::borrow<u64, MarketingPosition>(&arg0.positions, v1).pending_sell_shares - v0.shares_in;
    }

    public(friend) fun close_claimed_position(arg0: &mut MarketingLedger, arg1: u64, arg2: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg2) == arg3, 209);
        let v0 = 0x2::table::borrow_mut<u64, MarketingPosition>(&mut arg0.positions, arg1);
        let v1 = v0.remaining_cash_principal + v0.remaining_credit_principal;
        let v2 = if (v1 == 0) {
            0
        } else {
            (((arg3 as u128) * (v0.remaining_cash_principal as u128) / (v1 as u128)) as u64)
        };
        v0.remaining_shares = 0;
        v0.remaining_cash_principal = 0;
        v0.remaining_credit_principal = 0;
        v0.closed = true;
        split_cash_credit(arg0, v0.user, arg2, v2, arg3 - v2, v0.remaining_credit_principal, arg4)
    }

    public(friend) fun create_buy_request(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8, arg6: u64, arg7: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u8>, arg12: u64, arg13: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg14: &0x2::clock::Clock) : u64 {
        assert_buy(arg0, arg1);
        let v0 = if (arg6 > 0) {
            if (arg8 > 0) {
                arg8 < arg9
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 209);
        assert!(arg10 > 0 && arg10 <= arg0.max_credit_tier_bps, 205);
        assert!((arg8 as u128) * (10000 as u128) <= (arg9 as u128) * (arg10 as u128), 205);
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg7) == arg9 - arg8, 209);
        assert!(0x2::clock::timestamp_ms(arg14) < arg12, 204);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::verify_signature_message(arg13, arg0.signer, credit_tier_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9, arg11, arg8, arg10, arg12));
        let v1 = borrow_user(arg0, arg1);
        let v2 = v1.credit_tier_nonce + 1;
        let v3 = borrow_user(arg0, arg1);
        v3.credit_tier_nonce = v2;
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.escrow_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg7));
        arg0.open_buy_cash_total = arg0.open_buy_cash_total + arg9 - arg8;
        let v4 = arg0.next_buy_request_id;
        arg0.next_buy_request_id = v4 + 1;
        let v5 = MarketingBuyRequest{
            user              : arg1,
            market_id         : arg2,
            market_object_id  : arg3,
            account_object_id : arg4,
            outcome           : arg5,
            fill_amount       : arg6,
            cash_amount       : arg9 - arg8,
            credit_amount     : arg8,
            max_total_yoso_in : arg9,
            tier_bps          : arg10,
            maker_order_hash  : arg11,
            expiry_ms         : arg12,
            cancelled         : false,
            executed          : false,
        };
        0x2::table::add<u64, MarketingBuyRequest>(&mut arg0.buy_requests, v4, v5);
        v4
    }

    public(friend) fun create_sell_request(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) : u64 {
        assert_trade(arg0, arg1);
        assert!(arg4 > 0, 209);
        let v0 = 0x2::table::borrow_mut<u64, MarketingPosition>(&mut arg0.positions, arg2);
        assert!(v0.user == arg1, 201);
        assert!(!v0.closed, 208);
        assert!(v0.remaining_shares - v0.pending_sell_shares >= arg4, 209);
        v0.pending_sell_shares = v0.pending_sell_shares + arg4;
        let v1 = v0.outcome;
        let v2 = arg0.next_sell_request_id;
        arg0.next_sell_request_id = v2 + 1;
        let v3 = MarketingSellRequest{
            user               : arg1,
            position_id        : arg2,
            market_id          : v0.market_id,
            market_object_id   : v0.market_object_id,
            account_object_id  : v0.account_object_id,
            outcome            : v1,
            shares_in          : arg4,
            min_total_yoso_out : arg5,
            maker_order_hash   : arg3,
            expiry_ms          : arg6,
            cancelled          : false,
            executed           : false,
        };
        0x2::table::add<u64, MarketingSellRequest>(&mut arg0.sell_requests, v2, v3);
        v2
    }

    public fun create_yocash_migration_cap(arg0: &MarketingLedger, arg1: &YoCashMigrationState, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg3);
        assert_migration_state_for_ledger(arg0, arg1);
        assert!(arg2 != @0x0, 201);
        let v0 = new_migration_cap_for_state(arg0, arg1, arg3);
        let v1 = YoCashMigrationCapCreated{
            cap_id    : 0x2::object::id<MigrationCap>(&v0),
            state_id  : 0x2::object::id<YoCashMigrationState>(arg1),
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
            epoch     : arg1.epoch,
            recipient : arg2,
        };
        0x2::event::emit<YoCashMigrationCapCreated>(v1);
        0x2::transfer::transfer<MigrationCap>(v0, arg2);
    }

    public fun credit_tier_message(arg0: &MarketingLedger, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: u64, arg10: u64, arg11: u64) : vector<u8> {
        let v0 = get_user(arg0, arg1);
        let v1 = CreditTierEnvelope{
            domain            : b"YOSO_MARKETING_CREDIT_TIER_V1",
            ledger_id         : 0x2::object::id<MarketingLedger>(arg0),
            user              : arg1,
            market_id         : arg2,
            market_object_id  : arg3,
            account_object_id : arg4,
            outcome           : arg5,
            fill_amount       : arg6,
            max_total_yoso_in : arg7,
            maker_order_hash  : arg8,
            credit_amount     : arg9,
            tier_bps          : arg10,
            nonce             : v0.credit_tier_nonce,
            expiry_ms         : arg11,
        };
        0x2::bcs::to_bytes<CreditTierEnvelope>(&v1)
    }

    public fun custody(arg0: &MarketingLedger) : address {
        assert_version(arg0);
        arg0.custody
    }

    public fun deposit_credit(arg0: &mut MarketingLedger, arg1: u64, arg2: u64, arg3: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_live_user(arg0, 0x2::tx_context::sender(arg5));
        assert!(arg1 > 0, 209);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 204);
        let v0 = 0x2::tx_context::sender(arg5);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::verify_signature_message(arg3, arg0.signer, deposit_credit_message(arg0, v0, arg1, arg2));
        let v1 = borrow_user(arg0, v0);
        v1.user_nonce = v1.user_nonce + 1;
        v1.trial_balance = v1.trial_balance + arg1;
        v1.credit_owed = v1.credit_owed + arg1;
        v1.total_credit_received = v1.total_credit_received + arg1;
        arg0.total_credit_issued = arg0.total_credit_issued + arg1;
        let v2 = CreditDeposited{
            user        : v0,
            amount      : arg1,
            new_balance : v1.trial_balance,
        };
        0x2::event::emit<CreditDeposited>(v2);
    }

    public fun deposit_credit_message(arg0: &MarketingLedger, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = get_user(arg0, arg1);
        let v1 = DepositCreditEnvelope{
            domain    : b"YOSO_MARKETING_DEPOSIT_V1",
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
            user      : arg1,
            amount    : arg2,
            nonce     : v0.user_nonce,
            expiry_ms : arg3,
        };
        0x2::bcs::to_bytes<DepositCreditEnvelope>(&v1)
    }

    public fun destroy_yocash_migration_cap(arg0: MigrationCap) {
        let MigrationCap {
            id        : v0,
            state_id  : _,
            ledger_id : _,
            epoch     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun disable_yocash_migration(arg0: &MarketingLedger, arg1: &mut YoCashMigrationState, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_migration_state_for_ledger(arg0, arg1);
        arg1.enabled = false;
        let v0 = YoCashMigrationDisabled{
            state_id  : 0x2::object::id<YoCashMigrationState>(arg1),
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
            epoch     : arg1.epoch,
        };
        0x2::event::emit<YoCashMigrationDisabled>(v0);
    }

    public fun escrow_vault_balance(arg0: &MarketingLedger) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.escrow_vault)
    }

    public fun fund_ledger(arg0: &mut MarketingLedger, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1);
        assert!(v0 > 0, 209);
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
        let v1 = MarketingLedgerFunded{amount: v0};
        0x2::event::emit<MarketingLedgerFunded>(v1);
    }

    fun get_user(arg0: &MarketingLedger, arg1: address) : UserCreditState {
        if (0x2::table::contains<address, UserCreditState>(&arg0.users, arg1)) {
            *0x2::table::borrow<address, UserCreditState>(&arg0.users, arg1)
        } else {
            zero_user()
        }
    }

    public fun init_marketing_ledger(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::share_object<MarketingLedger>(new_for_params(arg0, v0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun init_yocash_migration_state(arg0: &MarketingLedger, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = new_migration_state_for_ledger(arg0, arg1);
        let v1 = YoCashMigrationStateInitialized{
            state_id  : 0x2::object::id<YoCashMigrationState>(&v0),
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
        };
        0x2::event::emit<YoCashMigrationStateInitialized>(v1);
        0x2::transfer::share_object<YoCashMigrationState>(v0);
    }

    public fun is_authorized_creator(arg0: &MarketingLedger, arg1: address) : bool {
        assert_version(arg0);
        bool_table(&arg0.authorized_credit_creators, arg1)
    }

    public fun migrate_user_yocash_state(arg0: &mut MarketingLedger, arg1: &mut YoCashMigrationState, arg2: &MigrationCap, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert_migration_cap(arg0, arg1, arg2);
        migrate_user_yocash_state_inner(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun migrate_user_yocash_state_batch(arg0: &mut MarketingLedger, arg1: &mut YoCashMigrationState, arg2: &MigrationCap, arg3: vector<address>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>) {
        assert_migration_cap(arg0, arg1, arg2);
        let v0 = 0x1::vector::length<address>(&arg3);
        let v1 = if (v0 == 0x1::vector::length<u64>(&arg4)) {
            if (v0 == 0x1::vector::length<u64>(&arg5)) {
                if (v0 == 0x1::vector::length<u64>(&arg6)) {
                    if (v0 == 0x1::vector::length<u64>(&arg7)) {
                        v0 == 0x1::vector::length<u64>(&arg8)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 209);
        let v2 = 0;
        while (v2 < v0) {
            migrate_user_yocash_state_inner(arg0, arg1, *0x1::vector::borrow<address>(&arg3, v2), *0x1::vector::borrow<u64>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2), *0x1::vector::borrow<u64>(&arg6, v2), *0x1::vector::borrow<u64>(&arg7, v2), *0x1::vector::borrow<u64>(&arg8, v2));
            v2 = v2 + 1;
        };
    }

    fun migrate_user_yocash_state_inner(arg0: &mut MarketingLedger, arg1: &mut YoCashMigrationState, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg2 != @0x0, 201);
        assert!(arg4 <= arg3, 206);
        assert!(arg7 >= arg6, 206);
        assert!(!bool_table(&arg1.migrated_users, arg2), 212);
        let v0 = get_user(arg0, arg2);
        let v1 = if (v0.trial_balance == 0) {
            if (v0.profit_to_claim == 0) {
                if (v0.total_withdrawn == 0) {
                    if (v0.credit_owed == 0) {
                        if (v0.total_credit_received == 0) {
                            if (v0.user_nonce == 0) {
                                if (v0.credit_tier_nonce == 0) {
                                    v0.admin_clawback == 0
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 215);
        let v2 = borrow_user(arg0, arg2);
        v2.trial_balance = arg3;
        v2.profit_to_claim = arg4;
        v2.total_withdrawn = arg5;
        v2.credit_owed = arg6;
        v2.total_credit_received = arg7;
        assert_inv(v2);
        let v3 = &mut arg1.migrated_users;
        set_bool(v3, arg2, true);
        arg0.total_credit_issued = arg0.total_credit_issued + arg7;
        let v4 = UserYoCashMigrated{
            user                  : arg2,
            trial_balance         : arg3,
            profit_to_claim       : arg4,
            total_withdrawn       : arg5,
            credit_owed           : arg6,
            total_credit_received : arg7,
        };
        0x2::event::emit<UserYoCashMigrated>(v4);
    }

    public fun migrate_version(arg0: &mut MarketingLedger, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 201);
        assert!(arg0.version == arg1, 200);
        assert!(arg2 == 1 && arg2 >= arg1, 200);
        arg0.version = arg2;
    }

    public fun migration_cap_id(arg0: &MigrationCap) : 0x2::object::ID {
        0x2::object::id<MigrationCap>(arg0)
    }

    public fun migration_state_id(arg0: &YoCashMigrationState) : 0x2::object::ID {
        0x2::object::id<YoCashMigrationState>(arg0)
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun new_for_params(arg0: address, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : MarketingLedger {
        let v0 = if (arg0 != @0x0) {
            if (arg2 != @0x0) {
                arg3 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 201);
        let v1 = if (arg0 != arg1) {
            if (arg0 != arg2) {
                arg0 != arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 201);
        assert!(arg4 <= 10000, 205);
        MarketingLedger{
            id                         : 0x2::object::new(arg6),
            custody                    : arg0,
            version                    : 1,
            admin                      : arg1,
            operator                   : arg3,
            signer                     : arg2,
            paused                     : false,
            mixed_positions_paused     : false,
            max_credit_tier_bps        : arg4,
            total_credit_issued        : 0,
            withdraw_daily_cap         : arg5,
            withdrawn_today            : 0x2::table::new<u64, u64>(arg6),
            yoso_vault                 : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            escrow_vault               : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            open_buy_cash_total        : 0,
            users                      : 0x2::table::new<address, UserCreditState>(arg6),
            authorized_credit_creators : 0x2::table::new<address, bool>(arg6),
            positions                  : 0x2::table::new<u64, MarketingPosition>(arg6),
            buy_requests               : 0x2::table::new<u64, MarketingBuyRequest>(arg6),
            sell_requests              : 0x2::table::new<u64, MarketingSellRequest>(arg6),
            next_position_id           : 0,
            next_buy_request_id        : 0,
            next_sell_request_id       : 0,
        }
    }

    fun new_migration_cap_for_state(arg0: &MarketingLedger, arg1: &YoCashMigrationState, arg2: &mut 0x2::tx_context::TxContext) : MigrationCap {
        assert_migration_state_for_ledger(arg0, arg1);
        MigrationCap{
            id        : 0x2::object::new(arg2),
            state_id  : 0x2::object::id<YoCashMigrationState>(arg1),
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
            epoch     : arg1.epoch,
        }
    }

    fun new_migration_state_for_ledger(arg0: &MarketingLedger, arg1: &mut 0x2::tx_context::TxContext) : YoCashMigrationState {
        assert_version(arg0);
        YoCashMigrationState{
            id             : 0x2::object::new(arg1),
            ledger_id      : 0x2::object::id<MarketingLedger>(arg0),
            enabled        : true,
            epoch          : 0,
            migrated_users : 0x2::table::new<address, bool>(arg1),
        }
    }

    public fun open_buy_cash_total(arg0: &MarketingLedger) : u64 {
        assert_version(arg0);
        arg0.open_buy_cash_total
    }

    public(friend) fun open_position(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: address) : u64 {
        let v0 = arg0.next_position_id;
        arg0.next_position_id = v0 + 1;
        let v1 = MarketingPosition{
            user                       : arg1,
            market_id                  : arg2,
            market_object_id           : arg3,
            account_object_id          : arg4,
            outcome                    : arg5,
            remaining_shares           : arg6,
            remaining_cash_principal   : arg7,
            remaining_credit_principal : arg8,
            pending_sell_shares        : 0,
            closed                     : false,
            executor                   : arg9,
        };
        0x2::table::add<u64, MarketingPosition>(&mut arg0.positions, v0, v1);
        v0
    }

    public fun operator(arg0: &MarketingLedger) : address {
        assert_version(arg0);
        arg0.operator
    }

    public fun pause(arg0: &mut MarketingLedger, arg1: &0x2::tx_context::TxContext) {
        assert_admin_or_operator(arg0, arg1);
        arg0.paused = true;
    }

    public fun position(arg0: &MarketingLedger, arg1: u64) : MarketingPosition {
        assert_version(arg0);
        *0x2::table::borrow<u64, MarketingPosition>(&arg0.positions, arg1)
    }

    public(friend) fun position_data(arg0: MarketingPosition) : (address, u64, 0x2::object::ID, 0x2::object::ID, u8, u64, u64, u64, u64, bool, address) {
        (arg0.user, arg0.market_id, arg0.market_object_id, arg0.account_object_id, arg0.outcome, arg0.remaining_shares, arg0.remaining_cash_principal, arg0.remaining_credit_principal, arg0.pending_sell_shares, arg0.closed, arg0.executor)
    }

    public(friend) fun prepare_buy_execution(arg0: &mut MarketingLedger, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (MarketingBuyRequest, 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        let v0 = *0x2::table::borrow<u64, MarketingBuyRequest>(&arg0.buy_requests, arg1);
        assert!(!v0.cancelled && !v0.executed, 207);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.expiry_ms, 204);
        assert_buy(arg0, v0.user);
        0x2::table::borrow_mut<u64, MarketingBuyRequest>(&mut arg0.buy_requests, arg1).executed = true;
        arg0.open_buy_cash_total = arg0.open_buy_cash_total - v0.cash_amount;
        let v1 = 0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.escrow_vault, v0.cash_amount), arg3);
        (v0, v1, borrow_credit(arg0, v0.user, v0.credit_amount, arg3))
    }

    public(friend) fun prepare_claim(arg0: &MarketingLedger, arg1: u64, arg2: address) : MarketingPosition {
        assert_trade(arg0, arg2);
        let v0 = position(arg0, arg1);
        assert!(v0.user == arg2 && !v0.closed, 208);
        assert!(v0.pending_sell_shares == 0, 210);
        v0
    }

    public(friend) fun prepare_sell_execution(arg0: &mut MarketingLedger, arg1: u64, arg2: &0x2::clock::Clock) : MarketingSellRequest {
        let v0 = *0x2::table::borrow<u64, MarketingSellRequest>(&arg0.sell_requests, arg1);
        assert!(!v0.cancelled && !v0.executed, 207);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.expiry_ms, 204);
        assert_trade(arg0, v0.user);
        0x2::table::borrow_mut<u64, MarketingSellRequest>(&mut arg0.sell_requests, arg1).executed = true;
        v0
    }

    public fun rotate_yocash_migration_epoch(arg0: &MarketingLedger, arg1: &mut YoCashMigrationState, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_migration_state_for_ledger(arg0, arg1);
        let v0 = arg1.epoch;
        arg1.epoch = v0 + 1;
        let v1 = YoCashMigrationEpochRotated{
            state_id  : 0x2::object::id<YoCashMigrationState>(arg1),
            ledger_id : 0x2::object::id<MarketingLedger>(arg0),
            old_epoch : v0,
            new_epoch : arg1.epoch,
        };
        0x2::event::emit<YoCashMigrationEpochRotated>(v1);
    }

    public(friend) fun sell_request_data(arg0: MarketingSellRequest) : (address, u64, u64, 0x2::object::ID, 0x2::object::ID, u8, u64, u64, vector<u8>, u64, bool, bool) {
        (arg0.user, arg0.position_id, arg0.market_id, arg0.market_object_id, arg0.account_object_id, arg0.outcome, arg0.shares_in, arg0.min_total_yoso_out, arg0.maker_order_hash, arg0.expiry_ms, arg0.cancelled, arg0.executed)
    }

    public fun set_authorized_credit_creator(arg0: &mut MarketingLedger, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin_or_operator(arg0, arg3);
        let v0 = &mut arg0.authorized_credit_creators;
        set_bool(v0, arg1, arg2);
        let v1 = AuthorizedCreditCreatorUpdated{
            creator    : arg1,
            authorized : arg2,
        };
        0x2::event::emit<AuthorizedCreditCreatorUpdated>(v1);
    }

    public fun set_blacklisted(arg0: &mut MarketingLedger, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_admin_or_operator(arg0, arg3);
        borrow_user(arg0, arg1).blacklisted = arg2;
        if (arg2) {
            let v0 = Blacklisted{user: arg1};
            0x2::event::emit<Blacklisted>(v0);
        } else {
            let v1 = Unblacklisted{user: arg1};
            0x2::event::emit<Unblacklisted>(v1);
        };
    }

    fun set_bool(arg0: &mut 0x2::table::Table<address, bool>, arg1: address, arg2: bool) {
        if (0x2::table::contains<address, bool>(arg0, arg1)) {
            *0x2::table::borrow_mut<address, bool>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<address, bool>(arg0, arg1, arg2);
        };
    }

    public fun set_custody(arg0: &mut MarketingLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 201);
        arg0.custody = arg1;
        let v0 = CustodyUpdated{
            old_custody : arg0.custody,
            new_custody : arg1,
        };
        0x2::event::emit<CustodyUpdated>(v0);
    }

    public fun set_mixed_positions_paused(arg0: &mut MarketingLedger, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin_or_operator(arg0, arg2);
        arg0.mixed_positions_paused = arg1;
    }

    public fun set_operator(arg0: &mut MarketingLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0 && arg1 != arg0.custody, 201);
        arg0.operator = arg1;
        let v0 = OperatorUpdated{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public fun set_signer(arg0: &mut MarketingLedger, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.signer = arg1;
        let v0 = SignerUpdated{
            old_signer : arg0.signer,
            new_signer : arg1,
        };
        0x2::event::emit<SignerUpdated>(v0);
    }

    fun set_u64(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow_mut<u64, u64>(arg0, arg1) = arg2;
        } else {
            0x2::table::add<u64, u64>(arg0, arg1, arg2);
        };
    }

    fun settle_credit(arg0: &mut MarketingLedger, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg4) == arg3, 209);
        if (arg3 == 0) {
            0x2::coin::destroy_zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg4);
        } else {
            0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg4));
        };
        let v0 = borrow_user(arg0, arg1);
        v0.trial_balance = v0.trial_balance + arg3;
        if (arg3 > arg2) {
            let v1 = arg3 - arg2;
            v0.profit_to_claim = v0.profit_to_claim + v1;
            let v2 = ProfitToClaimAccrued{
                user                : arg1,
                amount              : v1,
                new_profit_to_claim : v0.profit_to_claim,
            };
            0x2::event::emit<ProfitToClaimAccrued>(v2);
        } else if (arg3 < arg2) {
            let v3 = min(v0.profit_to_claim, arg2 - arg3);
            if (v3 > 0) {
                v0.profit_to_claim = v0.profit_to_claim - v3;
                let v4 = ProfitToClaimSpent{
                    user                : arg1,
                    amount              : v3,
                    new_profit_to_claim : v0.profit_to_claim,
                };
                0x2::event::emit<ProfitToClaimSpent>(v4);
            };
        };
        assert_inv(v0);
    }

    fun split_cash_credit(arg0: &mut MarketingLedger, arg1: address, arg2: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg2);
        assert!(arg3 + arg4 == v0, 209);
        let (v1, v2) = if (arg3 == 0) {
            (0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg6), arg2)
        } else if (arg3 == v0) {
            (arg2, 0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg6))
        } else {
            (0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg2, arg3, arg6), arg2)
        };
        settle_credit(arg0, arg1, arg5, arg4, v2);
        v1
    }

    fun table_u64(arg0: &0x2::table::Table<u64, u64>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            *0x2::table::borrow<u64, u64>(arg0, arg1)
        } else {
            0
        }
    }

    public fun unpause(arg0: &mut MarketingLedger, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.paused = false;
    }

    public fun user_state_data(arg0: &MarketingLedger, arg1: address) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = get_user(arg0, arg1);
        (v0.trial_balance, v0.profit_to_claim, v0.total_withdrawn, v0.credit_owed, v0.total_credit_received, v0.user_nonce, v0.credit_tier_nonce, v0.admin_clawback, v0.blacklisted)
    }

    public fun withdraw_profit(arg0: &mut MarketingLedger, arg1: u64, arg2: u64, arg3: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_live_user(arg0, v0);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2, 204);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::verify_signature_message(arg3, arg0.signer, withdraw_profit_message(arg0, v0, arg1, arg2));
        let v1 = get_user(arg0, v0);
        let v2 = if (arg1 > v1.total_withdrawn) {
            arg1 - v1.total_withdrawn
        } else {
            0
        };
        let v3 = min(v1.profit_to_claim, v2);
        let v4 = v3;
        let v5 = 0x2::clock::timestamp_ms(arg4) / 86400000;
        let v6 = table_u64(&arg0.withdrawn_today, v5);
        if (arg0.withdraw_daily_cap > 0) {
            let v7 = if (arg0.withdraw_daily_cap > v6) {
                arg0.withdraw_daily_cap - v6
            } else {
                0
            };
            v4 = min(v3, v7);
        };
        if (v4 == 0) {
            let v8 = ProfitWithdrawn{
                user                : v0,
                cash_to_user        : 0,
                locked              : v1.profit_to_claim,
                new_total_withdrawn : v1.total_withdrawn,
            };
            0x2::event::emit<ProfitWithdrawn>(v8);
            return 0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg5)
        };
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_vault) >= v4, 206);
        let v9 = borrow_user(arg0, v0);
        v9.profit_to_claim = v9.profit_to_claim - v4;
        v9.trial_balance = v9.trial_balance - v4;
        v9.total_withdrawn = v9.total_withdrawn + v4;
        assert_inv(v9);
        let v10 = v9.total_withdrawn;
        let v11 = &mut arg0.withdrawn_today;
        set_u64(v11, v5, v6 + v4);
        let v12 = ProfitWithdrawn{
            user                : v0,
            cash_to_user        : v4,
            locked              : v9.profit_to_claim,
            new_total_withdrawn : v10,
        };
        0x2::event::emit<ProfitWithdrawn>(v12);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.yoso_vault, v4), arg5)
    }

    public fun withdraw_profit_message(arg0: &MarketingLedger, arg1: address, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = WithdrawProfitEnvelope{
            domain         : b"YOSO_MARKETING_WITHDRAW_V1",
            ledger_id      : 0x2::object::id<MarketingLedger>(arg0),
            user           : arg1,
            withdrawal_cap : arg2,
            expiry_ms      : arg3,
        };
        0x2::bcs::to_bytes<WithdrawProfitEnvelope>(&v0)
    }

    public fun yoso_vault_balance(arg0: &MarketingLedger) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.yoso_vault)
    }

    fun zero_user() : UserCreditState {
        UserCreditState{
            trial_balance         : 0,
            profit_to_claim       : 0,
            total_withdrawn       : 0,
            credit_owed           : 0,
            total_credit_received : 0,
            user_nonce            : 0,
            credit_tier_nonce     : 0,
            admin_clawback        : 0,
            blacklisted           : false,
        }
    }

    // decompiled from Move bytecode v7
}

