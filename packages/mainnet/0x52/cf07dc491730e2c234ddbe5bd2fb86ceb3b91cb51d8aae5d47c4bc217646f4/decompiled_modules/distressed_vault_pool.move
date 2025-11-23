module 0x52cf07dc491730e2c234ddbe5bd2fb86ceb3b91cb51d8aae5d47c4bc217646f4::distressed_vault_pool {
    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct DistressedVaultPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_principal_value: u64,
        estimated_recovery_value: u64,
        total_tokens_issued: u64,
        token_price: u64,
        created_at: u64,
        lockup_end_at: u64,
        pool_manager: address,
        dao_treasury: address,
        status: u8,
        investment_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        recovery_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_distributed: u64,
        total_fees_collected: u64,
        locked: bool,
    }

    struct NPLToken has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        symbol: 0x1::string::String,
        amount: u64,
        investment_amount: u64,
        entry_timestamp: u64,
        lockup_end_at: u64,
        distributions_received: u64,
        owner: address,
    }

    struct InvestorPosition has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        investor: address,
        tokens_owned: u64,
        total_invested: u64,
        total_received: u64,
        entry_timestamp: u64,
        lockup_end_at: u64,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_pools: u64,
        total_value_locked: u64,
        admin: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        manager: address,
        created_at: u64,
    }

    struct VaultAddedToPool has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        principal_value: u64,
        estimated_recovery: u64,
    }

    struct InvestmentMade has copy, drop {
        pool_id: 0x2::object::ID,
        investor: address,
        amount: u64,
        tokens_received: u64,
        timestamp: u64,
    }

    struct DistributionMade has copy, drop {
        pool_id: 0x2::object::ID,
        gross_amount: u64,
        management_fee: u64,
        performance_fee: u64,
        net_distributed: u64,
        timestamp: u64,
    }

    struct TokensClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        investor: address,
        tokens_amount: u64,
        payout_amount: u64,
        timestamp: u64,
    }

    struct RecoveryReceived has copy, drop {
        pool_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        recovery_amount: u64,
        recovery_method: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun add_vault_to_pool(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        assert!(!arg0.locked, 2);
        assert!(arg0.status < 5, 9);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.vault_ids, &arg2), 7);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.vault_ids, arg2);
        arg0.total_principal_value = arg0.total_principal_value + arg3;
        arg0.estimated_recovery_value = arg0.estimated_recovery_value + arg4;
        let v0 = VaultAddedToPool{
            pool_id            : 0x2::object::id<DistressedVaultPool>(arg0),
            vault_id           : arg2,
            principal_value    : arg3,
            estimated_recovery : arg4,
        };
        0x2::event::emit<VaultAddedToPool>(v0);
    }

    public entry fun claim_npl_yield(arg0: &mut DistressedVaultPool, arg1: &mut NPLToken, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 1);
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        let v1 = arg0.total_tokens_issued;
        assert!(v1 > 0, 6);
        let v2 = arg1.amount * 0x2::balance::value<0x2::sui::SUI>(&arg0.recovery_balance) / v1;
        assert!(v2 > 0, 6);
        arg1.distributions_received = arg1.distributions_received + v2;
        let v3 = TokensClaimed{
            pool_id       : 0x2::object::id<DistressedVaultPool>(arg0),
            investor      : v0,
            tokens_amount : arg1.amount,
            payout_amount : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokensClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.recovery_balance, v2), arg3), v0);
    }

    public entry fun close_pool(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        arg0.status = 5;
        arg0.locked = true;
    }

    public entry fun create_npl_pool(arg0: &mut PoolRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = DistressedVaultPool{
            id                       : 0x2::object::new(arg6),
            name                     : 0x1::string::utf8(arg1),
            token_symbol             : 0x1::string::utf8(arg2),
            vault_ids                : 0x2::vec_set::empty<0x2::object::ID>(),
            total_principal_value    : 0,
            estimated_recovery_value : 0,
            total_tokens_issued      : 0,
            token_price              : arg3,
            created_at               : v1,
            lockup_end_at            : v1 + 63072000000,
            pool_manager             : v0,
            dao_treasury             : arg4,
            status                   : 1,
            investment_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            recovery_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            total_distributed        : 0,
            total_fees_collected     : 0,
            locked                   : false,
        };
        let v3 = 0x2::object::id<DistressedVaultPool>(&v2);
        let v4 = PoolAdminCap{
            id      : 0x2::object::new(arg6),
            pool_id : v3,
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.pools, v3);
        arg0.total_pools = arg0.total_pools + 1;
        let v5 = PoolCreated{
            pool_id      : v3,
            name         : 0x1::string::utf8(arg1),
            token_symbol : 0x1::string::utf8(arg2),
            manager      : v0,
            created_at   : v1,
        };
        0x2::event::emit<PoolCreated>(v5);
        0x2::transfer::transfer<PoolAdminCap>(v4, v0);
        0x2::transfer::share_object<DistressedVaultPool>(v2);
    }

    public entry fun distribute_recovery(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.recovery_balance);
        assert!(v0 > 0, 8);
        let v1 = v0 * 200 / 10000;
        let v2 = if (arg0.total_distributed + v0 > arg0.total_principal_value) {
            arg0.total_distributed + v0 - arg0.total_principal_value
        } else {
            0
        };
        let v3 = v2 * 2000 / 10000;
        let v4 = v1 + v3;
        let v5 = v0 - v4;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.recovery_balance, v4), arg3), arg0.dao_treasury);
            arg0.total_fees_collected = arg0.total_fees_collected + v4;
        };
        arg0.total_distributed = arg0.total_distributed + v5;
        let v6 = DistributionMade{
            pool_id         : 0x2::object::id<DistressedVaultPool>(arg0),
            gross_amount    : v0,
            management_fee  : v1,
            performance_fee : v3,
            net_distributed : v5,
            timestamp       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DistributionMade>(v6);
    }

    public fun get_estimated_recovery(arg0: &DistressedVaultPool) : u64 {
        arg0.estimated_recovery_value
    }

    public fun get_pool_status(arg0: &DistressedVaultPool) : u8 {
        arg0.status
    }

    public fun get_recovery_balance(arg0: &DistressedVaultPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.recovery_balance)
    }

    public fun get_token_amount(arg0: &NPLToken) : u64 {
        arg0.amount
    }

    public fun get_token_distributions(arg0: &NPLToken) : u64 {
        arg0.distributions_received
    }

    public fun get_token_price(arg0: &DistressedVaultPool) : u64 {
        arg0.token_price
    }

    public fun get_total_distributed(arg0: &DistressedVaultPool) : u64 {
        arg0.total_distributed
    }

    public fun get_total_tokens_issued(arg0: &DistressedVaultPool) : u64 {
        arg0.total_tokens_issued
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id                 : 0x2::object::new(arg0),
            pools              : 0x2::vec_set::empty<0x2::object::ID>(),
            total_pools        : 0,
            total_value_locked : 0,
            admin              : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public entry fun invest_in_pool(arg0: &mut DistressedVaultPool, arg1: &mut PoolRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg0.status == 1 || arg0.status == 2, 3);
        assert!(v1 >= 5000000000000, 4);
        assert!(!arg0.locked, 2);
        let v3 = v1 / arg0.token_price;
        assert!(v3 > 0, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.investment_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total_tokens_issued = arg0.total_tokens_issued + v3;
        arg1.total_value_locked = arg1.total_value_locked + v1;
        let v4 = NPLToken{
            id                     : 0x2::object::new(arg4),
            pool_id                : 0x2::object::id<DistressedVaultPool>(arg0),
            symbol                 : arg0.token_symbol,
            amount                 : v3,
            investment_amount      : v1,
            entry_timestamp        : v2,
            lockup_end_at          : arg0.lockup_end_at,
            distributions_received : 0,
            owner                  : v0,
        };
        let v5 = InvestmentMade{
            pool_id         : 0x2::object::id<DistressedVaultPool>(arg0),
            investor        : v0,
            amount          : v1,
            tokens_received : v3,
            timestamp       : v2,
        };
        0x2::event::emit<InvestmentMade>(v5);
        0x2::transfer::transfer<NPLToken>(v4, v0);
    }

    public fun is_lockup_expired(arg0: &NPLToken, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.lockup_end_at
    }

    public entry fun lock_pool(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        arg0.locked = true;
    }

    public entry fun receive_recovery(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.recovery_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v0 = RecoveryReceived{
            pool_id         : 0x2::object::id<DistressedVaultPool>(arg0),
            vault_id        : arg2,
            recovery_amount : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            recovery_method : 0x1::string::utf8(arg4),
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<RecoveryReceived>(v0);
    }

    public entry fun redeem_tokens(arg0: &mut DistressedVaultPool, arg1: &mut PoolRegistry, arg2: NPLToken, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.lockup_end_at, 5);
        assert!(arg2.owner == v0, 1);
        assert!(arg2.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        let v1 = arg0.total_tokens_issued;
        let v2 = if (v1 > 0) {
            arg2.amount * 0x2::balance::value<0x2::sui::SUI>(&arg0.recovery_balance) / v1
        } else {
            0
        };
        arg0.total_tokens_issued = arg0.total_tokens_issued - arg2.amount;
        arg1.total_value_locked = arg1.total_value_locked - arg2.investment_amount;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.recovery_balance, v2), arg4), v0);
        };
        let NPLToken {
            id                     : v3,
            pool_id                : _,
            symbol                 : _,
            amount                 : _,
            investment_amount      : _,
            entry_timestamp        : _,
            lockup_end_at          : _,
            distributions_received : _,
            owner                  : _,
        } = arg2;
        0x2::object::delete(v3);
    }

    public entry fun update_pool_status(arg0: &mut DistressedVaultPool, arg1: &PoolAdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<DistressedVaultPool>(arg0), 1);
        assert!(arg2 <= 5, 8);
        arg0.status = arg2;
    }

    // decompiled from Move bytecode v6
}

