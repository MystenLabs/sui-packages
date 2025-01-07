module 0x4f0a1a923dd063757fd37e04a9c2cee8980008e94433c9075c390065f98e9e4b::events {
    struct CreatedVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        min_lock_duration_ms: u64,
        max_lock_duration_ms: u64,
        max_lock_multiplier: u64,
        min_stake_amount: u64,
    }

    struct InitializedRewardEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
        emission_rate: u64,
        emission_start_ms: u64,
    }

    struct AddedRewardEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    struct IncreasedEmissionsEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        emission_schedule_ms: u64,
        emission_rate: u64,
    }

    struct StakedEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
        multiplied_staked_amount: u64,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
    }

    struct StakedEventRelaxed has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
        lock_start_timestamp_ms: u64,
        lock_end_timestamp_ms: u64,
    }

    struct LockedEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
        lock_start_timestamp_ms: u64,
        lock_duration_ms: u64,
        lock_multiplier: u64,
    }

    struct UnlockedEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        staked_type: 0x1::ascii::String,
        staked_amount: u64,
    }

    struct JoinedEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        other_staked_position_id: 0x2::object::ID,
    }

    struct SplitEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        split_staked_position_id: 0x2::object::ID,
    }

    struct DepositedPrincipalEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        amount: u64,
    }

    struct WithdrewPrincipalEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        stake_type: 0x1::ascii::String,
        amount: u64,
    }

    struct HarvestedRewardsEvent has copy, drop {
        afterburner_vault_id: 0x2::object::ID,
        reward_types: vector<0x1::ascii::String>,
        reward_amounts: vector<u64>,
    }

    struct HarvestedRewardsEventMetadata {
        afterburner_vault_id: 0x2::object::ID,
        reward_types: vector<0x1::ascii::String>,
        reward_amounts: vector<u64>,
    }

    struct DestroyedStakedPositionEvent has copy, drop {
        staked_position_id: 0x2::object::ID,
    }

    public(friend) fun add_harvest_metadata(arg0: &mut HarvestedRewardsEventMetadata, arg1: 0x1::ascii::String, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.reward_types, &arg1);
        let v2 = if (v0) {
            v1
        } else {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg0.reward_types, arg1);
            0x1::vector::push_back<u64>(&mut arg0.reward_amounts, 0);
            0x1::vector::length<0x1::ascii::String>(&arg0.reward_types) - 1
        };
        *0x1::vector::borrow_mut<u64>(&mut arg0.reward_amounts, v2) = *0x1::vector::borrow<u64>(&arg0.reward_amounts, v2) + arg2;
    }

    public fun afterburner_vault_id(arg0: &HarvestedRewardsEventMetadata) : 0x2::object::ID {
        arg0.afterburner_vault_id
    }

    public(friend) fun begin_harvest(arg0: 0x2::object::ID) : HarvestedRewardsEventMetadata {
        HarvestedRewardsEventMetadata{
            afterburner_vault_id : arg0,
            reward_types         : 0x1::vector::empty<0x1::ascii::String>(),
            reward_amounts       : vector[],
        }
    }

    public(friend) fun emit_added_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AddedRewardEvent{
            vault_id      : arg0,
            reward_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount : arg1,
        };
        0x2::event::emit<AddedRewardEvent>(v0);
    }

    public(friend) fun emit_created_vault_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CreatedVaultEvent{
            vault_id             : arg0,
            stake_type           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            min_lock_duration_ms : arg1,
            max_lock_duration_ms : arg2,
            max_lock_multiplier  : arg3,
            min_stake_amount     : arg4,
        };
        0x2::event::emit<CreatedVaultEvent>(v0);
    }

    public(friend) fun emit_deposited_principal_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = DepositedPrincipalEvent{
            staked_position_id : arg0,
            vault_id           : arg1,
            stake_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount             : arg2,
        };
        0x2::event::emit<DepositedPrincipalEvent>(v0);
    }

    public(friend) fun emit_destroyed_staked_position_event(arg0: 0x2::object::ID) {
        let v0 = DestroyedStakedPositionEvent{staked_position_id: arg0};
        0x2::event::emit<DestroyedStakedPositionEvent>(v0);
    }

    public(friend) fun emit_harvested_rewards_event(arg0: HarvestedRewardsEventMetadata) {
        let HarvestedRewardsEventMetadata {
            afterburner_vault_id : v0,
            reward_types         : v1,
            reward_amounts       : v2,
        } = arg0;
        let v3 = HarvestedRewardsEvent{
            afterburner_vault_id : v0,
            reward_types         : v1,
            reward_amounts       : v2,
        };
        0x2::event::emit<HarvestedRewardsEvent>(v3);
    }

    public(friend) fun emit_increased_emissions_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = IncreasedEmissionsEvent{
            vault_id             : arg0,
            reward_type          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            emission_schedule_ms : arg1,
            emission_rate        : arg2,
        };
        0x2::event::emit<IncreasedEmissionsEvent>(v0);
    }

    public(friend) fun emit_initialized_reward_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = InitializedRewardEvent{
            vault_id          : arg0,
            reward_type       : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount     : arg1,
            emission_rate     : arg2,
            emission_start_ms : arg3,
        };
        0x2::event::emit<InitializedRewardEvent>(v0);
    }

    public(friend) fun emit_joined_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = JoinedEvent{
            staked_position_id       : arg0,
            other_staked_position_id : arg1,
        };
        0x2::event::emit<JoinedEvent>(v0);
    }

    public(friend) fun emit_locked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LockedEvent{
            staked_position_id      : arg0,
            vault_id                : arg1,
            staked_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount           : arg2,
            lock_start_timestamp_ms : arg3,
            lock_duration_ms        : arg4,
            lock_multiplier         : arg5,
        };
        0x2::event::emit<LockedEvent>(v0);
    }

    public(friend) fun emit_split_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = SplitEvent{
            staked_position_id       : arg0,
            split_staked_position_id : arg1,
        };
        0x2::event::emit<SplitEvent>(v0);
    }

    public(friend) fun emit_staked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = StakedEvent{
            staked_position_id       : arg0,
            vault_id                 : arg1,
            staked_type              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount            : arg2,
            multiplied_staked_amount : arg3,
            lock_start_timestamp_ms  : arg4,
            lock_duration_ms         : arg5,
            lock_multiplier          : arg6,
        };
        0x2::event::emit<StakedEvent>(v0);
    }

    public(friend) fun emit_staked_event_relaxed<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = StakedEventRelaxed{
            staked_position_id      : arg0,
            vault_id                : arg1,
            staked_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount           : arg2,
            lock_start_timestamp_ms : arg3,
            lock_end_timestamp_ms   : arg4,
        };
        0x2::event::emit<StakedEventRelaxed>(v0);
    }

    public(friend) fun emit_unlocked_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = UnlockedEvent{
            staked_position_id : arg0,
            vault_id           : arg1,
            staked_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            staked_amount      : arg2,
        };
        0x2::event::emit<UnlockedEvent>(v0);
    }

    public(friend) fun emit_withdrew_principal_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = WithdrewPrincipalEvent{
            staked_position_id : arg0,
            vault_id           : arg1,
            stake_type         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount             : arg2,
        };
        0x2::event::emit<WithdrewPrincipalEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

