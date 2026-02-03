module 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward {
    struct EventDeposit has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        sender: address,
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventWithdraw has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        sender: address,
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventClaimRewards has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        recipient: address,
        token_name: 0x1::type_name::TypeName,
        reward_amount: u64,
        lock_id: 0x2::object::ID,
    }

    struct EventNotifyReward has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        sender: address,
        token_name: 0x1::type_name::TypeName,
        epoch_start: u64,
        amount: u64,
    }

    struct EventEpochFinalized has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        internal_reward_id: 0x2::object::ID,
        epoch_start: u64,
    }

    struct EventUpdateSupply has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        internal_reward_id: 0x2::object::ID,
        epoch_start: u64,
        total_supply: u64,
    }

    struct EventEpochResetFinal has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        internal_reward_id: 0x2::object::ID,
        epoch_start: u64,
    }

    struct EventUpdateBalances has copy, drop, store {
        wrapper_reward_id: 0x2::object::ID,
        internal_reward_id: 0x2::object::ID,
        epoch_start: u64,
        balances: vector<u64>,
        lock_ids: vector<0x2::object::ID>,
    }

    struct Checkpoint has drop, store {
        epoch_start: u64,
        balance_of: u64,
    }

    struct SupplyCheckpoint has drop, store {
        epoch_start: u64,
        supply: u64,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        wrapper_reward_id: 0x2::object::ID,
        token_rewards_per_epoch: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>,
        last_earn: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>,
        rewards: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        checkpoints: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>,
        num_checkpoints: 0x2::table::Table<0x2::object::ID, u64>,
        supply_checkpoints: 0x2::table::Table<u64, SupplyCheckpoint>,
        supply_num_checkpoints: u64,
        balances: 0x2::bag::Bag,
        balance_update_enabled: bool,
        epoch_updates_finalized: 0x2::table::Table<u64, bool>,
        bag: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &Reward) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    public fun add_reward_token(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: 0x1::type_name::TypeName) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rewards, arg2);
    }

    public fun balance_of(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        balance_of_at(arg0, arg1, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg2))
    }

    public fun balance_of_at(arg0: &Reward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        if (v0 == 0) {
            return 0
        };
        let v1 = get_prior_balance_index(arg0, arg1, arg2);
        let v2 = 0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1);
        let v3 = 0x2::table::borrow<u64, Checkpoint>(v2, 0);
        if (v1 == 0 && v3.epoch_start > arg2) {
            return 0
        };
        0x2::table::borrow<u64, Checkpoint>(v2, v1).balance_of
    }

    public fun create(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : (Reward, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap) {
        let v0 = 0x2::object::new(arg3);
        let v1 = Reward{
            id                      : v0,
            wrapper_reward_id       : arg0,
            token_rewards_per_epoch : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(arg3),
            last_earn               : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(arg3),
            rewards                 : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            checkpoints             : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(arg3),
            num_checkpoints         : 0x2::table::new<0x2::object::ID, u64>(arg3),
            supply_checkpoints      : 0x2::table::new<u64, SupplyCheckpoint>(arg3),
            supply_num_checkpoints  : 0,
            balances                : 0x2::bag::new(arg3),
            balance_update_enabled  : arg2,
            epoch_updates_finalized : 0x2::table::new<u64, bool>(arg3),
            bag                     : 0x2::bag::new(arg3),
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v1.rewards, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v2));
            v2 = v2 + 1;
        };
        (v1, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::create(0x2::object::uid_to_inner(&v0), arg3))
    }

    public fun deposit(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        let v0 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg4);
        let v1 = total_supply_at(arg0, v0) + arg2;
        let v2 = balance_of(arg0, arg3, arg4) + arg2;
        write_checkpoint_internal(arg0, arg3, v2, v0, arg5);
        write_supply_checkpoint_internal(arg0, v0, v1);
        let v3 = EventDeposit{
            wrapper_reward_id : arg0.wrapper_reward_id,
            sender            : 0x2::tx_context::sender(arg5),
            lock_id           : arg3,
            amount            : arg2,
        };
        0x2::event::emit<EventDeposit>(v3);
    }

    public fun earned<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = earned_internal<T0>(arg0, arg1, arg2, false);
        v0
    }

    public fun earned_ignore_epoch_final<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = earned_internal<T0>(arg0, arg1, arg2, true);
        v0
    }

    fun earned_internal<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: bool) : (u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1) || *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1) == 0) {
            return (0, 0)
        };
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0) && 0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0), arg1)) {
            0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(*0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0), arg1))
        } else {
            0
        };
        let v3 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), get_prior_balance_index(arg0, arg1, v2));
        let v4 = if (v2 >= v3.epoch_start) {
            v2
        } else {
            v3.epoch_start
        };
        let v5 = v4;
        let v6 = (0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg2)) - v4) / 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch();
        if (v6 > 0) {
            let v7 = 0;
            while (v7 < v6 && v7 < 100) {
                let v8 = if (arg0.balance_update_enabled) {
                    if (!arg3) {
                        !0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, v5) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, v5)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v8) {
                    break
                };
                let v9 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), get_prior_balance_index(arg0, arg1, v5 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() - 1));
                let v10 = get_prior_supply_index(arg0, v5 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() - 1);
                let v11 = if (!0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v10)) {
                    1
                } else {
                    let v12 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v10).supply;
                    let v13 = v12;
                    if (v12 == 0) {
                        v13 = 1;
                    };
                    v13
                };
                if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0)) {
                    break
                };
                let v14 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0);
                let v15 = if (0x2::table::contains<u64, u64>(v14, v5)) {
                    *0x2::table::borrow<u64, u64>(v14, v5)
                } else {
                    0
                };
                v1 = v1 + 0x6b904ae739b2baad330aae14991abcd3b7354d3dc3db72507ed8dabeeb7a36de::full_math_u64::mul_div_floor(v9.balance_of, v15, v11);
                v5 = v5 + 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch();
                v7 = v7 + 1;
            };
        };
        (v1, v5)
    }

    public fun get_prior_balance_index(arg0: &Reward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        if (v0 == 0) {
            return 0
        };
        if (0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1).epoch_start <= arg2) {
            return v0 - 1
        };
        if (0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), 0).epoch_start > arg2) {
            return 0
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v2 > v1) {
            let v3 = v2 - (v2 - v1) / 2;
            let v4 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v3);
            if (v4.epoch_start == arg2) {
                return v3
            };
            if (v4.epoch_start < arg2) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1
    }

    public fun get_prior_supply_index(arg0: &Reward, arg1: u64) : u64 {
        let v0 = arg0.supply_num_checkpoints;
        if (v0 == 0) {
            return 0
        };
        if (0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1).epoch_start <= arg1) {
            return v0 - 1
        };
        if (0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, 0).epoch_start > arg1) {
            return 0
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v2 > v1) {
            let v3 = v2 - (v2 - v1) / 2;
            let v4 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v3);
            if (v4.epoch_start == arg1) {
                return v3
            };
            if (v4.epoch_start < arg1) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1
    }

    public fun get_reward_internal<T0>(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: address, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        let (v0, v1) = earned_internal<T0>(arg0, arg3, arg4, false);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v2, 0x2::table::new<0x2::object::ID, u64>(arg5));
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(v3, arg3)) {
            0x2::table::remove<0x2::object::ID, u64>(v3, arg3);
        };
        0x2::table::add<0x2::object::ID, u64>(v3, arg3, v1);
        let v4 = EventClaimRewards{
            wrapper_reward_id : arg0.wrapper_reward_id,
            recipient         : arg2,
            token_name        : v2,
            reward_amount     : v0,
            lock_id           : arg3,
        };
        0x2::event::emit<EventClaimRewards>(v4);
        if (v0 > 0) {
            return 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), v0))
        };
        0x1::option::none<0x2::balance::Balance<T0>>()
    }

    public fun is_epoch_final(arg0: &Reward, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg1) && *0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, arg1)
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun notify_reward_amount_internal<T0>(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg3));
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v1)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.token_rewards_per_epoch, v1, 0x2::table::new<u64, u64>(arg4));
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.token_rewards_per_epoch, v1);
        let v4 = if (0x2::table::contains<u64, u64>(v3, v2)) {
            0x2::table::remove<u64, u64>(v3, v2)
        } else {
            0
        };
        0x2::table::add<u64, u64>(v3, v2, v4 + v0);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, arg2);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg2);
        };
        let v5 = EventNotifyReward{
            wrapper_reward_id : arg0.wrapper_reward_id,
            sender            : 0x2::tx_context::sender(arg4),
            token_name        : v1,
            epoch_start       : v2,
            amount            : v0,
        };
        0x2::event::emit<EventNotifyReward>(v5);
    }

    public fun reset_final(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        assert!(arg2 % 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() == 0, 57465357444921274);
        assert!(0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg2), 86720681210724470);
        assert!(arg0.balance_update_enabled, 87295163281596280);
        0x2::table::remove<u64, bool>(&mut arg0.epoch_updates_finalized, arg2);
        let v0 = EventEpochResetFinal{
            wrapper_reward_id  : arg0.wrapper_reward_id,
            internal_reward_id : 0x2::object::id<Reward>(arg0),
            epoch_start        : arg2,
        };
        0x2::event::emit<EventEpochResetFinal>(v0);
    }

    public fun rewards_at_epoch<T0>(arg0: &Reward, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0);
        if (!0x2::table::contains<u64, u64>(v1, arg1)) {
            return 0
        };
        *0x2::table::borrow<u64, u64>(v1, arg1)
    }

    public fun rewards_contains(arg0: &Reward, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rewards, &arg1)
    }

    public fun rewards_list(arg0: &Reward) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.rewards)
    }

    public fun rewards_list_length(arg0: &Reward) : u64 {
        0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.rewards)
    }

    public fun rewards_per_epoch<T0>(arg0: &Reward) : &0x2::table::Table<u64, u64> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0), 9223372492121309183);
        0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0)
    }

    public fun rewards_this_epoch<T0>(arg0: &Reward, arg1: &0x2::clock::Clock) : u64 {
        rewards_at_epoch<T0>(arg0, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg1)))
    }

    public fun total_supply(arg0: &Reward, arg1: &0x2::clock::Clock) : u64 {
        total_supply_at(arg0, 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg1))
    }

    public fun total_supply_at(arg0: &Reward, arg1: u64) : u64 {
        if (arg0.supply_num_checkpoints == 0) {
            return 0
        };
        let v0 = get_prior_supply_index(arg0, arg1);
        let v1 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0);
        if (v0 == 0 && v1.epoch_start > arg1) {
            return 0
        };
        v1.supply
    }

    public fun update_balances(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        assert!(arg0.balance_update_enabled, 931921756019291001);
        assert!(arg4 % 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() == 0, 97211664930268266);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg2), 951147350837936100);
        assert!(!0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg4) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, arg4), 931921756019291000);
        assert!(arg4 < 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg6)), 987934305039328400);
        let v0 = 0x1::vector::empty<SupplyCheckpoint>();
        let v1 = arg0.supply_num_checkpoints;
        if (v1 == 0) {
            let v2 = SupplyCheckpoint{
                epoch_start : arg4,
                supply      : 0,
            };
            0x1::vector::push_back<SupplyCheckpoint>(&mut v0, v2);
        } else {
            let v3 = get_prior_supply_index(arg0, arg4);
            let v4 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v3);
            let v5 = if (v3 == 0 && v4.epoch_start > arg4) {
                let v6 = SupplyCheckpoint{
                    epoch_start : arg4,
                    supply      : 0,
                };
                0x1::vector::push_back<SupplyCheckpoint>(&mut v0, v6);
                v3
            } else {
                let v7 = SupplyCheckpoint{
                    epoch_start : arg4,
                    supply      : v4.supply,
                };
                0x1::vector::push_back<SupplyCheckpoint>(&mut v0, v7);
                v3 + 1
            };
            while (v5 < v1) {
                let v8 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v5);
                let v9 = SupplyCheckpoint{
                    epoch_start : v8.epoch_start,
                    supply      : v8.supply,
                };
                0x1::vector::push_back<SupplyCheckpoint>(&mut v0, v9);
                v5 = v5 + 1;
            };
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&arg2)) {
            let v11 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v10);
            let v12 = *0x1::vector::borrow<u64>(&arg2, v10);
            let v13 = 0;
            let v14 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, v11)) {
                *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, v11)
            } else {
                0
            };
            let v15 = if (v14 == 0) {
                0
            } else {
                let v16 = get_prior_balance_index(arg0, v11, arg4);
                let v17 = 0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, v11);
                let v18 = 0x2::table::borrow<u64, Checkpoint>(v17, 0);
                if (v16 == 0 && v18.epoch_start > arg4) {
                    v13 = v18.epoch_start;
                    0
                } else {
                    if (v16 < v14 - 1) {
                        v13 = 0x2::table::borrow<u64, Checkpoint>(v17, v16 + 1).epoch_start;
                    };
                    0x2::table::borrow<u64, Checkpoint>(v17, v16).balance_of
                }
            };
            let v19 = 0;
            while (v19 < 0x1::vector::length<SupplyCheckpoint>(&v0)) {
                let v20 = 0x1::vector::borrow_mut<SupplyCheckpoint>(&mut v0, v19);
                if (v13 != 0 && v20.epoch_start >= v13) {
                    break
                };
                v20.supply = v20.supply + v12 - v15;
                v19 = v19 + 1;
            };
            write_checkpoint_internal(arg0, v11, v12, arg4, arg7);
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < 0x1::vector::length<SupplyCheckpoint>(&v0)) {
            write_supply_checkpoint_internal(arg0, 0x1::vector::borrow<SupplyCheckpoint>(&v0, v10).epoch_start, 0x1::vector::borrow<SupplyCheckpoint>(&v0, v10).supply);
            v10 = v10 + 1;
        };
        let v21 = 0x2::object::id<Reward>(arg0);
        let v22 = EventUpdateBalances{
            wrapper_reward_id  : arg0.wrapper_reward_id,
            internal_reward_id : v21,
            epoch_start        : arg4,
            balances           : arg2,
            lock_ids           : arg3,
        };
        0x2::event::emit<EventUpdateBalances>(v22);
        if (arg5) {
            0x2::table::add<u64, bool>(&mut arg0.epoch_updates_finalized, arg4, true);
            let v23 = EventEpochFinalized{
                wrapper_reward_id  : arg0.wrapper_reward_id,
                internal_reward_id : v21,
                epoch_start        : arg4,
            };
            0x2::event::emit<EventEpochFinalized>(v23);
        };
    }

    public fun update_balances_ignore_supply(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        assert!(arg0.balance_update_enabled, 931921756019291001);
        assert!(arg4 % 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() == 0, 97211664930268266);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg2), 951147350837936100);
        assert!(!0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg4) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, arg4), 931921756019291000);
        assert!(arg4 < 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg5)), 987934305039328400);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            write_checkpoint_internal(arg0, *0x1::vector::borrow<0x2::object::ID>(&arg3, v0), *0x1::vector::borrow<u64>(&arg2, v0), arg4, arg6);
            v0 = v0 + 1;
        };
        let v1 = EventUpdateBalances{
            wrapper_reward_id  : arg0.wrapper_reward_id,
            internal_reward_id : 0x2::object::id<Reward>(arg0),
            epoch_start        : arg4,
            balances           : arg2,
            lock_ids           : arg3,
        };
        0x2::event::emit<EventUpdateBalances>(v1);
    }

    public fun update_supply(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        assert!(arg0.balance_update_enabled, 931921756019291001);
        assert!(arg2 % 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch() == 0, 705782693965862900);
        assert!(!0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg2) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, arg2), 904903521124960500);
        assert!(arg2 <= 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg4)), 313936473495920450);
        write_supply_checkpoint_internal(arg0, arg2, arg3);
        let v0 = EventUpdateSupply{
            wrapper_reward_id  : arg0.wrapper_reward_id,
            internal_reward_id : 0x2::object::id<Reward>(arg0),
            epoch_start        : arg2,
            total_supply       : arg3,
        };
        0x2::event::emit<EventUpdateSupply>(v0);
    }

    public fun withdraw(arg0: &mut Reward, arg1: &0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::RewardCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::reward_cap::validate(arg1, 0x2::object::id<Reward>(arg0));
        let v0 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::current_timestamp(arg4);
        let v1 = total_supply_at(arg0, v0) - arg2;
        let v2 = balance_of(arg0, arg3, arg4) - arg2;
        write_checkpoint_internal(arg0, arg3, v2, v0, arg5);
        write_supply_checkpoint_internal(arg0, v0, v1);
        let v3 = EventWithdraw{
            wrapper_reward_id : arg0.wrapper_reward_id,
            sender            : 0x2::tx_context::sender(arg5),
            lock_id           : arg3,
            amount            : arg2,
        };
        0x2::event::emit<EventWithdraw>(v3);
    }

    public fun wrapper_reward_id(arg0: &Reward) : 0x2::object::ID {
        arg0.wrapper_reward_id
    }

    fun write_checkpoint_internal(arg0: &mut Reward, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(arg3);
        let v2 = if (v0 > 0) {
            if (0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) {
                if (0x2::table::contains<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1)) {
                    0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1).epoch_start == v1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1);
            if (0x2::table::contains<u64, Checkpoint>(v3, v0 - 1)) {
                0x2::table::remove<u64, Checkpoint>(v3, v0 - 1);
            };
            let v4 = Checkpoint{
                epoch_start : v1,
                balance_of  : arg2,
            };
            0x2::table::add<u64, Checkpoint>(v3, v0 - 1, v4);
        } else {
            if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) {
                0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1, 0x2::table::new<u64, Checkpoint>(arg4));
            };
            let v5 = get_prior_balance_index(arg0, arg1, v1);
            let v6 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1);
            if (0x2::table::contains<u64, Checkpoint>(v6, v5) && 0x2::table::borrow<u64, Checkpoint>(v6, v5).epoch_start == v1) {
                0x2::table::remove<u64, Checkpoint>(v6, v5);
                let v7 = Checkpoint{
                    epoch_start : v1,
                    balance_of  : arg2,
                };
                0x2::table::add<u64, Checkpoint>(v6, v5, v7);
            } else {
                let v8 = Checkpoint{
                    epoch_start : v1,
                    balance_of  : arg2,
                };
                if (v0 == 0) {
                    0x2::table::add<u64, Checkpoint>(v6, v0, v8);
                } else {
                    let v9 = if (0x2::table::contains<u64, Checkpoint>(v6, v5) && 0x2::table::borrow<u64, Checkpoint>(v6, v5).epoch_start < v1) {
                        v5 + 1
                    } else {
                        v5
                    };
                    let v10 = v0 - 1;
                    while (v10 >= v9) {
                        0x2::table::add<u64, Checkpoint>(v6, v10 + 1, 0x2::table::remove<u64, Checkpoint>(v6, v10));
                        if (v10 == 0) {
                            break
                        };
                        v10 = v10 - 1;
                    };
                    0x2::table::add<u64, Checkpoint>(v6, v9, v8);
                };
                if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
                    0x2::table::remove<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1);
                };
                0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1, v0 + 1);
            };
        };
    }

    fun write_supply_checkpoint_internal(arg0: &mut Reward, arg1: u64, arg2: u64) {
        let v0 = arg0.supply_num_checkpoints;
        let v1 = 0xe616397e503278d406e184d2258bcbe7a263d0192cc0848de2b54b518165f832::common::epoch_start(arg1);
        let v2 = if (v0 > 0) {
            if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1)) {
                0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1).epoch_start == v1
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0 - 1);
            let v3 = SupplyCheckpoint{
                epoch_start : v1,
                supply      : arg2,
            };
            0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0 - 1, v3);
        } else {
            if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0)) {
                0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0);
            };
            let v4 = get_prior_supply_index(arg0, v1);
            if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v4) && 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v4).epoch_start == v1) {
                0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v4);
                let v5 = SupplyCheckpoint{
                    epoch_start : v1,
                    supply      : arg2,
                };
                0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v4, v5);
            } else {
                let v6 = SupplyCheckpoint{
                    epoch_start : v1,
                    supply      : arg2,
                };
                if (v0 == 0) {
                    0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0, v6);
                } else {
                    let v7 = if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v4) && 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v4).epoch_start < v1) {
                        v4 + 1
                    } else {
                        v4
                    };
                    let v8 = v0 - 1;
                    while (v8 >= v7) {
                        0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v8 + 1, 0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v8));
                        if (v8 == 0) {
                            break
                        };
                        v8 = v8 - 1;
                    };
                    0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v7, v6);
                };
                arg0.supply_num_checkpoints = v0 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

