module 0x1f5d972741a5d25a7e116d6605adf0dc3320ed48bbcc2e9be00bd0fbc9fa4713::dex_dao {
    struct DexDaoConfig has store, key {
        id: 0x2::object::UID,
        dex_dao_cap: 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::DexDaoCapability,
        hive_profile: 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile,
        hive_cycle: u64,
        nectar_schedule: NectarSchedule,
        active_pool_hives: u64,
        pool_hives: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        total_nectar_points: u64,
        nectar_points: 0x2::table::Table<0x2::object::ID, u64>,
        unbonding_duration: u64,
        instant_withdrawal_profiles: 0x2::table::Table<address, bool>,
        vote_config: VoteConfig,
        module_version: u64,
    }

    struct NectarSchedule has copy, store {
        start_epoch: u64,
        end_epoch: u64,
        nectar_per_epoch: u64,
        cycle_inflation: u64,
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
        gems_available: 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::HiveGems,
        global_claim_index: u256,
        last_claim_epoch: u64,
        lp_bee_boxes: 0x2::table::Table<address, LpBeeBox<T0>>,
        proposal_list: 0x2::table::Table<u64, Proposal>,
        next_proposal_id: u64,
        bee_fruit_list: vector<address>,
        module_version: u64,
    }

    struct LpBeeBox<phantom T0> has store {
        staked_balance: 0x2::balance::Balance<T0>,
        total_gems_earned: u64,
        claim_index: u256,
        is_unbonding: bool,
        unbonding_balance: 0x2::balance::Balance<T0>,
        unlock_epoch: u64,
        bee_fruits: 0x2::table::Table<address, u256>,
    }

    struct BeeFruit<phantom T0> has key {
        id: 0x2::object::UID,
        available_fruits: 0x2::balance::Balance<T0>,
        fruits_per_epoch: u64,
        start_epoch: u64,
        end_epoch: u64,
        claim_index: u256,
        last_claim_epoch: u64,
        belongs_to_hive: 0x2::object::ID,
        module_version: u64,
    }

    struct Proposal has store {
        proposal_id: u64,
        proposer: address,
        deposit: 0x2::balance::Balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>,
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
        voters: 0x2::table::Table<address, bool>,
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

    struct NectarSetForNewHiveCycle has copy, drop {
        hive_cycle: u64,
        start_epoch: u64,
        end_epoch: u64,
        nectar_per_epoch: u64,
        cycle_inflation: u64,
    }

    struct NectarPerEpochUpdated has copy, drop {
        new_nectar_per_epoch: u64,
    }

    struct PoolHiveNecatarPointsUpdated has copy, drop {
        pool_hive_identifier: 0x2::object::ID,
        new_nectar_points: u64,
        total_nectar_points: u64,
    }

    struct InstantWithdrawlProfilesUpdated has copy, drop {
        instant_withdrawal_profiles: vector<address>,
        are_added: bool,
    }

    struct DexDaoConfigUpdated has copy, drop {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
    }

    struct PoolHiveCreated has copy, drop {
        pool_id: 0x2::object::ID,
        lp_identifier: 0x1::type_name::TypeName,
        pool_hive_id: 0x2::object::ID,
        cur_epoch: u64,
    }

    struct RipeFruitsClaimed<phantom T0> has copy, drop {
        fruit_addr: address,
        profile_addr: address,
        fruit_global_claim_index: u256,
        earned_fruits: u64,
        pool_hive_id: 0x2::object::ID,
    }

    struct KraftedGemsForPoolHive has copy, drop {
        pool_hive_id: 0x2::object::ID,
        gems_earned_by_hive: u64,
        nectar_per_epoch_for_hive: u64,
        index_increment: u64,
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
        is_unlocked: bool,
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

    struct NewProposalCreated has copy, drop {
        pool_hive_id: 0x2::object::ID,
        proposal_id: u64,
        proposer: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        proposal_type: u64,
        voting_start_epoch: u64,
        voting_end_epoch: u64,
        execution_start_epoch: u64,
        execution_end_epoch: u64,
        new_params: 0x1::option::Option<vector<u64>>,
        new_weights: 0x1::option::Option<vector<u64>>,
        new_fee_info: 0x1::option::Option<vector<u64>>,
        fruit_life: 0x1::option::Option<FruitLife>,
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

    fun accrue_hive_for_bee_box<T0>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut LpBeeBox<T0>, arg3: u64) : 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::HiveGems {
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = *0x2::table::borrow<0x2::object::ID, u64>(&arg0.nectar_points, v0);
        if (v1 == 0) {
            return 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::zero()
        };
        let v2 = arg3 - arg1.last_claim_epoch;
        let v3 = 0;
        if (v2 > 0 && arg1.total_staked > 0) {
            let v4 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((arg0.nectar_schedule.nectar_per_epoch as u128), (v1 as u128), (arg0.total_nectar_points as u128));
            let v5 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((v2 as u128), (v4 as u128), (arg1.total_staked as u128));
            arg1.global_claim_index = arg1.global_claim_index + (v5 as u256);
            arg1.last_claim_epoch = arg3;
            let v6 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((arg1.total_staked as u128), (v5 as u128), (1000000 as u128));
            let v7 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::zero();
            if (v6 <= 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_available_gems_in_profile(&arg0.hive_profile)) {
                0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::join(&mut v7, 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::withdraw_gems_from_profile(&mut arg0.hive_profile, v6));
            };
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::join(&mut arg1.gems_available, v7);
            let v8 = KraftedGemsForPoolHive{
                pool_hive_id              : v0,
                gems_earned_by_hive       : v6,
                nectar_per_epoch_for_hive : v4,
                index_increment           : v5,
                global_claim_index        : arg1.global_claim_index,
                last_claim_epoch          : arg1.last_claim_epoch,
            };
            0x2::event::emit<KraftedGemsForPoolHive>(v8);
        };
        let v9 = 0x2::balance::value<T0>(&arg2.staked_balance);
        if (v9 > 0 && arg1.global_claim_index > arg2.claim_index) {
            let v10 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128(((arg1.global_claim_index - arg2.claim_index) as u128), (v9 as u128), (1000000 as u128));
            v3 = v10;
            arg2.claim_index = arg1.global_claim_index;
            arg2.total_gems_earned = arg2.total_gems_earned + v10;
        };
        if (v3 > 0) {
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::split(&mut arg1.gems_available, v3)
        } else {
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::zero()
        }
    }

    public fun add_more_fruits<T0, T1>(arg0: &mut BeeFruit<T1>, arg1: &mut PoolHive<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.belongs_to_hive == 0x2::object::uid_to_inner(&arg1.id), 7015);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let (v2, _) = 0x1::vector::index_of<address>(&arg1.bee_fruit_list, &v1);
        assert!(v2, 7016);
        assert!(arg0.end_epoch > v0, 7014);
        let v4 = if (arg0.end_epoch > v0) {
            v0
        } else {
            arg0.end_epoch
        };
        let v5 = if (arg0.last_claim_epoch > arg0.start_epoch) {
            arg0.last_claim_epoch
        } else {
            arg0.start_epoch
        };
        if (v0 >= arg0.start_epoch) {
            let v6 = 0;
            if (v4 > v5) {
                v6 = v4 - v5;
            };
            if (v6 > 0) {
                arg0.claim_index = arg0.claim_index + (0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(arg0.fruits_per_epoch, v6, 1000000), arg1.total_staked) as u256);
                arg0.last_claim_epoch = v0;
            };
        };
        0x2::balance::join<T1>(&mut arg0.available_fruits, 0x2::balance::split<T1>(&mut arg2, arg3));
        let v7 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, arg3, arg0.end_epoch - v5);
        arg0.fruits_per_epoch = arg0.fruits_per_epoch + v7;
        let v8 = MoreFruitsAdded{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg1.id),
            bee_fruit_addr       : 0x2::object::uid_to_address(&arg0.id),
            fruits_added         : arg3,
            additional_per_epoch : v7,
            fruits_per_epoch     : arg0.fruits_per_epoch,
            available_fruits     : 0x2::balance::value<T1>(&arg0.available_fruits),
        };
        0x2::event::emit<MoreFruitsAdded>(v8);
        arg2
    }

    public fun add_more_fruits_coins<T0, T1>(arg0: &mut BeeFruit<T1>, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = add_more_fruits<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(arg2), arg3, arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        destroy_or_transfer_balance<T1>(v0, v1, arg4);
    }

    public entry fun castVote<T0>(arg0: &mut PoolHive<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 7024);
        let v2 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v0 >= v2.voting_start_epoch && v0 <= v2.voting_end_epoch, 7025);
        if (v2.proposal_status == 0) {
            v2.proposal_status = 1;
        };
        let v3 = 0x2::balance::value<T0>(&0x2::table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v1).staked_balance);
        assert!(v3 > 0, 7026);
        assert!(!0x2::table::contains<address, bool>(&v2.voters, v1), 7027);
        if (arg2 == true) {
            v2.yes_votes = v2.yes_votes + v3;
        } else {
            v2.no_votes = v2.no_votes + v3;
        };
        0x2::table::add<address, bool>(&mut v2.voters, v1, arg2);
        let v4 = VoteCasted{
            pool_hive_id : 0x2::object::uid_to_inner(&arg0.id),
            proposal_id  : v2.proposal_id,
            voter        : v1,
            vote         : arg2,
            yes_votes    : v2.yes_votes,
            no_votes     : v2.no_votes,
            total_staked : arg0.total_staked,
        };
        0x2::event::emit<VoteCasted>(v4);
    }

    public fun check_if_all_are_hives(arg0: &DexDaoConfig, arg1: vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.nectar_points, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg1, v0)))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun claim_fruit_for_bee_box<T0, T1>(arg0: &mut BeeFruit<T1>, arg1: &mut LpBeeBox<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address) : 0x2::balance::Balance<T1> {
        if (arg0.start_epoch > arg4) {
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x2::balance::zero<T1>();
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
            arg0.claim_index = arg0.claim_index + 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256((1000000 as u256), 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u256((arg0.fruits_per_epoch as u256), (v3 as u256), (1000000 as u256)), (arg3 as u256));
            arg0.last_claim_epoch = arg4;
        };
        let v4 = 0x2::object::uid_to_address(&arg0.id);
        if (!0x2::table::contains<address, u256>(&arg1.bee_fruits, v4)) {
            0x2::table::add<address, u256>(&mut arg1.bee_fruits, v4, arg0.claim_index);
        };
        let v5 = 0x2::table::borrow_mut<address, u256>(&mut arg1.bee_fruits, v4);
        let v6 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128(((arg0.claim_index - *v5) as u128), (0x2::balance::value<T0>(&arg1.staked_balance) as u128), (1000000 as u128));
        *v5 = arg0.claim_index;
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut v0, 0x2::balance::split<T1>(&mut arg0.available_fruits, v6));
        };
        let v7 = RipeFruitsClaimed<T1>{
            fruit_addr               : v4,
            profile_addr             : arg5,
            fruit_global_claim_index : arg0.claim_index,
            earned_fruits            : v6,
            pool_hive_id             : arg2,
        };
        0x2::event::emit<RipeFruitsClaimed<T1>>(v7);
        v0
    }

    fun deposit_gems_and_unbond_shares<T0>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: address, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg4: address, arg5: LpBeeBox<T0>, arg6: u64, arg7: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg5.staked_balance) >= arg6, 7008);
        assert!(arg6 == 0 || !arg5.is_unbonding, 7009);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = &mut arg5;
        let v2 = accrue_hive_for_bee_box<T0>(arg0, arg1, v1, arg7);
        let v3 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::value(&v2);
        if (v3 > 0) {
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::deposit_gems_in_profile(arg3, v2);
        } else {
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::destroy_zero(v2);
        };
        let v4 = HiveGemsHarvested{
            pool_hive_addr   : arg2,
            profile_addr     : arg4,
            hive_gems_earned : v3,
            claim_index      : arg5.claim_index,
        };
        0x2::event::emit<HiveGemsHarvested>(v4);
        if (arg6 > 0) {
            let v5 = false;
            if (0x2::table::contains<address, bool>(&arg0.instant_withdrawal_profiles, arg4)) {
                v5 = *0x2::table::borrow<address, bool>(&arg0.instant_withdrawal_profiles, arg4);
            };
            arg1.total_staked = arg1.total_staked - arg6;
            if (v5) {
                0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg5.staked_balance, arg6));
            } else {
                0x2::balance::join<T0>(&mut arg5.unbonding_balance, 0x2::balance::split<T0>(&mut arg5.staked_balance, arg6));
                arg5.is_unbonding = true;
                arg5.unlock_epoch = arg7 + arg0.unbonding_duration;
                arg1.total_unbonding = arg1.total_unbonding + arg6;
            };
            let v6 = UnbondingFromBeeBox{
                pool_hive_addr      : 0x2::object::uid_to_address(&arg1.id),
                profile_addr        : arg4,
                lp_balance_unbonded : arg6,
                unlock_epoch        : arg5.unlock_epoch,
                is_unlocked         : v5,
            };
            0x2::event::emit<UnbondingFromBeeBox>(v6);
        };
        0x2::table::add<address, LpBeeBox<T0>>(&mut arg1.lp_bee_boxes, arg4, arg5);
        v0
    }

    public fun deposit_hive_as_incentives(arg0: &mut DexDaoConfig, arg1: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HiveVault, arg2: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::burn_hive_for_gems(arg1, &mut arg0.hive_profile, arg2, arg3, arg4);
    }

    fun deposit_into_bee_box<T0>(arg0: address, arg1: 0x1::string::String, arg2: &mut DexDaoConfig, arg3: &mut PoolHive<T0>, arg4: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg5: LpBeeBox<T0>, arg6: 0x2::balance::Balance<T0>, arg7: u64) {
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg2, arg3, v0, arg7);
        let v2 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::value(&v1);
        if (v2 > 0) {
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::deposit_gems_in_profile(arg4, v1);
        } else {
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::destroy_zero(v1);
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
        0x2::table::add<address, LpBeeBox<T0>>(&mut arg3.lp_bee_boxes, arg0, arg5);
    }

    public fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0 && arg3.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 1, 7006);
        let (v1, v2, v3, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 || v4 == 0x2::tx_context::sender(arg5), 7007);
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg5);
        let v6 = &mut v5;
        let v7 = claim_fruit_for_bee_box<T0, T1>(arg3, v6, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg4, v0);
        v7
    }

    public fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: &mut BeeFruit<T2>, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 2, 7006);
        let (v1, v2, v3, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 || v4 == 0x2::tx_context::sender(arg6), 7007);
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg6);
        let v6 = &mut v5;
        let v7 = claim_fruit_for_bee_box<T0, T1>(arg3, v6, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        let v8 = &mut v5;
        let v9 = claim_fruit_for_bee_box<T0, T2>(arg4, v8, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg5, v0);
        (v7, v9)
    }

    public fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: &mut BeeFruit<T2>, arg5: &mut BeeFruit<T3>, arg6: 0x2::balance::Balance<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0 && arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg7);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 3, 7006);
        let (v1, v2, v3, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 || v4 == 0x2::tx_context::sender(arg7), 7007);
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg7);
        let v6 = &mut v5;
        let v7 = claim_fruit_for_bee_box<T0, T1>(arg3, v6, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        let v8 = &mut v5;
        let v9 = claim_fruit_for_bee_box<T0, T2>(arg4, v8, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        let v10 = &mut v5;
        let v11 = claim_fruit_for_bee_box<T0, T3>(arg5, v10, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v1);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg6, v0);
        (v7, v9, v11)
    }

    public fun deposit_into_bee_box_no_fruits<T0>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 0, 7006);
        let (v1, v2, v3, v4) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg2);
        assert!(v3 || v4 == 0x2::tx_context::sender(arg4), 7007);
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg4);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg3, v0);
    }

    fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    fun destroy_proposal(arg0: Proposal) : (u64, address, 0x2::balance::Balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, 0x1::option::Option<FruitLife>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>) {
        let Proposal {
            proposal_id           : v0,
            proposer              : v1,
            deposit               : v2,
            title                 : v3,
            description           : v4,
            link                  : v5,
            proposal_type         : v6,
            voting_start_epoch    : v7,
            voting_end_epoch      : v8,
            execution_start_epoch : v9,
            execution_end_epoch   : v10,
            proposal_status       : v11,
            yes_votes             : v12,
            no_votes              : v13,
            voters                : v14,
            fruit_life            : v15,
            new_params            : v16,
            new_weights           : v17,
            new_fee_info          : v18,
        } = arg0;
        0x2::table::drop<address, bool>(v14);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v15, v16, v17, v18)
    }

    public entry fun evaluateProposal<T0>(arg0: &DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HiveVault, arg3: u64, arg4: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveDisperser, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x2::table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v0 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg5) > v0.voting_end_epoch && v0.proposal_status <= 1, 7028);
        let v1 = v0.yes_votes + v0.no_votes;
        let v2 = arg1.total_staked;
        let v3 = if (v2 == 0) {
            0
        } else {
            0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((1000000 as u128), (v1 as u128), (v2 as u128))
        };
        let v4 = 0x2::balance::withdraw_all<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v0.deposit);
        let v5 = 0;
        if (arg0.vote_config.proposal_required_quorum > v3) {
            v0.proposal_status = 5;
            let (v6, v7) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::burn_hive_and_return_gems(arg2, v4, 0x2::balance::value<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&v4), arg5);
            0x2::balance::destroy_zero<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v6);
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::deposit_gems_for_hive(arg4, v7);
        } else {
            let v8 = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((1000000 as u128), (v0.yes_votes as u128), (v1 as u128));
            v5 = v8;
            if (v8 > arg0.vote_config.proposal_approval_threshold) {
                v0.proposal_status = 3;
            } else {
                v0.proposal_status = 4;
            };
            destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v4, v0.proposer, arg5);
        };
        let v9 = ProposalEvaluated{
            pool_hive_id         : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id          : v0.proposal_id,
            proposal_status      : v0.proposal_status,
            yes_votes            : v0.yes_votes,
            no_votes             : v0.no_votes,
            total_possible_votes : v2,
            votes_quorum         : v3,
            yes_votes_threshold  : v5,
        };
        0x2::event::emit<ProposalEvaluated>(v9);
    }

    public entry fun executeProposalToAddFruit<T0, T1>(arg0: &mut PoolHive<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(arg0.module_version == 0, 7038);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 7024);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v1.proposal_type == 5 && v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 7030);
        let v2 = 0x1::option::extract<FruitLife>(&mut v1.fruit_life);
        assert!(0x1::vector::length<address>(&arg0.bee_fruit_list) < 3, 7023);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_address(&v3);
        let v5 = BeeFruit<T1>{
            id               : v3,
            available_fruits : 0x2::balance::zero<T1>(),
            fruits_per_epoch : 0,
            start_epoch      : v2.start_epoch,
            end_epoch        : v2.end_epoch,
            claim_index      : 0,
            last_claim_epoch : v0,
            belongs_to_hive  : 0x2::object::uid_to_inner(&arg0.id),
            module_version   : 0,
        };
        0x2::transfer::share_object<BeeFruit<T1>>(v5);
        0x1::vector::push_back<address>(&mut arg0.bee_fruit_list, v4);
        let v6 = BeeFruitKraftedForPoolHive{
            proposal_id          : v1.proposal_id,
            pool_hive_id         : 0x2::object::uid_to_inner(&arg0.id),
            bee_fruit_addr       : v4,
            bee_fruit_identifier : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BeeFruitKraftedForPoolHive>(v6);
    }

    public entry fun executeThreePoolProposal<T0, T1, T2, T3>(arg0: &DexDaoConfig, arg1: &mut PoolHive<0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LP<T0, T1, T2, T3>>, arg2: &mut 0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LiquidityPool<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x2::table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 7030);
        if (v1.proposal_type == 0) {
            let v2 = 0x1::option::extract<vector<u64>>(&mut v1.new_fee_info);
            0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::update_fee_for_pool<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v2, 0), *0x1::vector::borrow<u64>(&v2, 1));
        };
        if (v1.proposal_type == 1) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::update_stable_config<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1), *0x1::vector::borrow<u64>(&v3, 2));
        };
        if (v1.proposal_type == 2) {
            let v4 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::update_weighted_config<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, 0x1::option::extract<vector<u64>>(&mut v1.new_weights), *0x1::vector::borrow<u64>(&v4, 0));
        };
        if (v1.proposal_type == 3) {
            let v5 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::update_curved_A_and_gamma<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), (*0x1::vector::borrow<u64>(&v5, 2) as u256), *0x1::vector::borrow<u64>(&v5, 3));
        };
        if (v1.proposal_type == 4) {
            let v6 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::update_curved_config_fee_params<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 2), *0x1::vector::borrow<u64>(&v6, 3), *0x1::vector::borrow<u64>(&v6, 4), *0x1::vector::borrow<u64>(&v6, 5));
        };
        let v7 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            pool_hive_id  : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type : v1.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v7);
    }

    public entry fun executeTwoPoolProposal<T0, T1, T2>(arg0: &DexDaoConfig, arg1: &mut PoolHive<0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LP<T0, T1, T2>>, arg2: &mut 0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x2::table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(v1.proposal_status == 3 && v0 >= v1.execution_start_epoch && v0 <= v1.execution_end_epoch, 7030);
        if (v1.proposal_type == 0) {
            let v2 = 0x1::option::extract<vector<u64>>(&mut v1.new_fee_info);
            0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::update_fee_for_pool<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v2, 0), *0x1::vector::borrow<u64>(&v2, 1));
        };
        if (v1.proposal_type == 1) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::update_stable_config<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1), *0x1::vector::borrow<u64>(&v3, 2));
        };
        if (v1.proposal_type == 2) {
            let v4 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::update_weighted_config<T0, T1, T2>(arg2, &arg0.dex_dao_cap, 0x1::option::extract<vector<u64>>(&mut v1.new_weights), *0x1::vector::borrow<u64>(&v4, 0));
        };
        if (v1.proposal_type == 3) {
            let v5 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::update_curved_A_and_gamma<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), (*0x1::vector::borrow<u64>(&v5, 2) as u256), *0x1::vector::borrow<u64>(&v5, 3));
        };
        if (v1.proposal_type == 4) {
            let v6 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::update_curved_config_fee_params<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), *0x1::vector::borrow<u64>(&v6, 2), *0x1::vector::borrow<u64>(&v6, 3), *0x1::vector::borrow<u64>(&v6, 4), *0x1::vector::borrow<u64>(&v6, 5));
        };
        let v7 = ProposalExecuted{
            proposal_id   : v1.proposal_id,
            pool_hive_id  : 0x2::object::uid_to_inner(&arg1.id),
            proposal_type : v1.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v7);
    }

    public fun get_dex_dao_config(arg0: &DexDaoConfig) : (0x2::object::ID, u64, NectarSchedule, u64, u64, u64, VoteConfig) {
        (0x2::object::uid_to_inner(&arg0.id), arg0.hive_cycle, arg0.nectar_schedule, arg0.active_pool_hives, arg0.total_nectar_points, arg0.unbonding_duration, arg0.vote_config)
    }

    public fun get_hive_cycle(arg0: &DexDaoConfig) : u64 {
        arg0.hive_cycle
    }

    public fun get_lp_bee_box<T0>(arg0: &PoolHive<T0>, arg1: address) : (u64, u64, u256, bool, u64, u64, u64) {
        let v0 = 0x2::table::borrow<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1);
        (0x2::balance::value<T0>(&v0.staked_balance), v0.total_gems_earned, v0.claim_index, v0.is_unbonding, 0x2::balance::value<T0>(&v0.unbonding_balance), v0.unlock_epoch, 0x2::table::length<address, u256>(&v0.bee_fruits))
    }

    public fun get_lp_bee_box_fruit_claim_index<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: address) : u256 {
        *0x2::table::borrow<address, u256>(&0x2::table::borrow<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1).bee_fruits, arg2)
    }

    public fun get_nectar_schedule(arg0: &DexDaoConfig) : (u64, u64, u64, u64) {
        (arg0.nectar_schedule.start_epoch, arg0.nectar_schedule.end_epoch, arg0.nectar_schedule.nectar_per_epoch, arg0.nectar_schedule.cycle_inflation)
    }

    public fun get_pool_hive<T0>(arg0: &PoolHive<T0>) : (u64, u64, u64, u256, u64, u64, vector<address>) {
        (arg0.total_staked, arg0.total_unbonding, 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::value(&arg0.gems_available), arg0.global_claim_index, arg0.last_claim_epoch, arg0.next_proposal_id, arg0.bee_fruit_list)
    }

    public fun get_pool_hive_id<T0>(arg0: &DexDaoConfig) : 0x2::object::ID {
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pool_hives, 0x1::type_name::get<T0>())
    }

    public fun get_pool_hive_points<T0>(arg0: &DexDaoConfig) : (0x2::object::ID, u64, u64) {
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pool_hives, 0x1::type_name::get<T0>());
        (v0, *0x2::table::borrow<0x2::object::ID, u64>(&arg0.nectar_points, v0), arg0.total_nectar_points)
    }

    public fun get_pool_hive_proposal<T0>(arg0: &PoolHive<T0>, arg1: u64) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        (v0.proposer, v0.title, v0.description, v0.link, v0.proposal_type, v0.voting_start_epoch, v0.voting_end_epoch, v0.execution_start_epoch, v0.execution_end_epoch, v0.proposal_status, v0.yes_votes, v0.no_votes)
    }

    public fun get_pool_hive_proposal_fruit_life<T0>(arg0: &PoolHive<T0>, arg1: u64) : (0x1::ascii::String, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        if (0x1::option::is_some<FruitLife>(&v0.fruit_life)) {
            let v4 = 0x1::option::borrow<FruitLife>(&v0.fruit_life);
            (0x1::type_name::into_string(v4.fruit_typename), v4.start_epoch, v4.end_epoch)
        } else {
            (0x1::type_name::into_string(0x1::type_name::get<T0>()), 0, 0)
        }
    }

    public fun get_pool_hive_proposal_params<T0>(arg0: &PoolHive<T0>, arg1: u64) : (vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x2::table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        if (0x1::option::is_some<vector<u64>>(&v0.new_params)) {
            v1 = *0x1::option::borrow<vector<u64>>(&v0.new_params);
        };
        if (0x1::option::is_some<vector<u64>>(&v0.new_weights)) {
            v2 = *0x1::option::borrow<vector<u64>>(&v0.new_weights);
        };
        if (0x1::option::is_some<vector<u64>>(&v0.new_fee_info)) {
            v3 = *0x1::option::borrow<vector<u64>>(&v0.new_fee_info);
        };
        (v1, v2, v3)
    }

    fun get_profile_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LpBeeBox<T0> {
        if (0x2::table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1)) {
            0x2::table::remove<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, arg1)
        } else {
            LpBeeBox<T0>{staked_balance: 0x2::balance::zero<T0>(), total_gems_earned: 0, claim_index: arg0.global_claim_index, is_unbonding: false, unbonding_balance: 0x2::balance::zero<T0>(), unlock_epoch: 0, bee_fruits: 0x2::table::new<address, u256>(arg2)}
        }
    }

    public fun get_total_nectar_points(arg0: &DexDaoConfig) : u64 {
        arg0.total_nectar_points
    }

    public fun get_vote_config(arg0: &DexDaoConfig) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.vote_config.proposal_required_deposit, arg0.vote_config.voting_start_delay, arg0.vote_config.voting_period_length, arg0.vote_config.execution_delay, arg0.vote_config.execution_period_length, arg0.vote_config.proposal_required_quorum, arg0.vote_config.proposal_approval_threshold)
    }

    public entry fun increment_bee_fruit<T0>(arg0: &mut BeeFruit<T0>) {
        assert!(arg0.module_version < 0, 7039);
        arg0.module_version = 0;
    }

    public entry fun increment_dex_dao_config(arg0: &mut DexDaoConfig) {
        assert!(arg0.module_version < 0, 7039);
        arg0.module_version = 0;
    }

    public entry fun increment_pool_hive<T0>(arg0: &mut PoolHive<T0>) {
        assert!(arg0.module_version < 0, 7039);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_dex_dao_config(arg0: 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::DexDaoCapability, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0xa753c76fc8ff7b4a941bd8f863f6f0f96de34c9efec9dd0b7b8de3b7a6a55db3::hsui_vault::HSuiVault, arg3: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfileMappingStore, arg4: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfileConfig, arg5: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HSuiDisperser<0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hsui::HSUI>, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"DEX DAO ::init_dex_dao_config() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg7 > 0x2::tx_context::epoch(arg16), 7000);
        assert!(arg15 < 7, 7010);
        let (v1, v2) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::kraft_owned_hive_profile(arg1, arg2, arg3, arg4, arg5, arg6, 0x1::string::utf8(b"PoolHiveVault"), 0, 0, 0, arg16);
        let v3 = NectarSchedule{
            start_epoch      : arg7,
            end_epoch        : arg7 + 352,
            nectar_per_epoch : 0,
            cycle_inflation  : 1000000,
        };
        let v4 = VoteConfig{
            proposal_required_deposit   : arg8,
            voting_start_delay          : arg9,
            voting_period_length        : arg10,
            execution_delay             : arg11,
            execution_period_length     : arg12,
            proposal_required_quorum    : 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, arg13, 100),
            proposal_approval_threshold : 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, arg14, 100),
        };
        let v5 = DexDaoConfig{
            id                          : 0x2::object::new(arg16),
            dex_dao_cap                 : arg0,
            hive_profile                : v1,
            hive_cycle                  : 0,
            nectar_schedule             : v3,
            active_pool_hives           : 0,
            pool_hives                  : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg16),
            total_nectar_points         : 0,
            nectar_points               : 0x2::table::new<0x2::object::ID, u64>(arg16),
            unbonding_duration          : arg15,
            instant_withdrawal_profiles : 0x2::table::new<address, bool>(arg16),
            vote_config                 : v4,
            module_version              : 0,
        };
        let v6 = NectarSetForNewHiveCycle{
            hive_cycle       : v5.hive_cycle,
            start_epoch      : v5.nectar_schedule.start_epoch,
            end_epoch        : v5.nectar_schedule.end_epoch,
            nectar_per_epoch : v5.nectar_schedule.nectar_per_epoch,
            cycle_inflation  : v5.nectar_schedule.cycle_inflation,
        };
        0x2::event::emit<NectarSetForNewHiveCycle>(v6);
        0x2::transfer::share_object<DexDaoConfig>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg16), 0x2::tx_context::sender(arg16));
    }

    public entry fun kraft_new_pool_hive_three_token_amm<T0, T1, T2, T3>(arg0: &mut DexDaoConfig, arg1: &mut 0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::get<0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LP<T0, T1, T2, T3>>();
        let v1 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pool_hives, v0), 7005);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = PoolHive<0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LP<T0, T1, T2, T3>>{
            id                 : v2,
            total_staked       : 0,
            total_unbonding    : 0,
            gems_available     : 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v1,
            lp_bee_boxes       : 0x2::table::new<address, LpBeeBox<0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LP<T0, T1, T2, T3>>>(arg2),
            proposal_list      : 0x2::table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            bee_fruit_list     : 0x1::vector::empty<address>(),
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::LP<T0, T1, T2, T3>>>(v4);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pool_hives, v0, v3);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.nectar_points, v3, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v5 = PoolHiveCreated{
            pool_id       : 0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1),
            lp_identifier : v0,
            pool_hive_id  : v3,
            cur_epoch     : v1,
        };
        0x2::event::emit<PoolHiveCreated>(v5);
        0x4446d523d326408f9f5b88baa13d21d811b7e7d9b913a53401b90c1c1750b6e8::three_pool::set_pool_hive_id<T0, T1, T2, T3>(arg1, &arg0.dex_dao_cap, v3);
    }

    public entry fun kraft_new_pool_hive_two_token_amm<T0, T1, T2>(arg0: &mut DexDaoConfig, arg1: &mut 0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::get<0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LP<T0, T1, T2>>();
        let v1 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pool_hives, v0), 7005);
        let v2 = 0x2::object::new(arg2);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = PoolHive<0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LP<T0, T1, T2>>{
            id                 : v2,
            total_staked       : 0,
            total_unbonding    : 0,
            gems_available     : 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v1,
            lp_bee_boxes       : 0x2::table::new<address, LpBeeBox<0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LP<T0, T1, T2>>>(arg2),
            proposal_list      : 0x2::table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            bee_fruit_list     : 0x1::vector::empty<address>(),
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::LP<T0, T1, T2>>>(v4);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pool_hives, v0, v3);
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.nectar_points, v3, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v5 = PoolHiveCreated{
            pool_id       : 0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1),
            lp_identifier : v0,
            pool_hive_id  : v3,
            cur_epoch     : v1,
        };
        0x2::event::emit<PoolHiveCreated>(v5);
        0xcde75ce32f13e55b7889f1d96406ae0419bb03b3acdef0e3a4541ec4733b32fd::two_pool::set_pool_hive_id<T0, T1, T2>(arg1, &arg0.dex_dao_cap, v3);
    }

    public entry fun removeExpiredProposal<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HiveVault, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveDisperser, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        assert!(0x2::table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 7024);
        let v0 = 0x2::table::remove<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg4) > v0.execution_end_epoch, 7029);
        let (v1, _, v3, _, _, _, v7, _, _, _, _, v12, _, _, _, _, _, _) = destroy_proposal(v0);
        let v19 = v3;
        if (0x2::balance::value<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&v19) > 0) {
            let (v20, v21) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::burn_hive_and_return_gems(arg1, v19, 0x2::balance::value<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&v19), arg4);
            0x2::balance::destroy_zero<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v20);
            0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::deposit_gems_for_hive(arg2, v21);
        } else {
            0x2::balance::destroy_zero<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v19);
        };
        let v22 = ProposalDeleted{
            pool_hive_id    : 0x2::object::uid_to_inner(&arg0.id),
            proposal_id     : v1,
            proposal_type   : v7,
            proposal_status : v12,
        };
        0x2::event::emit<ProposalDeleted>(v22);
    }

    public fun remove_expired_fruit<T0, T1>(arg0: &mut PoolHive<T0>, arg1: &mut BeeFruit<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(arg1.belongs_to_hive == 0x2::object::uid_to_inner(&arg0.id), 7015);
        let (v2, v3) = 0x1::vector::index_of<address>(&arg0.bee_fruit_list, &v1);
        assert!(v2, 7016);
        assert!(v0 > arg1.end_epoch || 0x2::balance::value<T1>(&arg1.available_fruits) == 0 && arg1.start_epoch > v0, 7017);
        0x1::vector::remove<address>(&mut arg0.bee_fruit_list, v3);
        let v4 = BeeFruitDestroyed{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            bee_fruit_addr : v1,
            cur_epoch      : v0,
        };
        0x2::event::emit<BeeFruitDestroyed>(v4);
    }

    public entry fun submit_proposal<T0>(arg0: &DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&v1), 7018);
        assert!(arg3 >= 0 && arg3 < 5, 7019);
        if (arg3 == 0) {
            assert!(0x1::option::is_some<vector<u64>>(&arg7), 7019);
            let v2 = *0x1::option::borrow<vector<u64>>(&arg7);
            assert!(0x1::vector::length<u64>(&v2) >= 2, 7019);
        };
        if (arg3 == 1) {
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v3 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v4 = *0x1::vector::borrow<u64>(&v3, 0);
            let v5 = *0x1::vector::borrow<u64>(&v3, 1);
            let v6 = *0x1::vector::borrow<u64>(&v3, 2);
            assert!(100 < v4 && v4 < 1000000, 7036);
            assert!(v6 > v5 && v6 - v5 > 86400000, 7037);
            assert!(0x1::vector::length<u64>(&v3) >= 3, 7019);
        };
        if (arg3 == 2) {
            assert!(0x1::option::is_some<vector<u64>>(&arg9) && 0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v7 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v8 = *0x1::option::borrow<vector<u64>>(&arg9);
            assert!(*0x1::vector::borrow<u64>(&v7, 0) < 100, 7034);
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(&v8)) {
                assert!(*0x1::vector::borrow<u64>(&v8, v9) > 0, 7033);
                v9 = v9 + 1;
            };
            assert!(0x1::vector::length<u64>(&v7) >= 1, 7019);
        };
        if (arg3 == 3) {
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v10 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v11 = *0x1::vector::borrow<u64>(&v10, 0);
            let v12 = (*0x1::vector::borrow<u64>(&v10, 2) as u256);
            let v13 = *0x1::vector::borrow<u64>(&v10, 3);
            assert!(v12 >= 10000000000 && v12 <= 500000000000000000 + 1, 7035);
            assert!(v13 > v11 && v13 - v11 > 86400000, 7037);
            assert!(0x1::vector::length<u64>(&v10) >= 4, 7019);
        };
        if (arg3 == 4) {
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v14 = *0x1::option::borrow<vector<u64>>(&arg8);
            0xacd5821adf1802b69ccd6dce75694d81f47c49e4aedecd565cee60912465bf3a::curved_math::assert_new_config_params(*0x1::vector::borrow<u64>(&v14, 0), *0x1::vector::borrow<u64>(&v14, 1), *0x1::vector::borrow<u64>(&v14, 2), *0x1::vector::borrow<u64>(&v14, 3), *0x1::vector::borrow<u64>(&v14, 4), *0x1::vector::borrow<u64>(&v14, 5));
            assert!(0x1::vector::length<u64>(&v14) >= 6, 7019);
        };
        let v15 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            deposit               : 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v1, arg0.vote_config.proposal_required_deposit),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v0 + arg0.vote_config.voting_start_delay,
            voting_end_epoch      : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length,
            execution_start_epoch : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay,
            execution_end_epoch   : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length,
            proposal_status       : 0,
            yes_votes             : 0,
            no_votes              : 0,
            voters                : 0x2::table::new<address, bool>(arg10),
            fruit_life            : 0x1::option::none<FruitLife>(),
            new_params            : arg8,
            new_weights           : arg9,
            new_fee_info          : arg7,
        };
        let v16 = NewProposalCreated{
            pool_hive_id          : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id           : v15.proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v15.voting_start_epoch,
            voting_end_epoch      : v15.voting_end_epoch,
            execution_start_epoch : v15.execution_start_epoch,
            execution_end_epoch   : v15.execution_end_epoch,
            new_params            : arg8,
            new_weights           : arg9,
            new_fee_info          : arg7,
            fruit_life            : 0x1::option::none<FruitLife>(),
        };
        0x2::event::emit<NewProposalCreated>(v16);
        0x2::table::add<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v15);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v17 = 0x2::tx_context::sender(arg10);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v1, v17, arg10);
    }

    public entry fun submit_proposal_to_add_fruit<T0, T1>(arg0: &DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg9);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::coin::into_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&v1), 7018);
        assert!(v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length < arg7, 7020);
        assert!(arg7 < arg8, 7021);
        assert!(arg3 == 5, 7019);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) < 3, 7023);
        let v2 = FruitLife{
            fruit_typename : 0x1::type_name::get<T1>(),
            start_epoch    : arg7,
            end_epoch      : arg8,
        };
        let v3 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            deposit               : 0x2::balance::split<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(&mut v1, arg0.vote_config.proposal_required_deposit),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v0 + arg0.vote_config.voting_start_delay,
            voting_end_epoch      : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length,
            execution_start_epoch : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay,
            execution_end_epoch   : v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length,
            proposal_status       : 0,
            yes_votes             : 0,
            no_votes              : 0,
            voters                : 0x2::table::new<address, bool>(arg9),
            fruit_life            : 0x1::option::some<FruitLife>(v2),
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
        };
        let v4 = NewProposalCreated{
            pool_hive_id          : 0x2::object::uid_to_inner(&arg1.id),
            proposal_id           : v3.proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v3.voting_start_epoch,
            voting_end_epoch      : v3.voting_end_epoch,
            execution_start_epoch : v3.execution_start_epoch,
            execution_end_epoch   : v3.execution_end_epoch,
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
            fruit_life            : 0x1::option::some<FruitLife>(v2),
        };
        0x2::event::emit<NewProposalCreated>(v4);
        0x2::table::add<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v3);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v5 = 0x2::tx_context::sender(arg9);
        destroy_or_transfer_balance<0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive::HIVE>(v1, v5, arg9);
    }

    public fun transition_into_next_hive_cycle(arg0: &mut DexDaoConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg1);
        assert!(v0 > arg0.nectar_schedule.end_epoch, 7001);
        let v1 = if (arg0.hive_cycle < 5) {
            1000000 / 4
        } else if (arg0.hive_cycle < 10) {
            1000000 / 7
        } else {
            0
        };
        arg0.nectar_schedule.start_epoch = v0;
        arg0.nectar_schedule.end_epoch = v0 + 352;
        arg0.nectar_schedule.nectar_per_epoch = arg0.nectar_schedule.nectar_per_epoch + 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div_u128((arg0.nectar_schedule.nectar_per_epoch as u128), (v1 as u128), (1000000 as u128));
        arg0.hive_cycle = arg0.hive_cycle + 1;
        let v2 = NectarSetForNewHiveCycle{
            hive_cycle       : arg0.hive_cycle,
            start_epoch      : arg0.nectar_schedule.start_epoch,
            end_epoch        : arg0.nectar_schedule.end_epoch,
            nectar_per_epoch : arg0.nectar_schedule.nectar_per_epoch,
            cycle_inflation  : v1,
        };
        0x2::event::emit<NectarSetForNewHiveCycle>(v2);
    }

    public fun unbond_from_bee_box_1_fruit<T0, T1>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg3.module_version == 0, 7038);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 1, 7006);
        let v0 = 0x2::tx_context::epoch(arg5);
        let (v1, v2) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg5);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = claim_fruit_for_bee_box<T0, T1>(arg3, v4, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v6 = 0x2::object::uid_to_address(&arg1.id);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v6, arg2, v2, v3, arg4, v0), v5)
    }

    public fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: &mut BeeFruit<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg3.module_version == 0 && arg4.module_version == 0, 7038);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 2, 7006);
        let v0 = 0x2::tx_context::epoch(arg6);
        let (v1, v2) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg6);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = claim_fruit_for_bee_box<T0, T1>(arg3, v4, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v6 = &mut v3;
        let v7 = claim_fruit_for_bee_box<T0, T2>(arg4, v6, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v8 = 0x2::object::uid_to_address(&arg1.id);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v8, arg2, v2, v3, arg5, v0), v5, v7)
    }

    public fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut BeeFruit<T1>, arg4: &mut BeeFruit<T2>, arg5: &mut BeeFruit<T3>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg3.module_version == 0 && arg4.module_version == 0 && arg5.module_version == 0, 7038);
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 3, 7006);
        let v0 = 0x2::tx_context::epoch(arg7);
        let (v1, v2) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg7);
        let v3 = v1;
        let v4 = &mut v3;
        let v5 = claim_fruit_for_bee_box<T0, T1>(arg3, v4, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v6 = &mut v3;
        let v7 = claim_fruit_for_bee_box<T0, T2>(arg4, v6, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v8 = &mut v3;
        let v9 = claim_fruit_for_bee_box<T0, T3>(arg5, v8, 0x2::object::uid_to_inner(&arg1.id), arg1.total_staked, v0, v2);
        let v10 = 0x2::object::uid_to_address(&arg1.id);
        (deposit_gems_and_unbond_shares<T0>(arg0, arg1, v10, arg2, v2, v3, arg6, v0), v5, v7, v9)
    }

    public fun unbond_from_bee_box_no_fruit<T0>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x1::vector::length<address>(&arg1.bee_fruit_list) == 0, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let (v1, v2) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        let v3 = 0x2::object::uid_to_address(&arg1.id);
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v3, arg2, v2, v1, arg3, v0)
    }

    public fun unlock_from_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg1);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg2), 7007);
        assert!(0x2::table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, v0), 7011);
        let v4 = 0x2::table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v0);
        assert!(v4.is_unbonding, 7012);
        assert!(0x2::tx_context::epoch(arg2) >= v4.unlock_epoch, 7013);
        let v5 = 0x2::balance::value<T0>(&v4.unbonding_balance);
        let v6 = 0x2::balance::withdraw_all<T0>(&mut v4.unbonding_balance);
        v4.is_unbonding = false;
        v4.unlock_epoch = 0;
        arg0.total_unbonding = arg0.total_unbonding - v5;
        let v7 = UnlockFromBeeBox{
            pool_hive_addr      : 0x2::object::uid_to_address(&arg0.id),
            username            : v1,
            profile_addr        : v0,
            staker_addr         : v3,
            lp_balance_unlocked : v5,
        };
        0x2::event::emit<UnlockFromBeeBox>(v7);
        v6
    }

    public fun update_dex_dao_config(arg0: &mut DexDaoConfig, arg1: &0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::HiveDaoCapability, arg2: vector<u64>) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = *0x1::vector::borrow<u64>(&arg2, 0);
        if (v0 >= 1000000000) {
            arg0.vote_config.proposal_required_deposit = v0;
        };
        let v1 = *0x1::vector::borrow<u64>(&arg2, 1);
        if (v1 >= 1) {
            arg0.vote_config.voting_start_delay = v1;
        };
        let v2 = *0x1::vector::borrow<u64>(&arg2, 2);
        if (v2 >= 3) {
            arg0.vote_config.voting_period_length = v2;
        };
        let v3 = *0x1::vector::borrow<u64>(&arg2, 3);
        if (v3 >= 1) {
            arg0.vote_config.execution_delay = v3;
        };
        let v4 = *0x1::vector::borrow<u64>(&arg2, 4);
        if (v4 >= 1) {
            arg0.vote_config.execution_period_length = v4;
        };
        let v5 = *0x1::vector::borrow<u64>(&arg2, 5);
        if (v5 >= 10) {
            arg0.vote_config.proposal_required_quorum = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, v5, 100);
        };
        let v6 = *0x1::vector::borrow<u64>(&arg2, 6);
        if (v6 >= 50) {
            arg0.vote_config.proposal_approval_threshold = 0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::math::mul_div(1000000, v6, 100);
        };
        let v7 = *0x1::vector::borrow<u64>(&arg2, 7);
        if (7 >= v7 && v7 >= 1) {
            arg0.unbonding_duration = v7;
        };
        let v8 = DexDaoConfigUpdated{
            proposal_required_deposit   : arg0.vote_config.proposal_required_deposit,
            voting_start_delay          : arg0.vote_config.voting_start_delay,
            voting_period_length        : arg0.vote_config.voting_period_length,
            execution_delay             : arg0.vote_config.execution_delay,
            execution_period_length     : arg0.vote_config.execution_period_length,
            proposal_required_quorum    : arg0.vote_config.proposal_required_quorum,
            proposal_approval_threshold : arg0.vote_config.proposal_approval_threshold,
        };
        0x2::event::emit<DexDaoConfigUpdated>(v8);
    }

    public fun update_instant_withdrawal_profiles(arg0: &mut DexDaoConfig, arg1: &0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::HiveDaoCapability, arg2: vector<address>, arg3: bool) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            if (arg3) {
                if (!0x2::table::contains<address, bool>(&arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0))) {
                    0x2::table::add<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0), true);
                } else {
                    *0x2::table::borrow_mut<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0)) = true;
                };
            } else if (0x2::table::contains<address, bool>(&arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0))) {
                *0x2::table::borrow_mut<address, bool>(&mut arg0.instant_withdrawal_profiles, *0x1::vector::borrow<address>(&arg2, v0)) = false;
            };
            v0 = v0 + 1;
        };
        let v1 = InstantWithdrawlProfilesUpdated{
            instant_withdrawal_profiles : arg2,
            are_added                   : arg3,
        };
        0x2::event::emit<InstantWithdrawlProfilesUpdated>(v1);
    }

    public fun update_nectar_per_epoch(arg0: &mut DexDaoConfig, arg1: &0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::HiveDaoCapability, arg2: u64) {
        assert!(arg0.module_version == 0, 7038);
        arg0.nectar_schedule.nectar_per_epoch = arg2;
        let v0 = NectarPerEpochUpdated{new_nectar_per_epoch: arg0.nectar_schedule.nectar_per_epoch};
        0x2::event::emit<NectarPerEpochUpdated>(v0);
    }

    public fun update_pool_hive_points(arg0: &mut DexDaoConfig, arg1: &0x1fbebab3c5dc54441cd8ea99a02110be44f4e8e43fea61f89b360a8847aed3e9::config::HiveDaoCapability, arg2: vector<0x2::object::ID>, arg3: vector<u64>) {
        assert!(arg0.module_version == 0, 7038);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3), 7004);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x2::object::ID>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.nectar_points, v1), 7002);
            arg0.total_nectar_points = arg0.total_nectar_points - 0x2::table::remove<0x2::object::ID, u64>(&mut arg0.nectar_points, v1) + v2;
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.nectar_points, v1, v2);
            let v3 = PoolHiveNecatarPointsUpdated{
                pool_hive_identifier : v1,
                new_nectar_points    : v2,
                total_nectar_points  : arg0.total_nectar_points,
            };
            0x2::event::emit<PoolHiveNecatarPointsUpdated>(v3);
            v0 = v0 + 1;
        };
    }

    fun verify_and_extract_bee_box<T0>(arg0: &mut DexDaoConfig, arg1: &mut PoolHive<T0>, arg2: &mut 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::HiveProfile, arg3: &mut 0x2::tx_context::TxContext) : (LpBeeBox<T0>, address) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let (v0, _, v2, v3) = 0x33e2c0b377a9f0006c9e5d555068993855b7546d36a34b690c0864de23026df4::hive_profile::get_profile_meta_info(arg2);
        assert!(v2 || v3 == 0x2::tx_context::sender(arg3), 7007);
        assert!(0x2::table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, v0), 7011);
        (get_profile_bee_box<T0>(arg1, v0, arg3), v0)
    }

    // decompiled from Move bytecode v6
}

