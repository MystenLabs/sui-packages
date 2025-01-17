module 0xaf7c528433fd00f8f7707f139e1831628e1f77faff2f3d5758330a84b1fbafcd::events {
    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
    }

    struct UpdateStakingStatusEvent has copy, drop {
        is_open_staking: bool,
    }

    struct UpdateRewardConfigEvent has copy, drop {
        emission_rate: u64,
        start_time: u64,
        end_time: u64,
    }

    struct UpdatePackageVersionEvent has copy, drop {
        version: u64,
    }

    struct InitVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        deposit_amount: u64,
        total_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        owner: address,
    }

    struct WithdrawEvent has copy, drop {
        withdraw_amount: u64,
        remaining_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        owner: address,
    }

    struct StakeEvent has copy, drop {
        stake_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        position_staked_amount: u64,
        vault_total_staked_amount: u64,
        owner: address,
    }

    struct UnstakeEvent has copy, drop {
        removed_amount: u64,
        position_remaining_amount: u64,
        vault_remaining_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        owner: address,
    }

    struct ClaimRewardEvent has copy, drop {
        reward_amount: u64,
        coin_type: 0x1::type_name::TypeName,
        owner: address,
    }

    struct CreateStakePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct RewardInfoForEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        pending_reward_amount: u64,
    }

    struct CalculatePendingRewardEvent has copy, drop {
        reward_info: RewardInfoForEvent,
    }

    struct CalculateAllPendingRewardEvent has copy, drop {
        reward_infos: vector<RewardInfoForEvent>,
    }

    struct InitRewardManagerEvent has copy, drop {
        reward_manager_id: 0x2::object::ID,
    }

    struct CloseStakePositionEvent has copy, drop {
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct DestroyRewardManagerEvent has copy, drop {
        reward_manager_id: 0x2::object::ID,
        owner: address,
    }

    public fun emit_calculate_all_pending_reward(arg0: vector<u64>, arg1: vector<0x1::type_name::TypeName>) {
        let v0 = 0x1::vector::empty<RewardInfoForEvent>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = RewardInfoForEvent{
                coin_type             : *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v1),
                pending_reward_amount : *0x1::vector::borrow<u64>(&arg0, v1),
            };
            0x1::vector::insert<RewardInfoForEvent>(&mut v0, v2, 0);
            v1 = v1 + 1;
        };
        let v3 = CalculateAllPendingRewardEvent{reward_infos: v0};
        0x2::event::emit<CalculateAllPendingRewardEvent>(v3);
    }

    public fun emit_calculate_pending_reward(arg0: u64, arg1: 0x1::type_name::TypeName) {
        let v0 = RewardInfoForEvent{
            coin_type             : arg1,
            pending_reward_amount : arg0,
        };
        let v1 = CalculatePendingRewardEvent{reward_info: v0};
        0x2::event::emit<CalculatePendingRewardEvent>(v1);
    }

    public fun emit_claim_reward(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: address) {
        let v0 = ClaimRewardEvent{
            reward_amount : arg0,
            coin_type     : arg1,
            owner         : arg2,
        };
        0x2::event::emit<ClaimRewardEvent>(v0);
    }

    public fun emit_close_stake_position(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CloseStakePositionEvent{
            position_id : arg0,
            owner       : arg1,
        };
        0x2::event::emit<CloseStakePositionEvent>(v0);
    }

    public fun emit_create_stake_position(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CreateStakePositionEvent{
            position_id : arg0,
            owner       : arg1,
        };
        0x2::event::emit<CreateStakePositionEvent>(v0);
    }

    public fun emit_deposit(arg0: u64, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: address) {
        let v0 = DepositEvent{
            deposit_amount : arg0,
            total_amount   : arg1,
            coin_type      : arg2,
            owner          : arg3,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun emit_destroy_reward_manager(arg0: 0x2::object::ID, arg1: address) {
        let v0 = DestroyRewardManagerEvent{
            reward_manager_id : arg0,
            owner             : arg1,
        };
        0x2::event::emit<DestroyRewardManagerEvent>(v0);
    }

    public fun emit_init_config(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = InitConfigEvent{
            admin_cap_id       : arg0,
            protocol_config_id : arg1,
        };
        0x2::event::emit<InitConfigEvent>(v0);
    }

    public fun emit_init_reward_manager(arg0: 0x2::object::ID) {
        let v0 = InitRewardManagerEvent{reward_manager_id: arg0};
        0x2::event::emit<InitRewardManagerEvent>(v0);
    }

    public fun emit_init_vault(arg0: 0x2::object::ID) {
        let v0 = InitVaultEvent{vault_id: arg0};
        0x2::event::emit<InitVaultEvent>(v0);
    }

    public fun emit_stake(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: address) {
        let v0 = StakeEvent{
            stake_amount              : arg0,
            coin_type                 : arg1,
            position_staked_amount    : arg2,
            vault_total_staked_amount : arg3,
            owner                     : arg4,
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public fun emit_unstake(arg0: u64, arg1: u64, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: address) {
        let v0 = UnstakeEvent{
            removed_amount            : arg0,
            position_remaining_amount : arg1,
            vault_remaining_amount    : arg2,
            coin_type                 : arg3,
            owner                     : arg4,
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    public fun emit_update_package_version(arg0: u64) {
        let v0 = UpdatePackageVersionEvent{version: arg0};
        0x2::event::emit<UpdatePackageVersionEvent>(v0);
    }

    public fun emit_update_reward_config(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = UpdateRewardConfigEvent{
            emission_rate : arg0,
            start_time    : arg1,
            end_time      : arg2,
        };
        0x2::event::emit<UpdateRewardConfigEvent>(v0);
    }

    public fun emit_update_staking_status(arg0: bool) {
        let v0 = UpdateStakingStatusEvent{is_open_staking: arg0};
        0x2::event::emit<UpdateStakingStatusEvent>(v0);
    }

    public fun emit_withdraw(arg0: u64, arg1: u64, arg2: 0x1::type_name::TypeName, arg3: address) {
        let v0 = WithdrawEvent{
            withdraw_amount  : arg0,
            remaining_amount : arg1,
            coin_type        : arg2,
            owner            : arg3,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

