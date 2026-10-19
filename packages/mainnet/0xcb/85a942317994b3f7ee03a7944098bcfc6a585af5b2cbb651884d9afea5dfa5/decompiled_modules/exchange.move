module 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::exchange {
    struct OraclePolicy has drop, store {
        enabled: bool,
        publisher: address,
        max_age_ms: u64,
        paused: bool,
    }

    struct OracleConfiguredV1 has copy, drop {
        meta: Meta,
        publisher: address,
        max_age_ms: u64,
        paused: bool,
    }

    struct OracleRoundV1 has copy, drop {
        meta: Meta,
        publisher: address,
        prices: vector<u64>,
        source_times: vector<u64>,
        received_at: u64,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        exchange_id: 0x2::object::ID,
    }

    struct Account has copy, drop, store {
        owner: address,
        queued: u256,
        available: u64,
        rewards: u64,
        referral_rewards: u64,
        rekt: u64,
        staked: u64,
        pending: u64,
        referrer: address,
        ref_weight: u128,
        minted: u64,
        losses: u128,
        snapshot_epoch: u64,
        basis: EpochBasis,
    }

    struct AccountStore has store {
        rows: 0x2::table_vec::TableVec<Account>,
        cash: u64,
        tokens: u64,
        queued: u256,
        stake: u64,
        weight: u128,
    }

    struct Position has copy, drop, store {
        number: u64,
        owner: address,
        market: u64,
        long: bool,
        margin: u64,
        leverage: u64,
        entry: u64,
        debt: bool,
    }

    struct Claim has copy, drop, store {
        number: u64,
        owner: address,
        amount: u128,
    }

    struct ClaimSlice has copy, drop, store {
        number: u64,
        owner: address,
        amount: u64,
    }

    struct QueueNode has store {
        claim: Claim,
        reserved: u64,
        prev: u64,
        next: u64,
        owner_prev: u64,
        owner_next: u64,
    }

    struct ClaimQueue has store {
        account_indices: 0x2::table::Table<address, u64>,
        nodes: 0x2::table::Table<u64, QueueNode>,
        owners: 0x2::table::Table<address, u64>,
        owner_tails: 0x2::table::Table<address, u64>,
        tail: u64,
        total: u256,
    }

    struct EpochBasis has copy, drop, store {
        stake: u64,
        pending: u64,
        weight: u128,
    }

    struct EpochBatch has drop, store {
        active: bool,
        cursor: u64,
        account_count: u64,
        timestamp: u64,
        provision: u128,
        earnings: u256,
        available: u64,
        budget: u64,
        ref_room: u64,
        ref_budget: u64,
        div_budget: u64,
        fees: u64,
        total_stake: u64,
        total_weight: u128,
        paid_ref: u64,
        paid_div: u64,
        paid_fee: u64,
    }

    struct EpochStartedV1 has copy, drop {
        meta: Meta,
        budget: u64,
        fees: u64,
    }

    struct EpochBatchV1 has copy, drop {
        meta: Meta,
        cursor: u64,
        count: u64,
    }

    struct DelayedState has store {
        enabled: bool,
        last_tick: u64,
        next_order: u64,
        trade_ids: vector<u64>,
        orders: vector<DelayedOrder>,
    }

    struct DelayedOrder has copy, drop, store {
        number: u64,
        position: Position,
        closing: bool,
        submitted: u64,
        target: u64,
        deadline: u64,
        claims: vector<ClaimSlice>,
    }

    struct DelayedConfiguredV1 has copy, drop {
        meta: Meta,
        interval_ms: u64,
        delay_ms: u64,
        timeout_ms: u64,
    }

    struct OrderQueuedV1 has copy, drop {
        meta: Meta,
        order: DelayedOrder,
    }

    struct OrderResolvedV1 has copy, drop {
        meta: Meta,
        order: DelayedOrder,
        outcome: u8,
        head_after: u64,
    }

    struct LiquidationIntervalV1 has copy, drop {
        meta: Meta,
        position_id: u64,
        from_time: u64,
        to_time: u64,
        worst_price: u64,
    }

    struct DelayedRoundV1 has copy, drop {
        meta: Meta,
        tick: u64,
        prices: vector<u64>,
        times: vector<u64>,
        trade_ids: vector<u64>,
        lows: vector<u64>,
        highs: vector<u64>,
    }

    struct OperationState has store {
        package_version: u64,
        engine: EngineAccounting,
        epoch_batch: EpochBatch,
        sequence: u64,
        last_epoch_ms: u64,
        oracle: OraclePolicy,
        delayed: DelayedState,
    }

    struct EngineCap has store {
        exchange_id: 0x2::object::ID,
        generation: u64,
    }

    struct EngineCreditLockedV1 has copy, drop {
        meta: Meta,
        owner: address,
        frame: u64,
        amount: u64,
        locked_after: u64,
    }

    struct EngineFrameFinalizedV1 has copy, drop {
        meta: Meta,
        frame: u64,
    }

    struct CreditLock has store {
        frame: u64,
        amount: u64,
    }

    struct EngineAccounting has store {
        generation: u64,
        enabled: bool,
        cash: u64,
        debt: u64,
        applying: u64,
        finalized: u64,
        busy: bool,
        locks: 0x2::table::Table<address, CreditLock>,
    }

    struct Exchange<phantom T0> has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        pool: u64,
        fee_escrow: u64,
        dev_fees: u64,
        debt_locked: u64,
        accounts: AccountStore,
        positions: vector<Position>,
        claims: ClaimQueue,
        head: u64,
        prices: vector<u64>,
        price_times: vector<u64>,
        next_position: u64,
        next_claim: u64,
        epoch: u64,
        progress: u128,
        cash_progress: u128,
        debt_progress: u128,
        supply: u64,
        gains: u128,
        costs: u256,
        allocated: u128,
        ref_allocated: u128,
        dividend_bps: u64,
        ref_cap_bps: u64,
        ref_fee_bps: u64,
        cash_bonus_bps: u64,
        debt_bonus_bps: u64,
        reserve: u64,
        total_dividends: u128,
        total_referrals: u128,
        operation_state: OperationState,
    }

    struct Activity has copy, drop {
        kind: u8,
        owner: address,
        number: u64,
        amount: u128,
        tokens: u64,
    }

    struct Meta has copy, drop, store {
        exchange_id: 0x2::object::ID,
        schema_version: u16,
        protocol_epoch: u64,
        operation_id: u64,
    }

    struct Configuration has copy, drop, store {
        dividend_bps: u64,
        ref_cap_bps: u64,
        ref_fee_bps: u64,
        cash_bonus_bps: u64,
        debt_bonus_bps: u64,
        reserve: u64,
    }

    struct ExchangeCreatedV1 has copy, drop {
        meta: Meta,
        admin_cap: 0x2::object::ID,
        creator: address,
        config: Configuration,
        half: u64,
        decimals: u8,
        formula_version: u8,
        initial_prices: vector<u64>,
        collateral_type: 0x1::type_name::TypeName,
    }

    struct AccountCreatedV1 has copy, drop {
        meta: Meta,
        owner: address,
        via_deposit: bool,
    }

    struct ReferralBoundV1 has copy, drop {
        meta: Meta,
        owner: address,
        referrer: address,
    }

    struct DepositedV1 has copy, drop {
        meta: Meta,
        owner: address,
        amount: u64,
        available_after: u64,
    }

    struct WithdrawnV1 has copy, drop {
        meta: Meta,
        owner: address,
        amount: u64,
        coin_id: 0x2::object::ID,
        available_after: u64,
    }

    struct PoolFundedV1 has copy, drop {
        meta: Meta,
        funder: address,
        amount: u64,
        pool_after: u64,
    }

    struct PriceUpdatedV1 has copy, drop {
        meta: Meta,
        actor: address,
        cap_id: 0x2::object::ID,
        market: u64,
        old_price: u64,
        price: u64,
        old_timestamp: u64,
        timestamp: u64,
    }

    struct ConfigurationChangedV1 has copy, drop {
        meta: Meta,
        actor: address,
        cap_id: 0x2::object::ID,
        old: Configuration,
        new: Configuration,
    }

    struct PositionOpenedV1 has copy, drop {
        meta: Meta,
        position: Position,
        price_timestamp: u64,
        notional: u64,
    }

    struct ClaimConsumedV1 has copy, drop {
        meta: Meta,
        owner: address,
        claim_id: u64,
        position_id: u64,
        amount: u64,
        remaining: u128,
    }

    struct ClaimCreatedV1 has copy, drop {
        meta: Meta,
        owner: address,
        claim_id: u64,
        position_id: u64,
        principal: u64,
        profit: u128,
        amount: u128,
    }

    struct SettlementCreditedV1 has copy, drop {
        meta: Meta,
        owner: address,
        position_id: u64,
        principal: u64,
        profit: u64,
        amount: u64,
    }

    struct DebtCollateralReleasedV1 has copy, drop {
        meta: Meta,
        owner: address,
        position_id: u64,
        margin: u64,
        cancelled: u64,
        surviving: u64,
        locked_after: u64,
    }

    struct FeeAssessedV1 has copy, drop {
        meta: Meta,
        position_id: u64,
        profit_basis: bool,
        assessed: u128,
        funded: u64,
        staker: u64,
        developer: u64,
        skip_reason: u8,
    }

    struct EmissionSliceV1 has copy, drop {
        meta: Meta,
        position_id: u64,
        debt: bool,
        progress_before: u128,
        progress_after: u128,
        eligible_loss: u64,
        rate: u64,
        tokens: u64,
    }

    struct RektMintedV1 has copy, drop {
        meta: Meta,
        beneficiary: address,
        source_owner: address,
        position_id: u64,
        debt: bool,
        referral: bool,
        eligible_loss: u64,
        tokens: u64,
        bonus_bps: u64,
        pending_after: u64,
        supply_after: u64,
        effective_epoch: u64,
    }

    struct ReferralCashCreditedV1 has copy, drop {
        meta: Meta,
        owner: address,
        source_owner: address,
        position_id: u64,
        loss: u64,
        bps: u64,
        amount: u64,
        available_after: u64,
    }

    struct ReferralWeightAccruedV1 has copy, drop {
        meta: Meta,
        owner: address,
        source_owner: address,
        position_id: u64,
        paid_fee: u64,
        bps: u64,
        amount: u64,
        weight_after: u128,
    }

    struct PositionSettledV1 has copy, drop {
        meta: Meta,
        position: Position,
        executor: address,
        liquidation: bool,
        exit_price: u64,
        price_timestamp: u64,
        win: bool,
        hard_bust: bool,
        quoted_value: u128,
        net_profit: u128,
        realized_loss: u64,
        eligible_loss: u64,
        tokens: u64,
    }

    struct ClaimPaidV1 has copy, drop {
        meta: Meta,
        owner: address,
        claim_id: u64,
        amount: u64,
        remaining: u128,
        from_epoch: bool,
    }

    struct QueueHarvestedV1 has copy, drop {
        meta: Meta,
        requested: u64,
        visited: u64,
        paid_claims: u64,
        total_paid: u64,
        head_before: u64,
        head_after: u64,
        stop_reason: u8,
        from_epoch: bool,
    }

    struct StakeQueuedV1 has copy, drop {
        meta: Meta,
        owner: address,
        amount: u64,
        pending_after: u64,
        effective_epoch: u64,
    }

    struct UnstakedV1 has copy, drop {
        meta: Meta,
        owner: address,
        from_pending: u64,
        from_active: u64,
        liquid_after: u64,
        pending_after: u64,
        active_after: u64,
    }

    struct RewardsClaimedV1 has copy, drop {
        meta: Meta,
        owner: address,
        rewards: u64,
        referral_rewards: u64,
        available_after: u64,
    }

    struct RewardsAccruedV1 has copy, drop {
        meta: Meta,
        owner: address,
        active_basis: u64,
        weight_basis: u128,
        fee_dividend: u64,
        extra_dividend: u64,
        referral_cash: u64,
        rewards_after: u64,
        referral_after: u64,
    }

    struct ReferralWeightExpiredV1 has copy, drop {
        meta: Meta,
        owner: address,
        weight: u128,
        cash_awarded: u64,
    }

    struct StakeActivatedV1 has copy, drop {
        meta: Meta,
        owner: address,
        amount: u64,
        active_after: u64,
        effective_epoch: u64,
    }

    struct EpochSettledV1 has copy, drop {
        meta: Meta,
        old_epoch: u64,
        new_epoch: u64,
        timestamp: u64,
        provision: u128,
        earnings: u256,
        available: u64,
        budget: u64,
        ref_room: u64,
        ref_budget: u64,
        div_budget: u64,
        total_stake: u64,
        total_weight: u128,
        paid_ref: u64,
        paid_div: u64,
        paid_fee: u64,
        retained_budget: u64,
    }

    struct TreasurySnapshotV1 has copy, drop {
        meta: Meta,
        head: u64,
        epoch_escrow: u64,
        vault: u64,
        pool: u64,
        fee_escrow: u64,
        dev_fees: u64,
        debt_locked: u64,
        queue: u256,
        progress: u128,
        cash_progress: u128,
        debt_progress: u128,
        supply: u64,
        gains: u128,
        costs: u256,
        allocated: u128,
        ref_allocated: u128,
        total_dividends: u128,
        total_referrals: u128,
    }

    struct EngineGenerationChangedV1 has copy, drop {
        meta: Meta,
        generation: u64,
        finalized: u64,
    }

    struct DeveloperFeesWithdrawnV1 has copy, drop {
        meta: Meta,
        recipient: address,
        amount: u64,
        remaining: u64,
    }

    fun account<T0>(arg0: &Exchange<T0>, arg1: address) : u64 {
        assert!(0x2::table::contains<address, u64>(&arg0.claims.account_indices, arg1), 1);
        *0x2::table::borrow<address, u64>(&arg0.claims.account_indices, arg1)
    }

    public fun account_count<T0>(arg0: &Exchange<T0>) : u64 {
        assert!(arg0.operation_state.package_version == 1, 900);
        0x2::table_vec::length<Account>(&arg0.accounts.rows)
    }

    public fun accounts_page<T0>(arg0: &Exchange<T0>, arg1: u64, arg2: u64) : vector<Account> {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(arg2 > 0 && arg2 <= 16, 6);
        let v0 = 0x1::vector::empty<Account>();
        while (arg1 < 0x2::table_vec::length<Account>(&arg0.accounts.rows) && 0x1::vector::length<Account>(&v0) < arg2) {
            0x1::vector::push_back<Account>(&mut v0, *0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun advance_epoch<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(!arg1.operation_state.engine.enabled, 11);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        assert!(!arg1.operation_state.epoch_batch.active, 10);
        begin<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.operation_state.last_epoch_ms + 1000, 10);
        if (arg1.operation_state.delayed.enabled) {
            assert!(0x1::vector::is_empty<DelayedOrder>(&arg1.operation_state.delayed.orders) && (0x1::vector::is_empty<Position>(&arg1.positions) || v0 < arg1.operation_state.delayed.last_tick + 1000), 11);
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<Position>(&arg1.positions)) {
            fresh<T0>(arg1, 0x1::vector::borrow<Position>(&arg1.positions, v1).market, arg2);
            v1 = v1 + 1;
        };
        let v2 = open_profits<T0>(arg1);
        start_epoch<T0>(arg1, v2, v0);
    }

    fun begin<T0>(arg0: &mut Exchange<T0>) {
        arg0.operation_state.sequence = arg0.operation_state.sequence + 1;
    }

    fun cash_limit(arg0: u256, arg1: u64) : u64 {
        let v0 = if (arg0 < (arg1 as u256)) {
            arg0
        } else {
            (arg1 as u256)
        };
        (v0 as u64)
    }

    public fun check<T0>(arg0: &Exchange<T0>) {
        assert!(arg0.operation_state.package_version == 1, 900);
        let v0 = &arg0.operation_state.epoch_batch;
        let v1 = if (v0.active) {
            v0.budget + v0.fees - v0.paid_ref - v0.paid_div - v0.paid_fee
        } else {
            0
        };
        let v2 = arg0.pool + arg0.fee_escrow + arg0.dev_fees + v1 + arg0.accounts.cash + arg0.operation_state.engine.cash;
        let v3 = 0;
        let v4 = arg0.operation_state.engine.debt;
        while (v3 < 0x1::vector::length<Position>(&arg0.positions)) {
            let v5 = 0x1::vector::borrow<Position>(&arg0.positions, v3);
            if (!v5.debt) {
                v2 = v2 + v5.margin;
            } else {
                v4 = v4 + v5.margin;
            };
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders)) {
            let v6 = 0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v3);
            if (!v6.closing) {
                if (v6.position.debt) {
                    v4 = v4 + v6.position.margin;
                } else {
                    v2 = v2 + v6.position.margin;
                };
            };
            v3 = v3 + 1;
        };
        let v7 = if (v2 == 0x2::balance::value<T0>(&arg0.vault)) {
            if (arg0.accounts.tokens == arg0.supply) {
                if (v4 == arg0.debt_locked) {
                    arg0.accounts.queued == arg0.claims.total
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 9);
    }

    fun claim_cash(arg0: u128, arg1: u64) : u64 {
        let v0 = if (arg0 < (arg1 as u128)) {
            arg0
        } else {
            (arg1 as u128)
        };
        (v0 as u64)
    }

    public fun claim_rewards<T0>(arg0: &mut Exchange<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.busy, 11);
        begin<T0>(arg0);
        let v0 = account<T0>(arg0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rewards + 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).referral_rewards;
        let v2 = RewardsClaimedV1{
            meta             : meta<T0>(arg0),
            owner            : 0x2::tx_context::sender(arg1),
            rewards          : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rewards,
            referral_rewards : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).referral_rewards,
            available_after  : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).available + v1,
        };
        0x2::event::emit<RewardsClaimedV1>(v2);
        set_rewards<T0>(0, arg0, v0);
        set_referral_rewards<T0>(0, arg0, v0);
        let v3 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).available + v1;
        set_available<T0>(v3, arg0, v0);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public fun close<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        settle<T0>(arg0, arg1, false, arg2, arg3);
    }

    fun config<T0>(arg0: &Exchange<T0>) : Configuration {
        Configuration{
            dividend_bps   : arg0.dividend_bps,
            ref_cap_bps    : arg0.ref_cap_bps,
            ref_fee_bps    : arg0.ref_fee_bps,
            cash_bonus_bps : arg0.cash_bonus_bps,
            debt_bonus_bps : arg0.debt_bonus_bps,
            reserve        : arg0.reserve,
        }
    }

    public fun configure<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(!arg1.operation_state.engine.enabled, 11);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        begin<T0>(arg1);
        let v0 = if (arg2 <= 3000) {
            if (arg3 <= arg2) {
                if (arg4 <= 10000) {
                    if (arg5 <= 2000) {
                        arg6 <= 2000
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
        assert!(v0, 6);
        arg1.dividend_bps = arg2;
        arg1.ref_cap_bps = arg3;
        arg1.ref_fee_bps = arg4;
        arg1.cash_bonus_bps = arg5;
        arg1.debt_bonus_bps = arg6;
        arg1.reserve = arg7;
        let v1 = ConfigurationChangedV1{
            meta   : meta<T0>(arg1),
            actor  : 0x2::tx_context::sender(arg8),
            cap_id : 0x2::object::id<AdminCap<T0>>(arg0),
            old    : config<T0>(arg1),
            new    : config<T0>(arg1),
        };
        0x2::event::emit<ConfigurationChangedV1>(v1);
    }

    public fun configure_oracle<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: address, arg3: u64, arg4: bool) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(!arg1.operation_state.engine.enabled, 11);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        let v0 = if (arg2 != @0x0) {
            if (arg3 >= 250) {
                arg3 <= 2000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        if (!arg1.operation_state.oracle.enabled) {
            assert!(0x1::vector::is_empty<Position>(&arg1.positions), 5);
        };
        begin<T0>(arg1);
        let v1 = OraclePolicy{
            enabled    : true,
            publisher  : arg2,
            max_age_ms : arg3,
            paused     : arg4,
        };
        arg1.operation_state.oracle = v1;
        if (!arg1.operation_state.delayed.enabled) {
            arg1.price_times = vector[0, 0];
        };
        let v2 = OracleConfiguredV1{
            meta       : meta<T0>(arg1),
            publisher  : arg2,
            max_age_ms : arg3,
            paused     : arg4,
        };
        0x2::event::emit<OracleConfiguredV1>(v2);
    }

    fun consume_claims<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: u64) {
        take_claims<T0>(arg0, arg1, arg2, false, arg3);
    }

    public fun create<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        validate_decimals(0x2::coin::get_decimals<T0>(arg0));
        create_inner<T0>(arg1);
    }

    fun create_inner<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap<T0>{
            id          : 0x2::object::new(arg0),
            exchange_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::transfer<AdminCap<T0>>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AccountStore{
            rows   : 0x2::table_vec::empty<Account>(arg0),
            cash   : 0,
            tokens : 0,
            queued : 0,
            stake  : 0,
            weight : 0,
        };
        let v3 = ClaimQueue{
            account_indices : 0x2::table::new<address, u64>(arg0),
            nodes           : 0x2::table::new<u64, QueueNode>(arg0),
            owners          : 0x2::table::new<address, u64>(arg0),
            owner_tails     : 0x2::table::new<address, u64>(arg0),
            tail            : 0,
            total           : 0,
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, 100000 * 1000000);
        0x1::vector::push_back<u64>(v5, 3000 * 1000000);
        let v6 = EngineAccounting{
            generation : 0,
            enabled    : false,
            cash       : 0,
            debt       : 0,
            applying   : 0,
            finalized  : 0,
            busy       : false,
            locks      : 0x2::table::new<address, CreditLock>(arg0),
        };
        let v7 = OraclePolicy{
            enabled    : false,
            publisher  : @0x0,
            max_age_ms : 2000,
            paused     : false,
        };
        let v8 = DelayedState{
            enabled    : false,
            last_tick  : 0,
            next_order : 1,
            trade_ids  : vector[0, 0],
            orders     : 0x1::vector::empty<DelayedOrder>(),
        };
        let v9 = OperationState{
            package_version : 1,
            engine          : v6,
            epoch_batch     : empty_epoch(),
            sequence        : 0,
            last_epoch_ms   : 0,
            oracle          : v7,
            delayed         : v8,
        };
        let v10 = Exchange<T0>{
            id              : v0,
            vault           : 0x2::balance::zero<T0>(),
            pool            : 0,
            fee_escrow      : 0,
            dev_fees        : 0,
            debt_locked     : 0,
            accounts        : v2,
            positions       : 0x1::vector::empty<Position>(),
            claims          : v3,
            head            : 0,
            prices          : v4,
            price_times     : vector[0, 0],
            next_position   : 1,
            next_claim      : 1,
            epoch           : 0,
            progress        : 0,
            cash_progress   : 0,
            debt_progress   : 0,
            supply          : 0,
            gains           : 0,
            costs           : 0,
            allocated       : 0,
            ref_allocated   : 0,
            dividend_bps    : 1000,
            ref_cap_bps     : 100,
            ref_fee_bps     : 2000,
            cash_bonus_bps  : 2000,
            debt_bonus_bps  : 0,
            reserve         : 50000 * 1000000,
            total_dividends : 0,
            total_referrals : 0,
            operation_state : v9,
        };
        let v11 = ExchangeCreatedV1{
            meta            : meta<T0>(&v10),
            admin_cap       : 0x2::object::id<AdminCap<T0>>(&v1),
            creator         : 0x2::tx_context::sender(arg0),
            config          : config<T0>(&v10),
            half            : 10000000000000,
            decimals        : 6,
            formula_version : 1,
            initial_prices  : v10.prices,
            collateral_type : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<ExchangeCreatedV1>(v11);
        snapshot<T0>(&v10);
        0x2::transfer::share_object<Exchange<T0>>(v10);
    }

    fun credit<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = arg3 + arg4;
        if (v0 == 0) {
            return
        };
        let v1 = account<T0>(arg0, arg1);
        let v2 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v1).available + v0;
        set_available<T0>(v2, arg0, v1);
        let v3 = SettlementCreditedV1{
            meta        : meta<T0>(arg0),
            owner       : arg1,
            position_id : arg2,
            principal   : arg3,
            profit      : arg4,
            amount      : v0,
        };
        0x2::event::emit<SettlementCreditedV1>(v3);
    }

    fun credit_cash_referral<T0>(arg0: &mut Exchange<T0>, arg1: &Position, arg2: u64, arg3: bool) {
        let v0 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, account<T0>(arg0, arg1.owner)).referrer;
        let v1 = if (arg1.debt) {
            true
        } else if (!arg3) {
            true
        } else {
            v0 == @0x0
        };
        if (v1) {
            return
        };
        let v2 = mul(arg2, 500, 10000);
        let v3 = account<T0>(arg0, v0);
        arg0.pool = arg0.pool - v2;
        let v4 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v3).available + v2;
        set_available<T0>(v4, arg0, v3);
        arg0.costs = arg0.costs + (v2 as u256);
        arg0.total_referrals = arg0.total_referrals + (v2 as u128);
        let v5 = ReferralCashCreditedV1{
            meta            : meta<T0>(arg0),
            owner           : v0,
            source_owner    : arg1.owner,
            position_id     : arg1.number,
            loss            : arg2,
            bps             : 500,
            amount          : v2,
            available_after : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v3).available,
        };
        0x2::event::emit<ReferralCashCreditedV1>(v5);
    }

    public fun deposit<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        begin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = ensure<T0>(arg0, 0x2::tx_context::sender(arg2), true);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v2 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v1).available + v0;
        set_available<T0>(v2, arg0, v1);
        let v3 = DepositedV1{
            meta            : meta<T0>(arg0),
            owner           : 0x2::tx_context::sender(arg2),
            amount          : v0,
            available_after : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v1).available,
        };
        0x2::event::emit<DepositedV1>(v3);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    fun effective_epoch<T0>(arg0: &Exchange<T0>) : u64 {
        let v0 = if (arg0.operation_state.epoch_batch.active) {
            2
        } else {
            1
        };
        arg0.epoch + v0
    }

    public fun emission(arg0: u128, arg1: u64) : (u64, u128) {
        let v0 = arg0;
        let v1 = 0;
        while (arg1 > 0) {
            let v2 = v0 / (10000000000000 as u128);
            let v3 = claim_cash((10000000000000 as u128) - v0 % (10000000000000 as u128), arg1);
            let v4 = if (v2 >= 40) {
                0
            } else {
                100000000 >> (v2 as u8)
            };
            v1 = v1 + mul(v3, v4, 1000000);
            v0 = v0 + (v3 as u128);
            arg1 = arg1 - v3;
        };
        (v1, v0)
    }

    fun empty_epoch() : EpochBatch {
        EpochBatch{
            active        : false,
            cursor        : 0,
            account_count : 0,
            timestamp     : 0,
            provision     : 0,
            earnings      : 0,
            available     : 0,
            budget        : 0,
            ref_room      : 0,
            ref_budget    : 0,
            div_budget    : 0,
            fees          : 0,
            total_stake   : 0,
            total_weight  : 0,
            paid_ref      : 0,
            paid_div      : 0,
            paid_fee      : 0,
        }
    }

    public fun enable_delayed<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        let v0 = if (arg1.operation_state.oracle.enabled) {
            if (!arg1.operation_state.delayed.enabled) {
                0x1::vector::is_empty<Position>(&arg1.positions)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        begin<T0>(arg1);
        arg1.operation_state.delayed.enabled = true;
        let v1 = DelayedConfiguredV1{
            meta        : meta<T0>(arg1),
            interval_ms : 1000,
            delay_ms    : 800,
            timeout_ms  : 30000,
        };
        0x2::event::emit<DelayedConfiguredV1>(v1);
        snapshot<T0>(arg1);
    }

    public(friend) fun engine_admin<T0>(arg0: &AdminCap<T0>, arg1: &Exchange<T0>) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
    }

    fun engine_auth<T0>(arg0: &EngineCap, arg1: &Exchange<T0>) {
        let v0 = if (arg1.operation_state.engine.enabled) {
            if (arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1)) {
                arg0.generation == arg1.operation_state.engine.generation
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun engine_available<T0>(arg0: &Exchange<T0>, arg1: address) : u64 {
        assert!(arg0.operation_state.package_version == 1, 900);
        let v0 = 0;
        if (0x2::table::contains<address, CreditLock>(&arg0.operation_state.engine.locks, arg1)) {
            let v1 = 0x2::table::borrow<address, CreditLock>(&arg0.operation_state.engine.locks, arg1);
            if (v1.frame > arg0.operation_state.engine.finalized) {
                v0 = v1.amount;
            };
        };
        0x2::table_vec::borrow<Account>(&arg0.accounts.rows, account<T0>(arg0, arg1)).available - v0
    }

    public(friend) fun engine_begin<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u64) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        assert!(!arg1.operation_state.engine.busy && arg2 == arg1.operation_state.engine.finalized + 1, 12);
        arg1.operation_state.engine.busy = true;
    }

    public(friend) fun engine_dividend_config<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        let v0 = if (arg1.operation_state.engine.enabled) {
            if (!arg1.operation_state.engine.busy) {
                !arg1.operation_state.epoch_batch.active
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        assert!(arg2 <= 3000, 6);
        begin<T0>(arg1);
        arg1.dividend_bps = arg2;
        arg1.reserve = arg3;
        let v1 = ConfigurationChangedV1{
            meta   : meta<T0>(arg1),
            actor  : 0x2::tx_context::sender(arg4),
            cap_id : 0x2::object::id<AdminCap<T0>>(arg0),
            old    : config<T0>(arg1),
            new    : config<T0>(arg1),
        };
        0x2::event::emit<ConfigurationChangedV1>(v1);
    }

    public(friend) fun engine_emergency_finish<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u64) {
        assert!(arg1.operation_state.package_version == 1, 900);
        let v0 = if (arg1.operation_state.engine.cash == 0) {
            if (arg1.operation_state.engine.debt == 0) {
                arg1.debt_locked == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 12);
        engine_finish<T0>(arg0, arg1, arg2);
    }

    public(friend) fun engine_emergency_refund<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: Position, arg3: vector<ClaimSlice>, arg4: u64) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(arg1.operation_state.engine.busy && arg4 == arg1.operation_state.engine.finalized + 1, 12);
        arg1.operation_state.engine.applying = arg4;
        engine_refund<T0>(arg0, arg1, arg2, arg3);
        arg1.operation_state.engine.applying = 0;
    }

    public(friend) fun engine_enable<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>) : EngineCap {
        assert!(arg1.operation_state.package_version == 1, 900);
        let v0 = if (arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1)) {
            if (!arg1.operation_state.engine.enabled) {
                if (!arg1.operation_state.oracle.enabled) {
                    if (!arg1.operation_state.epoch_batch.active) {
                        if (arg1.next_position == 1) {
                            if (0x1::vector::is_empty<Position>(&arg1.positions)) {
                                0x1::vector::is_empty<DelayedOrder>(&arg1.operation_state.delayed.orders)
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
        assert!(v0, 1);
        arg1.operation_state.engine.enabled = true;
        arg1.operation_state.engine.generation = 1;
        EngineCap{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg1),
            generation  : 1,
        }
    }

    public(friend) fun engine_epoch<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u128, arg3: u64) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        let v0 = if (!arg1.operation_state.engine.busy) {
            if (!arg1.operation_state.epoch_batch.active) {
                arg3 >= arg1.operation_state.last_epoch_ms + 1000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        begin<T0>(arg1);
        start_epoch<T0>(arg1, arg2, arg3);
    }

    public(friend) fun engine_fill<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: Position, arg3: vector<ClaimSlice>, arg4: u64, arg5: u64) : Position {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        assert!(arg4 > 0 && arg4 <= 1000000000 * 1000000, 4);
        begin<T0>(arg1);
        release_slices<T0>(arg1, arg3, false);
        arg2.entry = arg4;
        let v0 = PositionOpenedV1{
            meta            : meta<T0>(arg1),
            position        : arg2,
            price_timestamp : arg5,
            notional        : arg2.margin * arg2.leverage,
        };
        0x2::event::emit<PositionOpenedV1>(v0);
        arg2
    }

    public(friend) fun engine_finish<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u64) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        assert!(arg1.operation_state.engine.busy && arg2 == arg1.operation_state.engine.finalized + 1, 12);
        begin<T0>(arg1);
        arg1.operation_state.engine.finalized = arg2;
        arg1.operation_state.engine.busy = false;
        check<T0>(arg1);
        let v0 = EngineFrameFinalizedV1{
            meta  : meta<T0>(arg1),
            frame : arg2,
        };
        0x2::event::emit<EngineFrameFinalizedV1>(v0);
        snapshot<T0>(arg1);
    }

    public(friend) fun engine_handoff<T0>(arg0: &AdminCap<T0>, arg1: &EngineCap, arg2: &mut Exchange<T0>) : EngineCap {
        assert!(arg2.operation_state.package_version == 1, 900);
        engine_admin<T0>(arg0, arg2);
        engine_auth<T0>(arg1, arg2);
        let v0 = if (!arg2.operation_state.engine.busy) {
            if (!arg2.operation_state.epoch_batch.active) {
                if (arg2.operation_state.engine.cash == 0) {
                    arg2.operation_state.engine.debt == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        begin<T0>(arg2);
        arg2.operation_state.engine.generation = arg2.operation_state.engine.generation + 1;
        let v1 = arg2.operation_state.engine.generation;
        let v2 = EngineGenerationChangedV1{
            meta       : meta<T0>(arg2),
            generation : v1,
            finalized  : arg2.operation_state.engine.finalized,
        };
        0x2::event::emit<EngineGenerationChangedV1>(v2);
        check<T0>(arg2);
        snapshot<T0>(arg2);
        EngineCap{
            exchange_id : 0x2::object::id<Exchange<T0>>(arg2),
            generation  : v1,
        }
    }

    public(friend) fun engine_lock<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::tx_context::TxContext) : (Position, vector<ClaimSlice>) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_lock_for<T0>(arg0, arg1, 0x2::tx_context::sender(arg7), arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun engine_lock_for<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: address, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: bool) : (Position, vector<ClaimSlice>) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        assert!(!arg1.operation_state.engine.busy, 11);
        let v0 = if (arg3 < 2) {
            if (arg5 >= 1000000) {
                if (arg6 >= 10) {
                    if (arg6 <= 1000) {
                        (arg5 as u128) * (arg6 as u128) <= 10000000 * (1000000 as u128)
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
        assert!(v0, 2);
        begin<T0>(arg1);
        let v1 = account<T0>(arg1, arg2);
        let v2 = arg1.next_position;
        arg1.next_position = v2 + 1;
        let v3 = 0x1::vector::empty<ClaimSlice>();
        if (arg7) {
            v3 = take_claims<T0>(arg1, arg2, arg5, true, v2);
            arg1.operation_state.engine.debt = arg1.operation_state.engine.debt + arg5;
        } else {
            assert!(engine_available<T0>(arg1, arg2) >= arg5, 3);
            let v4 = 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, v1).available - arg5;
            set_available<T0>(v4, arg1, v1);
            arg1.operation_state.engine.cash = arg1.operation_state.engine.cash + arg5;
        };
        check<T0>(arg1);
        let v5 = Position{
            number   : v2,
            owner    : arg2,
            market   : arg3,
            long     : arg4,
            margin   : arg5,
            leverage : arg6,
            entry    : 0,
            debt     : arg7,
        };
        (v5, v3)
    }

    public(friend) fun engine_order_event<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: u64, arg3: Position, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: vector<ClaimSlice>, arg9: u8) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        if (arg9 == 255 && arg4) {
            begin<T0>(arg1);
        };
        let v0 = DelayedOrder{
            number    : arg2,
            position  : arg3,
            closing   : arg4,
            submitted : arg5,
            target    : arg6,
            deadline  : arg7,
            claims    : arg8,
        };
        if (arg9 == 255) {
            let v1 = OrderQueuedV1{
                meta  : meta<T0>(arg1),
                order : v0,
            };
            0x2::event::emit<OrderQueuedV1>(v1);
        } else {
            let v2 = OrderResolvedV1{
                meta       : meta<T0>(arg1),
                order      : v0,
                outcome    : arg9,
                head_after : arg1.head,
            };
            0x2::event::emit<OrderResolvedV1>(v2);
        };
        snapshot<T0>(arg1);
    }

    public(friend) fun engine_refund<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: Position, arg3: vector<ClaimSlice>) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        begin<T0>(arg1);
        if (arg2.debt) {
            arg1.operation_state.engine.debt = arg1.operation_state.engine.debt - arg2.margin;
            arg1.debt_locked = arg1.debt_locked - arg2.margin;
            release_slices<T0>(arg1, arg3, true);
        } else {
            arg1.operation_state.engine.cash = arg1.operation_state.engine.cash - arg2.margin;
            let v0 = account<T0>(arg1, arg2.owner);
            let v1 = 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, v0).available + arg2.margin;
            set_available<T0>(v1, arg1, v0);
        };
        check<T0>(arg1);
    }

    public(friend) fun engine_settle<T0>(arg0: &EngineCap, arg1: &mut Exchange<T0>, arg2: Position, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: address) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_auth<T0>(arg0, arg1);
        let v0 = if (arg1.operation_state.engine.busy) {
            if (0x1::vector::is_empty<Position>(&arg1.positions)) {
                arg6 == arg1.operation_state.engine.finalized + 1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 12);
        assert!(arg3 > 0 && arg3 <= 1000000000 * 1000000, 4);
        assert!(!arg5 || hard_bust(&arg2, arg3), 8);
        begin<T0>(arg1);
        if (arg2.debt) {
            arg1.operation_state.engine.debt = arg1.operation_state.engine.debt - arg2.margin;
        } else {
            arg1.operation_state.engine.cash = arg1.operation_state.engine.cash - arg2.margin;
        };
        arg1.operation_state.engine.applying = arg6;
        0x1::vector::push_back<Position>(&mut arg1.positions, arg2);
        settle_at<T0>(arg1, 0, arg3, arg4, arg5, arg7);
        arg1.operation_state.engine.applying = 0;
        check<T0>(arg1);
        snapshot<T0>(arg1);
    }

    fun enqueue<T0>(arg0: &mut Exchange<T0>, arg1: Position, arg2: bool, arg3: vector<ClaimSlice>, arg4: &0x2::clock::Clock) {
        let v0 = arg0.operation_state.delayed.next_order;
        arg0.operation_state.delayed.next_order = v0 + 1;
        let v1 = target_tick(arg4);
        let v2 = DelayedOrder{
            number    : v0,
            position  : arg1,
            closing   : arg2,
            submitted : 0x2::clock::timestamp_ms(arg4),
            target    : v1,
            deadline  : v1 + 30000,
            claims    : arg3,
        };
        0x1::vector::push_back<DelayedOrder>(&mut arg0.operation_state.delayed.orders, v2);
        let v3 = OrderQueuedV1{
            meta  : meta<T0>(arg0),
            order : v2,
        };
        0x2::event::emit<OrderQueuedV1>(v3);
    }

    fun ensure<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: bool) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claims.account_indices, arg1)) {
            return *0x2::table::borrow<address, u64>(&arg0.claims.account_indices, arg1)
        };
        let v0 = 0x2::table_vec::length<Account>(&arg0.accounts.rows);
        0x2::table::add<address, u64>(&mut arg0.claims.account_indices, arg1, v0);
        let v1 = EpochBasis{
            stake   : 0,
            pending : 0,
            weight  : 0,
        };
        let v2 = Account{
            owner            : arg1,
            queued           : 0,
            available        : 0,
            rewards          : 0,
            referral_rewards : 0,
            rekt             : 0,
            staked           : 0,
            pending          : 0,
            referrer         : @0x0,
            ref_weight       : 0,
            minted           : 0,
            losses           : 0,
            snapshot_epoch   : 0,
            basis            : v1,
        };
        0x2::table_vec::push_back<Account>(&mut arg0.accounts.rows, v2);
        let v3 = AccountCreatedV1{
            meta        : meta<T0>(arg0),
            owner       : arg1,
            via_deposit : arg2,
        };
        0x2::event::emit<AccountCreatedV1>(v3);
        v0
    }

    fun epoch_basis<T0>(arg0: &Exchange<T0>, arg1: u64) : EpochBasis {
        let v0 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1);
        if (v0.snapshot_epoch == arg0.epoch + 1) {
            v0.basis
        } else {
            EpochBasis{stake: v0.staked, pending: v0.pending, weight: v0.ref_weight}
        }
    }

    fun epoch_escrow<T0>(arg0: &Exchange<T0>) : u64 {
        let v0 = &arg0.operation_state.epoch_batch;
        if (v0.active) {
            v0.budget + v0.fees - v0.paid_ref - v0.paid_div - v0.paid_fee
        } else {
            0
        }
    }

    public fun execute_round<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.enabled, 11);
        let v0 = if (arg0.operation_state.delayed.enabled) {
            if (!arg0.operation_state.oracle.paused) {
                0x2::tx_context::sender(arg8) == arg0.operation_state.oracle.publisher
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = if (arg1 > arg0.operation_state.delayed.last_tick) {
            if (arg1 % 1000 == 0) {
                0x2::clock::timestamp_ms(arg7) >= arg1 + 250
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 12);
        let v2 = if (0x1::vector::length<u64>(&arg2) == 2) {
            if (0x1::vector::length<u64>(&arg3) == 2) {
                if (0x1::vector::length<u64>(&arg4) == 2) {
                    if (0x1::vector::length<u64>(&arg5) == 2) {
                        0x1::vector::length<u64>(&arg6) == 2
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
        assert!(v2, 12);
        if (!0x1::vector::is_empty<Position>(&arg0.positions)) {
            assert!(arg1 == arg0.operation_state.delayed.last_tick + 1000, 12);
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders)) {
            let v4 = 0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v3);
            let v5 = if (v4.closing) {
                true
            } else if (arg1 <= v4.target) {
                true
            } else {
                0x2::clock::timestamp_ms(arg7) > v4.deadline
            };
            assert!(v5, 12);
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 2) {
            let v6 = if (*0x1::vector::borrow<u64>(&arg2, v3) > 0) {
                if (*0x1::vector::borrow<u64>(&arg2, v3) <= 1000000000 * 1000000) {
                    if (*0x1::vector::borrow<u64>(&arg5, v3) > 0) {
                        if (*0x1::vector::borrow<u64>(&arg5, v3) <= *0x1::vector::borrow<u64>(&arg2, v3)) {
                            if (*0x1::vector::borrow<u64>(&arg6, v3) >= *0x1::vector::borrow<u64>(&arg2, v3)) {
                                *0x1::vector::borrow<u64>(&arg6, v3) <= 1000000000 * 1000000
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
            assert!(v6, 12);
            let v7 = if (*0x1::vector::borrow<u64>(&arg3, v3) > 0) {
                if (*0x1::vector::borrow<u64>(&arg3, v3) <= arg1) {
                    if (*0x1::vector::borrow<u64>(&arg4, v3) > 0) {
                        *0x1::vector::borrow<u64>(&arg4, v3) >= *0x1::vector::borrow<u64>(&arg0.operation_state.delayed.trade_ids, v3)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 12);
            if (*0x1::vector::borrow<u64>(&arg4, v3) == *0x1::vector::borrow<u64>(&arg0.operation_state.delayed.trade_ids, v3)) {
                let v8 = if (*0x1::vector::borrow<u64>(&arg3, v3) == *0x1::vector::borrow<u64>(&arg0.price_times, v3)) {
                    if (*0x1::vector::borrow<u64>(&arg2, v3) == *0x1::vector::borrow<u64>(&arg0.prices, v3)) {
                        if (*0x1::vector::borrow<u64>(&arg5, v3) == *0x1::vector::borrow<u64>(&arg2, v3)) {
                            *0x1::vector::borrow<u64>(&arg6, v3) == *0x1::vector::borrow<u64>(&arg2, v3)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v8, 12);
            } else {
                assert!(arg0.operation_state.delayed.last_tick == 0 || *0x1::vector::borrow<u64>(&arg3, v3) >= *0x1::vector::borrow<u64>(&arg0.price_times, v3), 12);
            };
            if (!0x1::vector::is_empty<Position>(&arg0.positions)) {
                assert!(*0x1::vector::borrow<u64>(&arg5, v3) <= *0x1::vector::borrow<u64>(&arg0.prices, v3) && *0x1::vector::borrow<u64>(&arg6, v3) >= *0x1::vector::borrow<u64>(&arg0.prices, v3), 12);
            };
            v3 = v3 + 1;
        };
        let v9 = arg0.price_times;
        begin<T0>(arg0);
        arg0.prices = arg2;
        arg0.price_times = arg3;
        arg0.operation_state.delayed.trade_ids = arg4;
        arg0.operation_state.delayed.last_tick = arg1;
        let v10 = DelayedRoundV1{
            meta      : meta<T0>(arg0),
            tick      : arg1,
            prices    : arg2,
            times     : arg3,
            trade_ids : arg4,
            lows      : arg5,
            highs     : arg6,
        };
        0x2::event::emit<DelayedRoundV1>(v10);
        v3 = 0;
        while (v3 < 0x1::vector::length<Position>(&arg0.positions)) {
            let v11 = *0x1::vector::borrow<Position>(&arg0.positions, v3);
            let v12 = if (v11.long) {
                *0x1::vector::borrow<u64>(&arg5, v11.market)
            } else {
                *0x1::vector::borrow<u64>(&arg6, v11.market)
            };
            if (hard_bust(&v11, v12)) {
                let v13 = LiquidationIntervalV1{
                    meta        : meta<T0>(arg0),
                    position_id : v11.number,
                    from_time   : *0x1::vector::borrow<u64>(&v9, v11.market),
                    to_time     : *0x1::vector::borrow<u64>(&arg3, v11.market),
                    worst_price : v12,
                };
                0x2::event::emit<LiquidationIntervalV1>(v13);
                settle_at<T0>(arg0, v3, v12, *0x1::vector::borrow<u64>(&arg3, v11.market), true, 0x2::tx_context::sender(arg8));
                continue
            };
            v3 = v3 + 1;
        };
        v3 = 0;
        while (v3 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders)) {
            let v14 = *0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v3);
            let v15 = if (v14.closing) {
                position_index<T0>(arg0, v14.position.number) == 0x1::vector::length<Position>(&arg0.positions)
            } else {
                false
            };
            let v16 = if (v14.closing) {
                if (v14.target <= arg1) {
                    if (*0x1::vector::borrow<u64>(&arg3, v14.position.market) > v14.submitted) {
                        arg1 - *0x1::vector::borrow<u64>(&arg3, v14.position.market) <= arg0.operation_state.oracle.max_age_ms
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            let v17 = if (v15) {
                true
            } else if (v16) {
                true
            } else {
                !v14.closing && (v14.target == arg1 || 0x2::clock::timestamp_ms(arg7) > v14.deadline)
            };
            if (v17) {
                let v18 = 0x1::vector::remove<DelayedOrder>(&mut arg0.operation_state.delayed.orders, v3);
                if (v18.closing) {
                    let v19 = position_index<T0>(arg0, v18.position.number);
                    if (v19 < 0x1::vector::length<Position>(&arg0.positions)) {
                        settle_at<T0>(arg0, v19, *0x1::vector::borrow<u64>(&arg2, v18.position.market), *0x1::vector::borrow<u64>(&arg3, v18.position.market), false, 0x2::tx_context::sender(arg8));
                    };
                    let v20 = if (v15) {
                        3
                    } else {
                        1
                    };
                    let v21 = OrderResolvedV1{
                        meta       : meta<T0>(arg0),
                        order      : v18,
                        outcome    : v20,
                        head_after : arg0.head,
                    };
                    0x2::event::emit<OrderResolvedV1>(v21);
                    continue
                };
                if (0x2::clock::timestamp_ms(arg7) > v18.deadline) {
                    refund_order<T0>(arg0, v18, 2);
                    continue
                };
                if (*0x1::vector::borrow<u64>(&arg3, v18.position.market) <= v18.submitted || arg1 - *0x1::vector::borrow<u64>(&arg3, v18.position.market) > arg0.operation_state.oracle.max_age_ms) {
                    refund_order<T0>(arg0, v18, 4);
                    continue
                };
                release_slices<T0>(arg0, v18.claims, false);
                let v22 = v18.position;
                v22.entry = *0x1::vector::borrow<u64>(&arg2, v22.market);
                0x1::vector::push_back<Position>(&mut arg0.positions, v22);
                let v23 = OrderResolvedV1{
                    meta       : meta<T0>(arg0),
                    order      : v18,
                    outcome    : 0,
                    head_after : arg0.head,
                };
                0x2::event::emit<OrderResolvedV1>(v23);
                let v24 = PositionOpenedV1{
                    meta            : meta<T0>(arg0),
                    position        : v22,
                    price_timestamp : *0x1::vector::borrow<u64>(&arg3, v22.market),
                    notional        : v22.margin * v22.leverage,
                };
                0x2::event::emit<PositionOpenedV1>(v24);
                let v25 = Activity{
                    kind   : 0,
                    owner  : v22.owner,
                    number : v22.number,
                    amount : (v22.margin as u128),
                    tokens : 0,
                };
                0x2::event::emit<Activity>(v25);
                continue
            };
            v3 = v3 + 1;
        };
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public fun expire_order<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.operation_state.package_version == 1, 900);
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders) && 0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v0).number != arg1) {
            v0 = v0 + 1;
        };
        assert!(v0 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders), 11);
        let v1 = *0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v0);
        assert!(!v1.closing && 0x2::clock::timestamp_ms(arg2) > v1.deadline, 10);
        begin<T0>(arg0);
        let v2 = 0x1::vector::remove<DelayedOrder>(&mut arg0.operation_state.delayed.orders, v0);
        refund_order<T0>(arg0, v2, 2);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    fun fee<T0>(arg0: &mut Exchange<T0>, arg1: u128, arg2: u64, arg3: bool) : u64 {
        let v0 = if (arg1 == 0) {
            3
        } else if (queue_total<T0>(arg0) > 0) {
            1
        } else if ((arg0.pool as u128) < arg1) {
            2
        } else {
            0
        };
        let v1 = if (v0 == 0) {
            claim_cash(arg1, arg0.pool)
        } else {
            0
        };
        let v2 = v1 / 2;
        arg0.pool = arg0.pool - v1;
        arg0.fee_escrow = arg0.fee_escrow + v2;
        arg0.dev_fees = arg0.dev_fees + v1 - v2;
        let v3 = FeeAssessedV1{
            meta         : meta<T0>(arg0),
            position_id  : arg2,
            profit_basis : arg3,
            assessed     : arg1,
            funded       : v1,
            staker       : v2,
            developer    : v1 - v2,
            skip_reason  : v0,
        };
        0x2::event::emit<FeeAssessedV1>(v3);
        v1
    }

    fun fresh<T0>(arg0: &Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 < 2, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(!arg0.operation_state.oracle.paused, 4);
        let v1 = if (arg0.operation_state.oracle.enabled) {
            arg0.operation_state.oracle.max_age_ms
        } else {
            120000
        };
        let v2 = if (*0x1::vector::borrow<u64>(&arg0.price_times, arg1) > 0) {
            if (v0 >= *0x1::vector::borrow<u64>(&arg0.price_times, arg1)) {
                v0 - *0x1::vector::borrow<u64>(&arg0.price_times, arg1) <= v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 4);
    }

    public fun fund_pool<T0>(arg0: &mut Exchange<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.busy, 11);
        begin<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.pool = arg0.pool + v0;
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v1 = PoolFundedV1{
            meta       : meta<T0>(arg0),
            funder     : 0x2::tx_context::sender(arg2),
            amount     : v0,
            pool_after : arg0.pool,
        };
        0x2::event::emit<PoolFundedV1>(v1);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public fun get_account<T0>(arg0: &Exchange<T0>, arg1: address) : 0x1::option::Option<Account> {
        assert!(arg0.operation_state.package_version == 1, 900);
        if (!0x2::table::contains<address, u64>(&arg0.claims.account_indices, arg1)) {
            0x1::option::none<Account>()
        } else {
            0x1::option::some<Account>(*0x2::table_vec::borrow<Account>(&arg0.accounts.rows, *0x2::table::borrow<address, u64>(&arg0.claims.account_indices, arg1)))
        }
    }

    fun hard_bust(arg0: &Position, arg1: u64) : bool {
        let v0 = arg0.long && arg1 < arg0.entry || arg1 > arg0.entry;
        if (!v0) {
            return false
        };
        let v1 = if (arg1 > arg0.entry) {
            arg1 - arg0.entry
        } else {
            arg0.entry - arg1
        };
        (v1 as u128) * 1000000 * (arg0.leverage as u128) >= (arg0.entry as u128) * (1000000 - 480 * (arg0.leverage as u128))
    }

    public fun harvest<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.busy, 11);
        begin<T0>(arg0);
        harvest_inner<T0>(arg0, arg1, false);
        snapshot<T0>(arg0);
    }

    fun harvest_inner<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool) {
        let v0 = arg0.head;
        let v1 = 0;
        let v2 = 0;
        assert!(arg1 > 0 && arg1 <= 16, 6);
        let v3 = 0;
        while (arg0.head > 0 && v3 < arg1) {
            let v4 = 0x2::table::borrow<u64, QueueNode>(&arg0.claims.nodes, arg0.head);
            let v5 = v4.claim;
            if (v4.reserved > 0) {
                break
            };
            if (v5.amount == 0) {
                queue_remove<T0>(arg0, v5.number);
                v3 = v3 + 1;
                continue
            };
            if (arg0.pool == 0) {
                break
            };
            let v6 = claim_cash(v5.amount, arg0.pool);
            let v7 = account<T0>(arg0, v5.owner);
            let v8 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v7).available + v6;
            set_available<T0>(v8, arg0, v7);
            let v9 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v7).queued - (v6 as u256);
            set_queued<T0>(v9, arg0, v7);
            arg0.pool = arg0.pool - v6;
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v5.number).claim.amount = v5.amount - (v6 as u128);
            arg0.claims.total = arg0.claims.total - (v6 as u256);
            let v10 = ClaimPaidV1{
                meta       : meta<T0>(arg0),
                owner      : v5.owner,
                claim_id   : v5.number,
                amount     : v6,
                remaining  : v5.amount - (v6 as u128),
                from_epoch : arg2,
            };
            0x2::event::emit<ClaimPaidV1>(v10);
            v1 = v1 + v6;
            v2 = v2 + 1;
            if ((v6 as u128) == v5.amount) {
                queue_remove<T0>(arg0, v5.number);
            };
            v3 = v3 + 1;
        };
        check<T0>(arg0);
        let v11 = if (arg0.head == 0) {
            0
        } else if (arg0.pool == 0) {
            1
        } else {
            2
        };
        let v12 = QueueHarvestedV1{
            meta        : meta<T0>(arg0),
            requested   : arg1,
            visited     : v3,
            paid_claims : v2,
            total_paid  : v1,
            head_before : v0,
            head_after  : arg0.head,
            stop_reason : v11,
            from_epoch  : arg2,
        };
        0x2::event::emit<QueueHarvestedV1>(v12);
    }

    public fun liquidate<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        settle<T0>(arg0, arg1, true, arg2, arg3);
    }

    fun meta<T0>(arg0: &Exchange<T0>) : Meta {
        Meta{
            exchange_id    : 0x2::object::id<Exchange<T0>>(arg0),
            schema_version : 4,
            protocol_epoch : arg0.epoch,
            operation_id   : arg0.operation_state.sequence,
        }
    }

    public fun migrate_package<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>) {
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        let v0 = if (arg1.operation_state.package_version < 1) {
            if (!arg1.operation_state.engine.busy) {
                !arg1.operation_state.epoch_batch.active
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 900);
        arg1.operation_state.package_version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mint_loss<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u64) : u64 {
        let v0 = arg0.progress;
        while (arg2 > 0) {
            let v1 = claim_cash((10000000000000 as u128) - v0 % (10000000000000 as u128), arg2);
            let v2 = v0 / (10000000000000 as u128);
            let v3 = if (v2 >= 40) {
                0
            } else {
                100000000 >> (v2 as u8)
            };
            let v4 = EmissionSliceV1{
                meta            : meta<T0>(arg0),
                position_id     : arg6,
                debt            : arg3,
                progress_before : v0,
                progress_after  : v0 + (v1 as u128),
                eligible_loss   : v1,
                rate            : v3,
                tokens          : mul(v1, v3, 1000000),
            };
            0x2::event::emit<EmissionSliceV1>(v4);
            v0 = v0 + (v1 as u128);
            arg2 = arg2 - v1;
        };
        let (v5, v6) = emission(arg0.progress, arg2);
        arg0.progress = v6;
        arg0.supply = arg0.supply + v5;
        if (arg3) {
            arg0.debt_progress = arg0.debt_progress + (arg2 as u128);
        } else {
            arg0.cash_progress = arg0.cash_progress + (arg2 as u128);
        };
        let v7 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).pending + v5;
        set_pending<T0>(v7, arg0, arg1);
        0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, arg1).minted = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).minted + v5;
        0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, arg1).losses = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).losses + (arg2 as u128);
        let v8 = RektMintedV1{
            meta            : meta<T0>(arg0),
            beneficiary     : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).owner,
            source_owner    : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).owner,
            position_id     : arg6,
            debt            : arg3,
            referral        : false,
            eligible_loss   : arg2,
            tokens          : v5,
            bonus_bps       : 0,
            pending_after   : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).pending,
            supply_after    : arg0.supply,
            effective_epoch : effective_epoch<T0>(arg0),
        };
        0x2::event::emit<RektMintedV1>(v8);
        let v9 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).referrer;
        if (arg4 && v9 != @0x0) {
            let v10 = account<T0>(arg0, v9);
            let v11 = if (arg3) {
                arg0.debt_bonus_bps
            } else {
                arg0.cash_bonus_bps
            };
            let v12 = mul(v5, v11, 10000);
            let v13 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v10).pending + v12;
            set_pending<T0>(v13, arg0, v10);
            0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, v10).minted = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v10).minted + v12;
            arg0.supply = arg0.supply + v12;
            let v14 = if (arg3) {
                arg0.debt_bonus_bps
            } else {
                arg0.cash_bonus_bps
            };
            let v15 = RektMintedV1{
                meta            : meta<T0>(arg0),
                beneficiary     : v9,
                source_owner    : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).owner,
                position_id     : arg6,
                debt            : arg3,
                referral        : true,
                eligible_loss   : 0,
                tokens          : v12,
                bonus_bps       : v14,
                pending_after   : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v10).pending,
                supply_after    : arg0.supply,
                effective_epoch : effective_epoch<T0>(arg0),
            };
            0x2::event::emit<RektMintedV1>(v15);
        };
        v5
    }

    fun mul(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun open<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.enabled, 11);
        assert!(!arg0.operation_state.delayed.enabled, 11);
        begin<T0>(arg0);
        fresh<T0>(arg0, arg1, arg6);
        let v0 = if (arg3 >= 1000000) {
            if (arg4 >= 10) {
                arg4 <= 1000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!((arg3 as u128) * (arg4 as u128) <= 10000000 * (1000000 as u128), 6);
        assert!(0x1::vector::length<Position>(&arg0.positions) < 200, 6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = account<T0>(arg0, v1);
        let v3 = arg0.next_position;
        if (arg5) {
            consume_claims<T0>(arg0, v1, arg3, v3);
        } else {
            assert!(0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).available >= arg3, 3);
            let v4 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).available - arg3;
            set_available<T0>(v4, arg0, v2);
        };
        let v5 = arg0.next_position;
        arg0.next_position = v5 + 1;
        let v6 = Position{
            number   : v5,
            owner    : v1,
            market   : arg1,
            long     : arg2,
            margin   : arg3,
            leverage : arg4,
            entry    : *0x1::vector::borrow<u64>(&arg0.prices, arg1),
            debt     : arg5,
        };
        0x1::vector::push_back<Position>(&mut arg0.positions, v6);
        let v7 = PositionOpenedV1{
            meta            : meta<T0>(arg0),
            position        : *0x1::vector::borrow<Position>(&arg0.positions, 0x1::vector::length<Position>(&arg0.positions) - 1),
            price_timestamp : *0x1::vector::borrow<u64>(&arg0.price_times, arg1),
            notional        : arg3 * arg4,
        };
        0x2::event::emit<PositionOpenedV1>(v7);
        let v8 = Activity{
            kind   : 0,
            owner  : v1,
            number : v5,
            amount : (arg3 as u128),
            tokens : 0,
        };
        0x2::event::emit<Activity>(v8);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public fun open_profits<T0>(arg0: &Exchange<T0>) : u128 {
        assert!(arg0.operation_state.package_version == 1, 900);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Position>(&arg0.positions)) {
            let v2 = 0x1::vector::borrow<Position>(&arg0.positions, v1);
            let (v3, v4, _) = quote(v2, *0x1::vector::borrow<u64>(&arg0.prices, v2.market));
            if (v3) {
                v0 = v0 + v4;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun pay<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u128) {
        let v0 = (arg3 as u128) + arg4;
        let v1 = v0;
        let v2 = 0;
        if (arg0.head == 0) {
            let v3 = claim_cash(v0, arg0.pool);
            v2 = v3;
            arg0.pool = arg0.pool - v3;
            v1 = v0 - (v3 as u128);
            credit<T0>(arg0, arg1, arg2, min(arg3, v3), sub(v3, arg3));
        };
        if (v1 > 0) {
            let v4 = arg0.next_claim;
            arg0.next_claim = v4 + 1;
            let v5 = Claim{
                number : v4,
                owner  : arg1,
                amount : v1,
            };
            queue_add<T0>(arg0, v5);
            let v6 = ClaimCreatedV1{
                meta        : meta<T0>(arg0),
                owner       : arg1,
                claim_id    : v4,
                position_id : arg2,
                principal   : sub(arg3, v2),
                profit      : arg4 - (sub(v2, arg3) as u128),
                amount      : v1,
            };
            0x2::event::emit<ClaimCreatedV1>(v6);
        };
    }

    public fun position_bust(arg0: &Position, arg1: u64) : bool {
        hard_bust(arg0, arg1)
    }

    fun position_index<T0>(arg0: &Exchange<T0>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Position>(&arg0.positions) && 0x1::vector::borrow<Position>(&arg0.positions, v0).number != arg1) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun position_is_debt(arg0: &Position) : bool {
        arg0.debt
    }

    public fun position_market(arg0: &Position) : u64 {
        arg0.market
    }

    public fun position_number(arg0: &Position) : u64 {
        arg0.number
    }

    public fun position_owner(arg0: &Position) : address {
        arg0.owner
    }

    public(friend) fun position_provision(arg0: &Position, arg1: u64) : u128 {
        let (v0, v1, _) = quote(arg0, arg1);
        if (v0) {
            v1
        } else {
            0
        }
    }

    fun preserve_basis<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        let v0 = &arg0.operation_state.epoch_batch;
        let v1 = if (v0.active) {
            if (arg1 >= v0.cursor) {
                if (arg1 < v0.account_count) {
                    0x2::table_vec::borrow<Account>(&arg0.accounts.rows, arg1).snapshot_epoch != arg0.epoch + 1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, arg1).basis = epoch_basis<T0>(arg0, arg1);
            0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, arg1).snapshot_epoch = arg0.epoch + 1;
        };
    }

    public fun profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u128 {
        let v0 = if (arg3 > arg2) {
            arg3 - arg2
        } else {
            arg2 - arg3
        };
        let v1 = (v0 as u128) * 1000000000000 / (arg2 as u128);
        if (v1 <= 20000000) {
            return 0
        };
        let v2 = v1 - 20000000;
        let v3 = if (arg4 == 0) {
            814598
        } else {
            483979
        };
        (((arg0 as u256) * (arg1 as u256) * (v2 as u256) * (v2 as u256) * 9 / 10 * (1000000000000 as u256) * ((v2 + 1000000000000 / 15000 + 1000000000000 * 100 / v3) as u256)) as u128)
    }

    public fun publish_prices<T0>(arg0: &mut Exchange<T0>, arg1: vector<u64>, arg2: vector<u64>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.enabled, 11);
        assert!(!arg0.operation_state.delayed.enabled, 11);
        let v0 = if (arg0.operation_state.oracle.enabled) {
            if (!arg0.operation_state.oracle.paused) {
                0x2::tx_context::sender(arg4) == arg0.operation_state.oracle.publisher
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(0x1::vector::length<u64>(&arg1) == 2 && 0x1::vector::length<u64>(&arg2) == 2, 4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < 2) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v2) > 0 && *0x1::vector::borrow<u64>(&arg1, v2) <= 1000000000 * 1000000, 4);
            let v3 = if (*0x1::vector::borrow<u64>(&arg2, v2) > 0) {
                if (v1 >= *0x1::vector::borrow<u64>(&arg2, v2)) {
                    v1 - *0x1::vector::borrow<u64>(&arg2, v2) <= arg0.operation_state.oracle.max_age_ms
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 4);
            assert!(*0x1::vector::borrow<u64>(&arg2, v2) >= *0x1::vector::borrow<u64>(&arg0.price_times, v2), 4);
            if (*0x1::vector::borrow<u64>(&arg2, v2) == *0x1::vector::borrow<u64>(&arg0.price_times, v2)) {
                assert!(*0x1::vector::borrow<u64>(&arg1, v2) == *0x1::vector::borrow<u64>(&arg0.prices, v2), 4);
            };
            v2 = v2 + 1;
        };
        assert!(*0x1::vector::borrow<u64>(&arg2, 0) > *0x1::vector::borrow<u64>(&arg0.price_times, 0) || *0x1::vector::borrow<u64>(&arg2, 1) > *0x1::vector::borrow<u64>(&arg0.price_times, 1), 4);
        begin<T0>(arg0);
        arg0.prices = arg1;
        arg0.price_times = arg2;
        let v4 = OracleRoundV1{
            meta         : meta<T0>(arg0),
            publisher    : 0x2::tx_context::sender(arg4),
            prices       : arg1,
            source_times : arg2,
            received_at  : v1,
        };
        0x2::event::emit<OracleRoundV1>(v4);
    }

    fun queue_add<T0>(arg0: &mut Exchange<T0>, arg1: Claim) {
        let v0 = account<T0>(arg0, arg1.owner);
        let v1 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).queued + (arg1.amount as u256);
        set_queued<T0>(v1, arg0, v0);
        let v2 = arg1.number;
        let v3 = arg0.claims.tail;
        let v4 = if (0x2::table::contains<address, u64>(&arg0.claims.owner_tails, arg1.owner)) {
            *0x2::table::borrow<address, u64>(&arg0.claims.owner_tails, arg1.owner)
        } else {
            0
        };
        if (v4 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v4).owner_next = v2;
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claims.owner_tails, arg1.owner) = v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.claims.owners, arg1.owner, v2);
            0x2::table::add<address, u64>(&mut arg0.claims.owner_tails, arg1.owner, v2);
        };
        if (v3 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v3).next = v2;
        } else {
            arg0.head = v2;
        };
        arg0.claims.tail = v2;
        arg0.claims.total = arg0.claims.total + (arg1.amount as u256);
        let v5 = QueueNode{
            claim      : arg1,
            reserved   : 0,
            prev       : v3,
            next       : 0,
            owner_prev : v4,
            owner_next : 0,
        };
        0x2::table::add<u64, QueueNode>(&mut arg0.claims.nodes, v2, v5);
    }

    fun queue_remove<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        let QueueNode {
            claim      : v0,
            reserved   : v1,
            prev       : v2,
            next       : v3,
            owner_prev : v4,
            owner_next : v5,
        } = 0x2::table::remove<u64, QueueNode>(&mut arg0.claims.nodes, arg1);
        let v6 = v0;
        assert!(v6.amount == 0 && v1 == 0, 9);
        if (v2 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v2).next = v3;
        } else {
            arg0.head = v3;
        };
        if (v3 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v3).prev = v2;
        } else {
            arg0.claims.tail = v2;
        };
        if (v4 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v4).owner_next = v5;
        } else if (v5 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claims.owners, v6.owner) = v5;
        } else {
            0x2::table::remove<address, u64>(&mut arg0.claims.owners, v6.owner);
        };
        if (v5 > 0) {
            0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v5).owner_prev = v4;
        } else if (v4 > 0) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.claims.owner_tails, v6.owner) = v4;
        } else {
            0x2::table::remove<address, u64>(&mut arg0.claims.owner_tails, v6.owner);
        };
    }

    public fun queue_total<T0>(arg0: &Exchange<T0>) : u256 {
        assert!(arg0.operation_state.package_version == 1, 900);
        arg0.claims.total
    }

    public fun quote(arg0: &Position, arg1: u64) : (bool, u128, bool) {
        if (arg0.long && arg1 >= arg0.entry || arg1 <= arg0.entry) {
            (true, profit(arg0.margin, arg0.leverage, arg0.entry, arg1, arg0.market), false)
        } else {
            let v3 = if (arg1 > arg0.entry) {
                arg1 - arg0.entry
            } else {
                arg0.entry - arg1
            };
            let v4 = ((arg0.margin * arg0.leverage) as u128) * (v3 as u128) / (arg0.entry as u128);
            let v5 = if (v4 > (arg0.margin as u128)) {
                arg0.margin
            } else {
                (v4 as u64)
            };
            (false, (v5 as u128), hard_bust(arg0, arg1))
        }
    }

    fun refund_order<T0>(arg0: &mut Exchange<T0>, arg1: DelayedOrder, arg2: u8) {
        if (arg1.position.debt) {
            arg0.debt_locked = arg0.debt_locked - arg1.position.margin;
            release_slices<T0>(arg0, arg1.claims, true);
        } else {
            let v0 = account<T0>(arg0, arg1.position.owner);
            let v1 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).available + arg1.position.margin;
            set_available<T0>(v1, arg0, v0);
        };
        let v2 = OrderResolvedV1{
            meta       : meta<T0>(arg0),
            order      : arg1,
            outcome    : arg2,
            head_after : arg0.head,
        };
        0x2::event::emit<OrderResolvedV1>(v2);
    }

    public fun register<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        begin<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table_vec::length<Account>(&arg0.accounts.rows);
        let v2 = ensure<T0>(arg0, v0, false);
        assert!(v2 == v1, 7);
        if (arg1 != @0x0) {
            assert!(arg1 != v0, 7);
            account<T0>(arg0, arg1);
            0x2::table_vec::borrow_mut<Account>(&mut arg0.accounts.rows, v2).referrer = arg1;
            let v3 = ReferralBoundV1{
                meta     : meta<T0>(arg0),
                owner    : v0,
                referrer : arg1,
            };
            0x2::event::emit<ReferralBoundV1>(v3);
        };
        snapshot<T0>(arg0);
    }

    fun release_slices<T0>(arg0: &mut Exchange<T0>, arg1: vector<ClaimSlice>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ClaimSlice>(&arg1)) {
            let v1 = *0x1::vector::borrow<ClaimSlice>(&arg1, v0);
            let v2 = 0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v1.number);
            v2.reserved = v2.reserved - v1.amount;
            if (arg2) {
                v2.claim.amount = v2.claim.amount + (v1.amount as u128);
            };
            let v3 = v2.reserved == 0 && v2.claim.amount == 0;
            if (arg2) {
                arg0.claims.total = arg0.claims.total + (v1.amount as u256);
                let v4 = account<T0>(arg0, v1.owner);
                let v5 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v4).queued + (v1.amount as u256);
                set_queued<T0>(v5, arg0, v4);
            };
            if (v3) {
                queue_remove<T0>(arg0, v1.number);
            };
            v0 = v0 + 1;
        };
    }

    public fun request_close<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.enabled, 11);
        assert!(arg0.operation_state.delayed.enabled, 11);
        let v0 = position_index<T0>(arg0, arg1);
        assert!(v0 < 0x1::vector::length<Position>(&arg0.positions), 5);
        let v1 = *0x1::vector::borrow<Position>(&arg0.positions, v0);
        assert!(v1.owner == 0x2::tx_context::sender(arg3), 1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders)) {
            let v3 = 0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v2);
            assert!(!v3.closing || v3.position.number != arg1, 11);
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders) < 32, 6);
        begin<T0>(arg0);
        enqueue<T0>(arg0, v1, true, 0x1::vector::empty<ClaimSlice>(), arg2);
        snapshot<T0>(arg0);
    }

    public fun request_open<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.enabled, 11);
        assert!(arg0.operation_state.delayed.enabled && !arg0.operation_state.oracle.paused, 11);
        let v0 = if (arg1 < 2) {
            if (arg3 >= 1000000) {
                if (arg4 >= 10) {
                    arg4 <= 1000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert!((arg3 as u128) * (arg4 as u128) <= 10000000 * (1000000 as u128), 6);
        assert!(0x1::vector::length<Position>(&arg0.positions) + 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders) < 16, 6);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = account<T0>(arg0, v1);
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<DelayedOrder>(&arg0.operation_state.delayed.orders)) {
            if (0x1::vector::borrow<DelayedOrder>(&arg0.operation_state.delayed.orders, v4).position.owner == v1) {
                v3 = v3 + 1;
            };
            v4 = v4 + 1;
        };
        assert!(v3 < 3, 6);
        begin<T0>(arg0);
        let v5 = 0x1::vector::empty<ClaimSlice>();
        if (arg5) {
            let v6 = arg0.next_position;
            v5 = take_claims<T0>(arg0, v1, arg3, true, v6);
        } else {
            assert!(0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).available >= arg3, 3);
            let v7 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).available - arg3;
            set_available<T0>(v7, arg0, v2);
        };
        let v8 = arg0.next_position;
        arg0.next_position = v8 + 1;
        let v9 = Position{
            number   : v8,
            owner    : v1,
            market   : arg1,
            long     : arg2,
            margin   : arg3,
            leverage : arg4,
            entry    : 0,
            debt     : arg5,
        };
        enqueue<T0>(arg0, v9, false, v5, arg6);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public(friend) fun session_meta<T0>(arg0: &Exchange<T0>) : Meta {
        assert!(arg0.operation_state.package_version == 1, 900);
        meta<T0>(arg0)
    }

    public(friend) fun session_uid<T0>(arg0: &Exchange<T0>) : &0x2::object::UID {
        assert!(arg0.operation_state.package_version == 1, 900);
        &arg0.id
    }

    public(friend) fun session_uid_mut<T0>(arg0: &mut Exchange<T0>) : &mut 0x2::object::UID {
        assert!(arg0.operation_state.package_version == 1, 900);
        &mut arg0.id
    }

    fun set_available<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        let v0 = 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).available;
        if (arg1.operation_state.engine.applying > 0 && arg0 > v0) {
            let v1 = 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).owner;
            let v2 = arg1.operation_state.engine.applying;
            if (!0x2::table::contains<address, CreditLock>(&arg1.operation_state.engine.locks, v1)) {
                let v3 = CreditLock{
                    frame  : v2,
                    amount : 0,
                };
                0x2::table::add<address, CreditLock>(&mut arg1.operation_state.engine.locks, v1, v3);
            };
            let v4 = 0x2::table::borrow_mut<address, CreditLock>(&mut arg1.operation_state.engine.locks, v1);
            if (v4.frame != v2) {
                v4.frame = v2;
                v4.amount = 0;
            };
            v4.amount = v4.amount + arg0 - v0;
            let v5 = EngineCreditLockedV1{
                meta         : meta<T0>(arg1),
                owner        : v1,
                frame        : v2,
                amount       : arg0 - v0,
                locked_after : v4.amount,
            };
            0x2::event::emit<EngineCreditLockedV1>(v5);
        };
        arg1.accounts.cash = arg1.accounts.cash - v0 + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).available = arg0;
    }

    fun set_pending<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        preserve_basis<T0>(arg1, arg2);
        arg1.accounts.tokens = arg1.accounts.tokens - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).pending + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).pending = arg0;
    }

    public fun set_price<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.operation_state.package_version == 1, 900);
        assert!(!arg1.operation_state.engine.enabled, 11);
        assert!(arg0.exchange_id == 0x2::object::id<Exchange<T0>>(arg1), 1);
        assert!(!arg1.operation_state.oracle.enabled, 4);
        begin<T0>(arg1);
        let v0 = if (arg2 < 2) {
            if (arg3 > 0) {
                arg3 <= 1000000000 * 1000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        let v1 = PriceUpdatedV1{
            meta          : meta<T0>(arg1),
            actor         : 0x2::tx_context::sender(arg5),
            cap_id        : 0x2::object::id<AdminCap<T0>>(arg0),
            market        : arg2,
            old_price     : *0x1::vector::borrow<u64>(&arg1.prices, arg2),
            price         : arg3,
            old_timestamp : *0x1::vector::borrow<u64>(&arg1.price_times, arg2),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<PriceUpdatedV1>(v1);
        *0x1::vector::borrow_mut<u64>(&mut arg1.prices, arg2) = arg3;
        *0x1::vector::borrow_mut<u64>(&mut arg1.price_times, arg2) = 0x2::clock::timestamp_ms(arg4);
    }

    fun set_queued<T0>(arg0: u256, arg1: &mut Exchange<T0>, arg2: u64) {
        arg1.accounts.queued = arg1.accounts.queued - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).queued + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).queued = arg0;
    }

    fun set_ref_weight<T0>(arg0: u128, arg1: &mut Exchange<T0>, arg2: u64) {
        preserve_basis<T0>(arg1, arg2);
        arg1.accounts.weight = arg1.accounts.weight - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).ref_weight + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).ref_weight = arg0;
    }

    fun set_referral_rewards<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        arg1.accounts.cash = arg1.accounts.cash - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).referral_rewards + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).referral_rewards = arg0;
    }

    fun set_rekt<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        arg1.accounts.tokens = arg1.accounts.tokens - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).rekt + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).rekt = arg0;
    }

    fun set_rewards<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        arg1.accounts.cash = arg1.accounts.cash - 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).rewards + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).rewards = arg0;
    }

    fun set_staked<T0>(arg0: u64, arg1: &mut Exchange<T0>, arg2: u64) {
        preserve_basis<T0>(arg1, arg2);
        let v0 = 0x2::table_vec::borrow<Account>(&arg1.accounts.rows, arg2).staked;
        arg1.accounts.tokens = arg1.accounts.tokens - v0 + arg0;
        arg1.accounts.stake = arg1.accounts.stake - v0 + arg0;
        0x2::table_vec::borrow_mut<Account>(&mut arg1.accounts.rows, arg2).staked = arg0;
    }

    fun settle<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.operation_state.engine.enabled, 11);
        assert!(!arg0.operation_state.delayed.enabled, 11);
        begin<T0>(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Position>(&arg0.positions) && 0x1::vector::borrow<Position>(&arg0.positions, v0).number != arg1) {
            v0 = v0 + 1;
        };
        assert!(v0 < 0x1::vector::length<Position>(&arg0.positions), 5);
        let v1 = *0x1::vector::borrow<Position>(&arg0.positions, v0);
        fresh<T0>(arg0, v1.market, arg3);
        let (_, _, v4) = quote(&v1, *0x1::vector::borrow<u64>(&arg0.prices, v1.market));
        if (arg2) {
            assert!(v4, 8);
        } else {
            assert!(v1.owner == 0x2::tx_context::sender(arg4), 1);
        };
        let v5 = *0x1::vector::borrow<u64>(&arg0.prices, v1.market);
        let v6 = *0x1::vector::borrow<u64>(&arg0.price_times, v1.market);
        settle_at<T0>(arg0, v0, v5, v6, arg2, 0x2::tx_context::sender(arg4));
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    fun settle_at<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: address) {
        let v0 = *0x1::vector::borrow<Position>(&arg0.positions, arg1);
        let v1 = v0.number;
        let (v2, v3, v4) = quote(&v0, arg2);
        0x1::vector::swap_remove<Position>(&mut arg0.positions, arg1);
        let v5 = account<T0>(arg0, v0.owner);
        if (v0.debt) {
            arg0.debt_locked = arg0.debt_locked - v0.margin;
        };
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        if (v2) {
            let v10 = v3 * 9800 / 10000;
            if (v0.debt) {
                pay<T0>(arg0, v0.owner, v1, v0.margin, v10);
            } else {
                credit<T0>(arg0, v0.owner, v1, v0.margin, 0);
                pay<T0>(arg0, v0.owner, v1, 0, v10);
            };
            let v11 = fee<T0>(arg0, v3 - v10, v1, true);
            arg0.costs = arg0.costs + (v10 as u256) + (v11 as u256);
            v7 = v10;
        } else {
            let v12 = if (v4) {
                v0.margin
            } else {
                claim_cash(v3, v0.margin)
            };
            v8 = v12;
            let v13 = 0;
            if (v0.debt) {
                pay<T0>(arg0, v0.owner, v1, v0.margin - v12, 0);
                let v14 = FeeAssessedV1{
                    meta         : meta<T0>(arg0),
                    position_id  : v1,
                    profit_basis : false,
                    assessed     : 0,
                    funded       : 0,
                    staker       : 0,
                    developer    : 0,
                    skip_reason  : 4,
                };
                0x2::event::emit<FeeAssessedV1>(v14);
            } else {
                credit<T0>(arg0, v0.owner, v1, v0.margin - v12, 0);
                arg0.pool = arg0.pool + v12;
                v13 = fee<T0>(arg0, (mul(v12, 200, 10000) as u128), v1, false);
            };
            credit_cash_referral<T0>(arg0, &v0, v12, v4);
            arg0.gains = arg0.gains + ((v12 - v13) as u128);
            let v15 = if (v4) {
                v12
            } else {
                v12 - v13
            };
            v9 = v15;
            v6 = mint_loss<T0>(arg0, v5, v15, v0.debt, v4, v13, v1);
        };
        if (v0.debt) {
            let v16 = DebtCollateralReleasedV1{
                meta         : meta<T0>(arg0),
                owner        : v0.owner,
                position_id  : v1,
                margin       : v0.margin,
                cancelled    : v8,
                surviving    : v0.margin - v8,
                locked_after : arg0.debt_locked,
            };
            0x2::event::emit<DebtCollateralReleasedV1>(v16);
        };
        let v17 = PositionSettledV1{
            meta            : meta<T0>(arg0),
            position        : v0,
            executor        : arg5,
            liquidation     : arg4,
            exit_price      : arg2,
            price_timestamp : arg3,
            win             : v2,
            hard_bust       : v4,
            quoted_value    : v3,
            net_profit      : v7,
            realized_loss   : v8,
            eligible_loss   : v9,
            tokens          : v6,
        };
        0x2::event::emit<PositionSettledV1>(v17);
        let v18 = if (v4) {
            3
        } else if (v2) {
            1
        } else {
            2
        };
        let v19 = if (v2) {
            v7
        } else {
            (v8 as u128)
        };
        let v20 = Activity{
            kind   : v18,
            owner  : v0.owner,
            number : v1,
            amount : v19,
            tokens : v6,
        };
        0x2::event::emit<Activity>(v20);
    }

    public fun settle_epoch<T0>(arg0: &mut Exchange<T0>, arg1: u64) {
        assert!(arg0.operation_state.package_version == 1, 900);
        let v0 = if (arg0.operation_state.epoch_batch.active) {
            if (arg1 > 0) {
                arg1 <= 16
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 10);
        begin<T0>(arg0);
        let v1 = 0;
        while (arg0.operation_state.epoch_batch.cursor < arg0.operation_state.epoch_batch.account_count && v1 < arg1) {
            let v2 = arg0.operation_state.epoch_batch.cursor;
            let v3 = epoch_basis<T0>(arg0, v2);
            let v4 = if (arg0.operation_state.epoch_batch.total_weight > 0) {
                share_weight(arg0.operation_state.epoch_batch.ref_budget, v3.weight, arg0.operation_state.epoch_batch.total_weight)
            } else {
                0
            };
            let v5 = if (arg0.operation_state.epoch_batch.total_stake > 0) {
                mul(arg0.operation_state.epoch_batch.div_budget, v3.stake, arg0.operation_state.epoch_batch.total_stake)
            } else {
                0
            };
            let v6 = if (arg0.operation_state.epoch_batch.total_stake > 0) {
                mul(arg0.operation_state.epoch_batch.fees, v3.stake, arg0.operation_state.epoch_batch.total_stake)
            } else {
                0
            };
            let v7 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).rewards + v5 + v6;
            set_rewards<T0>(v7, arg0, v2);
            let v8 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).referral_rewards + v4;
            set_referral_rewards<T0>(v8, arg0, v2);
            if (v4 + v5 + v6 > 0) {
                let v9 = RewardsAccruedV1{
                    meta           : meta<T0>(arg0),
                    owner          : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).owner,
                    active_basis   : v3.stake,
                    weight_basis   : v3.weight,
                    fee_dividend   : v6,
                    extra_dividend : v5,
                    referral_cash  : v4,
                    rewards_after  : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).rewards,
                    referral_after : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).referral_rewards,
                };
                0x2::event::emit<RewardsAccruedV1>(v9);
            };
            if (v3.weight > 0) {
                let v10 = ReferralWeightExpiredV1{
                    meta         : meta<T0>(arg0),
                    owner        : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).owner,
                    weight       : v3.weight,
                    cash_awarded : v4,
                };
                0x2::event::emit<ReferralWeightExpiredV1>(v10);
            };
            if (v3.pending > 0) {
                let v11 = StakeActivatedV1{
                    meta            : meta<T0>(arg0),
                    owner           : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).owner,
                    amount          : v3.pending,
                    active_after    : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).staked + v3.pending,
                    effective_epoch : arg0.epoch + 1,
                };
                0x2::event::emit<StakeActivatedV1>(v11);
            };
            let v12 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).ref_weight - v3.weight;
            set_ref_weight<T0>(v12, arg0, v2);
            let v13 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).pending - v3.pending;
            set_pending<T0>(v13, arg0, v2);
            let v14 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v2).staked + v3.pending;
            set_staked<T0>(v14, arg0, v2);
            arg0.operation_state.epoch_batch.paid_ref = arg0.operation_state.epoch_batch.paid_ref + v4;
            arg0.operation_state.epoch_batch.paid_div = arg0.operation_state.epoch_batch.paid_div + v5;
            arg0.operation_state.epoch_batch.paid_fee = arg0.operation_state.epoch_batch.paid_fee + v6;
            arg0.operation_state.epoch_batch.cursor = v2 + 1;
            v1 = v1 + 1;
        };
        let v15 = EpochBatchV1{
            meta   : meta<T0>(arg0),
            cursor : arg0.operation_state.epoch_batch.cursor,
            count  : v1,
        };
        0x2::event::emit<EpochBatchV1>(v15);
        if (arg0.operation_state.epoch_batch.cursor == arg0.operation_state.epoch_batch.account_count) {
            let v16 = &arg0.operation_state.epoch_batch;
            let v17 = arg0.epoch;
            let v18 = EpochSettledV1{
                meta            : meta<T0>(arg0),
                old_epoch       : v17,
                new_epoch       : v17 + 1,
                timestamp       : v16.timestamp,
                provision       : v16.provision,
                earnings        : v16.earnings,
                available       : v16.available,
                budget          : v16.budget,
                ref_room        : v16.ref_room,
                ref_budget      : v16.ref_budget,
                div_budget      : v16.div_budget,
                total_stake     : v16.total_stake,
                total_weight    : v16.total_weight,
                paid_ref        : v16.paid_ref,
                paid_div        : v16.paid_div,
                paid_fee        : v16.paid_fee,
                retained_budget : v16.budget - v16.paid_ref - v16.paid_div,
            };
            0x2::event::emit<EpochSettledV1>(v18);
            arg0.pool = arg0.pool + v16.budget - v16.paid_ref - v16.paid_div;
            arg0.fee_escrow = arg0.fee_escrow + v16.fees - v16.paid_fee;
            arg0.allocated = arg0.allocated + ((v16.paid_ref + v16.paid_div) as u128);
            arg0.ref_allocated = arg0.ref_allocated + (v16.paid_ref as u128);
            arg0.total_dividends = arg0.total_dividends + ((v16.paid_div + v16.paid_fee) as u128);
            arg0.total_referrals = arg0.total_referrals + (v16.paid_ref as u128);
            arg0.operation_state.last_epoch_ms = v16.timestamp;
            arg0.epoch = v17 + 1;
            let v19 = Activity{
                kind   : 4,
                owner  : @0x0,
                number : arg0.epoch,
                amount : ((v16.paid_ref + v16.paid_div + v16.paid_fee) as u128),
                tokens : 0,
            };
            0x2::event::emit<Activity>(v19);
            arg0.operation_state.epoch_batch = empty_epoch();
        };
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    fun share_weight(arg0: u64, arg1: u128, arg2: u128) : u64 {
        assert!(arg1 <= arg2 && arg2 > 0, 9);
        cash_limit((arg0 as u256) * (arg1 as u256) / (arg2 as u256), arg0)
    }

    fun snapshot<T0>(arg0: &Exchange<T0>) {
        let v0 = TreasurySnapshotV1{
            meta            : meta<T0>(arg0),
            head            : arg0.head,
            epoch_escrow    : epoch_escrow<T0>(arg0),
            vault           : 0x2::balance::value<T0>(&arg0.vault),
            pool            : arg0.pool,
            fee_escrow      : arg0.fee_escrow,
            dev_fees        : arg0.dev_fees,
            debt_locked     : arg0.debt_locked,
            queue           : queue_total<T0>(arg0),
            progress        : arg0.progress,
            cash_progress   : arg0.cash_progress,
            debt_progress   : arg0.debt_progress,
            supply          : arg0.supply,
            gains           : arg0.gains,
            costs           : arg0.costs,
            allocated       : arg0.allocated,
            ref_allocated   : arg0.ref_allocated,
            total_dividends : arg0.total_dividends,
            total_referrals : arg0.total_referrals,
        };
        0x2::event::emit<TreasurySnapshotV1>(v0);
    }

    public fun stake<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.busy, 11);
        assert!(!arg0.operation_state.epoch_batch.active, 10);
        begin<T0>(arg0);
        let v0 = account<T0>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rekt >= arg1, 3);
        let v1 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rekt - arg1;
        set_rekt<T0>(v1, arg0, v0);
        let v2 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending + arg1;
        set_pending<T0>(v2, arg0, v0);
        let v3 = StakeQueuedV1{
            meta            : meta<T0>(arg0),
            owner           : 0x2::tx_context::sender(arg2),
            amount          : arg1,
            pending_after   : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending,
            effective_epoch : effective_epoch<T0>(arg0),
        };
        0x2::event::emit<StakeQueuedV1>(v3);
        snapshot<T0>(arg0);
    }

    fun start_epoch<T0>(arg0: &mut Exchange<T0>, arg1: u128, arg2: u64) {
        let v0 = sub256((arg0.gains as u256), arg0.costs + (arg1 as u256));
        let v1 = cash_limit(sub256((arg0.pool as u256), queue_total<T0>(arg0) + (arg0.debt_locked as u256) + (arg1 as u256) + (arg0.reserve as u256)), arg0.pool);
        let v2 = cash_limit(sub256(v0 * (arg0.dividend_bps as u256) / 10000, (arg0.allocated as u256)), v1);
        let v3 = cash_limit(sub256(v0 * (arg0.ref_cap_bps as u256) / 10000, (arg0.ref_allocated as u256)), v2);
        let v4 = arg0.accounts.weight;
        let v5 = claim_cash(v4, v3);
        let v6 = arg0.fee_escrow;
        arg0.pool = arg0.pool - v2;
        arg0.fee_escrow = 0;
        let v7 = EpochBatch{
            active        : true,
            cursor        : 0,
            account_count : 0x2::table_vec::length<Account>(&arg0.accounts.rows),
            timestamp     : arg2,
            provision     : arg1,
            earnings      : v0,
            available     : v1,
            budget        : v2,
            ref_room      : v3,
            ref_budget    : v5,
            div_budget    : v2 - v5,
            fees          : v6,
            total_stake   : arg0.accounts.stake,
            total_weight  : v4,
            paid_ref      : 0,
            paid_div      : 0,
            paid_fee      : 0,
        };
        arg0.operation_state.epoch_batch = v7;
        let v8 = EpochStartedV1{
            meta   : meta<T0>(arg0),
            budget : v2,
            fees   : v6,
        };
        0x2::event::emit<EpochStartedV1>(v8);
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    fun sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    fun sub256(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    fun take_claims<T0>(arg0: &mut Exchange<T0>, arg1: address, arg2: u64, arg3: bool, arg4: u64) : vector<ClaimSlice> {
        assert!(0x2::table::contains<address, u64>(&arg0.claims.owners, arg1), 3);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.claims.owners, arg1);
        let v1 = arg2;
        let v2 = 0x1::vector::empty<ClaimSlice>();
        let v3 = 0;
        loop {
            let v4 = if (v0 > 0) {
                if (v1 > 0) {
                    v3 < 16
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                let v5 = 0x2::table::borrow_mut<u64, QueueNode>(&mut arg0.claims.nodes, v0);
                v0 = v5.owner_next;
                let v6 = claim_cash(v5.claim.amount, v1);
                v5.claim.amount = v5.claim.amount - (v6 as u128);
                let v7 = v5.claim.amount;
                if (arg3) {
                    v5.reserved = v5.reserved + v6;
                };
                let v8 = v5.reserved == 0 && v7 == 0;
                if (v6 > 0) {
                    let v9 = ClaimSlice{
                        number : v0,
                        owner  : arg1,
                        amount : v6,
                    };
                    0x1::vector::push_back<ClaimSlice>(&mut v2, v9);
                    v1 = v1 - v6;
                    arg0.claims.total = arg0.claims.total - (v6 as u256);
                    if (!arg3) {
                        let v10 = ClaimConsumedV1{
                            meta        : meta<T0>(arg0),
                            owner       : arg1,
                            claim_id    : v0,
                            position_id : arg4,
                            amount      : v6,
                            remaining   : v7,
                        };
                        0x2::event::emit<ClaimConsumedV1>(v10);
                    };
                };
                if (v8) {
                    queue_remove<T0>(arg0, v0);
                };
                v0 = v5.owner_next;
                v3 = v3 + 1;
            } else {
                break
            };
        };
        assert!(v1 == 0, 3);
        let v11 = account<T0>(arg0, arg1);
        let v12 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v11).queued - (arg2 as u256);
        set_queued<T0>(v12, arg0, v11);
        arg0.debt_locked = arg0.debt_locked + arg2;
        v2
    }

    fun target_tick(arg0: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg0) + 800 + 999) / 1000 * 1000
    }

    public fun unstake<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        assert!(!arg0.operation_state.engine.busy, 11);
        assert!(!arg0.operation_state.epoch_batch.active, 10);
        begin<T0>(arg0);
        let v0 = account<T0>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).staked + 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending >= arg1, 3);
        let v1 = min(arg1, 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending);
        let v2 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending - v1;
        set_pending<T0>(v2, arg0, v0);
        let v3 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).staked - arg1 - v1;
        set_staked<T0>(v3, arg0, v0);
        let v4 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rekt + arg1;
        set_rekt<T0>(v4, arg0, v0);
        let v5 = UnstakedV1{
            meta          : meta<T0>(arg0),
            owner         : 0x2::tx_context::sender(arg2),
            from_pending  : v1,
            from_active   : arg1 - v1,
            liquid_after  : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).rekt,
            pending_after : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).pending,
            active_after  : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).staked,
        };
        0x2::event::emit<UnstakedV1>(v5);
        snapshot<T0>(arg0);
    }

    fun validate_decimals(arg0: u8) {
        assert!(arg0 == 6, 2);
    }

    public fun withdraw<T0>(arg0: &mut Exchange<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.operation_state.package_version == 1, 900);
        begin<T0>(arg0);
        let v0 = account<T0>(arg0, 0x2::tx_context::sender(arg2));
        assert!(arg1 > 0 && engine_available<T0>(arg0, 0x2::tx_context::sender(arg2)) >= arg1, 3);
        let v1 = 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).available - arg1;
        set_available<T0>(v1, arg0, v0);
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg1), arg2);
        let v3 = WithdrawnV1{
            meta            : meta<T0>(arg0),
            owner           : 0x2::tx_context::sender(arg2),
            amount          : arg1,
            coin_id         : 0x2::object::id<0x2::coin::Coin<T0>>(&v2),
            available_after : 0x2::table_vec::borrow<Account>(&arg0.accounts.rows, v0).available,
        };
        0x2::event::emit<WithdrawnV1>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        check<T0>(arg0);
        snapshot<T0>(arg0);
    }

    public fun withdraw_dev_fees<T0>(arg0: &AdminCap<T0>, arg1: &mut Exchange<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.operation_state.package_version == 1, 900);
        engine_admin<T0>(arg0, arg1);
        assert!(!arg1.operation_state.engine.busy && !arg1.operation_state.epoch_batch.active, 11);
        assert!(arg2 > 0 && arg2 <= arg1.dev_fees, 3);
        begin<T0>(arg1);
        arg1.dev_fees = arg1.dev_fees - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.vault, arg2), arg3), 0x2::tx_context::sender(arg3));
        check<T0>(arg1);
        let v0 = DeveloperFeesWithdrawnV1{
            meta      : meta<T0>(arg1),
            recipient : 0x2::tx_context::sender(arg3),
            amount    : arg2,
            remaining : arg1.dev_fees,
        };
        0x2::event::emit<DeveloperFeesWithdrawnV1>(v0);
        snapshot<T0>(arg1);
    }

    // decompiled from Move bytecode v7
}

