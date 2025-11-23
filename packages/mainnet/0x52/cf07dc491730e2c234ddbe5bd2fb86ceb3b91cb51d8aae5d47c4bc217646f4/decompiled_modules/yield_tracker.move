module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::yield_tracker {
    struct PaymentRecord has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        principal_paid: u64,
        interest_paid: u64,
        fees_paid: u64,
        payment_type: u8,
        timestamp: u64,
    }

    struct PoolYieldTracker has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        total_principal_collected: u64,
        total_interest_collected: u64,
        total_fees_collected: u64,
        total_payments_processed: u64,
        last_distribution_timestamp: u64,
        payment_history: vector<PaymentRecord>,
    }

    struct RepaymentQueue has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        pending_distributions: 0x2::table::Table<0x2::object::ID, u64>,
        total_pending: u64,
    }

    struct VaultPoolMapping has key {
        id: 0x2::object::UID,
        vault_to_pool: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        pool_to_vaults: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
    }

    struct YieldDistributionSnapshot has copy, drop, store {
        pool_id: 0x2::object::ID,
        senior_amount: u64,
        junior_amount: u64,
        equity_amount: u64,
        total_distributed: u64,
        timestamp: u64,
    }

    struct PaymentProcessed has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        principal: u64,
        interest: u64,
        total_amount: u64,
        payment_type: u8,
        timestamp: u64,
    }

    struct YieldDistributedToTranches has copy, drop {
        pool_id: 0x2::object::ID,
        senior_yield: u64,
        junior_yield: u64,
        equity_yield: u64,
        total_yield: u64,
        timestamp: u64,
    }

    struct VaultMappedToPool has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun distribute_yield(arg0: &mut 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &mut PoolYieldTracker, arg2: &mut RepaymentQueue, arg3: &mut 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token::YieldAccumulator, arg4: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token::PoolTokenMetadata, arg5: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token::PoolTokenMetadata, arg6: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token::PoolTokenMetadata, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_pool_status(arg0) == 1, 3);
        let v0 = arg2.total_pending;
        if (v0 == 0) {
            return
        };
        let v1 = 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::distribute_yield(arg0, v0, arg7);
        let v2 = *0x1::vector::borrow<u64>(&v1, 0);
        let v3 = *0x1::vector::borrow<u64>(&v1, 1);
        let v4 = *0x1::vector::borrow<u64>(&v1, 2);
        0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::pool_token::distribute_yield_to_tokens(arg3, arg4, arg5, arg6, v2, v3, v4, arg7);
        arg2.total_pending = 0;
        arg1.last_distribution_timestamp = 0x2::clock::timestamp_ms(arg7);
        let v5 = YieldDistributedToTranches{
            pool_id      : arg1.pool_id,
            senior_yield : v2,
            junior_yield : v3,
            equity_yield : v4,
            total_yield  : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<YieldDistributedToTranches>(v5);
    }

    public fun calculate_pool_performance(arg0: &PoolYieldTracker, arg1: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool) : (u64, u64, u64) {
        let v0 = arg0.total_principal_collected + arg0.total_interest_collected;
        let v1 = 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::get_total_loan_amount(arg1);
        let v2 = if (v1 > 0) {
            arg0.total_principal_collected * 10000 / v1
        } else {
            0
        };
        let v3 = if (arg0.total_payments_processed > 0) {
            v0 / arg0.total_payments_processed
        } else {
            0
        };
        (v2, v3, v0)
    }

    public fun get_last_distribution_timestamp(arg0: &PoolYieldTracker) : u64 {
        arg0.last_distribution_timestamp
    }

    public fun get_pending_distribution_amount(arg0: &RepaymentQueue) : u64 {
        arg0.total_pending
    }

    public fun get_total_interest_collected(arg0: &PoolYieldTracker) : u64 {
        arg0.total_interest_collected
    }

    public fun get_total_payments_processed(arg0: &PoolYieldTracker) : u64 {
        arg0.total_payments_processed
    }

    public fun get_total_principal_collected(arg0: &PoolYieldTracker) : u64 {
        arg0.total_principal_collected
    }

    public entry fun initialize_yield_tracker(arg0: &0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::vault_pool::VaultPool>(arg0);
        let v1 = PoolYieldTracker{
            id                          : 0x2::object::new(arg2),
            pool_id                     : v0,
            total_principal_collected   : 0,
            total_interest_collected    : 0,
            total_fees_collected        : 0,
            total_payments_processed    : 0,
            last_distribution_timestamp : 0x2::clock::timestamp_ms(arg1),
            payment_history             : 0x1::vector::empty<PaymentRecord>(),
        };
        let v2 = RepaymentQueue{
            id                    : 0x2::object::new(arg2),
            pool_id               : v0,
            pending_distributions : 0x2::table::new<0x2::object::ID, u64>(arg2),
            total_pending         : 0,
        };
        0x2::transfer::share_object<PoolYieldTracker>(v1);
        0x2::transfer::share_object<RepaymentQueue>(v2);
    }

    public entry fun map_vault_to_pool(arg0: &mut VaultPoolMapping, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.vault_to_pool, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_to_pool, arg1, arg2);
        };
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.pool_to_vaults, arg2)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.pool_to_vaults, arg2, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg0.pool_to_vaults, arg2), arg1);
        let v0 = VaultMappedToPool{
            vault_id  : arg1,
            pool_id   : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<VaultMappedToPool>(v0);
    }

    public fun process_prepayment(arg0: &mut PoolYieldTracker, arg1: &mut RepaymentQueue, arg2: 0x2::object::ID, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        let v0 = if (arg4) {
            3
        } else {
            2
        };
        process_vault_payment(arg0, arg1, arg2, arg3, 0, v0, arg5);
    }

    public fun process_vault_payment(arg0: &mut PoolYieldTracker, arg1: &mut RepaymentQueue, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u8, arg6: &0x2::clock::Clock) {
        let v0 = PaymentRecord{
            vault_id       : arg2,
            pool_id        : arg0.pool_id,
            principal_paid : arg3,
            interest_paid  : arg4,
            fees_paid      : 0,
            payment_type   : arg5,
            timestamp      : 0x2::clock::timestamp_ms(arg6),
        };
        arg0.total_principal_collected = arg0.total_principal_collected + arg3;
        arg0.total_interest_collected = arg0.total_interest_collected + arg4;
        arg0.total_payments_processed = arg0.total_payments_processed + 1;
        0x1::vector::push_back<PaymentRecord>(&mut arg0.payment_history, v0);
        let v1 = arg3 + arg4;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.pending_distributions, arg2)) {
            let v2 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.pending_distributions, arg2);
            *v2 = *v2 + v1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.pending_distributions, arg2, v1);
        };
        arg1.total_pending = arg1.total_pending + v1;
        let v3 = PaymentProcessed{
            vault_id     : arg2,
            pool_id      : arg0.pool_id,
            principal    : arg3,
            interest     : arg4,
            total_amount : v1,
            payment_type : arg5,
            timestamp    : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<PaymentProcessed>(v3);
    }

    public fun record_vault_default(arg0: &mut PoolYieldTracker, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = PaymentRecord{
            vault_id       : arg1,
            pool_id        : arg0.pool_id,
            principal_paid : 0,
            interest_paid  : 0,
            fees_paid      : 0,
            payment_type   : 4,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x1::vector::push_back<PaymentRecord>(&mut arg0.payment_history, v0);
        let v1 = PaymentProcessed{
            vault_id     : arg1,
            pool_id      : arg0.pool_id,
            principal    : 0,
            interest     : 0,
            total_amount : 0,
            payment_type : 4,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PaymentProcessed>(v1);
    }

    // decompiled from Move bytecode v6
}

