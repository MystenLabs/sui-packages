module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking {
    struct StakingPoolConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        total_reward_per_second: u64,
        unstaking_delay_seconds: u64,
        early_unstake_penalty_bps: u64,
        pool_details: 0x2::table::Table<u64, StakingPool>,
        acc_reward_per_share: u256,
        last_reward_update_timestamp: u64,
        total_share: u256,
        reward_balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
        principal_balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
        penalty_reserve_balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
        paused: bool,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        lockup_duration_seconds: u64,
        total_principal: u64,
        multiplier: u64,
        is_active: bool,
    }

    struct StakingReceipt has key {
        id: 0x2::object::UID,
        pool_config_id: 0x2::object::ID,
        principal_balance: u64,
        stake_timestamp: u64,
        lockup_end_timestamp: u64,
        lockup_duration_seconds: u64,
        reward_debt: u256,
    }

    struct UnstakingTicket has key {
        id: 0x2::object::UID,
        principal_to_return: u64,
        rewards_to_claim: u64,
        unlock_timestamp: u64,
        pool_lockup_duration_seconds: u64,
        return_balance: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
    }

    struct STAKING has drop {
        dummy_field: bool,
    }

    struct DepositedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        staking_receipt_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_minted: u256,
        timestamp: u64,
    }

    struct UnstakeRequestedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        staking_receipt_id: 0x2::object::ID,
        unstaking_ticket_id: 0x2::object::ID,
        user: address,
        principal_amount: u64,
        pending_rewards: u64,
        unlock_timestamp: u64,
        penalty_bps_at_request: u64,
    }

    struct ClaimedEvent has copy, drop {
        unstaking_ticket_id: 0x2::object::ID,
        user: address,
        principal_returned: u64,
        rewards_claimed: u64,
        pool_lockup_duration_seconds: u64,
    }

    struct EarlyUnstakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        staking_receipt_id: 0x2::object::ID,
        user: address,
        principal_amount: u64,
        rewards_claimed: u64,
        penalty_amount: u64,
        penalty_bps_applied: u64,
        pool_lockup_duration_seconds: u64,
    }

    struct RewardDepositedEvent has copy, drop {
        depositor: address,
        amount: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        lockup_duration_seconds: u64,
        multiplier: u64,
    }

    struct ContractPausedEvent has copy, drop {
        dummy_field: bool,
    }

    struct ContractUnpausedEvent has copy, drop {
        dummy_field: bool,
    }

    struct RewardRateUpdatedEvent has copy, drop {
        old_rate: u64,
        new_rate: u64,
    }

    struct PenaltyRateUpdatedEvent has copy, drop {
        old_penalty_bps: u64,
        new_penalty_bps: u64,
    }

    struct UnstakingDelayUpdatedEvent has copy, drop {
        old_delay_seconds: u64,
        new_delay_seconds: u64,
    }

    struct PenaltyReserveWithdrawnEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct RewardBalanceWithdrawnEvent has copy, drop {
        admin: address,
        amount: u64,
    }

    struct PoolActivatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        lockup_duration_seconds: u64,
        admin: address,
    }

    struct PoolRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        lockup_duration_seconds: u64,
        multiplier: u64,
    }

    public(friend) fun activate_pool_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1), 3);
        let v0 = 0x2::table::borrow_mut<u64, StakingPool>(&mut arg0.pool_details, arg1);
        assert!(!v0.is_active, 16);
        v0.is_active = true;
        let v1 = PoolActivatedEvent{
            pool_id                 : 0x2::object::uid_to_inner(&v0.id),
            lockup_duration_seconds : arg1,
            admin                   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolActivatedEvent>(v1);
    }

    public fun claim_unstake(arg0: &mut StakingPoolConfig, arg1: UnstakingTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 8);
        assert!(arg1.unlock_timestamp <= 0x2::clock::timestamp_ms(arg2), 2);
        let UnstakingTicket {
            id                           : v0,
            principal_to_return          : v1,
            rewards_to_claim             : v2,
            unlock_timestamp             : _,
            pool_lockup_duration_seconds : v4,
            return_balance               : v5,
        } = arg1;
        let v6 = v0;
        let v7 = ClaimedEvent{
            unstaking_ticket_id          : 0x2::object::uid_to_inner(&v6),
            user                         : 0x2::tx_context::sender(arg3),
            principal_returned           : v1,
            rewards_claimed              : v2,
            pool_lockup_duration_seconds : v4,
        };
        0x2::event::emit<ClaimedEvent>(v7);
        0x2::object::delete(v6);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(v5, arg3)
    }

    public(friend) fun create_pool_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1), 4);
        assert!(arg2 >= 100 && arg2 <= 2000, 5);
        let v0 = StakingPool{
            id                      : 0x2::object::new(arg3),
            lockup_duration_seconds : arg1,
            total_principal         : 0,
            multiplier              : arg2,
            is_active               : false,
        };
        0x2::table::add<u64, StakingPool>(&mut arg0.pool_details, arg1, v0);
        let v1 = PoolCreatedEvent{
            pool_id                 : 0x2::object::uid_to_inner(&v0.id),
            lockup_duration_seconds : arg1,
            multiplier              : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v1);
    }

    public fun deposit(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 8);
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1), 3);
        assert!(arg3 >= 10000, 6);
        assert!(0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg2) >= arg3, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        update_pool_rewards_internal(arg0, v0);
        let v1 = 0x2::table::borrow_mut<u64, StakingPool>(&mut arg0.pool_details, arg1);
        assert!(v1.is_active, 15);
        v1.total_principal = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v1.total_principal, arg3);
        let v2 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg3, v1.multiplier, 100);
        arg0.total_share = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u256(arg0.total_share, (v2 as u256));
        let v3 = StakingReceipt{
            id                      : 0x2::object::new(arg5),
            pool_config_id          : 0x2::object::uid_to_inner(&arg0.id),
            principal_balance       : arg3,
            stake_timestamp         : v0,
            lockup_end_timestamp    : 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(v1.lockup_duration_seconds, 1000)),
            lockup_duration_seconds : arg1,
            reward_debt             : 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u256((v2 as u256), arg0.acc_reward_per_share, 1000000000000000000),
        };
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.principal_balance, 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::coin::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg2, arg3, arg5)));
        let v4 = DepositedEvent{
            pool_id            : 0x2::object::uid_to_inner(&v1.id),
            staking_receipt_id : 0x2::object::uid_to_inner(&v3.id),
            user               : 0x2::tx_context::sender(arg5),
            amount             : arg3,
            shares_minted      : (v2 as u256),
            timestamp          : v0,
        };
        0x2::event::emit<DepositedEvent>(v4);
        0x2::transfer::transfer<StakingReceipt>(v3, 0x2::tx_context::sender(arg5));
    }

    public fun deposit_rewards(arg0: &mut StakingPoolConfig, arg1: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 8);
        let v0 = 0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg1);
        assert!(v0 > 0, 6);
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.reward_balance, 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg1));
        let v1 = RewardDepositedEvent{
            depositor : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<RewardDepositedEvent>(v1);
    }

    public fun early_unstake_and_claim(arg0: &mut StakingPoolConfig, arg1: StakingReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        update_pool_rewards_internal(arg0, v0);
        let v1 = arg1.lockup_duration_seconds;
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, v1), 3);
        assert!(v0 < arg1.lockup_end_timestamp, 2);
        let v2 = 0x2::table::borrow_mut<u64, StakingPool>(&mut arg0.pool_details, v1);
        let v3 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg1.principal_balance, v2.multiplier, 100);
        let v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((v3 as u256), arg0.acc_reward_per_share), 1000000000000000000), arg1.reward_debt);
        let v5 = arg0.early_unstake_penalty_bps;
        let v6 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg1.principal_balance, v5, 10000);
        let v7 = 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.principal_balance, arg1.principal_balance);
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v7, 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.reward_balance, (v4 as u64)));
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.penalty_reserve_balance, 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v7, v6));
        v2.total_principal = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(v2.total_principal, arg1.principal_balance);
        arg0.total_share = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u256(arg0.total_share, (v3 as u256));
        let StakingReceipt {
            id                      : v8,
            pool_config_id          : _,
            principal_balance       : _,
            stake_timestamp         : _,
            lockup_end_timestamp    : _,
            lockup_duration_seconds : _,
            reward_debt             : _,
        } = arg1;
        0x2::object::delete(v8);
        let v15 = EarlyUnstakeEvent{
            pool_id                      : 0x2::object::uid_to_inner(&v2.id),
            staking_receipt_id           : 0x2::object::uid_to_inner(&arg1.id),
            user                         : 0x2::tx_context::sender(arg3),
            principal_amount             : arg1.principal_balance,
            rewards_claimed              : (v4 as u64),
            penalty_amount               : v6,
            penalty_bps_applied          : v5,
            pool_lockup_duration_seconds : v1,
        };
        0x2::event::emit<EarlyUnstakeEvent>(v15);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(v7, arg3)
    }

    public fun get_basis_points_denominator() : u64 {
        10000
    }

    public fun get_multiplier_precision() : u64 {
        100
    }

    public fun get_penalty_reserve_balance(arg0: &StakingPoolConfig) : u64 {
        0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg0.penalty_reserve_balance)
    }

    public fun get_pending_reward(arg0: &StakingPoolConfig, arg1: &StakingReceipt, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0.last_reward_update_timestamp;
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (v0 == 0) {
            return 0
        };
        if (v1 < v0) {
            return 0
        };
        let v2 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(v1, v0) / 1000;
        let v3 = arg0.acc_reward_per_share;
        let v4 = v3;
        if (v2 > 0 && arg0.total_share > 0) {
            v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u256(v3, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg0.total_reward_per_second, v2) as u256), 1000000000000000000), (arg0.total_share as u256)));
        };
        let v5 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg1.principal_balance, 0x2::table::borrow<u64, StakingPool>(&arg0.pool_details, arg1.lockup_duration_seconds).multiplier, 100) as u256), v4), 1000000000000000000);
        if (v5 <= arg1.reward_debt) {
            return 0
        };
        (0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u256(v5, arg1.reward_debt) as u64)
    }

    public fun get_pool_info(arg0: &StakingPoolConfig, arg1: u64) : (u64, u64, u64, bool) {
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1), 3);
        let v0 = 0x2::table::borrow<u64, StakingPool>(&arg0.pool_details, arg1);
        (v0.lockup_duration_seconds, v0.total_principal, v0.multiplier, v0.is_active)
    }

    public fun get_version() : u64 {
        1
    }

    fun init(arg0: STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAKING>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = StakingPoolConfig{
            id                           : 0x2::object::new(arg1),
            version                      : 1,
            total_reward_per_second      : 0,
            unstaking_delay_seconds      : 0,
            early_unstake_penalty_bps    : 0,
            pool_details                 : 0x2::table::new<u64, StakingPool>(arg1),
            acc_reward_per_share         : 0,
            last_reward_update_timestamp : 0,
            total_share                  : 0,
            reward_balance               : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
            principal_balance            : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
            penalty_reserve_balance      : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
            paused                       : false,
        };
        0x2::transfer::public_share_object<StakingPoolConfig>(v0);
    }

    public fun is_paused(arg0: &StakingPoolConfig) : bool {
        arg0.paused
    }

    public(friend) fun pause_contract_internal(arg0: &mut StakingPoolConfig) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 11);
        arg0.paused = true;
        let v0 = ContractPausedEvent{dummy_field: false};
        0x2::event::emit<ContractPausedEvent>(v0);
    }

    public fun pool_exists(arg0: &StakingPoolConfig, arg1: u64) : bool {
        0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1)
    }

    public(friend) fun remove_pool_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 1, 0);
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1), 3);
        let v0 = 0x2::table::borrow<u64, StakingPool>(&arg0.pool_details, arg1);
        assert!(!v0.is_active, 16);
        let v1 = v0.multiplier;
        let StakingPool {
            id                      : v2,
            lockup_duration_seconds : _,
            total_principal         : _,
            multiplier              : _,
            is_active               : _,
        } = 0x2::table::remove<u64, StakingPool>(&mut arg0.pool_details, arg1);
        0x2::object::delete(v2);
        let v7 = PoolRemovedEvent{
            pool_id                 : 0x2::object::uid_to_inner(&v0.id),
            lockup_duration_seconds : arg1,
            multiplier              : v1,
        };
        0x2::event::emit<PoolRemovedEvent>(v7);
    }

    public fun request_unstake(arg0: &mut StakingPoolConfig, arg1: StakingReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        update_pool_rewards_internal(arg0, v0);
        let v1 = arg1.lockup_duration_seconds;
        assert!(0x2::table::contains<u64, StakingPool>(&arg0.pool_details, v1), 3);
        assert!(v0 >= arg1.lockup_end_timestamp, 2);
        let v2 = 0x2::table::borrow_mut<u64, StakingPool>(&mut arg0.pool_details, v1);
        let v3 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg1.principal_balance, v2.multiplier, 100);
        let v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((v3 as u256), arg0.acc_reward_per_share), 1000000000000000000), arg1.reward_debt);
        let v5 = 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.principal_balance, arg1.principal_balance);
        0x2::balance::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v5, 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.reward_balance, (v4 as u64)));
        let v6 = UnstakingTicket{
            id                           : 0x2::object::new(arg3),
            principal_to_return          : arg1.principal_balance,
            rewards_to_claim             : (v4 as u64),
            unlock_timestamp             : 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg0.unstaking_delay_seconds, 1000)),
            pool_lockup_duration_seconds : v1,
            return_balance               : v5,
        };
        v2.total_principal = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(v2.total_principal, arg1.principal_balance);
        arg0.total_share = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u256(arg0.total_share, (v3 as u256));
        let StakingReceipt {
            id                      : v7,
            pool_config_id          : _,
            principal_balance       : _,
            stake_timestamp         : _,
            lockup_end_timestamp    : _,
            lockup_duration_seconds : _,
            reward_debt             : _,
        } = arg1;
        0x2::object::delete(v7);
        let v14 = UnstakeRequestedEvent{
            pool_id                : 0x2::object::uid_to_inner(&v2.id),
            staking_receipt_id     : 0x2::object::uid_to_inner(&arg1.id),
            unstaking_ticket_id    : 0x2::object::uid_to_inner(&v6.id),
            user                   : 0x2::tx_context::sender(arg3),
            principal_amount       : v6.principal_to_return,
            pending_rewards        : v6.rewards_to_claim,
            unlock_timestamp       : v6.unlock_timestamp,
            penalty_bps_at_request : 0,
        };
        0x2::event::emit<UnstakeRequestedEvent>(v14);
        0x2::transfer::transfer<UnstakingTicket>(v6, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun unpause_contract_internal(arg0: &mut StakingPoolConfig) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.paused, 12);
        arg0.paused = false;
        let v0 = ContractUnpausedEvent{dummy_field: false};
        0x2::event::emit<ContractUnpausedEvent>(v0);
    }

    public(friend) fun update_penalty_rate_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 1, 0);
        assert!(arg1 > 0 && arg1 <= 10000, 10);
        arg0.early_unstake_penalty_bps = arg1;
        let v0 = PenaltyRateUpdatedEvent{
            old_penalty_bps : arg0.early_unstake_penalty_bps,
            new_penalty_bps : arg1,
        };
        0x2::event::emit<PenaltyRateUpdatedEvent>(v0);
    }

    fun update_pool_rewards_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        let v0 = arg0.last_reward_update_timestamp;
        if (v0 == 0) {
            arg0.last_reward_update_timestamp = arg1;
            return
        };
        assert!(arg1 >= v0, 7);
        let v1 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(arg1, v0) / 1000;
        if (v1 == 0) {
            return
        };
        if (arg0.total_share > 0) {
            arg0.acc_reward_per_share = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u256(arg0.acc_reward_per_share, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg0.total_reward_per_second, v1) as u256), 1000000000000000000), (arg0.total_share as u256)));
        };
        arg0.last_reward_update_timestamp = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(v1, 1000));
    }

    public(friend) fun update_reward_rate_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        update_pool_rewards_internal(arg0, 0x2::clock::timestamp_ms(arg2));
        arg0.total_reward_per_second = arg1;
        let v0 = RewardRateUpdatedEvent{
            old_rate : arg0.total_reward_per_second,
            new_rate : arg1,
        };
        0x2::event::emit<RewardRateUpdatedEvent>(v0);
    }

    public(friend) fun update_unstaking_delay_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 1, 0);
        assert!(arg1 <= 2592000, 9);
        arg0.unstaking_delay_seconds = arg1;
        let v0 = UnstakingDelayUpdatedEvent{
            old_delay_seconds : arg0.unstaking_delay_seconds,
            new_delay_seconds : arg1,
        };
        0x2::event::emit<UnstakingDelayUpdatedEvent>(v0);
    }

    public(friend) fun withdraw_penalty_reserve_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 1, 0);
        assert!(arg1 > 0, 6);
        let v0 = PenaltyReserveWithdrawnEvent{
            admin  : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<PenaltyReserveWithdrawnEvent>(v0);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.penalty_reserve_balance, arg1), arg2)
    }

    public(friend) fun withdraw_reward_balance_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 1, 0);
        assert!(arg1 > 0, 6);
        let v0 = RewardBalanceWithdrawnEvent{
            admin  : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<RewardBalanceWithdrawnEvent>(v0);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.reward_balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

