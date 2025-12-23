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

    struct AirdropPackageCap has store, key {
        id: 0x2::object::UID,
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
        abort 18
    }

    public fun claim_unstake(arg0: &mut StakingPoolConfig, arg1: UnstakingTicket, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
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
        abort 18
    }

    public fun deposit(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    public fun deposit_rewards(arg0: &mut StakingPoolConfig, arg1: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
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
        abort 18
    }

    public fun get_basis_points_denominator() : u64 {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::basis_points_denominator()
    }

    public fun get_config_version(arg0: &StakingPoolConfig) : u64 {
        arg0.version
    }

    public fun get_multiplier_precision() : u64 {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::multiplier_precision()
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
        let v2 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(v1, v0) / 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::milliseconds_per_second();
        let v3 = arg0.acc_reward_per_share;
        let v4 = v3;
        if (v2 > 0 && arg0.total_share > 0) {
            v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u256(v3, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg0.total_reward_per_second, v2) as u256), 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::precision()), (arg0.total_share as u256)));
        };
        let v5 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(arg1.principal_balance, 0x2::table::borrow<u64, StakingPool>(&arg0.pool_details, arg1.lockup_duration_seconds).multiplier, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::multiplier_precision()) as u256), v4), 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::precision());
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

    public fun get_staking_receipt_view(arg0: &StakingReceipt) : (u64, u64, u64, 0x2::object::ID) {
        (arg0.principal_balance, arg0.stake_timestamp, arg0.lockup_duration_seconds, 0x2::object::uid_to_inner(&arg0.id))
    }

    public fun get_unstaking_delay_seconds(arg0: &StakingPoolConfig) : u64 {
        arg0.unstaking_delay_seconds
    }

    public fun get_version() : u64 {
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version()
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

    public fun is_pool_active(arg0: &StakingPoolConfig, arg1: u64) : bool {
        0x2::table::borrow<u64, StakingPool>(&arg0.pool_details, arg1).is_active
    }

    public fun is_pool_exists(arg0: &StakingPoolConfig, arg1: u64) : bool {
        0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1)
    }

    public(friend) fun mint_airdrop_package_cap(arg0: &mut 0x2::tx_context::TxContext) : AirdropPackageCap {
        AirdropPackageCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun pause_contract_internal(arg0: &mut StakingPoolConfig) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(!arg0.paused, 11);
        arg0.paused = true;
        let v0 = ContractPausedEvent{dummy_field: false};
        0x2::event::emit<ContractPausedEvent>(v0);
    }

    public fun pool_exists(arg0: &StakingPoolConfig, arg1: u64) : bool {
        0x2::table::contains<u64, StakingPool>(&arg0.pool_details, arg1)
    }

    public fun pre_staking_v2_deposit(arg0: &mut StakingPoolConfig, arg1: &AirdropPackageCap, arg2: 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 18
    }

    public(friend) fun remove_pool_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
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
        abort 18
    }

    public(friend) fun set_version(arg0: &mut StakingPoolConfig, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun stop_rewards_and_update_acc_internal(arg0: &mut StakingPoolConfig, arg1: &0x2::clock::Clock) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        update_pool_rewards_internal(arg0, 0x2::clock::timestamp_ms(arg1));
        arg0.total_reward_per_second = 0;
    }

    public(friend) fun unpause_contract_internal(arg0: &mut StakingPoolConfig) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg0.paused, 12);
        arg0.paused = false;
        let v0 = ContractUnpausedEvent{dummy_field: false};
        0x2::event::emit<ContractUnpausedEvent>(v0);
    }

    public(friend) fun update_penalty_rate_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg1 > 0 && arg1 <= 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::max_penalty_bps(), 10);
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
        let v1 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(arg1, v0) / 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::milliseconds_per_second();
        if (v1 == 0) {
            return
        };
        if (arg0.total_share > 0) {
            arg0.acc_reward_per_share = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u256(arg0.acc_reward_per_share, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_div_u256(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u256((0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg0.total_reward_per_second, v1) as u256), 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::precision()), (arg0.total_share as u256)));
        };
        arg0.last_reward_update_timestamp = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(v1, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::milliseconds_per_second()));
    }

    public(friend) fun update_reward_rate_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg1 == 0, 19);
        update_pool_rewards_internal(arg0, 0x2::clock::timestamp_ms(arg2));
        arg0.total_reward_per_second = arg1;
        let v0 = RewardRateUpdatedEvent{
            old_rate : arg0.total_reward_per_second,
            new_rate : arg1,
        };
        0x2::event::emit<RewardRateUpdatedEvent>(v0);
    }

    public(friend) fun update_unstaking_delay_internal(arg0: &mut StakingPoolConfig, arg1: u64) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg1 <= 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::max_lockup_duration_seconds(), 9);
        arg0.unstaking_delay_seconds = arg1;
        let v0 = UnstakingDelayUpdatedEvent{
            old_delay_seconds : arg0.unstaking_delay_seconds,
            new_delay_seconds : arg1,
        };
        0x2::event::emit<UnstakingDelayUpdatedEvent>(v0);
    }

    public(friend) fun withdraw_penalty_reserve_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg1 > 0, 6);
        let v0 = PenaltyReserveWithdrawnEvent{
            admin  : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<PenaltyReserveWithdrawnEvent>(v0);
        0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.penalty_reserve_balance, arg1), arg2)
    }

    public(friend) fun withdraw_principal_and_reward_balance_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>) {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
        assert!(arg1 > 0 && arg2 > 0, 6);
        (0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.principal_balance, arg1), 0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg0.reward_balance, arg2))
    }

    public(friend) fun withdraw_reward_balance_internal(arg0: &mut StakingPoolConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(arg0.version == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::version(), 0);
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

