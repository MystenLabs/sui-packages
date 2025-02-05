module 0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::pool {
    struct StakingStatusUpdatedEvent has copy, drop {
        is_active: bool,
        timestamp: u64,
    }

    struct MinStakeAmountUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct MaxStakeLimitedUpdatedEvent has copy, drop {
        is_max_stake_limited: bool,
        timestamp: u64,
    }

    struct MaxStakeAmountUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct UnstakeLockTimeUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct MigratedEvent has copy, drop {
        prev_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct AprUpdatedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct RewardTokenDepositedEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct RewardTokenWithdrewEvent has copy, drop {
        prev_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct EmergencyWithdrewEvent has copy, drop {
        amount: u64,
        timestamp: u64,
    }

    struct StakeEvent has copy, drop {
        user_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop {
        user_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct ClaimEvent has copy, drop {
        user_address: address,
        amount: u64,
        timestamp: u64,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        is_active: bool,
        min_stake_amount: u64,
        is_max_stake_limited: bool,
        max_stake_amount: u64,
        unstake_lock_time: u64,
        current_apr: u64,
        stake_in_vault: 0x2::balance::Balance<T0>,
        total_claimed_amount: u64,
        reward_in_vault: 0x2::balance::Balance<T0>,
        user_info: 0x2::table::Table<address, UserInfo>,
        apr_history: vector<AprHistory>,
        stop_history: vector<StopHistory>,
    }

    struct UserInfo has copy, drop, store {
        user: address,
        stake_amount: u64,
        pending_reward_amount: u64,
        claimed_reward_amount: u64,
        last_claimed_timestamp: u64,
        last_updated_timestamp: u64,
        claim_history: vector<ClaimHistory>,
    }

    struct AprHistory has copy, drop, store {
        index: u64,
        apr: u64,
        start_timestamp: u64,
    }

    struct StopHistory has copy, drop, store {
        index: u64,
        start_timestamp: u64,
        end_timestamp: u64,
    }

    struct ClaimHistory has copy, drop, store {
        index: u64,
        amount: u64,
        timestamp: u64,
    }

    fun add_apr_history<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AprHistory{
            index           : arg1,
            apr             : arg2,
            start_timestamp : arg3,
        };
        0x1::vector::push_back<AprHistory>(&mut arg0.apr_history, v0);
    }

    fun assert_active<T0>(arg0: &Pool<T0>) {
        assert!(arg0.is_active, 100);
    }

    fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 1);
    }

    fun check_user_info(arg0: &mut 0x2::table::Table<address, UserInfo>, arg1: address) {
        if (!0x2::table::contains<address, UserInfo>(arg0, arg1)) {
            let v0 = UserInfo{
                user                   : arg1,
                stake_amount           : 0,
                pending_reward_amount  : 0,
                claimed_reward_amount  : 0,
                last_claimed_timestamp : 0,
                last_updated_timestamp : 0,
                claim_history          : 0x1::vector::empty<ClaimHistory>(),
            };
            0x2::table::add<address, UserInfo>(arg0, arg1, v0);
        };
    }

    public entry fun claim<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_active<T0>(arg0);
        assert_version<T0>(arg0);
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        update_user_reward(v0, &arg0.apr_history, arg1);
        let v2 = v0.pending_reward_amount;
        assert!(v2 > 0, 102);
        let v3 = ClaimEvent{
            user_address : 0x2::tx_context::sender(arg2),
            amount       : v2,
            timestamp    : v1,
        };
        0x2::event::emit<ClaimEvent>(v3);
        let v4 = ClaimHistory{
            index     : 0x1::vector::length<ClaimHistory>(&v0.claim_history),
            amount    : v2,
            timestamp : v1,
        };
        0x1::vector::push_back<ClaimHistory>(&mut v0.claim_history, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reward_in_vault, v2, arg2), 0x2::tx_context::sender(arg2));
        v0.claimed_reward_amount = v0.claimed_reward_amount + v2;
        v0.pending_reward_amount = 0;
        v0.last_claimed_timestamp = v1;
        arg0.total_claimed_amount = arg0.total_claimed_amount + v2;
    }

    public entry fun deposit_reward<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 102);
        let v1 = 0x2::balance::value<T0>(&arg1.reward_in_vault);
        let v2 = RewardTokenDepositedEvent{
            prev_value : v1,
            new_value  : v1 + v0,
            timestamp  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<RewardTokenDepositedEvent>(v2);
        0x2::coin::put<T0>(&mut arg1.reward_in_vault, arg2);
    }

    fun get_current_reward(arg0: &UserInfo, arg1: &vector<AprHistory>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        if (arg0.stake_amount > 0) {
            let v1 = arg0.last_updated_timestamp;
            let v2 = 0;
            while (v2 < 0x1::vector::length<AprHistory>(arg1)) {
                let v3 = if (v2 == 0x1::vector::length<AprHistory>(arg1) - 1) {
                    0x2::clock::timestamp_ms(arg2) / 1000 - max(0x1::vector::borrow<AprHistory>(arg1, v2).start_timestamp, v1)
                } else if (v1 >= 0x1::vector::borrow<AprHistory>(arg1, v2).start_timestamp && v1 < 0x1::vector::borrow<AprHistory>(arg1, v2 + 1).start_timestamp) {
                    0x1::vector::borrow<AprHistory>(arg1, v2 + 1).start_timestamp - v1
                } else if (v1 < 0x1::vector::borrow<AprHistory>(arg1, v2).start_timestamp) {
                    0x1::vector::borrow<AprHistory>(arg1, v2 + 1).start_timestamp - 0x1::vector::borrow<AprHistory>(arg1, v2).start_timestamp
                } else {
                    0
                };
                v0 = v0 + (arg0.stake_amount as u128) * (v3 as u128) * (0x1::vector::borrow<AprHistory>(arg1, v2).apr as u128) / (10000 as u128) / (31536000 as u128);
                v2 = v2 + 1;
            };
        };
        (v0 as u64)
    }

    public fun get_user_info<T0>(arg0: &Pool<T0>, arg1: address, arg2: &0x2::clock::Clock) : UserInfo {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg1)) {
            UserInfo{user: arg1, stake_amount: 0, pending_reward_amount: 0, claimed_reward_amount: 0, last_claimed_timestamp: 0, last_updated_timestamp: 0, claim_history: 0x1::vector::empty<ClaimHistory>()}
        } else {
            let v1 = *0x2::table::borrow<address, UserInfo>(&arg0.user_info, arg1);
            UserInfo{user: arg1, stake_amount: v1.stake_amount, pending_reward_amount: v1.pending_reward_amount + get_current_reward(&v1, &arg0.apr_history, arg2), claimed_reward_amount: v1.claimed_reward_amount, last_claimed_timestamp: v1.last_claimed_timestamp, last_updated_timestamp: v1.last_updated_timestamp, claim_history: v1.claim_history}
        }
    }

    public entry fun initialize_pool<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                   : 0x2::object::new(arg7),
            version              : 1,
            is_active            : true,
            min_stake_amount     : arg1,
            is_max_stake_limited : arg2,
            max_stake_amount     : arg3,
            unstake_lock_time    : arg4,
            current_apr          : arg6,
            stake_in_vault       : 0x2::balance::zero<T0>(),
            total_claimed_amount : 0,
            reward_in_vault      : 0x2::balance::zero<T0>(),
            user_info            : 0x2::table::new<address, UserInfo>(arg7),
            apr_history          : 0x1::vector::empty<AprHistory>(),
            stop_history         : 0x1::vector::empty<StopHistory>(),
        };
        let v1 = &mut v0;
        add_apr_history<T0>(v1, 0, arg6, 0x2::clock::timestamp_ms(arg5) / 1000);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public entry fun migrate<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.version < 1, 1);
        let v0 = MigratedEvent{
            prev_version : arg1.version,
            new_version  : 1,
            timestamp    : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<MigratedEvent>(v0);
        arg1.version = 1;
    }

    public entry fun stake<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active<T0>(arg0);
        assert_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_stake_amount, 103);
        let v1 = &mut arg0.user_info;
        check_user_info(v1, 0x2::tx_context::sender(arg3));
        let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg3));
        assert!(!arg0.is_max_stake_limited || arg0.is_max_stake_limited && v0 + v2.stake_amount <= arg0.max_stake_amount, 104);
        update_user_reward(v2, &arg0.apr_history, arg1);
        v2.stake_amount = v2.stake_amount + v0;
        0x2::coin::put<T0>(&mut arg0.stake_in_vault, arg2);
        let v3 = StakeEvent{
            user_address : 0x2::tx_context::sender(arg3),
            amount       : v0,
            timestamp    : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<StakeEvent>(v3);
    }

    public entry fun unstake<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active<T0>(arg0);
        assert_version<T0>(arg0);
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, 0x2::tx_context::sender(arg3));
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v0.last_updated_timestamp + arg0.unstake_lock_time, 105);
        assert!(v0.stake_amount >= arg1, 106);
        update_user_reward(v0, &arg0.apr_history, arg2);
        let v1 = UnstakeEvent{
            user_address : 0x2::tx_context::sender(arg3),
            amount       : arg1,
            timestamp    : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<UnstakeEvent>(v1);
        v0.stake_amount = v0.stake_amount - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.stake_in_vault, arg1, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun update_active_status<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        assert!(arg1.is_active != arg2, 101);
        arg1.is_active = arg2;
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = StakingStatusUpdatedEvent{
            is_active : arg2,
            timestamp : v0,
        };
        0x2::event::emit<StakingStatusUpdatedEvent>(v1);
        if (!arg2) {
            let v2 = StopHistory{
                index           : 0x1::vector::length<StopHistory>(&arg1.stop_history),
                start_timestamp : v0,
                end_timestamp   : 0,
            };
            0x1::vector::push_back<StopHistory>(&mut arg1.stop_history, v2);
        } else {
            0x1::vector::borrow_mut<StopHistory>(&mut arg1.stop_history, 0x1::vector::length<StopHistory>(&arg1.stop_history) - 1).end_timestamp = v0;
        };
    }

    public entry fun update_apr<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = AprUpdatedEvent{
            prev_value : arg1.current_apr,
            new_value  : arg2,
            timestamp  : v0,
        };
        0x2::event::emit<AprUpdatedEvent>(v1);
        arg1.current_apr = arg2;
        let v2 = 0x1::vector::length<AprHistory>(&arg1.apr_history);
        add_apr_history<T0>(arg1, v2, arg2, v0);
    }

    public entry fun update_is_max_stake_limited<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: bool, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = MaxStakeLimitedUpdatedEvent{
            is_max_stake_limited : arg2,
            timestamp            : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<MaxStakeLimitedUpdatedEvent>(v0);
        arg1.is_max_stake_limited = arg2;
    }

    public entry fun update_max_stake_amount<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = MaxStakeAmountUpdatedEvent{
            prev_value : arg1.max_stake_amount,
            new_value  : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<MaxStakeAmountUpdatedEvent>(v0);
        arg1.max_stake_amount = arg2;
    }

    public entry fun update_min_stake_amount<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = MinStakeAmountUpdatedEvent{
            prev_value : arg1.min_stake_amount,
            new_value  : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<MinStakeAmountUpdatedEvent>(v0);
        arg1.min_stake_amount = arg2;
    }

    public entry fun update_unstake_lock_time<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg1);
        let v0 = UnstakeLockTimeUpdatedEvent{
            prev_value : arg1.unstake_lock_time,
            new_value  : arg2,
            timestamp  : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<UnstakeLockTimeUpdatedEvent>(v0);
        arg1.unstake_lock_time = arg2;
    }

    fun update_user_reward(arg0: &mut UserInfo, arg1: &vector<AprHistory>, arg2: &0x2::clock::Clock) {
        arg0.pending_reward_amount = arg0.pending_reward_amount + get_current_reward(arg0, arg1, arg2);
        arg0.last_updated_timestamp = 0x2::clock::timestamp_ms(arg2) / 1000;
    }

    public entry fun withdraw_reward<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg1.reward_in_vault);
        assert!(v0 > 0, 102);
        let v1 = RewardTokenWithdrewEvent{
            prev_value : v0,
            new_value  : 0,
            timestamp  : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<RewardTokenWithdrewEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.reward_in_vault, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_staked_token<T0>(arg0: &0xb8376e4bb3732e23447ede589463dc3f2e9bfd944b949204082b93f12bcf18fa::ownership::OwnerCap, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg1.stake_in_vault);
        assert!(v0 > 0, 102);
        let v1 = EmergencyWithdrewEvent{
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<EmergencyWithdrewEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.stake_in_vault, v0, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

