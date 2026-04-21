module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::staking_pool {
    struct StakingPool has store {
        total_eva_balance: 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>,
        total_shares: u64,
        last_synced_tranche_id: u64,
        active_shares: u64,
    }

    struct ProtocolTrancheKey has copy, drop, store {
        protocol_id: vector<u8>,
        tranche_id: u64,
    }

    struct StakingRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<vector<u8>, StakingPool>,
        tranche_shares: 0x2::table::Table<ProtocolTrancheKey, u64>,
    }

    struct StakeProof has store, key {
        id: 0x2::object::UID,
        protocol_id: vector<u8>,
        tranche_deposits: 0x2::table::Table<u64, u64>,
        total_shares: u64,
    }

    struct StakeEvent has copy, drop {
        protocol_id: vector<u8>,
        tranche_id: u64,
        eva_amount: u64,
        shares_minted: u64,
    }

    struct UnstakeEvent has copy, drop {
        protocol_id: vector<u8>,
        tranche_id: u64,
        shares_burned: u64,
        eva_amount: u64,
    }

    public fun add_protocol_pool(arg0: &mut StakingRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: 0x1::string::String) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = *0x1::string::as_bytes(&arg3);
        if (0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_already_exists();
        };
        let v1 = StakingPool{
            total_eva_balance      : 0x2::balance::zero<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(),
            total_shares           : 0,
            last_synced_tranche_id : 0,
            active_shares          : 0,
        };
        0x2::table::add<vector<u8>, StakingPool>(&mut arg0.pools, v0, v1);
    }

    fun add_tranche_shares(arg0: &mut StakingRegistry, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = ProtocolTrancheKey{
            protocol_id : arg1,
            tranche_id  : arg2,
        };
        if (0x2::table::contains<ProtocolTrancheKey, u64>(&arg0.tranche_shares, v0)) {
            let v1 = 0x2::table::borrow_mut<ProtocolTrancheKey, u64>(&mut arg0.tranche_shares, v0);
            *v1 = *v1 + arg3;
        } else {
            0x2::table::add<ProtocolTrancheKey, u64>(&mut arg0.tranche_shares, v0, arg3);
        };
    }

    public fun create_proof(arg0: &StakingRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : StakeProof {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_not_found();
        };
        StakeProof{
            id               : 0x2::object::new(arg2),
            protocol_id      : arg1,
            tranche_deposits : 0x2::table::new<u64, u64>(arg2),
            total_shares     : 0,
        }
    }

    public(friend) fun deposit_premium(arg0: &mut StakingRegistry, arg1: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg2: vector<u8>, arg3: 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>) {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_not_found();
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::sync_stake_update(arg1, arg2, 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg3), true);
        0x2::balance::join<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, arg2).total_eva_balance, arg3);
    }

    public(friend) fun distribute_premium(arg0: &mut StakingRegistry, arg1: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg2: vector<u8>, arg3: 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>) {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_not_found();
        };
        0x2::balance::join<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, arg2).total_eva_balance, arg3);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::sync_stake_update(arg1, arg2, 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg3), true);
    }

    public(friend) fun ensure_active_stake_synced(arg0: &mut StakingRegistry, arg1: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        process_expirations(arg0, arg1, arg2, arg3, arg4);
    }

    fun first_active_tranche_id(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg1: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg1) / 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::tranche_duration_ms(arg0)
    }

    public fun get_first_active_tranche_id(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg1: &0x2::clock::Clock) : u64 {
        first_active_tranche_id(arg0, arg1)
    }

    public(friend) fun get_pool_total_eva(arg0: &StakingRegistry, arg1: vector<u8>) : u64 {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg1)) {
            return 0
        };
        0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&0x2::table::borrow<vector<u8>, StakingPool>(&arg0.pools, arg1).total_eva_balance)
    }

    public fun get_pool_total_eva_and_shares(arg0: &StakingRegistry, arg1: vector<u8>) : (u64, u64) {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<vector<u8>, StakingPool>(&arg0.pools, arg1);
        (0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v0.total_eva_balance), v0.total_shares)
    }

    public fun get_proof_total_shares(arg0: &StakeProof) : u64 {
        arg0.total_shares
    }

    fun get_tranche_shares(arg0: &StakingRegistry, arg1: vector<u8>, arg2: u64) : u64 {
        let v0 = ProtocolTrancheKey{
            protocol_id : arg1,
            tranche_id  : arg2,
        };
        if (0x2::table::contains<ProtocolTrancheKey, u64>(&arg0.tranche_shares, v0)) {
            *0x2::table::borrow<ProtocolTrancheKey, u64>(&arg0.tranche_shares, v0)
        } else {
            0
        }
    }

    public fun get_tranche_shares_for_protocol(arg0: &StakingRegistry, arg1: vector<u8>, arg2: u64) : u64 {
        get_tranche_shares(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingRegistry{
            id             : 0x2::object::new(arg0),
            pools          : 0x2::table::new<vector<u8>, StakingPool>(arg0),
            tranche_shares : 0x2::table::new<ProtocolTrancheKey, u64>(arg0),
        };
        0x2::transfer::share_object<StakingRegistry>(v0);
    }

    fun process_expirations(arg0: &mut StakingRegistry, arg1: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg3)) {
            return
        };
        let v0 = first_active_tranche_id(arg2, arg4);
        let v1 = 0x2::table::borrow<vector<u8>, StakingPool>(&arg0.pools, arg3);
        let v2 = v1.active_shares;
        let v3 = v1.last_synced_tranche_id;
        while (v3 < v0) {
            let v4 = get_tranche_shares(arg0, arg3, v3);
            if (v4 > v2) {
                v2 = 0;
            } else {
                v2 = v2 - v4;
            };
            v3 = v3 + 1;
        };
        let v5 = 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, arg3);
        v5.last_synced_tranche_id = v0;
        v5.active_shares = v2;
        let (_, v7, _, _) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::get_protocol_status(arg1, arg3);
        let v10 = 0x2::table::borrow<vector<u8>, StakingPool>(&arg0.pools, arg3);
        let v11 = v10.total_shares;
        let v12 = if (v11 == 0) {
            0
        } else {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v10.total_eva_balance))), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v11)))
        };
        if (v12 < v7) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::sync_stake_update(arg1, arg3, v7 - v12, false);
        };
    }

    public(friend) fun remove_eva_for_claim(arg0: &mut StakingRegistry, arg1: vector<u8>, arg2: u64, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry) : 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA> {
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, arg1)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_not_found();
        };
        let v0 = 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, arg1);
        let v1 = 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v0.total_eva_balance);
        let v2 = if (arg2 >= v1) {
            v1
        } else {
            arg2
        };
        if (v2 == 0) {
            return 0x2::balance::zero<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>()
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::sync_stake_update(arg3, arg1, v2, false);
        0x2::balance::split<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut v0.total_eva_balance, v2)
    }

    public fun stake(arg0: &mut StakingRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg3: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg4: &mut StakeProof, arg5: 0x2::coin::Coin<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>, arg6: &0x2::clock::Clock) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = arg4.protocol_id;
        if (!0x2::table::contains<vector<u8>, StakingPool>(&arg0.pools, v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_protocol_pool_not_found();
        };
        process_expirations(arg0, arg2, arg3, v0, arg6);
        let v1 = first_active_tranche_id(arg3, arg6);
        let v2 = 0x2::coin::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg5);
        let v3 = 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, v0);
        let v4 = 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v3.total_eva_balance);
        let v5 = v3.total_shares;
        let v6 = if (v5 == 0 || v4 == 0) {
            v2
        } else {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v5)), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v4)))
        };
        v3.total_shares = v5 + v6;
        0x2::balance::join<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut v3.total_eva_balance, 0x2::coin::into_balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(arg5));
        v3.active_shares = v3.active_shares + v6;
        add_tranche_shares(arg0, v0, v1, v6);
        let v7 = StakeEvent{
            protocol_id   : v0,
            tranche_id    : v1,
            eva_amount    : v2,
            shares_minted : v6,
        };
        0x2::event::emit<StakeEvent>(v7);
        if (0x2::table::contains<u64, u64>(&arg4.tranche_deposits, v1)) {
            let v8 = 0x2::table::borrow_mut<u64, u64>(&mut arg4.tranche_deposits, v1);
            *v8 = *v8 + v6;
        } else {
            0x2::table::add<u64, u64>(&mut arg4.tranche_deposits, v1, v6);
        };
        arg4.total_shares = arg4.total_shares + v6;
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::sync_stake_update(arg2, v0, v2, true);
    }

    fun sub_tranche_shares(arg0: &mut StakingRegistry, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = ProtocolTrancheKey{
            protocol_id : arg1,
            tranche_id  : arg2,
        };
        let v1 = 0x2::table::borrow_mut<ProtocolTrancheKey, u64>(&mut arg0.tranche_shares, v0);
        if (*v1 < arg3) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_tranche_shares();
        };
        *v1 = *v1 - arg3;
        if (*v1 == 0) {
            0x2::table::remove<ProtocolTrancheKey, u64>(&mut arg0.tranche_shares, v0);
        };
    }

    public fun unstake(arg0: &mut StakingRegistry, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg3: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg4: &mut StakeProof, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg5 >= first_active_tranche_id(arg3, arg7)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_tranche_not_expired();
        };
        if (!0x2::table::contains<u64, u64>(&arg4.tranche_deposits, arg5)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_tranche_shares();
        };
        let v0 = 0x2::table::borrow_mut<u64, u64>(&mut arg4.tranche_deposits, arg5);
        if (*v0 < arg6) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_tranche_shares();
        };
        *v0 = *v0 - arg6;
        if (*v0 == 0) {
            0x2::table::remove<u64, u64>(&mut arg4.tranche_deposits, arg5);
        };
        arg4.total_shares = arg4.total_shares - arg6;
        let v1 = arg4.protocol_id;
        let v2 = 0x2::table::borrow<vector<u8>, StakingPool>(&arg0.pools, v1);
        let v3 = v2.total_shares;
        let v4 = if (arg6 == v3) {
            0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v2.total_eva_balance)
        } else {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg6), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v2.total_eva_balance))), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v3)))
        };
        sub_tranche_shares(arg0, v1, arg5, arg6);
        let v5 = UnstakeEvent{
            protocol_id   : v1,
            tranche_id    : arg5,
            shares_burned : arg6,
            eva_amount    : v4,
        };
        0x2::event::emit<UnstakeEvent>(v5);
        let v6 = 0x2::table::borrow_mut<vector<u8>, StakingPool>(&mut arg0.pools, v1);
        v6.total_shares = v3 - arg6;
        0x2::coin::from_balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(0x2::balance::split<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut v6.total_eva_balance, v4), arg8)
    }

    // decompiled from Move bytecode v6
}

