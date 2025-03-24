module 0x79ee374b9e3c60c00a19fdbeaea25731bbea8f2cab9bb61bb712543e0ba55b7a::events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct CreatedVaultEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        supported_lock_enforcements: vector<u8>,
        min_lock_duration_ms: u64,
        max_lock_duration_ms: u64,
        max_lock_multiplier: u64,
        min_stake_amount: u64,
    }

    struct InitializedRewardEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
        emission_rate: u64,
        emission_start_ms: u64,
    }

    struct AddedRewardEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    struct UpdatedEmissionScheduleEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        emission_frequency_ms: u64,
        emission_rate: u64,
    }

    struct StakedEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
        multiplier_staked_amount: u64,
        lock_enforcement: u8,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
    }

    struct LockedEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
    }

    struct UnlockedEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
    }

    struct JoinedEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        other_staked_position_id: 0x2::object::ID,
    }

    struct SplitEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        split_staked_position_id: 0x2::object::ID,
    }

    struct DepositedPrincipalEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        amount: u64,
    }

    struct WithdrewPrincipalEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        amount: u64,
    }

    struct HarvestedRewardsEventV1 has copy, drop {
        vault_id: 0x2::object::ID,
        reward_types: vector<0x1::ascii::String>,
        reward_amounts: vector<u64>,
    }

    struct DestroyedStakedPositionEventV1 has copy, drop {
        staked_position_id: 0x2::object::ID,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_added_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AddedRewardEventV1{
            vault_id      : arg0,
            reward_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount : arg1,
        };
        emit<AddedRewardEventV1>(v0);
    }

    public(friend) fun emit_created_vault_event<T0>(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = CreatedVaultEventV1{
            vault_id                    : arg0,
            stake_type                  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            supported_lock_enforcements : arg1,
            min_lock_duration_ms        : arg2,
            max_lock_duration_ms        : arg3,
            max_lock_multiplier         : arg4,
            min_stake_amount            : arg5,
        };
        emit<CreatedVaultEventV1>(v0);
    }

    public(friend) fun emit_deposited_principal_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = DepositedPrincipalEventV1{
            staked_position_id : arg0,
            vault_id           : arg1,
            stake_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount             : arg2,
        };
        emit<DepositedPrincipalEventV1>(v0);
    }

    public(friend) fun emit_destroyed_staked_position_event(arg0: 0x2::object::ID) {
        let v0 = DestroyedStakedPositionEventV1{staked_position_id: arg0};
        emit<DestroyedStakedPositionEventV1>(v0);
    }

    public(friend) fun emit_harvested_rewards_event(arg0: 0x2::object::ID, arg1: vector<0x1::type_name::TypeName>, arg2: vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::reverse<0x1::type_name::TypeName>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(0x1::vector::pop_back<0x1::type_name::TypeName>(&mut arg1)));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::type_name::TypeName>(arg1);
        let v2 = HarvestedRewardsEventV1{
            vault_id       : arg0,
            reward_types   : v0,
            reward_amounts : arg2,
        };
        emit<HarvestedRewardsEventV1>(v2);
    }

    public(friend) fun emit_initialized_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = InitializedRewardEventV1{
            vault_id          : arg0,
            reward_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount     : arg1,
            emission_rate     : arg2,
            emission_start_ms : arg3,
        };
        emit<InitializedRewardEventV1>(v0);
    }

    public(friend) fun emit_joined_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = JoinedEventV1{
            staked_position_id       : arg0,
            other_staked_position_id : arg1,
        };
        emit<JoinedEventV1>(v0);
    }

    public(friend) fun emit_locked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LockedEventV1{
            staked_position_id      : arg0,
            vault_id                : arg1,
            staked_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount           : arg2,
            lock_start_timestamp_ms : arg3,
            lock_duration_ms        : arg4,
            lock_multiplier         : arg5,
        };
        emit<LockedEventV1>(v0);
    }

    public(friend) fun emit_split_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = SplitEventV1{
            staked_position_id       : arg0,
            split_staked_position_id : arg1,
        };
        emit<SplitEventV1>(v0);
    }

    public(friend) fun emit_staked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = StakedEventV1{
            staked_position_id       : arg0,
            vault_id                 : arg1,
            staked_type              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount            : arg2,
            multiplier_staked_amount : arg3,
            lock_enforcement         : arg4,
            lock_start_timestamp_ms  : arg5,
            lock_duration_ms         : arg6,
            lock_multiplier          : arg7,
        };
        emit<StakedEventV1>(v0);
    }

    public(friend) fun emit_unlocked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = UnlockedEventV1{
            staked_position_id : arg0,
            vault_id           : arg1,
            staked_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount      : arg2,
        };
        emit<UnlockedEventV1>(v0);
    }

    public(friend) fun emit_updated_emission_schedule_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = UpdatedEmissionScheduleEventV1{
            vault_id              : arg0,
            reward_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            emission_frequency_ms : arg1,
            emission_rate         : arg2,
        };
        emit<UpdatedEmissionScheduleEventV1>(v0);
    }

    public(friend) fun emit_withdrew_principal_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = WithdrewPrincipalEventV1{
            staked_position_id : arg0,
            vault_id           : arg1,
            stake_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount             : arg2,
        };
        emit<WithdrewPrincipalEventV1>(v0);
    }

    // decompiled from Move bytecode v6
}

