module 0x5a00a4aa3c2abb13bc2ddab934c1bd4b216efcda7e4ed7348131c4bf4b3cb4b::staking_contract {
    struct TokenRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        token_type_name: 0x1::string::String,
    }

    struct StakingConfig has key {
        id: 0x2::object::UID,
        is_token_registry: bool,
        stake_token_type: 0x1::string::String,
        platform_fee_rate: u64,
        min_stake_amount: u64,
        min_annual_rate: u64,
        min_reward_coin_count: u64,
        pool_counter: u64,
        position_counter: u64,
        total_staked: u64,
        total_unstake: u64,
        total_claimed_rewards: u64,
        recommend_pool_id: 0x2::object::ID,
        recommend_pool_annual_rate: u64,
        recommend_pool_lock_duration_ms: u64,
        pool_ids: vector<0x2::object::ID>,
        active_pool_ids: vector<0x2::object::ID>,
        closed_pool_ids: vector<0x2::object::ID>,
        user_positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
        user_history_positions: 0x2::table::Table<address, vector<0x2::object::ID>>,
        user_pool_records: 0x2::table::Table<address, vector<0x2::object::ID>>,
        user_history_pool_records: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct StakePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_annual_rate: u64,
        pool_lock_duration_ms: u64,
        pool_total_staked: u64,
        pool_total_unstake: u64,
        pool_total_security_deposit: u64,
        pool_available_reward: u64,
        pool_creator: address,
        pool_created_at_ms: u64,
        pool_status: u8,
        pool_reward_vault: 0x2::balance::Balance<T0>,
        pool_stake_vault: 0x2::balance::Balance<T0>,
    }

    struct BeneficiaryInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        pending_beneficiary: address,
        total_rewards: u64,
        claimed_rewards: u64,
        platform_fee_vault: 0x2::balance::Balance<T0>,
    }

    struct OwnerInfo has store, key {
        id: 0x2::object::UID,
        owner: address,
        pending_owner: address,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        user: address,
        staked_amount: u64,
        reward_amount: u64,
        stake_time_ms: u64,
        lock_duration_ms: u64,
        claimed_reward: u64,
        status: u8,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct BeneficiaryCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
        annual_rate: u64,
        lock_duration_ms: u64,
        reward_amount: u64,
    }

    struct Staked has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        user: address,
        amount: u64,
        reward_amount: u64,
    }

    struct RewardClaimed has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        position_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    struct RewardAdded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct RewardWithDraw has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolClosed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct AddressChangeRequested has copy, drop {
        request_id: 0x2::object::ID,
        request_type: u8,
        old_address: address,
        new_address: address,
    }

    struct AddressChangeApproved has copy, drop {
        request_id: 0x2::object::ID,
        request_type: u8,
        old_address: address,
        new_address: address,
    }

    struct AddressChangeRejected has copy, drop {
        request_id: 0x2::object::ID,
        request_type: u8,
        old_address: address,
        new_address: address,
    }

    struct WithdRawneward has copy, drop {
        amount: u64,
        beneficiary: address,
    }

    struct Initialized has copy, drop {
        config_id: 0x2::object::ID,
        owner: address,
    }

    struct TokenRegistryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
        beneficiary: address,
    }

    public entry fun add_security_deposit_to_pool<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakePool<T0>, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_status == 0, 7);
        assert!(arg3 > 0, 0);
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2);
        assert!(v1 > 0, 0);
        let v2 = 0;
        while (v2 < v1) {
            v0 = v0 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(&arg2, v2));
            v2 = v2 + 1;
        };
        assert!(v0 >= arg3, 3);
        let v3 = 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg2, 0);
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) > 0) {
            0x2::coin::join<T0>(&mut v3, 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg2, 0));
        };
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0, 0);
        let (v4, v5) = if (0x2::coin::value<T0>(&v3) == arg3) {
            let v5 = v3;
            (0x2::coin::zero<T0>(arg4), v5)
        } else {
            let v5 = 0x2::coin::split<T0>(&mut v3, arg3, arg4);
            (v3, v5)
        };
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 == arg3, 0);
        arg1.pool_total_security_deposit = arg1.pool_total_security_deposit + v6;
        arg1.pool_available_reward = arg1.pool_available_reward + v6;
        0x2::balance::join<T0>(&mut arg1.pool_reward_vault, 0x2::coin::into_balance<T0>(v5));
        let v7 = RewardAdded{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            amount  : v6,
        };
        0x2::event::emit<RewardAdded>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
    }

    public fun approve_beneficiary_change<T0>(arg0: &TokenRegistry<T0>, arg1: BeneficiaryCap, arg2: address, arg3: &mut BeneficiaryInfo<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == arg3.pending_beneficiary, 9);
        arg3.beneficiary = arg2;
        arg3.pending_beneficiary = @0x0;
        0x2::transfer::transfer<BeneficiaryCap>(arg1, arg3.beneficiary);
    }

    public fun approve_owner_change(arg0: OwnerCap, arg1: &mut OwnerInfo, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == arg1.pending_owner, 9);
        arg1.owner = arg1.pending_owner;
        arg1.pending_owner = @0x0;
        0x2::transfer::transfer<OwnerCap>(arg0, arg1.owner);
    }

    fun calculate_claimable_reward(arg0: &StakePosition, arg1: u64) : u64 {
        if (arg1 <= arg0.stake_time_ms) {
            return 0
        };
        let v0 = arg1 - arg0.stake_time_ms;
        if (v0 >= arg0.lock_duration_ms) {
            return arg0.reward_amount
        };
        let v1 = (arg0.reward_amount as u128) * (v0 as u128) / (arg0.lock_duration_ms as u128);
        assert!(v1 <= 18446744073709551615, 19);
        (v1 as u64)
    }

    fun calculate_reward(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 1000000000000;
        let v1 = (arg0 as u128) * (arg1 as u128) * (arg2 as u128) * v0 / 31536000000 / 10000 / v0;
        assert!(v1 <= 18446744073709551615, 19);
        (v1 as u64)
    }

    public fun claim_reward<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &mut StakePool<T0>, arg3: &mut StakePosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.user == 0x2::tx_context::sender(arg5), 9);
        assert!(arg3.status == 0, 11);
        let v0 = calculate_claimable_reward(arg3, 0x2::clock::timestamp_ms(arg4)) - arg3.claimed_reward;
        assert!(v0 > 0, 0);
        arg3.claimed_reward = arg3.claimed_reward + v0;
        arg1.total_claimed_rewards = arg1.total_claimed_rewards + v0;
        let v1 = RewardClaimed{
            position_id : 0x2::object::uid_to_inner(&arg3.id),
            user        : arg3.user,
            amount      : v0,
        };
        0x2::event::emit<RewardClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool_reward_vault, v0), arg5), 0x2::tx_context::sender(arg5));
    }

    public fun close_stake_pool<T0>(arg0: &TokenRegistry<T0>, arg1: &OwnerCap, arg2: &mut StakePool<T0>, arg3: &mut StakingConfig, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.pool_status == 0, 7);
        assert!(arg2.pool_total_staked == 0 && arg2.pool_available_reward == 0, 0);
        assert!(0x2::balance::value<T0>(&arg2.pool_reward_vault) == 0 && 0x2::balance::value<T0>(&arg2.pool_stake_vault) == 0, 0);
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        arg2.pool_status = 1;
        let v1 = &mut arg3.active_pool_ids;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            if (*0x1::vector::borrow<0x2::object::ID>(v1, v2) == v0) {
                0x1::vector::remove<0x2::object::ID>(v1, v2);
                break
            };
            v2 = v2 + 1;
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg3.closed_pool_ids, v0);
        let v3 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg3.user_pool_records, v3)) {
            let v4 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg3.user_pool_records, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<0x2::object::ID>(v4)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v4, v5) == v0) {
                    0x1::vector::remove<0x2::object::ID>(v4, v5);
                    break
                };
                v5 = v5 + 1;
            };
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg3.user_history_pool_records, v3)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg3.user_history_pool_records, v3), v0);
        } else {
            let v6 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v6, v0);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg3.user_history_pool_records, v3, v6);
        };
        let v7 = PoolClosed{pool_id: 0x2::object::uid_to_inner(&arg2.id)};
        0x2::event::emit<PoolClosed>(v7);
    }

    public entry fun create_stake_pool<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: vector<0x2::coin::Coin<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(arg3 >= arg1.min_reward_coin_count, 0);
        assert!(arg4 > 0 && arg4 <= 100000, 1);
        assert!(arg4 >= arg1.min_annual_rate, 1);
        assert!(arg5 > 0, 2);
        assert!(arg5 <= 157680000000, 2);
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg2);
        assert!(v1 > 0, 0);
        let v2 = 0;
        while (v2 < v1) {
            v0 = v0 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(&arg2, v2));
            v2 = v2 + 1;
        };
        assert!(v0 >= arg3, 3);
        let v3 = 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg2, 0);
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) > 0) {
            0x2::coin::join<T0>(&mut v3, 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg2, 0));
        };
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg2) == 0, 0);
        let (v4, v5) = if (0x2::coin::value<T0>(&v3) == arg3) {
            let v5 = v3;
            (0x2::coin::zero<T0>(arg7), v5)
        } else {
            let v5 = 0x2::coin::split<T0>(&mut v3, arg3, arg7);
            (v3, v5)
        };
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 == arg3, 0);
        assert!(calculate_reward(arg1.min_stake_amount, arg4, arg5) > 0, 0);
        let v7 = StakePool<T0>{
            id                          : 0x2::object::new(arg7),
            pool_annual_rate            : arg4,
            pool_lock_duration_ms       : arg5,
            pool_total_staked           : 0,
            pool_total_unstake          : 0,
            pool_total_security_deposit : v6,
            pool_available_reward       : v6,
            pool_creator                : 0x2::tx_context::sender(arg7),
            pool_created_at_ms          : 0x2::clock::timestamp_ms(arg6),
            pool_status                 : 0,
            pool_reward_vault           : 0x2::balance::zero<T0>(),
            pool_stake_vault            : 0x2::balance::zero<T0>(),
        };
        arg1.pool_counter = arg1.pool_counter + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.pool_ids, 0x2::object::uid_to_inner(&v7.id));
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.active_pool_ids, 0x2::object::uid_to_inner(&v7.id));
        if (arg1.recommend_pool_annual_rate < arg4) {
            arg1.recommend_pool_id = 0x2::object::uid_to_inner(&v7.id);
            arg1.recommend_pool_annual_rate = arg4;
            arg1.recommend_pool_lock_duration_ms = arg5;
        };
        let v8 = 0x2::tx_context::sender(arg7);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_pool_records, v8)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_pool_records, v8), 0x2::object::uid_to_inner(&v7.id));
        } else {
            let v9 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v9, 0x2::object::uid_to_inner(&v7.id));
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_pool_records, v8, v9);
        };
        0x2::balance::join<T0>(&mut v7.pool_reward_vault, 0x2::coin::into_balance<T0>(v5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg7));
        0x2::transfer::share_object<StakePool<T0>>(v7);
        let v10 = PoolCreated{
            pool_id          : 0x2::object::uid_to_inner(&v7.id),
            creator          : 0x2::tx_context::sender(arg7),
            annual_rate      : arg4,
            lock_duration_ms : arg5,
            reward_amount    : v6,
        };
        0x2::event::emit<PoolCreated>(v10);
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
    }

    public fun get_claimable_reward(arg0: &StakePosition, arg1: &0x2::clock::Clock) : u64 {
        calculate_claimable_reward(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.claimed_reward
    }

    public fun get_pools_by_user(arg0: &StakingConfig, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_pool_records, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_pool_records, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_pools_paged(arg0: &StakingConfig, arg1: u8, arg2: u64, arg3: u64) : vector<0x2::object::ID> {
        let v0 = if (arg1 == 0) {
            &arg0.active_pool_ids
        } else if (arg1 == 1) {
            &arg0.closed_pool_ids
        } else {
            &arg0.pool_ids
        };
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (arg2 < 0x1::vector::length<0x2::object::ID>(v0) && arg2 < arg2 + arg3) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *0x1::vector::borrow<0x2::object::ID>(v0, arg2));
            arg2 = arg2 + 1;
        };
        v1
    }

    public fun get_position_unlock_time(arg0: &StakePosition) : u64 {
        arg0.stake_time_ms + arg0.lock_duration_ms
    }

    public fun get_positions_by_user(arg0: &StakingConfig, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_positions, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_positions, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_history_pools(arg0: &StakingConfig, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_history_pool_records, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_history_pool_records, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_user_history_positions(arg0: &StakingConfig, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.user_history_positions, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.user_history_positions, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingConfig{
            id                              : 0x2::object::new(arg0),
            is_token_registry               : false,
            stake_token_type                : 0x1::string::utf8(b"SUI"),
            platform_fee_rate               : 500,
            min_stake_amount                : 1000000,
            min_annual_rate                 : 100,
            min_reward_coin_count           : 1000000000,
            pool_counter                    : 0,
            position_counter                : 0,
            total_staked                    : 0,
            total_unstake                   : 0,
            total_claimed_rewards           : 0,
            recommend_pool_id               : 0x2::object::id_from_address(@0x0),
            recommend_pool_annual_rate      : 0,
            recommend_pool_lock_duration_ms : 0,
            pool_ids                        : 0x1::vector::empty<0x2::object::ID>(),
            active_pool_ids                 : 0x1::vector::empty<0x2::object::ID>(),
            closed_pool_ids                 : 0x1::vector::empty<0x2::object::ID>(),
            user_positions                  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            user_history_positions          : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            user_pool_records               : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            user_history_pool_records       : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        let v2 = OwnerInfo{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            pending_owner : @0x0,
        };
        let v3 = BeneficiaryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<StakingConfig>(v0);
        0x2::transfer::share_object<OwnerInfo>(v2);
        let v4 = Initialized{
            config_id : 0x2::object::uid_to_inner(&v0.id),
            owner     : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<Initialized>(v4);
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<BeneficiaryCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_token<T0>(arg0: &mut StakingConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_token_registry, 18);
        let v0 = TokenRegistry<T0>{
            id              : 0x2::object::new(arg1),
            token_type_name : arg0.stake_token_type,
        };
        let v1 = BeneficiaryInfo<T0>{
            id                  : 0x2::object::new(arg1),
            beneficiary         : 0x2::tx_context::sender(arg1),
            pending_beneficiary : @0x0,
            total_rewards       : 0,
            claimed_rewards     : 0,
            platform_fee_vault  : 0x2::balance::zero<T0>(),
        };
        arg0.is_token_registry = true;
        0x2::transfer::share_object<TokenRegistry<T0>>(v0);
        0x2::transfer::share_object<BeneficiaryInfo<T0>>(v1);
        let v2 = TokenRegistryInitialized{
            registry_id : 0x2::object::uid_to_inner(&v0.id),
            beneficiary : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TokenRegistryInitialized>(v2);
    }

    public fun is_position_unlocked(arg0: &StakePosition, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.stake_time_ms + arg0.lock_duration_ms
    }

    public fun request_beneficiary_change<T0>(arg0: &TokenRegistry<T0>, arg1: &mut BeneficiaryInfo<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 10);
        assert!(arg2 != arg1.beneficiary, 10);
        arg1.pending_beneficiary = arg2;
    }

    public fun request_owner_change(arg0: &mut OwnerInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 10);
        assert!(arg1 != arg0.owner, 10);
        arg0.pending_owner = arg1;
    }

    public entry fun stake<T0>(arg0: &TokenRegistry<T0>, arg1: &mut BeneficiaryInfo<T0>, arg2: &mut StakePool<T0>, arg3: &mut StakingConfig, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.pool_status == 0, 7);
        assert!(arg5 >= arg3.min_stake_amount, 3);
        let v0 = calculate_reward(arg5, arg2.pool_annual_rate, arg2.pool_lock_duration_ms);
        assert!(arg2.pool_available_reward >= v0, 4);
        arg2.pool_total_staked = arg2.pool_total_staked + arg5;
        arg2.pool_available_reward = arg2.pool_available_reward - v0;
        let v1 = 0;
        let v2 = 0x1::vector::length<0x2::coin::Coin<T0>>(&arg4);
        assert!(v2 > 0, 0);
        let v3 = 0;
        while (v3 < v2) {
            v1 = v1 + 0x2::coin::value<T0>(0x1::vector::borrow<0x2::coin::Coin<T0>>(&arg4, v3));
            v3 = v3 + 1;
        };
        assert!(v1 >= arg5, 3);
        let v4 = 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg4, 0);
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg4) > 0) {
            0x2::coin::join<T0>(&mut v4, 0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg4, 0));
        };
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg4) == 0, 0);
        let (v5, v6) = if (0x2::coin::value<T0>(&v4) == arg5) {
            let v6 = v4;
            (0x2::coin::zero<T0>(arg7), v6)
        } else {
            let v6 = 0x2::coin::split<T0>(&mut v4, arg5, arg7);
            (v4, v6)
        };
        assert!(0x2::coin::value<T0>(&v6) == arg5, 0);
        let v7 = v0 * arg3.platform_fee_rate / 10000;
        let v8 = v0 - v7;
        0x2::balance::join<T0>(&mut arg1.platform_fee_vault, 0x2::balance::split<T0>(&mut arg2.pool_reward_vault, v7));
        arg1.total_rewards = arg1.total_rewards + v7;
        let v9 = StakePosition{
            id               : 0x2::object::new(arg7),
            pool_id          : 0x2::object::uid_to_inner(&arg2.id),
            user             : 0x2::tx_context::sender(arg7),
            staked_amount    : arg5,
            reward_amount    : v8,
            stake_time_ms    : 0x2::clock::timestamp_ms(arg6),
            lock_duration_ms : arg2.pool_lock_duration_ms,
            claimed_reward   : 0,
            status           : 0,
        };
        arg3.position_counter = arg3.position_counter + 1;
        arg3.total_staked = arg3.total_staked + arg5;
        let v10 = 0x2::tx_context::sender(arg7);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg3.user_positions, v10)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg3.user_positions, v10), 0x2::object::uid_to_inner(&v9.id));
        } else {
            let v11 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v11, 0x2::object::uid_to_inner(&v9.id));
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg3.user_positions, v10, v11);
        };
        0x2::balance::join<T0>(&mut arg2.pool_stake_vault, 0x2::coin::into_balance<T0>(v6));
        0x2::transfer::share_object<StakePosition>(v9);
        let v12 = Staked{
            pool_id       : 0x2::object::uid_to_inner(&arg2.id),
            position_id   : 0x2::object::uid_to_inner(&v9.id),
            user          : 0x2::tx_context::sender(arg7),
            amount        : arg5,
            reward_amount : v8,
        };
        0x2::event::emit<Staked>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg7));
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg4);
    }

    public fun unstake<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &mut StakePool<T0>, arg3: &mut StakePosition, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.user == 0x2::tx_context::sender(arg5), 9);
        assert!(arg3.status == 0, 11);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg3.stake_time_ms + arg3.lock_duration_ms, 8);
        let v0 = arg3.reward_amount - arg3.claimed_reward;
        arg3.status = 1;
        arg3.claimed_reward = arg3.reward_amount;
        arg2.pool_total_staked = arg2.pool_total_staked - arg3.staked_amount;
        arg2.pool_total_unstake = arg2.pool_total_unstake + arg3.staked_amount;
        arg1.total_unstake = arg1.total_unstake + arg3.staked_amount;
        arg1.position_counter = arg1.position_counter - 1;
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::uid_to_inner(&arg3.id);
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_positions, v1)) {
            let v3 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_positions, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<0x2::object::ID>(v3)) {
                if (*0x1::vector::borrow<0x2::object::ID>(v3, v4) == v2) {
                    0x1::vector::remove<0x2::object::ID>(v3, v4);
                    break
                };
                v4 = v4 + 1;
            };
        };
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg1.user_history_positions, v1)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.user_history_positions, v1), v2);
        } else {
            let v5 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v5, v2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg1.user_history_positions, v1, v5);
        };
        if (v0 > 0) {
            arg1.total_claimed_rewards = arg1.total_claimed_rewards + v0;
            let v6 = Unstaked{
                position_id : 0x2::object::uid_to_inner(&arg3.id),
                user        : arg3.user,
                amount      : arg3.staked_amount,
            };
            0x2::event::emit<Unstaked>(v6);
            let v7 = RewardClaimed{
                position_id : 0x2::object::uid_to_inner(&arg3.id),
                user        : arg3.user,
                amount      : v0,
            };
            0x2::event::emit<RewardClaimed>(v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool_stake_vault, arg3.staked_amount), arg5), 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool_reward_vault, v0), arg5), 0x2::tx_context::sender(arg5));
        } else {
            let v8 = Unstaked{
                position_id : 0x2::object::uid_to_inner(&arg3.id),
                user        : arg3.user,
                amount      : arg3.staked_amount,
            };
            0x2::event::emit<Unstaked>(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.pool_stake_vault, arg3.staked_amount), arg5), 0x2::tx_context::sender(arg5));
        };
    }

    public fun update_min_annual_rate<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &OwnerCap, arg3: u64) {
        assert!(arg3 > 0 && arg3 <= 10000, 1);
        arg1.min_annual_rate = arg3;
    }

    public fun update_min_reward_coin_count<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &OwnerCap, arg3: u64) {
        assert!(arg3 > 0, 0);
        arg1.min_reward_coin_count = arg3;
    }

    public fun update_platform_fee_rate<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &OwnerCap, arg3: u64) {
        assert!(arg3 <= 2000, 1);
        arg1.platform_fee_rate = arg3;
    }

    public fun update_recommend_pool_info<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakingConfig, arg2: &OwnerCap, arg3: &StakePool<T0>) {
        assert!(arg3.pool_status == 0, 0);
        arg1.recommend_pool_annual_rate = arg3.pool_annual_rate;
        arg1.recommend_pool_lock_duration_ms = arg3.pool_lock_duration_ms;
        arg1.recommend_pool_id = 0x2::object::uid_to_inner(&arg3.id);
    }

    public fun withdraw_platform_fee<T0>(arg0: &TokenRegistry<T0>, arg1: &mut BeneficiaryInfo<T0>, arg2: &BeneficiaryCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_rewards > 0, 0);
        let v0 = arg1.total_rewards - arg1.claimed_rewards;
        assert!(v0 > 0, 0);
        arg1.claimed_rewards = arg1.claimed_rewards + v0;
        let v1 = WithdRawneward{
            amount      : v0,
            beneficiary : arg1.beneficiary,
        };
        0x2::event::emit<WithdRawneward>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.platform_fee_vault, v0), arg3), arg1.beneficiary);
    }

    public entry fun withdraw_reward_to_pool<T0>(arg0: &TokenRegistry<T0>, arg1: &mut StakePool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.pool_creator, 9);
        assert!(arg1.pool_status == 0, 7);
        assert!(arg2 > 0, 0);
        assert!(arg2 <= arg1.pool_available_reward, 0);
        arg1.pool_total_security_deposit = arg1.pool_total_security_deposit - arg2;
        arg1.pool_available_reward = arg1.pool_available_reward - arg2;
        let v0 = RewardWithDraw{
            pool_id : 0x2::object::uid_to_inner(&arg1.id),
            amount  : arg2,
        };
        0x2::event::emit<RewardWithDraw>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool_reward_vault, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

