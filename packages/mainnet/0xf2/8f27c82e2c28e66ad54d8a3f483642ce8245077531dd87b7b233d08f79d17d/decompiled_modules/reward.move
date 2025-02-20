module 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward {
    struct EventDeposit has copy, drop, store {
        sender: address,
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventWithdraw has copy, drop, store {
        sender: address,
        lock_id: 0x2::object::ID,
        amount: u64,
    }

    struct EventClaimRewards has copy, drop, store {
        recipient: address,
        token_name: 0x1::type_name::TypeName,
        reward_amount: u64,
    }

    struct EventNotifyReward has copy, drop, store {
        sender: address,
        token_name: 0x1::type_name::TypeName,
        epoch_start: u64,
        amount: u64,
    }

    struct Checkpoint has drop, store {
        timestamp: u64,
        balance_of: u64,
    }

    struct SupplyCheckpoint has drop, store {
        timestamp: u64,
        supply: u64,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        voter: 0x2::object::ID,
        ve: 0x2::object::ID,
        authorized: 0x2::object::ID,
        total_supply: u64,
        balance_of: 0x2::table::Table<0x2::object::ID, u64>,
        token_rewards_per_epoch: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>,
        last_earn: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>,
        rewards: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        checkpoints: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>,
        num_checkpoints: 0x2::table::Table<0x2::object::ID, u64>,
        supply_checkpoints: 0x2::table::Table<u64, SupplyCheckpoint>,
        supply_num_checkpoints: u64,
        balances: 0x2::bag::Bag,
    }

    public fun balance<T0>(arg0: &Reward) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>()))
    }

    public(friend) fun add_reward_token(arg0: &mut Reward, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rewards, arg1);
    }

    public fun authorized(arg0: &Reward) : 0x2::object::ID {
        arg0.authorized
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: &mut 0x2::tx_context::TxContext) : Reward {
        let v0 = Reward{
            id                      : 0x2::object::new(arg4),
            voter                   : arg0,
            ve                      : arg1,
            authorized              : arg2,
            total_supply            : 0,
            balance_of              : 0x2::table::new<0x2::object::ID, u64>(arg4),
            token_rewards_per_epoch : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(arg4),
            last_earn               : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(arg4),
            rewards                 : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            checkpoints             : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(arg4),
            num_checkpoints         : 0x2::table::new<0x2::object::ID, u64>(arg4),
            supply_checkpoints      : 0x2::table::new<u64, SupplyCheckpoint>(arg4),
            supply_num_checkpoints  : 0,
            balances                : 0x2::bag::new(arg4),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg3)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.rewards, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg3, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun deposit(arg0: &mut Reward, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_authorized_cap::validate(arg1, arg0.authorized);
        arg0.total_supply = arg0.total_supply + arg2;
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.balance_of, arg3)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.balance_of, arg3)
        } else {
            0
        };
        let v1 = v0 + arg2;
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.balance_of, arg3, v1);
        let v2 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg4);
        write_checkpoint_internal(arg0, arg3, v1, v2, arg5);
        write_supply_checkpoint_internal(arg0, v2);
        let v3 = EventDeposit{
            sender  : 0x2::tx_context::sender(arg5),
            lock_id : arg3,
            amount  : arg2,
        };
        0x2::event::emit<EventDeposit>(v3);
    }

    public(friend) fun earned<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let v0 = if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            true
        } else {
            let v1 = 0;
            0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1) == &v1
        };
        if (v0) {
            return 0
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = 0;
        let v4 = if (0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v2) && 0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v2), arg1)) {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(*0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v2), arg1))
        } else {
            0
        };
        let v5 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), get_prior_balance_index(arg0, arg1, v4));
        let v6 = if (v4 >= 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(v5.timestamp)) {
            v4
        } else {
            0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(v5.timestamp)
        };
        let v7 = v6;
        let v8 = (0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg2)) - v6) / 604800;
        if (v8 > 0) {
            let v9 = 0;
            while (v9 < v8) {
                let v10 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), get_prior_balance_index(arg0, arg1, v7 + 604800 - 1));
                let v11 = get_prior_supply_index(arg0, v7 + 604800 - 1);
                let v12 = if (!0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v11)) {
                    1
                } else {
                    let v13 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v11).supply;
                    let v14 = v13;
                    if (v13 == 0) {
                        v14 = 1;
                    };
                    v14
                };
                if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v2)) {
                    break
                };
                let v15 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v2);
                let v16 = if (0x2::table::contains<u64, u64>(v15, v7)) {
                    *0x2::table::borrow<u64, u64>(v15, v7)
                } else {
                    0
                };
                v3 = v3 + v10.balance_of * v16 / v12;
                v7 = v7 + 604800;
                v9 = v9 + 1;
            };
        };
        v3
    }

    public fun get_prior_balance_index(arg0: &Reward, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1);
        if (v0 == 0) {
            return 0
        };
        if (0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1).timestamp <= arg2) {
            return v0 - 1
        };
        if (0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), 0).timestamp > arg2) {
            return 0
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v2 > v1) {
            let v3 = v2 - (v2 - v1) / 2;
            let v4 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v3);
            if (v4.timestamp == arg2) {
                return v3
            };
            if (v4.timestamp < arg2) {
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
        if (0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1).timestamp <= arg1) {
            return v0 - 1
        };
        if (0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, 0).timestamp > arg1) {
            return 0
        };
        let v1 = 0;
        let v2 = v0 - 1;
        while (v2 > v1) {
            let v3 = v2 - (v2 - v1) / 2;
            let v4 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v3);
            if (v4.timestamp == arg1) {
                return v3
            };
            if (v4.timestamp < arg1) {
                v1 = v3;
                continue
            };
            v2 = v3 - 1;
        };
        v1
    }

    public(friend) fun get_reward_internal<T0>(arg0: &mut Reward, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        let v0 = earned<T0>(arg0, arg2, arg3);
        let v1 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v1)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v1, 0x2::table::new<0x2::object::ID, u64>(arg4));
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v1);
        if (0x2::table::contains<0x2::object::ID, u64>(v2, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(v2, arg2);
        };
        0x2::table::add<0x2::object::ID, u64>(v2, arg2, 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg3));
        let v3 = EventClaimRewards{
            recipient     : arg1,
            token_name    : v1,
            reward_amount : v0,
        };
        0x2::event::emit<EventClaimRewards>(v3);
        if (v0 > 0) {
            return 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), v0))
        };
        0x1::option::none<0x2::balance::Balance<T0>>()
    }

    public(friend) fun notify_reward_amount_internal<T0>(arg0: &mut Reward, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg2));
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v1)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.token_rewards_per_epoch, v1, 0x2::table::new<u64, u64>(arg3));
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&mut arg0.token_rewards_per_epoch, v1);
        let v4 = if (0x2::table::contains<u64, u64>(v3, v2)) {
            0x2::table::remove<u64, u64>(v3, v2)
        } else {
            0
        };
        0x2::table::add<u64, u64>(v3, v2, v4 + v0);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v1)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1, arg1);
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v1), arg1);
        };
        let v5 = EventNotifyReward{
            sender      : 0x2::tx_context::sender(arg3),
            token_name  : v1,
            epoch_start : v2,
            amount      : v0,
        };
        0x2::event::emit<EventNotifyReward>(v5);
    }

    public fun rewards_contains(arg0: &Reward, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.rewards, &arg1)
    }

    public fun rewards_list(arg0: &Reward) : vector<0x1::type_name::TypeName> {
        0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg0.rewards)
    }

    public(friend) fun rewards_list_length(arg0: &Reward) : u64 {
        0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.rewards)
    }

    public fun ve(arg0: &Reward) : 0x2::object::ID {
        arg0.ve
    }

    public fun voter(arg0: &Reward) : 0x2::object::ID {
        arg0.voter
    }

    public(friend) fun withdraw(arg0: &mut Reward, arg1: &0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::reward_authorized_cap::validate(arg1, arg0.authorized);
        arg0.total_supply = arg0.total_supply - arg2;
        let v0 = 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.balance_of, arg3);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.balance_of, arg3, v0 - arg2);
        let v1 = 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::current_timestamp(arg4);
        write_checkpoint_internal(arg0, arg3, v0 - arg2, v1, arg5);
        write_supply_checkpoint_internal(arg0, v1);
        let v2 = EventWithdraw{
            sender  : 0x2::tx_context::sender(arg5),
            lock_id : arg3,
            amount  : arg2,
        };
        0x2::event::emit<EventWithdraw>(v2);
    }

    fun write_checkpoint_internal(arg0: &mut Reward, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        if (v0 > 0 && 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), v0 - 1).timestamp) == 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(arg3)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1);
            if (0x2::table::contains<u64, Checkpoint>(v1, v0 - 1)) {
                0x2::table::remove<u64, Checkpoint>(v1, v0 - 1);
            };
            let v2 = Checkpoint{
                timestamp  : arg3,
                balance_of : arg2,
            };
            0x2::table::add<u64, Checkpoint>(v1, v0 - 1, v2);
        } else {
            if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1)) {
                0x2::table::add<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1, 0x2::table::new<u64, Checkpoint>(arg4));
            };
            let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&mut arg0.checkpoints, arg1);
            if (0x2::table::contains<u64, Checkpoint>(v3, v0)) {
                0x2::table::remove<u64, Checkpoint>(v3, v0);
            };
            let v4 = Checkpoint{
                timestamp  : arg3,
                balance_of : arg2,
            };
            0x2::table::add<u64, Checkpoint>(v3, v0, v4);
            if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
                0x2::table::remove<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1);
            };
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.num_checkpoints, arg1, v0 + 1);
        };
    }

    fun write_supply_checkpoint_internal(arg0: &mut Reward, arg1: u64) {
        let v0 = arg0.supply_num_checkpoints;
        if (v0 > 0 && 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1).timestamp) == 0xf28f27c82e2c28e66ad54d8a3f483642ce8245077531dd87b7b233d08f79d17d::common::epoch_start(arg1)) {
            if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0 - 1)) {
                0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0 - 1);
            };
            let v1 = SupplyCheckpoint{
                timestamp : arg1,
                supply    : arg0.total_supply,
            };
            0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0 - 1, v1);
        } else {
            if (0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v0)) {
                0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0);
            };
            let v2 = SupplyCheckpoint{
                timestamp : arg1,
                supply    : arg0.total_supply,
            };
            0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v0, v2);
            arg0.supply_num_checkpoints = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

