module 0x8e85bfe3139b0e4348f822cf30b6f21432af91bb74a019ba0a7dfc774c94f860::interest_farm_events {
    struct InterestFarmEvent<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct NewAccount has copy, drop {
        farm: address,
        account: address,
    }

    struct DestroyAccount has copy, drop {
        pos0: address,
    }

    struct Stake has copy, drop {
        farm: address,
        account: address,
        amount: u64,
        total_stake_amount: u64,
        stake: 0x1::type_name::TypeName,
        account_balance: u64,
        reward_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Unstake has copy, drop {
        farm: address,
        account: address,
        amount: u64,
        total_stake_amount: u64,
        stake: 0x1::type_name::TypeName,
        account_balance: u64,
        reward_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct Harvest has copy, drop {
        farm: address,
        account: address,
        amount: u64,
        reward: 0x1::type_name::TypeName,
        account_balance: u64,
        reward_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct UpdateReward has copy, drop {
        farm: address,
        reward: 0x1::type_name::TypeName,
        rewards: u64,
        rewards_per_second: u64,
        last_reward_timestamp: u64,
        accrued_rewards_per_share: u256,
    }

    struct AddReward has copy, drop {
        farm: address,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct NewFarm has copy, drop {
        farm: address,
        rewards: vector<0x1::type_name::TypeName>,
        admin_type: 0x1::type_name::TypeName,
    }

    struct Pause has copy, drop {
        pos0: address,
    }

    struct Unpause has copy, drop {
        pos0: address,
    }

    struct SetRewardsPerSecond has copy, drop {
        farm: address,
        reward: 0x1::type_name::TypeName,
        old_rewards_per_second: u64,
        new_rewards_per_second: u64,
    }

    struct SetEndTime has copy, drop {
        farm: address,
        reward: 0x1::type_name::TypeName,
        end: u64,
    }

    public(friend) fun emit_add_reward(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = AddReward{
            farm   : arg0,
            reward : arg1,
            amount : arg2,
        };
        let v1 = InterestFarmEvent<AddReward>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<AddReward>>(v1);
    }

    public(friend) fun emit_destroy_account(arg0: address) {
        let v0 = DestroyAccount{pos0: arg0};
        let v1 = InterestFarmEvent<DestroyAccount>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<DestroyAccount>>(v1);
    }

    public(friend) fun emit_harvest(arg0: address, arg1: address, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg6: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = Harvest{
            farm            : arg0,
            account         : arg1,
            amount          : arg2,
            reward          : arg3,
            account_balance : arg4,
            reward_debts    : arg5,
            rewards         : arg6,
        };
        let v1 = InterestFarmEvent<Harvest>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<Harvest>>(v1);
    }

    public(friend) fun emit_new_account(arg0: address, arg1: address) {
        let v0 = NewAccount{
            farm    : arg0,
            account : arg1,
        };
        let v1 = InterestFarmEvent<NewAccount>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<NewAccount>>(v1);
    }

    public(friend) fun emit_new_farm(arg0: address, arg1: vector<0x1::type_name::TypeName>, arg2: 0x1::type_name::TypeName) {
        let v0 = NewFarm{
            farm       : arg0,
            rewards    : arg1,
            admin_type : arg2,
        };
        let v1 = InterestFarmEvent<NewFarm>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<NewFarm>>(v1);
    }

    public(friend) fun emit_pause(arg0: address) {
        let v0 = Pause{pos0: arg0};
        let v1 = InterestFarmEvent<Pause>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<Pause>>(v1);
    }

    public(friend) fun emit_set_end_time(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = SetEndTime{
            farm   : arg0,
            reward : arg1,
            end    : arg2,
        };
        let v1 = InterestFarmEvent<SetEndTime>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<SetEndTime>>(v1);
    }

    public(friend) fun emit_set_rewards_per_second(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = SetRewardsPerSecond{
            farm                   : arg0,
            reward                 : arg1,
            old_rewards_per_second : arg2,
            new_rewards_per_second : arg3,
        };
        let v1 = InterestFarmEvent<SetRewardsPerSecond>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<SetRewardsPerSecond>>(v1);
    }

    public(friend) fun emit_stake(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg7: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = Stake{
            farm               : arg0,
            account            : arg1,
            amount             : arg2,
            total_stake_amount : arg3,
            stake              : arg4,
            account_balance    : arg5,
            reward_debts       : arg6,
            rewards            : arg7,
        };
        let v1 = InterestFarmEvent<Stake>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<Stake>>(v1);
    }

    public(friend) fun emit_unpause(arg0: address) {
        let v0 = Unpause{pos0: arg0};
        let v1 = InterestFarmEvent<Unpause>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<Unpause>>(v1);
    }

    public(friend) fun emit_unstake(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u256>, arg7: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = Unstake{
            farm               : arg0,
            account            : arg1,
            amount             : arg2,
            total_stake_amount : arg3,
            stake              : arg4,
            account_balance    : arg5,
            reward_debts       : arg6,
            rewards            : arg7,
        };
        let v1 = InterestFarmEvent<Unstake>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<Unstake>>(v1);
    }

    public(friend) fun emit_update_reward(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u256) {
        let v0 = UpdateReward{
            farm                      : arg0,
            reward                    : arg1,
            rewards                   : arg2,
            rewards_per_second        : arg3,
            last_reward_timestamp     : arg4,
            accrued_rewards_per_share : arg5,
        };
        let v1 = InterestFarmEvent<UpdateReward>{pos0: v0};
        0x2::event::emit<InterestFarmEvent<UpdateReward>>(v1);
    }

    // decompiled from Move bytecode v6
}

