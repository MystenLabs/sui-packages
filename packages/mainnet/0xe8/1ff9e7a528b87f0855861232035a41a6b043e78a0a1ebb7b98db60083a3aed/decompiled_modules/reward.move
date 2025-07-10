module 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward {
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
        lock_id: 0x2::object::ID,
    }

    struct EventNotifyReward has copy, drop, store {
        sender: address,
        token_name: 0x1::type_name::TypeName,
        epoch_start: u64,
        amount: u64,
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
        voter: 0x2::object::ID,
        ve: 0x1::option::Option<0x2::object::ID>,
        authorized: 0x2::object::ID,
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

    public(friend) fun add_reward_token(arg0: &mut Reward, arg1: 0x1::type_name::TypeName) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.rewards, arg1);
    }

    public fun authorized(arg0: &Reward) : 0x2::object::ID {
        arg0.authorized
    }

    public fun balance_of(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        balance_of_at(arg0, arg1, 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg2))
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

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x2::object::ID, arg3: vector<0x1::type_name::TypeName>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : Reward {
        let v0 = Reward{
            id                      : 0x2::object::new(arg5),
            voter                   : arg0,
            ve                      : arg1,
            authorized              : arg2,
            token_rewards_per_epoch : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(arg5),
            last_earn               : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(arg5),
            rewards                 : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            checkpoints             : 0x2::table::new<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(arg5),
            num_checkpoints         : 0x2::table::new<0x2::object::ID, u64>(arg5),
            supply_checkpoints      : 0x2::table::new<u64, SupplyCheckpoint>(arg5),
            supply_num_checkpoints  : 0,
            balances                : 0x2::bag::new(arg5),
            balance_update_enabled  : arg4,
            epoch_updates_finalized : 0x2::table::new<u64, bool>(arg5),
            bag                     : 0x2::bag::new(arg5),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg3)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.rewards, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg3, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun deposit(arg0: &mut Reward, arg1: &0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::validate(arg1, arg0.authorized);
        let v0 = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg4);
        let v1 = total_supply_at(arg0, v0) + arg2;
        let v2 = balance_of(arg0, arg3, arg4) + arg2;
        write_checkpoint_internal(arg0, arg3, v2, v0, arg5);
        write_supply_checkpoint_internal(arg0, v0, v1);
        let v3 = EventDeposit{
            sender  : 0x2::tx_context::sender(arg5),
            lock_id : arg3,
            amount  : arg2,
        };
        0x2::event::emit<EventDeposit>(v3);
    }

    public(friend) fun earned<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        let (v0, _) = earned_internal<T0>(arg0, arg1, arg2);
        v0
    }

    public(friend) fun earned_internal<T0>(arg0: &Reward, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1) || *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1) == 0) {
            return (0, 0)
        };
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0) && 0x2::table::contains<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0), arg1)) {
            0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(*0x2::table::borrow<0x2::object::ID, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v0), arg1))
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
        let v6 = (0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg2)) - v4) / 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch();
        if (v6 > 0) {
            let v7 = 0;
            while (v7 < v6) {
                if (arg0.balance_update_enabled && (!0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, v5) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, v5))) {
                    break
                };
                let v8 = 0x2::table::borrow<u64, Checkpoint>(0x2::table::borrow<0x2::object::ID, 0x2::table::Table<u64, Checkpoint>>(&arg0.checkpoints, arg1), get_prior_balance_index(arg0, arg1, v5 + 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch() - 1));
                let v9 = get_prior_supply_index(arg0, v5 + 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch() - 1);
                let v10 = if (!0x2::table::contains<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v9)) {
                    1
                } else {
                    let v11 = 0x2::table::borrow<u64, SupplyCheckpoint>(&arg0.supply_checkpoints, v9).supply;
                    let v12 = v11;
                    if (v11 == 0) {
                        v12 = 1;
                    };
                    v12
                };
                if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0)) {
                    break
                };
                let v13 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0);
                let v14 = if (0x2::table::contains<u64, u64>(v13, v5)) {
                    *0x2::table::borrow<u64, u64>(v13, v5)
                } else {
                    0
                };
                v1 = v1 + 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u64::mul_div_floor(v8.balance_of, v14, v10);
                v5 = v5 + 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch();
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

    public(friend) fun get_reward_internal<T0>(arg0: &mut Reward, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::balance::Balance<T0>> {
        let (v0, v1) = earned_internal<T0>(arg0, arg2, arg3);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&arg0.last_earn, v2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v2, 0x2::table::new<0x2::object::ID, u64>(arg4));
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg0.last_earn, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(v3, arg2)) {
            0x2::table::remove<0x2::object::ID, u64>(v3, arg2);
        };
        0x2::table::add<0x2::object::ID, u64>(v3, arg2, v1);
        let v4 = EventClaimRewards{
            recipient     : arg1,
            token_name    : v2,
            reward_amount : v0,
            lock_id       : arg2,
        };
        0x2::event::emit<EventClaimRewards>(v4);
        if (v0 > 0) {
            return 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v2), v0))
        };
        0x1::option::none<0x2::balance::Balance<T0>>()
    }

    public(friend) fun notify_reward_amount_internal<T0>(arg0: &mut Reward, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg2));
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

    public(friend) fun rewards_list_length(arg0: &Reward) : u64 {
        0x2::vec_set::size<0x1::type_name::TypeName>(&arg0.rewards)
    }

    public fun rewards_per_epoch<T0>(arg0: &Reward) : &0x2::table::Table<u64, u64> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0), 9223372492121309183);
        0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, u64>>(&arg0.token_rewards_per_epoch, v0)
    }

    public fun rewards_this_epoch<T0>(arg0: &Reward, arg1: &0x2::clock::Clock) : u64 {
        rewards_at_epoch<T0>(arg0, 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg1)))
    }

    public fun total_supply(arg0: &Reward, arg1: &0x2::clock::Clock) : u64 {
        total_supply_at(arg0, 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg1))
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

    public(friend) fun update_balances(arg0: &mut Reward, arg1: &0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::RewardAuthorizedCap, arg2: vector<u64>, arg3: vector<0x2::object::ID>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::validate(arg1, arg0.authorized);
        assert!(arg0.balance_update_enabled, 931921756019291001);
        assert!(arg4 % 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch() == 0, 97211664930268266);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) == 0x1::vector::length<u64>(&arg2), 951147350837936100);
        assert!(!0x2::table::contains<u64, bool>(&arg0.epoch_updates_finalized, arg4) || !*0x2::table::borrow<u64, bool>(&arg0.epoch_updates_finalized, arg4), 931921756019291000);
        assert!(arg4 < 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg6)), 987934305039328400);
        let v0 = 0;
        let v1 = total_supply_at(arg0, arg4);
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v0);
            let v3 = *0x1::vector::borrow<u64>(&arg2, v0);
            let v4 = v1 + v3;
            v1 = v4 - balance_of_at(arg0, v2, arg4);
            write_checkpoint_internal(arg0, v2, v3, arg4, arg7);
            v0 = v0 + 1;
        };
        write_supply_checkpoint_internal(arg0, arg4, v1);
        if (arg5) {
            0x2::table::add<u64, bool>(&mut arg0.epoch_updates_finalized, arg4, true);
        };
    }

    public fun ve(arg0: &Reward) : 0x2::object::ID {
        *0x1::option::borrow<0x2::object::ID>(&arg0.ve)
    }

    public fun voter(arg0: &Reward) : 0x2::object::ID {
        arg0.voter
    }

    public(friend) fun withdraw(arg0: &mut Reward, arg1: &0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::RewardAuthorizedCap, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::reward_authorized_cap::validate(arg1, arg0.authorized);
        let v0 = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::current_timestamp(arg4);
        let v1 = total_supply_at(arg0, v0) - arg2;
        let v2 = balance_of(arg0, arg3, arg4) - arg2;
        write_checkpoint_internal(arg0, arg3, v2, v0, arg5);
        write_supply_checkpoint_internal(arg0, v0, v1);
        let v3 = EventWithdraw{
            sender  : 0x2::tx_context::sender(arg5),
            lock_id : arg3,
            amount  : arg2,
        };
        0x2::event::emit<EventWithdraw>(v3);
    }

    fun write_checkpoint_internal(arg0: &mut Reward, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::table::contains<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.num_checkpoints, arg1)
        } else {
            0
        };
        let v1 = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(arg3);
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
                    let v9 = v5 + 1;
                    while (v9 < v0) {
                        0x2::table::add<u64, Checkpoint>(v6, v9 + 1, 0x2::table::remove<u64, Checkpoint>(v6, v9));
                        v9 = v9 + 1;
                    };
                    0x2::table::add<u64, Checkpoint>(v6, v5 + 1, v8);
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
        let v1 = 0xe81ff9e7a528b87f0855861232035a41a6b043e78a0a1ebb7b98db60083a3aed::common::epoch_start(arg1);
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
                    let v7 = v4 + 1;
                    while (v7 < v0) {
                        0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v7 + 1, 0x2::table::remove<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v7));
                        v7 = v7 + 1;
                    };
                    0x2::table::add<u64, SupplyCheckpoint>(&mut arg0.supply_checkpoints, v4 + 1, v6);
                };
                arg0.supply_num_checkpoints = v0 + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

