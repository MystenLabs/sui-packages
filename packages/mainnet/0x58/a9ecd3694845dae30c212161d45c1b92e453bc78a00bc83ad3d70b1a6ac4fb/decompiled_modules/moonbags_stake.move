module 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_stake {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        deny_unstake_duration_ms: u64,
    }

    struct StakingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        staking_token: 0x2::coin::Coin<T0>,
        sui_token: 0x2::coin::Coin<0x2::sui::SUI>,
        total_supply: u64,
        reward_index: u128,
        pending_initial_rewards: u64,
    }

    struct CreatorPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        sui_token: 0x2::coin::Coin<0x2::sui::SUI>,
        creator: address,
    }

    struct StakingAccount has store, key {
        id: 0x2::object::UID,
        staker: address,
        balance: u64,
        reward_index: u128,
        earned: u64,
        unstake_deadline: u64,
    }

    struct InitializeStakingPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        initializer: 0x1::ascii::String,
        timestamp: u64,
    }

    struct InitializeCreatorPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        initializer: 0x1::ascii::String,
        creator: 0x1::ascii::String,
        timestamp: u64,
    }

    struct StakeEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        staker: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct UnstakeEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        is_staking_account_deleted: bool,
        unstaker: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct UpdateRewardIndexEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        reward_updater: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
        is_initial_rewards: bool,
    }

    struct DepositPoolCreatorEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        depositor: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct ClaimStakingPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        staking_pool: 0x2::object::ID,
        staking_account: 0x2::object::ID,
        is_staking_account_deleted: bool,
        claimer: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
    }

    struct ClaimCreatorPoolEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        creator_pool: 0x2::object::ID,
        claimer: 0x1::ascii::String,
        reward: u64,
        timestamp: u64,
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 10);
    }

    fun calculate_rewards(arg0: u128, arg1: &StakingAccount) : u64 {
        let v0 = 0x1::u128::try_as_u64((arg1.balance as u128) * (arg0 - arg1.reward_index) / 10000000000000000);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::destroy_some<u64>(v0)
        } else {
            18446744073709551615
        }
    }

    public entry fun calculate_rewards_earned<T0>(arg0: &Configuration, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, StakingPool<T0>>(&arg0.id, v0);
        let v2 = 0x2::tx_context::sender(arg1);
        assert!(0x2::dynamic_object_field::exists_<address>(&v1.id, v2), 3);
        let v3 = 0x2::dynamic_object_field::borrow<address, StakingAccount>(&v1.id, v2);
        v3.earned + calculate_rewards(v1.reward_index, v3)
    }

    public entry fun claim_creator_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<CreatorPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CreatorPool<T0>>(&mut arg0.id, v0);
        assert!(v1.creator == 0x2::tx_context::sender(arg2), 5);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1.sui_token);
        assert!(v2 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.sui_token, v2, arg2), v1.creator);
        let v3 = ClaimCreatorPoolEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            creator_pool  : 0x2::object::id<CreatorPool<T0>>(v1),
            claimer       : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg2)),
            reward        : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimCreatorPoolEvent>(v3);
        v2
    }

    public entry fun claim_staking_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, StakingPool<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&v1.id, v2), 3);
        let v3 = 0x2::object::id<StakingPool<T0>>(v1);
        let v4 = 0x2::dynamic_object_field::borrow_mut<address, StakingAccount>(&mut v1.id, v2);
        update_rewards(v1.reward_index, v4);
        let v5 = v4.earned;
        assert!(v5 > 0, 7);
        v4.earned = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1.sui_token, v5, arg2), v2);
        let v6 = ClaimStakingPoolEvent{
            token_address              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staking_pool               : v3,
            staking_account            : 0x2::object::id<StakingAccount>(v4),
            is_staking_account_deleted : try_cleanup_empty_account<T0>(v1, v4.balance, v4.earned, v2),
            claimer                    : 0x2::address::to_ascii_string(v2),
            reward                     : v5,
            timestamp                  : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimStakingPoolEvent>(v6);
        v5
    }

    public entry fun deposit_creator_pool<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<CreatorPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CreatorPool<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 > 0, 6);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.sui_token, arg1);
        let v3 = DepositPoolCreatorEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            creator_pool  : 0x2::object::id<CreatorPool<T0>>(v1),
            depositor     : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg3)),
            amount        : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositPoolCreatorEvent>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Configuration{
            id                       : 0x2::object::new(arg0),
            version                  : 1,
            admin                    : 0x2::tx_context::sender(arg0),
            deny_unstake_duration_ms : 3600000,
        };
        0x2::transfer::public_share_object<Configuration>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) entry fun initialize_creator_pool<T0>(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<CreatorPool<T0>>());
        if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return
        };
        let v1 = CreatorPool<T0>{
            id        : 0x2::object::new(arg3),
            sui_token : 0x2::coin::zero<0x2::sui::SUI>(arg3),
            creator   : arg1,
        };
        let v2 = InitializeCreatorPoolEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            creator_pool  : 0x2::object::id<CreatorPool<T0>>(&v1),
            initializer   : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg3)),
            creator       : 0x2::address::to_ascii_string(arg1),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<InitializeCreatorPoolEvent>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, CreatorPool<T0>>(&mut arg0.id, v0, v1);
    }

    public entry fun initialize_staking_pool<T0>(arg0: &mut Configuration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0)) {
            return
        };
        let v1 = StakingPool<T0>{
            id                      : 0x2::object::new(arg2),
            staking_token           : 0x2::coin::zero<T0>(arg2),
            sui_token               : 0x2::coin::zero<0x2::sui::SUI>(arg2),
            total_supply            : 0,
            reward_index            : 0,
            pending_initial_rewards : 0,
        };
        let v2 = InitializeStakingPoolEvent{
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staking_pool  : 0x2::object::id<StakingPool<T0>>(&v1),
            initializer   : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg2)),
            timestamp     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<InitializeStakingPoolEvent>(v2);
        0x2::dynamic_object_field::add<0x1::ascii::String, StakingPool<T0>>(&mut arg0.id, v0, v1);
    }

    public entry fun migrate_version(arg0: &AdminCap, arg1: &mut Configuration) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
    }

    public entry fun stake<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, StakingPool<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x2::dynamic_object_field::exists_<address>(&v1.id, v2)) {
            let v3 = StakingAccount{
                id               : 0x2::object::new(arg3),
                staker           : v2,
                balance          : 0,
                reward_index     : 0,
                earned           : v1.pending_initial_rewards,
                unstake_deadline : 0,
            };
            v1.pending_initial_rewards = 0;
            0x2::dynamic_object_field::add<address, StakingAccount>(&mut v1.id, v2, v3);
        };
        let v4 = 0x2::dynamic_object_field::borrow_mut<address, StakingAccount>(&mut v1.id, v2);
        update_rewards(v1.reward_index, v4);
        let v5 = 0x2::coin::value<T0>(&arg1);
        assert!(v5 > 0, 6);
        let v6 = 0x2::clock::timestamp_ms(arg2);
        v4.unstake_deadline = v6 + arg0.deny_unstake_duration_ms;
        v4.balance = v4.balance + v5;
        v1.total_supply = v1.total_supply + v5;
        0x2::coin::join<T0>(&mut v1.staking_token, arg1);
        let v7 = StakeEvent{
            token_address   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staking_pool    : 0x2::object::id<StakingPool<T0>>(v1),
            staking_account : 0x2::object::id<StakingAccount>(v4),
            staker          : 0x2::address::to_ascii_string(v2),
            amount          : v5,
            timestamp       : v6,
        };
        0x2::event::emit<StakeEvent>(v7);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    fun try_cleanup_empty_account<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: u64, arg3: address) : bool {
        if (arg1 == 0 && arg2 == 0) {
            let StakingAccount {
                id               : v0,
                staker           : _,
                balance          : _,
                reward_index     : _,
                earned           : _,
                unstake_deadline : _,
            } = 0x2::dynamic_object_field::remove<address, StakingAccount>(&mut arg0.id, arg3);
            0x2::object::delete(v0);
            return true
        };
        false
    }

    public entry fun unstake<T0>(arg0: &mut Configuration, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(arg1 > 0, 6);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, StakingPool<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_object_field::exists_<address>(&v1.id, v2), 3);
        let v3 = 0x2::object::id<StakingPool<T0>>(v1);
        let v4 = 0x2::dynamic_object_field::borrow_mut<address, StakingAccount>(&mut v1.id, v2);
        let v5 = 0x2::clock::timestamp_ms(arg2);
        assert!(v5 >= v4.unstake_deadline, 8);
        update_rewards(v1.reward_index, v4);
        assert!(v4.balance >= arg1, 4);
        v4.balance = v4.balance - arg1;
        v1.total_supply = v1.total_supply - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.staking_token, arg1, arg3), v2);
        let v6 = UnstakeEvent{
            token_address              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staking_pool               : v3,
            staking_account            : 0x2::object::id<StakingAccount>(v4),
            is_staking_account_deleted : try_cleanup_empty_account<T0>(v1, v4.balance, v4.earned, v2),
            unstaker                   : 0x2::address::to_ascii_string(v2),
            amount                     : arg1,
            timestamp                  : v5,
        };
        0x2::event::emit<UnstakeEvent>(v6);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: address, arg3: u64) {
        arg1.admin = arg2;
        arg1.deny_unstake_duration_ms = arg3;
    }

    public entry fun update_reward_index<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<StakingPool<T0>>());
        assert!(0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v0), 1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, StakingPool<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 > 0, 6);
        if (v1.total_supply == 0) {
            v1.pending_initial_rewards = v1.pending_initial_rewards + v2;
            0x2::coin::join<0x2::sui::SUI>(&mut v1.sui_token, arg1);
            let v3 = UpdateRewardIndexEvent{
                token_address      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                staking_pool       : 0x2::object::id<StakingPool<T0>>(v1),
                reward_updater     : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg3)),
                reward             : v2,
                timestamp          : 0x2::clock::timestamp_ms(arg2),
                is_initial_rewards : true,
            };
            0x2::event::emit<UpdateRewardIndexEvent>(v3);
            return
        };
        v1.reward_index = v1.reward_index + (v2 as u128) * 10000000000000000 / (v1.total_supply as u128);
        0x2::coin::join<0x2::sui::SUI>(&mut v1.sui_token, arg1);
        let v4 = UpdateRewardIndexEvent{
            token_address      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staking_pool       : 0x2::object::id<StakingPool<T0>>(v1),
            reward_updater     : 0x2::address::to_ascii_string(0x2::tx_context::sender(arg3)),
            reward             : v2,
            timestamp          : 0x2::clock::timestamp_ms(arg2),
            is_initial_rewards : false,
        };
        0x2::event::emit<UpdateRewardIndexEvent>(v4);
    }

    fun update_rewards(arg0: u128, arg1: &mut StakingAccount) {
        arg1.earned = arg1.earned + calculate_rewards(arg0, arg1);
        arg1.reward_index = arg0;
    }

    // decompiled from Move bytecode v6
}

