module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events {
    struct StakingDataCreatedEvent has copy, drop {
        user: address,
        id: 0x2::object::ID,
    }

    struct StakingDataUpdatedEvent has copy, drop {
        staking_data_id: 0x2::object::ID,
        points: u64,
        current_multiplier: u64,
        ephemeral_multiplier: vector<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::ephemeral_multiplier::EphemeralMultiplier>,
    }

    struct StakingDataLevelUpdatedEvent has copy, drop {
        staking_data_id: 0x2::object::ID,
        points: u64,
        level: u8,
    }

    struct PopkinsStakedEvent has copy, drop {
        popkins_id: 0x2::object::ID,
        staking_data_id: 0x2::object::ID,
        lock_time: u64,
    }

    struct PopkinsUnstakedEvent has copy, drop {
        popkins_id: 0x2::object::ID,
    }

    struct StakingClassCreatedEvent has copy, drop {
        popkins_id: 0x2::object::ID,
        multiplier: u64,
        is_staked: bool,
        lock_time: u64,
    }

    struct StakingClassUpdatedEvent has copy, drop {
        popkins_id: 0x2::object::ID,
        multiplier: u64,
        is_staked: bool,
        lock_time: u64,
    }

    public(friend) fun emit_popkins_staked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PopkinsStakedEvent{
            popkins_id      : arg0,
            staking_data_id : arg1,
            lock_time       : arg2,
        };
        0x2::event::emit<PopkinsStakedEvent>(v0);
    }

    public(friend) fun emit_popkins_unstaked(arg0: 0x2::object::ID) {
        let v0 = PopkinsUnstakedEvent{popkins_id: arg0};
        0x2::event::emit<PopkinsUnstakedEvent>(v0);
    }

    public(friend) fun emit_staking_class_created(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: u64) {
        let v0 = StakingClassCreatedEvent{
            popkins_id : arg0,
            multiplier : arg1,
            is_staked  : arg2,
            lock_time  : arg3,
        };
        0x2::event::emit<StakingClassCreatedEvent>(v0);
    }

    public(friend) fun emit_staking_class_updated(arg0: 0x2::object::ID, arg1: u64, arg2: bool, arg3: u64) {
        let v0 = StakingClassUpdatedEvent{
            popkins_id : arg0,
            multiplier : arg1,
            is_staked  : arg2,
            lock_time  : arg3,
        };
        0x2::event::emit<StakingClassUpdatedEvent>(v0);
    }

    public(friend) fun emit_staking_data_created(arg0: address, arg1: 0x2::object::ID) {
        let v0 = StakingDataCreatedEvent{
            user : arg0,
            id   : arg1,
        };
        0x2::event::emit<StakingDataCreatedEvent>(v0);
    }

    public(friend) fun emit_staking_data_level_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u8) {
        let v0 = StakingDataLevelUpdatedEvent{
            staking_data_id : arg0,
            points          : arg1,
            level           : arg2,
        };
        0x2::event::emit<StakingDataLevelUpdatedEvent>(v0);
    }

    public(friend) fun emit_staking_data_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: vector<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::ephemeral_multiplier::EphemeralMultiplier>) {
        let v0 = StakingDataUpdatedEvent{
            staking_data_id      : arg0,
            points               : arg1,
            current_multiplier   : arg2,
            ephemeral_multiplier : arg3,
        };
        0x2::event::emit<StakingDataUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

