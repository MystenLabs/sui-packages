module 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events {
    struct EntityRegistered has copy, drop {
        entity: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct EntityEnabled has copy, drop {
        entity: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct EntityRevoked has copy, drop {
        entity: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct MaxDepositUpdated has copy, drop {
        entity: 0x1::type_name::TypeName,
        old_max: u64,
        new_max: u64,
        timestamp_ms: u64,
    }

    struct MaxRewardRatioUpdated has copy, drop {
        old_ratio: u64,
        new_ratio: u64,
        timestamp_ms: u64,
    }

    struct EntitySupplied has copy, drop {
        pool_id: 0x2::object::ID,
        entity: 0x1::type_name::TypeName,
        amount: u64,
        new_principal: u64,
        timestamp_ms: u64,
    }

    struct EntityWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        entity: 0x1::type_name::TypeName,
        amount: u64,
        new_principal: u64,
        timestamp_ms: u64,
    }

    struct EntityRewardsDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        entity: 0x1::type_name::TypeName,
        depositor: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        entity: 0x1::type_name::TypeName,
        amount: u64,
        timestamp_ms: u64,
    }

    public(friend) fun emit_entity_enabled(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = EntityEnabled{
            entity       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<EntityEnabled>(v0);
    }

    public(friend) fun emit_entity_registered(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = EntityRegistered{
            entity       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<EntityRegistered>(v0);
    }

    public(friend) fun emit_entity_revoked(arg0: 0x1::type_name::TypeName, arg1: u64) {
        let v0 = EntityRevoked{
            entity       : arg0,
            timestamp_ms : arg1,
        };
        0x2::event::emit<EntityRevoked>(v0);
    }

    public(friend) fun emit_entity_rewards_deposited(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: address, arg3: u64, arg4: u64) {
        let v0 = EntityRewardsDeposited{
            pool_id      : arg0,
            entity       : arg1,
            depositor    : arg2,
            amount       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<EntityRewardsDeposited>(v0);
    }

    public(friend) fun emit_entity_supplied(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = EntitySupplied{
            pool_id       : arg0,
            entity        : arg1,
            amount        : arg2,
            new_principal : arg3,
            timestamp_ms  : arg4,
        };
        0x2::event::emit<EntitySupplied>(v0);
    }

    public(friend) fun emit_entity_withdrawn(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = EntityWithdrawn{
            pool_id       : arg0,
            entity        : arg1,
            amount        : arg2,
            new_principal : arg3,
            timestamp_ms  : arg4,
        };
        0x2::event::emit<EntityWithdrawn>(v0);
    }

    public(friend) fun emit_max_deposit_updated(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = MaxDepositUpdated{
            entity       : arg0,
            old_max      : arg1,
            new_max      : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<MaxDepositUpdated>(v0);
    }

    public(friend) fun emit_max_reward_ratio_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = MaxRewardRatioUpdated{
            old_ratio    : arg0,
            new_ratio    : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<MaxRewardRatioUpdated>(v0);
    }

    public(friend) fun emit_rewards_claimed(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) {
        let v0 = RewardsClaimed{
            pool_id      : arg0,
            entity       : arg1,
            amount       : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<RewardsClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

