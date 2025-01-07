module 0xa65dfd10d48f9b404b11329f99835f4e35960aeffc757e8d189464161724cca2::dex_dao {
    struct PoolsGovernor has store, key {
        id: 0x2::object::UID,
        hive_profile: 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile,
        gems_cycle: u64,
        gems_schedule: GemsSchedule,
        total_gems_points: u64,
        gems_points_map: 0x2::linked_table::LinkedTable<address, u64>,
        dex_dao_cap: 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::DexDaoCapability,
        unbonding_duration: u64,
        instant_withdrawal_profiles: 0x2::linked_table::LinkedTable<address, bool>,
        vote_config: VoteConfig,
        active_pool_hives: u64,
        pool_hives: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct GemsSchedule has copy, store {
        start_epoch: u64,
        end_epoch: u64,
        gems_per_epoch: u64,
    }

    struct VoteConfig has copy, store {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
    }

    struct PoolHive<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_unbonding: u64,
        lp_bee_boxes: 0x2::linked_table::LinkedTable<address, LpBeeBox<T0>>,
        gems_available: 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::HiveGems,
        global_claim_index: u256,
        last_claim_epoch: u64,
        bee_fruit_list: vector<0x1::ascii::String>,
        proposal_list: 0x2::linked_table::LinkedTable<u64, Proposal>,
        next_proposal_id: u64,
        module_version: u64,
    }

    struct LpBeeBox<phantom T0> has store {
        staked_balance: 0x2::balance::Balance<T0>,
        total_gems_earned: u64,
        claim_index: u256,
        unbonding_psns: 0x2::linked_table::LinkedTable<u64, u64>,
        unbonding_balance: 0x2::balance::Balance<T0>,
        bee_fruits: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct Proposal has store {
        proposal_id: u64,
        proposer: address,
        deposit: 0x2::balance::Balance<0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive::HIVE>,
        title: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        proposal_type: u64,
        voting_start_epoch: u64,
        voting_end_epoch: u64,
        execution_start_epoch: u64,
        execution_end_epoch: u64,
        proposal_status: u64,
        yes_votes: u64,
        no_votes: u64,
        voters: 0x2::linked_table::LinkedTable<address, bool>,
        fruit_life: 0x1::option::Option<FruitLife>,
        new_params: 0x1::option::Option<vector<u64>>,
        new_weights: 0x1::option::Option<vector<u64>>,
        new_fee_info: 0x1::option::Option<vector<u64>>,
    }

    struct FruitLife has copy, drop, store {
        fruit_typename: 0x1::type_name::TypeName,
        start_epoch: u64,
        end_epoch: u64,
    }

    struct BeeFruit<phantom T0> has store, key {
        id: 0x2::object::UID,
        available_fruits: 0x2::balance::Balance<T0>,
        fruits_per_epoch: u64,
        start_epoch: u64,
        end_epoch: u64,
        claim_index: u256,
        last_claim_epoch: u64,
        module_version: u64,
    }

    struct GemsSetForNewHiveCycle has copy, drop {
        gems_cycle: u64,
        start_epoch: u64,
        end_epoch: u64,
        gems_per_epoch: u64,
    }

    struct GemsPerEpochUpdated has copy, drop {
        new_gems_per_epoch: u64,
    }

    struct PoolHiveNecatarPointsUpdated has copy, drop {
        pool_hive_identifier: address,
        new_gems_points: u64,
        total_gems_points: u64,
    }

    struct InstantWithdrawlProfilesUpdated has copy, drop {
        instant_withdrawal_profiles: vector<address>,
        are_added: bool,
    }

    struct PoolsGovernorUpdated has copy, drop {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
    }

    struct PoolHiveKraftd has copy, drop {
        pool_id: address,
        lp_identifier: 0x1::ascii::String,
        pool_hive_addr: address,
        cur_epoch: u64,
    }

    struct RipeFruitsClaimed<phantom T0> has copy, drop {
        fruit_type: 0x1::ascii::String,
        profile_addr: address,
        user_name: 0x1::string::String,
        fruit_global_claim_index: u256,
        earned_fruits: u64,
        pool_hive_addr: address,
    }

    struct KraftedGemsForPoolHive has copy, drop {
        pool_hive_addr: address,
        gems_earned_by_hive: u64,
        gems_per_epoch_for_hive: u256,
        index_increment: u256,
        global_claim_index: u256,
        last_claim_epoch: u64,
    }

    struct AddedToBeeBox has copy, drop {
        pool_hive_addr: address,
        profile_addr: address,
        username: 0x1::string::String,
        lp_balance_added: u64,
        hive_gems_earned: u64,
        claim_index: u256,
    }

    struct UnbondingFromBeeBox has copy, drop {
        pool_hive_addr: address,
        profile_addr: address,
        lp_balance_unbonded: u64,
        unlock_epoch: u64,
    }

    struct UnlockFromBeeBox has copy, drop {
        pool_hive_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        staker_addr: address,
        lp_balance_unlocked: u64,
    }

    struct HiveGemsHarvested has copy, drop {
        pool_hive_addr: address,
        profile_addr: address,
        hive_gems_earned: u64,
        claim_index: u256,
    }

    struct MoreFruitsAdded has copy, drop {
        pool_hive_addr: address,
        bee_fruit_addr: address,
        fruits_added: u64,
        additional_per_epoch: u64,
        fruits_per_epoch: u64,
        available_fruits: u64,
    }

    struct BeeFruitDestroyed has copy, drop {
        pool_hive_addr: address,
        bee_fruit_addr: address,
        cur_epoch: u64,
    }

    struct VoteCasted has copy, drop {
        pool_hive_id: 0x2::object::ID,
        proposal_id: u64,
        voter: address,
        vote: bool,
        yes_votes: u64,
        no_votes: u64,
        total_staked: u64,
    }

    struct ProposalEvaluated has copy, drop {
        pool_hive_id: 0x2::object::ID,
        proposal_id: u64,
        proposal_status: u64,
        yes_votes: u64,
        no_votes: u64,
        total_possible_votes: u64,
        votes_quorum: u64,
        yes_votes_threshold: u64,
    }

    struct ProposalDeleted has copy, drop {
        pool_hive_id: 0x2::object::ID,
        proposal_id: u64,
        proposal_type: u64,
        proposal_status: u64,
    }

    struct BeeFruitKraftedForPoolHive has copy, drop {
        proposal_id: u64,
        pool_hive_id: 0x2::object::ID,
        bee_fruit_addr: address,
        bee_fruit_identifier: 0x1::type_name::TypeName,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        pool_hive_id: 0x2::object::ID,
        proposal_type: u64,
    }

    fun accrue_hive_for_bee_box<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut LpBeeBox<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::HiveGems {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = *0x2::linked_table::borrow<address, u64>(&arg0.gems_points_map, v0);
        if (v1 == 0) {
            arg1.last_claim_epoch = arg3;
            return 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::zero()
        };
        let v2 = arg3 - arg1.last_claim_epoch;
        let v3 = 0;
        if (v2 > 0 && arg1.total_staked > 0) {
            let v4 = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((arg0.gems_schedule.gems_per_epoch as u256), (v1 as u256), (arg0.total_gems_points as u256));
            let v5 = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((v2 as u256), (v4 as u256), (arg1.total_staked as u256));
            arg1.global_claim_index = arg1.global_claim_index + v5;
            arg1.last_claim_epoch = arg3;
            let v6 = (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((arg1.total_staked as u256), (v5 as u256), (1000000 as u256)) as u64);
            let v7 = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::zero();
            if (v6 <= 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_available_gems_in_profile(&arg0.hive_profile)) {
                0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::join(&mut v7, 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::withdraw_gems_from_profile(&mut arg0.hive_profile, v6, arg4));
            };
            0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::join(&mut arg1.gems_available, v7);
            let v8 = KraftedGemsForPoolHive{
                pool_hive_addr          : v0,
                gems_earned_by_hive     : v6,
                gems_per_epoch_for_hive : v4,
                index_increment         : v5,
                global_claim_index      : arg1.global_claim_index,
                last_claim_epoch        : arg1.last_claim_epoch,
            };
            0x2::event::emit<KraftedGemsForPoolHive>(v8);
        };
        let v9 = 0x2::balance::value<T0>(&arg2.staked_balance);
        if (v9 > 0 && arg1.global_claim_index > arg2.claim_index) {
            let v10 = (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256(((arg1.global_claim_index - arg2.claim_index) as u256), (v9 as u256), (1000000 as u256)) as u64);
            v3 = v10;
            arg2.claim_index = arg1.global_claim_index;
            arg2.total_gems_earned = arg2.total_gems_earned + v10;
        };
        if (v3 > 0) {
            0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::split(&mut arg1.gems_available, v3)
        } else {
            0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::zero()
        }
    }

    fun authority_check(arg0: bool, arg1: address, arg2: address) {
        assert!(arg0 || arg1 == arg2, 7007);
    }

    fun claim_fruit_for_bee_box<T0, T1>(arg0: &mut BeeFruit<T1>, arg1: &mut LpBeeBox<T0>, arg2: address, arg3: u64, arg4: u64, arg5: address, arg6: 0x1::string::String) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::zero<T1>();
        if (arg0.start_epoch > arg4) {
            return v0
        };
        let v1 = if (arg0.end_epoch > arg4) {
            arg4
        } else {
            arg0.end_epoch
        };
        let v2 = if (arg0.last_claim_epoch > arg0.start_epoch) {
            arg0.last_claim_epoch
        } else {
            arg0.start_epoch
        };
        let v3 = 0;
        if (v1 > v2) {
            v3 = v1 - v2;
        };
        if (v3 > 0) {
            arg0.claim_index = arg0.claim_index + 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((1000000 as u256), 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256((arg0.fruits_per_epoch as u256), (v3 as u256), (1000000 as u256)), (arg3 as u256));
            arg0.last_claim_epoch = arg4;
        };
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruits, v4)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4, arg0.claim_index);
        };
        let v5 = 0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4);
        let v6 = (0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u256(((arg0.claim_index - *v5) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64);
        *v5 = arg0.claim_index;
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut v0, 0x2::balance::split<T1>(&mut arg0.available_fruits, v6));
        };
        let v7 = RipeFruitsClaimed<T1>{
            fruit_type               : v4,
            profile_addr             : arg5,
            user_name                : arg6,
            fruit_global_claim_index : arg0.claim_index,
            earned_fruits            : v6,
            pool_hive_addr           : arg2,
        };
        0x2::event::emit<RipeFruitsClaimed<T1>>(v7);
        v0
    }

    fun deposit_gems_and_unbond_shares<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: address, arg3: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg4: address, arg5: LpBeeBox<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg5.staked_balance) >= arg6, 7008);
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg0, arg1, v0, arg7, arg8);
        let v2 = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::value(&v1);
        if (v2 > 0) {
            0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::deposit_gems_in_profile(arg3, v1);
        } else {
            0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::destroy_zero(v1);
        };
        let v3 = HiveGemsHarvested{
            pool_hive_addr   : arg2,
            profile_addr     : arg4,
            hive_gems_earned : v2,
            claim_index      : arg5.claim_index,
        };
        0x2::event::emit<HiveGemsHarvested>(v3);
        if (arg6 > 0) {
            let v4 = arg7 + arg0.unbonding_duration;
            arg1.total_staked = arg1.total_staked - arg6;
            0x2::balance::join<T0>(&mut arg5.unbonding_balance, 0x2::balance::split<T0>(&mut arg5.staked_balance, arg6));
            if (0x2::linked_table::contains<u64, u64>(&arg5.unbonding_psns, v4)) {
                *0x2::linked_table::borrow_mut<u64, u64>(&mut arg5.unbonding_psns, v4) = *0x2::linked_table::borrow<u64, u64>(&arg5.unbonding_psns, v4) + arg6;
            } else {
                0x2::linked_table::push_back<u64, u64>(&mut arg5.unbonding_psns, v4, arg6);
            };
            arg1.total_unbonding = arg1.total_unbonding + arg6;
            let v5 = UnbondingFromBeeBox{
                pool_hive_addr      : 0x2::object::uid_to_address(&arg1.id),
                profile_addr        : arg4,
                lp_balance_unbonded : arg6,
                unlock_epoch        : v4,
            };
            0x2::event::emit<UnbondingFromBeeBox>(v5);
        };
        0x2::linked_table::push_back<address, LpBeeBox<T0>>(&mut arg1.lp_bee_boxes, arg4, arg5);
        0x2::balance::zero<T0>()
    }

    public fun deposit_hive_as_incentives(arg0: &mut PoolsGovernor, arg1: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive::HiveVault, arg2: 0x2::coin::Coin<0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive::burn_hive_for_gems(arg1, &mut arg0.hive_profile, arg2, arg3, arg4);
    }

    fun deposit_into_bee_box<T0>(arg0: address, arg1: 0x1::string::String, arg2: &mut PoolsGovernor, arg3: &mut PoolHive<T0>, arg4: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg5: LpBeeBox<T0>, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg2, arg3, v0, arg7, arg8);
        let v2 = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::value(&v1);
        if (v2 > 0) {
            0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::deposit_gems_in_profile(arg4, v1);
        } else {
            0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::destroy_zero(v1);
        };
        let v3 = 0x2::balance::value<T0>(&arg6);
        arg3.total_staked = arg3.total_staked + v3;
        0x2::balance::join<T0>(&mut arg5.staked_balance, arg6);
        let v4 = AddedToBeeBox{
            pool_hive_addr   : 0x2::object::uid_to_address(&arg3.id),
            profile_addr     : arg0,
            username         : arg1,
            lp_balance_added : v3,
            hive_gems_earned : v2,
            claim_index      : arg5.claim_index,
        };
        0x2::event::emit<AddedToBeeBox>(v4);
        0x2::linked_table::push_back<address, LpBeeBox<T0>>(&mut arg3.lp_bee_boxes, arg0, arg5);
    }

    public fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 1, 7006);
        let (v2, v3, v4, v5) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg2);
        authority_check(v4, v5, 0x2::tx_context::sender(arg4));
        let v6 = get_profile_bee_box<T0>(arg1, v2, arg4);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = &mut v6;
        let v9 = claim_fruit_for_bee_box<T0, T1>(v7, v8, v1, arg1.total_staked, v0, v2, v3);
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0, arg4);
        v9
    }

    public fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 2, 7006);
        let (v2, v3, v4, v5) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg2);
        authority_check(v4, v5, 0x2::tx_context::sender(arg4));
        let v6 = get_profile_bee_box<T0>(arg1, v2, arg4);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = &mut v6;
        let v9 = claim_fruit_for_bee_box<T0, T1>(v7, v8, v1, arg1.total_staked, v0, v2, v3);
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v11 = &mut v6;
        let v12 = claim_fruit_for_bee_box<T0, T2>(v10, v11, v1, arg1.total_staked, v0, v2, v3);
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0, arg4);
        (v9, v12)
    }

    public fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 3, 7006);
        let (v2, v3, v4, v5) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg2);
        authority_check(v4, v5, 0x2::tx_context::sender(arg4));
        let v6 = get_profile_bee_box<T0>(arg1, v2, arg4);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = &mut v6;
        let v9 = claim_fruit_for_bee_box<T0, T1>(v7, v8, v1, arg1.total_staked, v0, v2, v3);
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v11 = &mut v6;
        let v12 = claim_fruit_for_bee_box<T0, T2>(v10, v11, v1, arg1.total_staked, v0, v2, v3);
        let v13 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T3>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v14 = &mut v6;
        let v15 = claim_fruit_for_bee_box<T0, T3>(v13, v14, v1, arg1.total_staked, v0, v2, v3);
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0, arg4);
        (v9, v12, v15)
    }

    public fun deposit_into_bee_box_no_fruits<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let (v1, v2, v3, v4) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg2);
        authority_check(v3, v4, 0x2::tx_context::sender(arg4));
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg4);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg3, v0, arg4);
    }

    fun get_profile_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LpBeeBox<T0> {
        if (0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1)) {
            0x2::linked_table::remove<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, arg1)
        } else {
            LpBeeBox<T0>{staked_balance: 0x2::balance::zero<T0>(), total_gems_earned: 0, claim_index: arg0.global_claim_index, unbonding_psns: 0x2::linked_table::new<u64, u64>(arg2), unbonding_balance: 0x2::balance::zero<T0>(), bee_fruits: 0x2::linked_table::new<0x1::ascii::String, u256>(arg2)}
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_pools_manager(arg0: &0x2::clock::Clock, arg1: 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::DexDaoCapability, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2ba6b97fc5c4310f5dfad5ae717ead306764665fe6d7cac9ff2de8cbf6afff8e::hsui_vault::HSuiVault, arg4: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfileMappingStore, arg5: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveManager, arg6: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HSuiDisperser<0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0x2::tx_context::epoch(arg17), 7000);
        assert!(arg16 < 7, 7010);
        let (v0, v1) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::kraft_owned_hive_profile(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::string::utf8(b"PoolsGovernor"), 0x1::string::utf8(b"Govern your AMM Pool via its PoolHive!"), arg17);
        let v2 = GemsSchedule{
            start_epoch    : arg8,
            end_epoch      : arg8 + 352,
            gems_per_epoch : 0,
        };
        let v3 = VoteConfig{
            proposal_required_deposit   : arg9,
            voting_start_delay          : arg10,
            voting_period_length        : arg11,
            execution_delay             : arg12,
            execution_period_length     : arg13,
            proposal_required_quorum    : 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div(1000000, arg14, 100),
            proposal_approval_threshold : 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div(1000000, arg15, 100),
        };
        let v4 = PoolsGovernor{
            id                          : 0x2::object::new(arg17),
            hive_profile                : v0,
            gems_cycle                  : 0,
            gems_schedule               : v2,
            total_gems_points           : 0,
            gems_points_map             : 0x2::linked_table::new<address, u64>(arg17),
            dex_dao_cap                 : arg1,
            unbonding_duration          : arg16,
            instant_withdrawal_profiles : 0x2::linked_table::new<address, bool>(arg17),
            vote_config                 : v3,
            active_pool_hives           : 0,
            pool_hives                  : 0x2::linked_table::new<0x1::ascii::String, address>(arg17),
            module_version              : 0,
        };
        let v5 = GemsSetForNewHiveCycle{
            gems_cycle     : v4.gems_cycle,
            start_epoch    : v4.gems_schedule.start_epoch,
            end_epoch      : v4.gems_schedule.end_epoch,
            gems_per_epoch : v4.gems_schedule.gems_per_epoch,
        };
        0x2::event::emit<GemsSetForNewHiveCycle>(v5);
        0x2::transfer::share_object<PoolsGovernor>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg17), 0x2::tx_context::sender(arg17));
    }

    public entry fun kraft_new_pool_hive_three_token_amm<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut 0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::LP<T0, T1, T2, T3>>());
        let v1 = 0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::LP<T0, T1, T2, T3>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::LP<T0, T1, T2, T3>>>(arg2),
            gems_available     : 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::LP<T0, T1, T2, T3>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.gems_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = PoolHiveKraftd{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKraftd>(v7);
        0x2ff795c8fc6c2c05ef3b161f3755bb300bfc439cf4264ee57fb43f43b1e443e7::three_pool::set_pool_hive_addr<T0, T1, T2, T3>(arg1, &arg0.dex_dao_cap, v5);
    }

    public entry fun kraft_new_pool_hive_two_token_amm<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut 0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::LP<T0, T1, T2>>());
        let v1 = 0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::LP<T0, T1, T2>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::LP<T0, T1, T2>>>(arg2),
            gems_available     : 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::LP<T0, T1, T2>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.gems_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = PoolHiveKraftd{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKraftd>(v7);
        0x84ade832438d2b41e659c5a6010a1fc3d5c925735372a5dd60694d7bbc3dc49a::two_pool::set_pool_hive_addr<T0, T1, T2>(arg1, &arg0.dex_dao_cap, v5);
    }

    public fun transition_into_next_gems_cycle(arg0: &mut PoolsGovernor, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg1);
        assert!(v0 > arg0.gems_schedule.end_epoch, 7001);
        let v1 = if (arg0.gems_cycle < 5) {
            1000000 / 4
        } else if (arg0.gems_cycle < 10) {
            1000000 / 7
        } else {
            0
        };
        arg0.gems_schedule.start_epoch = v0 + 1;
        arg0.gems_schedule.end_epoch = v0 + 352 + 1;
        arg0.gems_schedule.gems_per_epoch = arg0.gems_schedule.gems_per_epoch + 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div_u128((arg0.gems_schedule.gems_per_epoch as u128), (v1 as u128), (1000000 as u128));
        arg0.gems_cycle = arg0.gems_cycle + 1;
        let v2 = GemsSetForNewHiveCycle{
            gems_cycle     : arg0.gems_cycle,
            start_epoch    : arg0.gems_schedule.start_epoch,
            end_epoch      : arg0.gems_schedule.end_epoch,
            gems_per_epoch : arg0.gems_schedule.gems_per_epoch,
        };
        0x2::event::emit<GemsSetForNewHiveCycle>(v2);
    }

    public fun unbond_from_bee_box_1_fruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 1, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, v4) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        let v5 = v2;
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = &mut v5;
        let v8 = claim_fruit_for_bee_box<T0, T1>(v6, v7, v1, arg1.total_staked, v0, v3, v4);
        let v9 = 0x2::object::uid_to_address(&arg1.id);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v9, arg2, v3, v5, arg3, v0, arg4), v8)
    }

    public fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 2, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, v4) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        let v5 = v2;
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = &mut v5;
        let v8 = claim_fruit_for_bee_box<T0, T1>(v6, v7, v1, arg1.total_staked, v0, v3, v4);
        let v9 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v10 = &mut v5;
        let v11 = claim_fruit_for_bee_box<T0, T2>(v9, v10, v1, arg1.total_staked, v0, v3, v4);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v5, arg3, v0, arg4), v8, v11)
    }

    public fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 3, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, v4) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        let v5 = v2;
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = &mut v5;
        let v8 = claim_fruit_for_bee_box<T0, T1>(v6, v7, v1, arg1.total_staked, v0, v3, v4);
        let v9 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v10 = &mut v5;
        let v11 = claim_fruit_for_bee_box<T0, T2>(v9, v10, v1, arg1.total_staked, v0, v3, v4);
        let v12 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T3>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v13 = &mut v5;
        let v14 = claim_fruit_for_bee_box<T0, T3>(v12, v13, v1, arg1.total_staked, v0, v3, v4);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v5, arg3, v0, arg4), v8, v11, v14)
    }

    public fun unbond_from_bee_box_no_fruit<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, _) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v2, arg3, v0, arg4)
    }

    public fun unlock_from_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg1);
        authority_check(v2, v3, 0x2::tx_context::sender(arg2));
        assert!(0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, v0), 7011);
        let v4 = 0x2::linked_table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v0);
        let v5 = 0;
        let v6 = *0x2::linked_table::front<u64, u64>(&v4.unbonding_psns);
        while (0x1::option::is_some<u64>(&v6)) {
            let v7 = *0x1::option::borrow<u64>(&v6);
            if (0x2::tx_context::epoch(arg2) >= v7) {
                v5 = v5 + *0x2::linked_table::borrow<u64, u64>(&v4.unbonding_psns, v7);
            };
            v6 = *0x2::linked_table::next<u64, u64>(&v4.unbonding_psns, v7);
        };
        assert!(v5 > 0, 7012);
        let v8 = 0x2::balance::split<T0>(&mut v4.unbonding_balance, v5);
        arg0.total_unbonding = arg0.total_unbonding - v5;
        let v9 = UnlockFromBeeBox{
            pool_hive_addr      : 0x2::object::uid_to_address(&arg0.id),
            username            : v1,
            profile_addr        : v0,
            staker_addr         : v3,
            lp_balance_unlocked : v5,
        };
        0x2::event::emit<UnlockFromBeeBox>(v9);
        v8
    }

    public fun update_gems_per_epoch(arg0: &mut PoolsGovernor, arg1: &0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::HiveDaoCapability, arg2: u64) {
        assert!(arg0.module_version == 0, 7038);
        assert!(arg2 < 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_available_gems_in_profile(&arg0.hive_profile) / 3, 7040);
        arg0.gems_schedule.gems_per_epoch = arg2;
        let v0 = GemsPerEpochUpdated{new_gems_per_epoch: arg0.gems_schedule.gems_per_epoch};
        0x2::event::emit<GemsPerEpochUpdated>(v0);
    }

    public fun update_instant_withdrawal_profiles(arg0: &mut PoolsGovernor, arg1: &0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::HiveDaoCapability, arg2: vector<address>, arg3: bool) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            if (arg3) {
                if (!0x2::linked_table::contains<address, bool>(&arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0))) {
                    0x2::linked_table::push_back<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0), true);
                } else {
                    *0x2::linked_table::borrow_mut<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0)) = true;
                };
            } else if (0x2::linked_table::contains<address, bool>(&arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0))) {
                *0x2::linked_table::borrow_mut<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0)) = false;
            };
            v0 = v0 + 1;
        };
        let v1 = InstantWithdrawlProfilesUpdated{
            instant_withdrawal_profiles : arg2,
            are_added                   : arg3,
        };
        0x2::event::emit<InstantWithdrawlProfilesUpdated>(v1);
    }

    public fun update_pool_hive_points(arg0: &mut PoolsGovernor, arg1: &0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::HiveDaoCapability, arg2: vector<address>, arg3: vector<u64>) {
        assert!(arg0.module_version == 0, 7038);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 7004);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            assert!(0x2::linked_table::contains<address, u64>(&arg0.gems_points_map, v1), 7002);
            arg0.total_gems_points = arg0.total_gems_points - 0x2::linked_table::remove<address, u64>(&mut arg0.gems_points_map, v1) + v2;
            0x2::linked_table::push_back<address, u64>(&mut arg0.gems_points_map, v1, v2);
            let v3 = PoolHiveNecatarPointsUpdated{
                pool_hive_identifier : v1,
                new_gems_points      : v2,
                total_gems_points    : arg0.total_gems_points,
            };
            0x2::event::emit<PoolHiveNecatarPointsUpdated>(v3);
            v0 = v0 + 1;
        };
    }

    public fun update_pools_governance_params(arg0: &mut PoolsGovernor, arg1: &0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::config::HiveDaoCapability, arg2: vector<u64>) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = *0x1::vector::borrow<u64>(&arg2, 0);
        if (v0 >= 1000000000) {
            arg0.vote_config.proposal_required_deposit = v0;
        };
        let v1 = *0x1::vector::borrow<u64>(&arg2, 1);
        if (7 >= v1 && v1 >= 1) {
            arg0.vote_config.voting_start_delay = v1;
        };
        let v2 = *0x1::vector::borrow<u64>(&arg2, 2);
        if (7 >= v2 && v2 >= 3) {
            arg0.vote_config.voting_period_length = v2;
        };
        let v3 = *0x1::vector::borrow<u64>(&arg2, 3);
        if (3 > v3 && v3 >= 1) {
            arg0.vote_config.execution_delay = v3;
        };
        let v4 = *0x1::vector::borrow<u64>(&arg2, 4);
        if (3 > v4 && v4 >= 1) {
            arg0.vote_config.execution_period_length = v4;
        };
        let v5 = *0x1::vector::borrow<u64>(&arg2, 5);
        if (50 >= v5 && v5 >= 10) {
            arg0.vote_config.proposal_required_quorum = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div(1000000, v5, 100);
        };
        let v6 = *0x1::vector::borrow<u64>(&arg2, 6);
        if (70 > v6 && v6 >= 40) {
            arg0.vote_config.proposal_approval_threshold = 0x8f3a47865019e92cec632a5a51e4ed090ee8f941a153cab5d16b427381247626::math::mul_div(1000000, v6, 100);
        };
        let v7 = *0x1::vector::borrow<u64>(&arg2, 7);
        if (7 >= v7 && v7 >= 1) {
            arg0.unbonding_duration = v7;
        };
        let v8 = PoolsGovernorUpdated{
            proposal_required_deposit   : arg0.vote_config.proposal_required_deposit,
            voting_start_delay          : arg0.vote_config.voting_start_delay,
            voting_period_length        : arg0.vote_config.voting_period_length,
            execution_delay             : arg0.vote_config.execution_delay,
            execution_period_length     : arg0.vote_config.execution_period_length,
            proposal_required_quorum    : arg0.vote_config.proposal_required_quorum,
            proposal_approval_threshold : arg0.vote_config.proposal_approval_threshold,
        };
        0x2::event::emit<PoolsGovernorUpdated>(v8);
    }

    fun verify_and_extract_bee_box<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::HiveProfile, arg3: &mut 0x2::tx_context::TxContext) : (LpBeeBox<T0>, address, 0x1::string::String) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0xd584c33b7a2de5876b47db61c241f3da6d028942b5cfdb5e3b321c861e4fdaa6::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, v0), 7011);
        (get_profile_bee_box<T0>(arg1, v0, arg3), v0, v1)
    }

    // decompiled from Move bytecode v6
}

