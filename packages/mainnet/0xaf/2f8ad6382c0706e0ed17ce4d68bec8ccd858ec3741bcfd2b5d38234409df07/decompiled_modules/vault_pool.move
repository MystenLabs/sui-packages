module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::vault_pool {
    struct Tranche has copy, drop, store {
        priority: u8,
        allocation_bps: u64,
        target_yield_bps: u64,
        total_investment: u64,
        yield_distributed: u64,
    }

    struct VaultPool has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        vault_refs: vector<0x2::object::ID>,
        total_loan_amount: u64,
        total_collateral_value: u64,
        weighted_avg_cltv: u64,
        weighted_avg_interest: u64,
        tranches: vector<Tranche>,
        pool_status: u8,
        created_at: u64,
        maturity_date: u64,
        total_repayments: u64,
        operator: address,
        kyc_required: bool,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: vector<0x2::object::ID>,
        pool_count: u64,
        total_pooled_loans: u64,
        total_pooled_value: u64,
    }

    struct PoolOperatorCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct PoolWhitelist has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        whitelisted: 0x2::table::Table<address, bool>,
        whitelist_count: u64,
    }

    struct PoolMetrics has copy, drop, store {
        pool_id: 0x2::object::ID,
        current_cltv: u64,
        delinquency_rate: u64,
        prepayment_rate: u64,
        total_yield: u64,
        annualized_return: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        vault_count: u64,
        total_loan_amount: u64,
        total_collateral_value: u64,
        operator: address,
        created_at: u64,
    }

    struct VaultAddedToPool has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        loan_amount: u64,
        collateral_amount: u64,
    }

    struct TrancheAllocated has copy, drop {
        pool_id: 0x2::object::ID,
        tranche_priority: u8,
        allocation_bps: u64,
        target_yield_bps: u64,
    }

    struct YieldDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        tranche_priority: u8,
        amount: u64,
        timestamp: u64,
    }

    struct PoolStatusChanged has copy, drop {
        pool_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        timestamp: u64,
    }

    struct WalletWhitelisted has copy, drop {
        pool_id: 0x2::object::ID,
        wallet: address,
        timestamp: u64,
    }

    public entry fun activate_pool(arg0: &mut VaultPool, arg1: &PoolOperatorCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.pool_status == 0, 7);
        arg0.pool_status = 1;
        let v0 = PoolStatusChanged{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.pool_status,
            new_status : 1,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolStatusChanged>(v0);
    }

    public entry fun add_tranches(arg0: &mut VaultPool, arg1: &PoolOperatorCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0.pool_status == 0, 7);
        let v0 = Tranche{
            priority          : 1,
            allocation_bps    : 7000,
            target_yield_bps  : arg2,
            total_investment  : 0,
            yield_distributed : 0,
        };
        let v1 = Tranche{
            priority          : 2,
            allocation_bps    : 2000,
            target_yield_bps  : arg3,
            total_investment  : 0,
            yield_distributed : 0,
        };
        let v2 = Tranche{
            priority          : 3,
            allocation_bps    : 1000,
            target_yield_bps  : arg4,
            total_investment  : 0,
            yield_distributed : 0,
        };
        0x1::vector::push_back<Tranche>(&mut arg0.tranches, v0);
        0x1::vector::push_back<Tranche>(&mut arg0.tranches, v1);
        0x1::vector::push_back<Tranche>(&mut arg0.tranches, v2);
        let v3 = TrancheAllocated{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            tranche_priority : 1,
            allocation_bps   : 7000,
            target_yield_bps : arg2,
        };
        0x2::event::emit<TrancheAllocated>(v3);
        let v4 = TrancheAllocated{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            tranche_priority : 2,
            allocation_bps   : 2000,
            target_yield_bps : arg3,
        };
        0x2::event::emit<TrancheAllocated>(v4);
        let v5 = TrancheAllocated{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            tranche_priority : 3,
            allocation_bps   : 1000,
            target_yield_bps : arg4,
        };
        0x2::event::emit<TrancheAllocated>(v5);
    }

    public fun calculate_pool_metrics(arg0: &VaultPool, arg1: u64, arg2: u64, arg3: u64) : PoolMetrics {
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0.vault_refs);
        let v1 = if (v0 > 0) {
            arg2 * 10000 / v0
        } else {
            0
        };
        let v2 = if (arg0.total_loan_amount > 0) {
            arg3 * 10000 / arg0.total_loan_amount
        } else {
            0
        };
        PoolMetrics{
            pool_id           : 0x2::object::uid_to_inner(&arg0.id),
            current_cltv      : arg1,
            delinquency_rate  : v1,
            prepayment_rate   : v2,
            total_yield       : arg0.total_repayments,
            annualized_return : arg0.weighted_avg_interest,
        }
    }

    public entry fun close_pool(arg0: &mut VaultPool, arg1: &PoolOperatorCap, arg2: &0x2::clock::Clock) {
        arg0.pool_status = 2;
        let v0 = PoolStatusChanged{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.pool_status,
            new_status : 2,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolStatusChanged>(v0);
    }

    public entry fun create_pool(arg0: &mut PoolRegistry, arg1: vector<u8>, arg2: vector<0x2::object::ID>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) >= 100, 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = 0x2::object::new(arg10);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = VaultPool{
            id                     : v2,
            name                   : v0,
            vault_refs             : arg2,
            total_loan_amount      : arg3,
            total_collateral_value : arg4,
            weighted_avg_cltv      : arg5,
            weighted_avg_interest  : arg6,
            tranches               : 0x1::vector::empty<Tranche>(),
            pool_status            : 0,
            created_at             : v1,
            maturity_date          : v1 + arg7 * 365 * 24 * 60 * 60 * 1000,
            total_repayments       : 0,
            operator               : 0x2::tx_context::sender(arg10),
            kyc_required           : arg8,
        };
        let v5 = PoolOperatorCap{
            id      : 0x2::object::new(arg10),
            pool_id : v3,
        };
        if (arg8) {
            let v6 = PoolWhitelist{
                id              : 0x2::object::new(arg10),
                pool_id         : v3,
                whitelisted     : 0x2::table::new<address, bool>(arg10),
                whitelist_count : 0,
            };
            0x2::transfer::share_object<PoolWhitelist>(v6);
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pools, v3);
        arg0.pool_count = arg0.pool_count + 1;
        arg0.total_pooled_loans = arg0.total_pooled_loans + 0x1::vector::length<0x2::object::ID>(&arg2);
        arg0.total_pooled_value = arg0.total_pooled_value + arg3;
        let v7 = PoolCreated{
            pool_id                : v3,
            name                   : v0,
            vault_count            : 0x1::vector::length<0x2::object::ID>(&arg2),
            total_loan_amount      : arg3,
            total_collateral_value : arg4,
            operator               : 0x2::tx_context::sender(arg10),
            created_at             : v1,
        };
        0x2::event::emit<PoolCreated>(v7);
        0x2::transfer::transfer<PoolOperatorCap>(v5, 0x2::tx_context::sender(arg10));
        0x2::transfer::share_object<VaultPool>(v4);
    }

    public fun distribute_yield(arg0: &mut VaultPool, arg1: u64, arg2: &0x2::clock::Clock) : vector<u64> {
        assert!(arg0.pool_status == 1, 7);
        let v0 = 0x1::vector::empty<u64>();
        arg0.total_repayments = arg0.total_repayments + arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Tranche>(&arg0.tranches)) {
            let v2 = 0x1::vector::borrow_mut<Tranche>(&mut arg0.tranches, v1);
            let v3 = arg1 * v2.allocation_bps / 10000;
            let v4 = if (arg1 >= v3) {
                v3
            } else {
                arg1
            };
            v2.yield_distributed = v2.yield_distributed + v4;
            arg1 = arg1 - v4;
            0x1::vector::push_back<u64>(&mut v0, v3);
            let v5 = YieldDistributed{
                pool_id          : 0x2::object::uid_to_inner(&arg0.id),
                tranche_priority : v2.priority,
                amount           : v3,
                timestamp        : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<YieldDistributed>(v5);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_pool_name(arg0: &VaultPool) : 0x1::string::String {
        arg0.name
    }

    public fun get_pool_status(arg0: &VaultPool) : u8 {
        arg0.pool_status
    }

    public fun get_total_collateral(arg0: &VaultPool) : u64 {
        arg0.total_collateral_value
    }

    public fun get_total_loan_amount(arg0: &VaultPool) : u64 {
        arg0.total_loan_amount
    }

    public fun get_total_repayments(arg0: &VaultPool) : u64 {
        arg0.total_repayments
    }

    public fun get_tranche_count(arg0: &VaultPool) : u64 {
        0x1::vector::length<Tranche>(&arg0.tranches)
    }

    public fun get_vault_count(arg0: &VaultPool) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.vault_refs)
    }

    public fun get_weighted_avg_cltv(arg0: &VaultPool) : u64 {
        arg0.weighted_avg_cltv
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                 : 0x2::object::new(arg0),
            pools              : 0x1::vector::empty<0x2::object::ID>(),
            pool_count         : 0,
            total_pooled_loans : 0,
            total_pooled_value : 0,
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public fun is_kyc_required(arg0: &VaultPool) : bool {
        arg0.kyc_required
    }

    public fun is_whitelisted(arg0: &PoolWhitelist, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted, arg1) && *0x2::table::borrow<address, bool>(&arg0.whitelisted, arg1)
    }

    public entry fun mark_pool_defaulted(arg0: &mut VaultPool, arg1: &PoolOperatorCap, arg2: &0x2::clock::Clock) {
        arg0.pool_status = 3;
        let v0 = PoolStatusChanged{
            pool_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_status : arg0.pool_status,
            new_status : 3,
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PoolStatusChanged>(v0);
    }

    public entry fun remove_from_whitelist(arg0: &mut PoolWhitelist, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, bool>(&arg0.whitelisted, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.whitelisted, arg1);
            arg0.whitelist_count = arg0.whitelist_count - 1;
        };
    }

    public entry fun whitelist_wallet(arg0: &mut PoolWhitelist, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, bool>(&arg0.whitelisted, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelisted, arg1, true);
            arg0.whitelist_count = arg0.whitelist_count + 1;
            let v0 = WalletWhitelisted{
                pool_id   : arg0.pool_id,
                wallet    : arg1,
                timestamp : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<WalletWhitelisted>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

