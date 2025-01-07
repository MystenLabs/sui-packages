module 0x914f85bc4d051d6bebbf5fa7caa34fd7d4ae26a60c3900b9230676f821d93278::dex_dao {
    struct PoolsGovernor has store, key {
        id: 0x2::object::UID,
        governor_profile: 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile,
        managed_buzzes: 0x2::linked_table::LinkedTable<0x1::ascii::String, SystemBuzz>,
        gems_cycle: u64,
        gems_schedule: GemsSchedule,
        total_gems_points: u64,
        gems_points_map: 0x2::linked_table::LinkedTable<address, u64>,
        dex_dao_cap: 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::DexDaoCapability,
        unbonding_duration: u64,
        vote_config: VoteConfig,
        active_pool_hives: u64,
        pool_hives: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct SystemBuzz has store {
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
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

    struct PoolGovernorBuzzes has store, key {
        id: 0x2::object::UID,
        governor_buzzes: 0x2::linked_table::LinkedTable<u64, GovernorBuzz>,
        count: u64,
    }

    struct GovernorBuzz has store {
        pool_hive: address,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        user_buzzes: 0x2::linked_table::LinkedTable<address, 0x1::string::String>,
    }

    struct PoolHive<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_unbonding: u64,
        lp_bee_boxes: 0x2::linked_table::LinkedTable<address, LpBeeBox<T0>>,
        gems_available: 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::HiveGems,
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
        deposit: 0x2::balance::Balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>,
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

    struct NewGovernorBuzz has copy, drop {
        count: u64,
        pool_hive: address,
        buzz: 0x1::string::String,
        gen_ai: 0x1::option::Option<0x1::string::String>,
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
        bee_fruit_type: 0x1::ascii::String,
        fruits_added: u64,
        additional_per_epoch: u64,
        fruits_per_epoch: u64,
        available_fruits: u64,
    }

    struct BeeFruitDestroyed has copy, drop {
        pool_hive_addr: address,
        bee_fruit_type: 0x1::ascii::String,
        cur_epoch: u64,
    }

    struct NewProposalKrafted has copy, drop {
        pool_hive_addr: address,
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
        pool_hive_addr: address,
        proposal_id: u64,
        voter: address,
        vote: bool,
        yes_votes: u64,
        no_votes: u64,
        total_staked: u64,
    }

    struct ProposalEvaluated has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        proposal_status: u64,
        yes_votes: u64,
        no_votes: u64,
        total_possible_votes: u64,
        votes_quorum: u64,
        yes_votes_threshold: u64,
    }

    struct ProposalDeleted has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        proposal_type: u64,
        proposal_status: u64,
    }

    struct BeeFruitKraftedForPoolHive has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        bee_fruit_identifier: 0x1::type_name::TypeName,
    }

    struct ProposalExecuted has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        proposal_type: u64,
    }

    struct UserLikedGovernorBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        buzz_index: u64,
    }

    struct UserUnLikedGovernorBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        buzz_index: u64,
    }

    struct UserBuzzOnGovernanceBuzzDetected has copy, drop {
        user_profile_addr: address,
        buzz_index: u64,
        username: 0x1::string::String,
        user_buzz: 0x1::string::String,
    }

    fun accrue_hive_for_bee_box<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut LpBeeBox<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::HiveGems {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = *0x2::linked_table::borrow<address, u64>(&arg0.gems_points_map, v0);
        if (v1 == 0) {
            arg1.last_claim_epoch = arg3;
            return 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::zero()
        };
        let v2 = arg3 - arg1.last_claim_epoch;
        let v3 = 0;
        if (v2 > 0 && arg1.total_staked > 0) {
            let v4 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256((arg0.gems_schedule.gems_per_epoch as u256), (v1 as u256), (arg0.total_gems_points as u256));
            let v5 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256((v2 as u256), (v4 as u256), (arg1.total_staked as u256));
            arg1.global_claim_index = arg1.global_claim_index + v5;
            arg1.last_claim_epoch = arg3;
            let v6 = (0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256((arg1.total_staked as u256), (v5 as u256), (1000000 as u256)) as u64);
            let v7 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::zero();
            if (v6 <= 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_available_gems_in_profile(&arg0.governor_profile)) {
                0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::join(&mut v7, 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::withdraw_gems_from_profile(&mut arg0.governor_profile, v6, arg4));
            };
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::join(&mut arg1.gems_available, v7);
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
            let v10 = (0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256(((arg1.global_claim_index - arg2.claim_index) as u256), (v9 as u256), (1000000 as u256)) as u64);
            v3 = v10;
            arg2.claim_index = arg1.global_claim_index;
            arg2.total_gems_earned = arg2.total_gems_earned + v10;
        };
        if (v3 > 0) {
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::split(&mut arg1.gems_available, v3)
        } else {
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::zero()
        }
    }

    public fun add_more_fruits<T0, T1>(arg0: &mut PoolHive<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v2, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.bee_fruit_list, &v1);
        assert!(v2, 7016);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg0.id, v1);
        assert!(v4.end_epoch > v0, 7014);
        let v5 = if (v4.end_epoch > v0) {
            v0
        } else {
            v4.end_epoch
        };
        let v6 = if (v4.last_claim_epoch > v4.start_epoch) {
            v4.last_claim_epoch
        } else {
            v4.start_epoch
        };
        if (v0 >= v4.start_epoch) {
            let v7 = 0;
            if (v5 > v6) {
                v7 = v5 - v6;
            };
            if (v7 > 0) {
                v4.claim_index = v4.claim_index + (0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(v4.fruits_per_epoch, v7, 1000000), arg0.total_staked) as u256);
                v4.last_claim_epoch = v0;
            };
        };
        0x2::balance::join<T1>(&mut v4.available_fruits, 0x2::balance::split<T1>(&mut arg1, arg2));
        let v8 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, arg2, v4.end_epoch - v6);
        v4.fruits_per_epoch = v4.fruits_per_epoch + v8;
        let v9 = MoreFruitsAdded{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg0.id),
            bee_fruit_type       : v1,
            fruits_added         : arg2,
            additional_per_epoch : v8,
            fruits_per_epoch     : v4.fruits_per_epoch,
            available_fruits     : 0x2::balance::value<T1>(&v4.available_fruits),
        };
        0x2::event::emit<MoreFruitsAdded>(v9);
        arg1
    }

    public fun add_more_fruits_coins<T0, T1>(arg0: &mut PoolHive<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = add_more_fruits<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::coin_helper::destroy_or_transfer_balance<T1>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    fun authority_check(arg0: bool, arg1: address, arg2: address) {
        assert!(arg0 || arg1 == arg2, 7007);
    }

    public entry fun castVote<T0>(arg0: &mut PoolHive<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 7024);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        assert!(v0 >= v2.voting_start_epoch && v0 <= v2.voting_end_epoch, 7025);
        if (v2.proposal_status == 0) {
            v2.proposal_status = 1;
        };
        let v3 = 0x2::balance::value<T0>(&0x2::linked_table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v1).staked_balance);
        assert!(v3 > 0, 7026);
        assert!(!0x2::linked_table::contains<address, bool>(&v2.voters, v1), 7027);
        if (arg2 == true) {
            v2.yes_votes = v2.yes_votes + v3;
        } else {
            v2.no_votes = v2.no_votes + v3;
        };
        0x2::linked_table::push_back<address, bool>(&mut v2.voters, v1, arg2);
        let v4 = VoteCasted{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            proposal_id    : v2.proposal_id,
            voter          : v1,
            vote           : arg2,
            yes_votes      : v2.yes_votes,
            no_votes       : v2.no_votes,
            total_staked   : arg0.total_staked,
        };
        0x2::event::emit<VoteCasted>(v4);
    }

    public fun check_if_all_are_hives(arg0: &PoolsGovernor, arg1: vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (!0x2::linked_table::contains<address, u64>(&arg0.gems_points_map, *0x1::vector::borrow<address>(&arg1, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
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
            arg0.claim_index = arg0.claim_index + 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256((1000000 as u256), 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256((arg0.fruits_per_epoch as u256), (v3 as u256), (1000000 as u256)), (arg3 as u256));
            arg0.last_claim_epoch = arg4;
        };
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruits, v4)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4, arg0.claim_index);
        };
        let v5 = 0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4);
        let v6 = (0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u256(((arg0.claim_index - *v5) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64);
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

    fun deposit_gems_and_unbond_shares<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: address, arg3: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg4: address, arg5: LpBeeBox<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg5.staked_balance) >= arg6, 7008);
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg0, arg1, v0, arg7, arg8);
        let v2 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::value(&v1);
        if (v2 > 0) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::deposit_gems_in_profile(arg3, v1);
        } else {
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::destroy_zero(v1);
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
    }

    public fun deposit_hive_as_incentives(arg0: &mut PoolsGovernor, arg1: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HiveVault, arg2: 0x2::coin::Coin<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::burn_hive_for_gems(arg1, &mut arg0.governor_profile, arg2, arg3, arg4);
    }

    fun deposit_into_bee_box<T0>(arg0: address, arg1: 0x1::string::String, arg2: &mut PoolsGovernor, arg3: &mut PoolHive<T0>, arg4: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg5: LpBeeBox<T0>, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg2, arg3, v0, arg7, arg8);
        let v2 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::value(&v1);
        if (v2 > 0) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::deposit_gems_in_profile(arg4, v1);
        } else {
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::destroy_zero(v1);
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

    public fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(&arg0.governor_profile);
        let (v6, _, _, _, _, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_following_subscription_info(arg2, v2);
        if (!v6) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::make_forever_follower_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        };
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 1, 7006);
        let (v14, v15, v16, v17) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg2);
        authority_check(v16, v17, 0x2::tx_context::sender(arg4));
        let v18 = get_profile_bee_box<T0>(arg1, v14, arg4);
        let v19 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v20 = &mut v18;
        let v21 = claim_fruit_for_bee_box<T0, T1>(v19, v20, v1, arg1.total_staked, v0, v14, v15);
        deposit_into_bee_box<T0>(v14, v15, arg0, arg1, arg2, v18, arg3, v0, arg4);
        v21
    }

    public fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(&arg0.governor_profile);
        let (v6, _, _, _, _, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_following_subscription_info(arg2, v2);
        if (!v6) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::make_forever_follower_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        };
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 2, 7006);
        let (v14, v15, v16, v17) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg2);
        authority_check(v16, v17, 0x2::tx_context::sender(arg4));
        let v18 = get_profile_bee_box<T0>(arg1, v14, arg4);
        let v19 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v20 = &mut v18;
        let v21 = claim_fruit_for_bee_box<T0, T1>(v19, v20, v1, arg1.total_staked, v0, v14, v15);
        let v22 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v23 = &mut v18;
        let v24 = claim_fruit_for_bee_box<T0, T2>(v22, v23, v1, arg1.total_staked, v0, v14, v15);
        deposit_into_bee_box<T0>(v14, v15, arg0, arg1, arg2, v18, arg3, v0, arg4);
        (v21, v24)
    }

    public fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(&arg0.governor_profile);
        let (v6, _, _, _, _, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_following_subscription_info(arg2, v2);
        if (!v6) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::make_forever_follower_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        };
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 3, 7006);
        let (v14, v15, v16, v17) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg2);
        authority_check(v16, v17, 0x2::tx_context::sender(arg4));
        let v18 = get_profile_bee_box<T0>(arg1, v14, arg4);
        let v19 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v20 = &mut v18;
        let v21 = claim_fruit_for_bee_box<T0, T1>(v19, v20, v1, arg1.total_staked, v0, v14, v15);
        let v22 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v23 = &mut v18;
        let v24 = claim_fruit_for_bee_box<T0, T2>(v22, v23, v1, arg1.total_staked, v0, v14, v15);
        let v25 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T3>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v26 = &mut v18;
        let v27 = claim_fruit_for_bee_box<T0, T3>(v25, v26, v1, arg1.total_staked, v0, v14, v15);
        deposit_into_bee_box<T0>(v14, v15, arg0, arg1, arg2, v18, arg3, v0, arg4);
        (v21, v24, v27)
    }

    public fun deposit_into_bee_box_no_fruits<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let (v1, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(&arg0.governor_profile);
        let (v5, _, _, _, _, _, _, _) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_following_subscription_info(arg2, v1);
        if (!v5) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::make_forever_follower_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        };
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let (v13, v14, v15, v16) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg2);
        authority_check(v15, v16, 0x2::tx_context::sender(arg4));
        let v17 = get_profile_bee_box<T0>(arg1, v13, arg4);
        deposit_into_bee_box<T0>(v13, v14, arg0, arg1, arg2, v17, arg3, v0, arg4);
    }

    fun destroy_proposal(arg0: Proposal) : (u64, address, 0x2::balance::Balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, 0x1::option::Option<FruitLife>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>) {
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
        0x2::linked_table::drop<address, bool>(v14);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v15, v16, v17, v18)
    }

    public entry fun evaluateProposal<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HiveVault, arg3: u64, arg4: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveDisperser, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EVALUATED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg5) > v1.voting_end_epoch && v1.proposal_status <= 1, 7028);
        let v2 = v1.yes_votes + v1.no_votes;
        let v3 = arg1.total_staked;
        let v4 = if (v3 == 0) {
            0
        } else {
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u128((1000000 as u128), (v2 as u128), (v3 as u128))
        };
        let v5 = 0;
        let v6 = if (arg0.vote_config.proposal_required_quorum > v4) {
            v1.proposal_status = 5;
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::deposit_gems_for_hive(arg4, 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::burn_hive_and_return_gems(arg2, 0x2::balance::withdraw_all<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&mut v1.deposit), v1.proposer, arg5));
            0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_CANCELLED"))
        } else {
            let v7 = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u128((1000000 as u128), (v1.yes_votes as u128), (v2 as u128));
            v5 = v7;
            let v6 = if (v7 > arg0.vote_config.proposal_approval_threshold) {
                v1.proposal_status = 3;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_PASSED"))
            } else {
                v1.proposal_status = 4;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_REJECTED"))
            };
            0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::coin_helper::destroy_or_transfer_balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(0x2::balance::withdraw_all<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&mut v1.deposit), v1.proposer, arg5);
            v6
        };
        let v8 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6);
        let v9 = v8.buzz;
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v1.proposal_id)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v9, v1.title);
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a566f74696e672073746174697374696373203a3a200a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Total votes casted: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v2)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Total possible votes: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v3)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"% participation: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v4 * 100 / 1000000)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Yes votes: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v1.yes_votes)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"No votes: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v1.no_votes)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v9, 0x1::string::utf8(b"Yes votes threshold: "));
        0x1::string::append(&mut v9, 0x1::string::utf8(u64_to_ascii(v5)));
        0x1::string::append(&mut v9, 0x1::string::utf8(x"0a"));
        let v10 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg5);
        make_new_governor_buzz(v10, v0, v9, v8.gen_ai, arg5);
        let v11 = ProposalEvaluated{
            pool_hive_addr       : v0,
            proposal_id          : v1.proposal_id,
            proposal_status      : v1.proposal_status,
            yes_votes            : v1.yes_votes,
            no_votes             : v1.no_votes,
            total_possible_votes : v3,
            votes_quorum         : v4,
            yes_votes_threshold  : v5,
        };
        0x2::event::emit<ProposalEvaluated>(v11);
    }

    public entry fun executeProposalToAddFruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg2), 7024);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg2);
        assert!(v2.proposal_type == 5 && v2.proposal_status == 3 && v0 >= v2.execution_start_epoch && v0 <= v2.execution_end_epoch, 7030);
        let v3 = 0x1::option::extract<FruitLife>(&mut v2.fruit_life);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) < 3, 7023);
        let v4 = 0x2::object::new(arg3);
        0x2::object::uid_to_address(&v4);
        let v5 = BeeFruit<T1>{
            id               : v4,
            available_fruits : 0x2::balance::zero<T1>(),
            fruits_per_epoch : 0,
            start_epoch      : v3.start_epoch,
            end_epoch        : v3.end_epoch,
            claim_index      : 0,
            last_claim_epoch : v0,
            module_version   : 0,
        };
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::dynamic_object_field::add<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, v6, v5);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.bee_fruit_list, v6);
        let v7 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED")));
        let v8 = v7.buzz;
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(u64_to_ascii(v2.proposal_id)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v8, v2.title);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Fruit Type Added: "));
        0x1::string::append(&mut v8, 0x1::string::from_ascii(v6));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Distribution starts from epoch: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(u64_to_ascii(v3.start_epoch)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v8, 0x1::string::utf8(b"Distribution ends at epoch: "));
        0x1::string::append(&mut v8, 0x1::string::utf8(u64_to_ascii(v3.end_epoch)));
        let v9 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg3);
        make_new_governor_buzz(v9, v1, v8, v7.gen_ai, arg3);
        let v10 = BeeFruitKraftedForPoolHive{
            pool_hive_addr       : v1,
            proposal_id          : v2.proposal_id,
            bee_fruit_identifier : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BeeFruitKraftedForPoolHive>(v10);
    }

    public entry fun executeThreePoolProposal<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LP<T0, T1, T2, T3>>, arg2: &mut 0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LiquidityPool<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v3 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(v3.proposal_status == 3 && v0 >= v3.execution_start_epoch && v0 <= v3.execution_end_epoch, 7030);
        if (v3.proposal_type == 0) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_FEE_BREAKDOWN_EXECUTED"));
            let v4 = 0x1::option::extract<vector<u64>>(&mut v3.new_fee_info);
            0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::update_fee_for_pool<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1));
        };
        if (v3.proposal_type == 1) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_STABLE_CONFIG_EXECUTED"));
            let v5 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::update_stable_config<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), *0x1::vector::borrow<u64>(&v5, 2));
        };
        if (v3.proposal_type == 2) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_WEIGHTED_CONFIG_EXECUTED"));
            let v6 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::update_weighted_config<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, 0x1::option::extract<vector<u64>>(&mut v3.new_weights), *0x1::vector::borrow<u64>(&v6, 0));
        };
        if (v3.proposal_type == 3) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_A_AND_GAMMA_EXECUTED"));
            let v7 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::update_curved_A_and_gamma<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), (*0x1::vector::borrow<u64>(&v7, 2) as u256), *0x1::vector::borrow<u64>(&v7, 3));
        };
        if (v3.proposal_type == 4) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_FEE_PARAMS_EXECUTED"));
            let v8 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::update_curved_config_fee_params<T0, T1, T2, T3>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v8, 0), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 2), *0x1::vector::borrow<u64>(&v8, 3), *0x1::vector::borrow<u64>(&v8, 4), *0x1::vector::borrow<u64>(&v8, 5));
        };
        let v9 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2);
        let v10 = v9.buzz;
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v10, 0x1::string::utf8(u64_to_ascii(v3.proposal_id)));
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v10, v3.title);
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a"));
        let v11 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg4);
        make_new_governor_buzz(v11, v1, v10, v9.gen_ai, arg4);
        let v12 = ProposalExecuted{
            pool_hive_addr : v1,
            proposal_id    : v3.proposal_id,
            proposal_type  : v3.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v12);
    }

    public entry fun executeTwoPoolProposal<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LP<T0, T1, T2>>, arg2: &mut 0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v3 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        assert!(v3.proposal_status == 3 && v0 >= v3.execution_start_epoch && v0 <= v3.execution_end_epoch, 7030);
        if (v3.proposal_type == 0) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_FEE_BREAKDOWN_EXECUTED"));
            let v4 = 0x1::option::extract<vector<u64>>(&mut v3.new_fee_info);
            0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::update_fee_for_pool<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1));
        };
        if (v3.proposal_type == 1) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_STABLE_CONFIG_EXECUTED"));
            let v5 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::update_stable_config<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v5, 0), *0x1::vector::borrow<u64>(&v5, 1), *0x1::vector::borrow<u64>(&v5, 2));
        };
        if (v3.proposal_type == 2) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_WEIGHTED_CONFIG_EXECUTED"));
            let v6 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::update_weighted_config<T0, T1, T2>(arg2, &arg0.dex_dao_cap, 0x1::option::extract<vector<u64>>(&mut v3.new_weights), *0x1::vector::borrow<u64>(&v6, 0));
        };
        if (v3.proposal_type == 3) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_A_AND_GAMMA_EXECUTED"));
            let v7 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::update_curved_A_and_gamma<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), (*0x1::vector::borrow<u64>(&v7, 2) as u256), *0x1::vector::borrow<u64>(&v7, 3));
        };
        if (v3.proposal_type == 4) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_FEE_PARAMS_EXECUTED"));
            let v8 = 0x1::option::extract<vector<u64>>(&mut v3.new_params);
            0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::update_curved_config_fee_params<T0, T1, T2>(arg2, &arg0.dex_dao_cap, *0x1::vector::borrow<u64>(&v8, 0), *0x1::vector::borrow<u64>(&v8, 1), *0x1::vector::borrow<u64>(&v8, 2), *0x1::vector::borrow<u64>(&v8, 3), *0x1::vector::borrow<u64>(&v8, 4), *0x1::vector::borrow<u64>(&v8, 5));
        };
        let v9 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2);
        let v10 = v9.buzz;
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v10, 0x1::string::utf8(u64_to_ascii(v3.proposal_id)));
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v10, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v10, v3.title);
        0x1::string::append(&mut v10, 0x1::string::utf8(x"0a"));
        let v11 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg4);
        make_new_governor_buzz(v11, v1, v10, v9.gen_ai, arg4);
        let v12 = ProposalExecuted{
            pool_hive_addr : v1,
            proposal_id    : v3.proposal_id,
            proposal_type  : v3.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v12);
    }

    public fun get_gems_schedule(arg0: &PoolsGovernor) : (u64, u64, u64) {
        (arg0.gems_schedule.start_epoch, arg0.gems_schedule.end_epoch, arg0.gems_schedule.gems_per_epoch)
    }

    public fun get_lp_bee_box<T0>(arg0: &PoolHive<T0>, arg1: address) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = *0x2::linked_table::front<u64, u64>(&v0.unbonding_psns);
        while (0x1::option::is_some<u64>(&v3)) {
            let v4 = *0x1::option::borrow<u64>(&v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            0x1::vector::push_back<u64>(&mut v2, *0x2::linked_table::borrow<u64, u64>(&v0.unbonding_psns, v4));
            v3 = *0x2::linked_table::next<u64, u64>(&v0.unbonding_psns, v4);
        };
        (0x2::balance::value<T0>(&v0.staked_balance), v0.total_gems_earned, v0.claim_index, v1, v2, 0x2::balance::value<T0>(&v0.unbonding_balance), 0x2::linked_table::length<0x1::ascii::String, u256>(&v0.bee_fruits))
    }

    public fun get_lp_bee_box_fruit_claim_index<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: 0x1::ascii::String) : u256 {
        *0x2::linked_table::borrow<0x1::ascii::String, u256>(&0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1).bee_fruits, arg2)
    }

    public fun get_managed_buzzes(arg0: &PoolsGovernor, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<0x1::string::String>, vector<0x1::string::String>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v4) && v5 < arg2) {
            let v6 = *0x1::option::borrow<0x1::ascii::String>(&v4);
            let v7 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v6);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v7.buzz);
            if (0x1::option::is_some<0x1::string::String>(&v7.gen_ai)) {
                0x1::vector::push_back<0x1::string::String>(&mut v2, *0x1::option::borrow<0x1::string::String>(&v7.gen_ai));
            } else {
                0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b""));
            };
            v4 = *0x2::linked_table::next<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2, 0x2::linked_table::length<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes))
    }

    public fun get_pool_hive<T0>(arg0: &PoolHive<T0>) : (u64, u64, u64, u256, u64, u64, vector<0x1::ascii::String>) {
        (arg0.total_staked, arg0.total_unbonding, 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::value(&arg0.gems_available), arg0.global_claim_index, arg0.last_claim_epoch, arg0.next_proposal_id, arg0.bee_fruit_list)
    }

    public fun get_pool_hive_addr<T0>(arg0: &PoolsGovernor) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_pool_hive_points<T0>(arg0: &PoolsGovernor) : (address, u64, u64) {
        let v0 = *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        (v0, *0x2::linked_table::borrow<address, u64>(&arg0.gems_points_map, v0), arg0.total_gems_points)
    }

    public fun get_pool_hive_proposal<T0>(arg0: &PoolHive<T0>, arg1: u64) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        (v0.proposer, v0.title, v0.description, v0.link, v0.proposal_type, v0.voting_start_epoch, v0.voting_end_epoch, v0.execution_start_epoch, v0.execution_end_epoch, v0.proposal_status, v0.yes_votes, v0.no_votes)
    }

    public fun get_pool_hive_proposal_fruit_life<T0>(arg0: &PoolHive<T0>, arg1: u64) : (0x1::ascii::String, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        if (0x1::option::is_some<FruitLife>(&v0.fruit_life)) {
            let v4 = 0x1::option::borrow<FruitLife>(&v0.fruit_life);
            (0x1::type_name::into_string(v4.fruit_typename), v4.start_epoch, v4.end_epoch)
        } else {
            (0x1::type_name::into_string(0x1::type_name::get<T0>()), 0, 0)
        }
    }

    public fun get_pool_hive_proposal_params<T0>(arg0: &PoolHive<T0>, arg1: u64) : (vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
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

    public fun get_pools_governor(arg0: &PoolsGovernor) : (address, u64, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.gems_cycle, arg0.total_gems_points, arg0.unbonding_duration, arg0.active_pool_hives, arg0.module_version)
    }

    fun get_profile_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LpBeeBox<T0> {
        if (0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1)) {
            0x2::linked_table::remove<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, arg1)
        } else {
            LpBeeBox<T0>{staked_balance: 0x2::balance::zero<T0>(), total_gems_earned: 0, claim_index: arg0.global_claim_index, unbonding_psns: 0x2::linked_table::new<u64, u64>(arg2), unbonding_balance: 0x2::balance::zero<T0>(), bee_fruits: 0x2::linked_table::new<0x1::ascii::String, u256>(arg2)}
        }
    }

    public fun get_vote_config(arg0: &PoolsGovernor) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.vote_config.proposal_required_deposit, arg0.vote_config.voting_start_delay, arg0.vote_config.voting_period_length, arg0.vote_config.execution_delay, arg0.vote_config.execution_period_length, arg0.vote_config.proposal_required_quorum, arg0.vote_config.proposal_approval_threshold)
    }

    public entry fun increment_pool_hive<T0>(arg0: &mut PoolHive<T0>) {
        assert!(arg0.module_version < 0, 7039);
        arg0.module_version = 0;
    }

    public entry fun increment_pools_governor(arg0: &mut PoolsGovernor) {
        assert!(arg0.module_version < 0, 7039);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_pools_manager(arg0: &0x2::clock::Clock, arg1: 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::DexDaoCapability, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x8260bc6f098f3cd80f436e181451d5a8d4c8efcf8c96c66f1c58d90e26be6294::hsui_vault::HSuiVault, arg4: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfileMappingStore, arg5: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveManager, arg6: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HSuiDisperser<0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hsui::HSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg8 > 0x2::tx_context::epoch(arg17), 7000);
        assert!(arg16 < 7, 7010);
        let (v0, v1) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::kraft_owned_hive_profile(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x1::string::utf8(b"PoolsGovernor"), 0x1::string::utf8(b"Govern your AMM Pool via its PoolHive!"), arg17);
        let v2 = v0;
        let v3 = PoolGovernorBuzzes{
            id              : 0x2::object::new(arg17),
            governor_buzzes : 0x2::linked_table::new<u64, GovernorBuzz>(arg17),
            count           : 0,
        };
        0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_add_to_composable_profile<PoolGovernorBuzzes>(&mut v2, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), v3, arg17);
        let v4 = GemsSchedule{
            start_epoch    : arg8,
            end_epoch      : arg8 + 352,
            gems_per_epoch : 0,
        };
        let v5 = VoteConfig{
            proposal_required_deposit   : arg9,
            voting_start_delay          : arg10,
            voting_period_length        : arg11,
            execution_delay             : arg12,
            execution_period_length     : arg13,
            proposal_required_quorum    : 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, arg14, 100),
            proposal_approval_threshold : 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, arg15, 100),
        };
        let v6 = PoolsGovernor{
            id                 : 0x2::object::new(arg17),
            governor_profile   : v2,
            managed_buzzes     : 0x2::linked_table::new<0x1::ascii::String, SystemBuzz>(arg17),
            gems_cycle         : 0,
            gems_schedule      : v4,
            total_gems_points  : 0,
            gems_points_map    : 0x2::linked_table::new<address, u64>(arg17),
            dex_dao_cap        : arg1,
            unbonding_duration : arg16,
            vote_config        : v5,
            active_pool_hives  : 0,
            pool_hives         : 0x2::linked_table::new<0x1::ascii::String, address>(arg17),
            module_version     : 0,
        };
        let v7 = GemsSetForNewHiveCycle{
            gems_cycle     : v6.gems_cycle,
            start_epoch    : v6.gems_schedule.start_epoch,
            end_epoch      : v6.gems_schedule.end_epoch,
            gems_per_epoch : v6.gems_schedule.gems_per_epoch,
        };
        0x2::event::emit<GemsSetForNewHiveCycle>(v7);
        0x2::transfer::share_object<PoolsGovernor>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg17), 0x2::tx_context::sender(arg17));
    }

    public entry fun interact_with_governance_buzz(arg0: &mut PoolsGovernor, arg1: &0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg1);
        if (!v2) {
            assert!(v3 == 0x2::tx_context::sender(arg4), 7041);
        };
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg4).governor_buzzes, arg2);
        if (0x2::linked_table::contains<address, 0x1::string::String>(&v4.user_buzzes, v0)) {
            *0x2::linked_table::borrow_mut<address, 0x1::string::String>(&mut v4.user_buzzes, v0) = arg3;
        } else {
            0x2::linked_table::push_back<address, 0x1::string::String>(&mut v4.user_buzzes, v0, arg3);
        };
        let v5 = UserBuzzOnGovernanceBuzzDetected{
            user_profile_addr : v0,
            buzz_index        : arg2,
            username          : v1,
            user_buzz         : arg3,
        };
        0x2::event::emit<UserBuzzOnGovernanceBuzzDetected>(v5);
    }

    public entry fun kraft_new_pool_hive_three_token_amm<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut 0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LP<T0, T1, T2, T3>>());
        let v1 = 0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LP<T0, T1, T2, T3>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LP<T0, T1, T2, T3>>>(arg2),
            gems_available     : 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::LP<T0, T1, T2, T3>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.gems_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"POOL_HIVE_KRAFTED")));
        let v8 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg2);
        make_new_governor_buzz(v8, v5, v7.buzz, v7.gen_ai, arg2);
        let v9 = PoolHiveKraftd{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKraftd>(v9);
        0xd303f87c40b80c077ede07c6f1efffced6b68972a8952889d80f11c98e4e15da::three_pool::set_pool_hive_addr<T0, T1, T2, T3>(arg1, &arg0.dex_dao_cap, v5);
    }

    public entry fun kraft_new_pool_hive_two_token_amm<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut 0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LP<T0, T1, T2>>());
        let v1 = 0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LP<T0, T1, T2>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LP<T0, T1, T2>>>(arg2),
            gems_available     : 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::LP<T0, T1, T2>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.gems_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"POOL_HIVE_KRAFTED")));
        let v8 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg2);
        make_new_governor_buzz(v8, v5, v7.buzz, v7.gen_ai, arg2);
        let v9 = PoolHiveKraftd{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKraftd>(v9);
        0x7514296bcd31c68912d505fd5771bfeb7c0db65907ff40bc049f7e46cebd146f::two_pool::set_pool_hive_addr<T0, T1, T2>(arg1, &arg0.dex_dao_cap, v5);
    }

    public fun like_governor_buzz(arg0: &mut PoolsGovernor, arg1: &0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg1);
        if (!v2) {
            assert!(v3 == 0x2::tx_context::sender(arg3), 7041);
        };
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg3).governor_buzzes, arg2);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v0), 7042);
        let v5 = UserLikedGovernorBuzz{
            user_profile_addr : v0,
            username          : v1,
            buzz_index        : arg2,
        };
        0x2::event::emit<UserLikedGovernorBuzz>(v5);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v0, true);
    }

    fun make_new_governor_buzz(arg0: &mut PoolGovernorBuzzes, arg1: address, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.count;
        let v1 = GovernorBuzz{
            pool_hive   : arg1,
            buzz        : arg2,
            gen_ai      : arg3,
            likes       : 0x2::linked_table::new<address, bool>(arg4),
            user_buzzes : 0x2::linked_table::new<address, 0x1::string::String>(arg4),
        };
        0x2::linked_table::push_back<u64, GovernorBuzz>(&mut arg0.governor_buzzes, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = NewGovernorBuzz{
            count     : v0,
            pool_hive : arg1,
            buzz      : arg2,
            gen_ai    : arg3,
        };
        0x2::event::emit<NewGovernorBuzz>(v2);
    }

    public fun query_gems_points_map(arg0: &PoolsGovernor, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, u64>(&arg0.gems_points_map)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = *0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, v5);
            0x1::vector::push_back<u64>(&mut v1, *0x2::linked_table::borrow<address, u64>(&arg0.gems_points_map, v5));
            v3 = *0x2::linked_table::next<address, u64>(&arg0.gems_points_map, v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, u64>(&arg0.gems_points_map))
    }

    public entry fun removeExpiredProposal<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HiveVault, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveDisperser, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 7024);
        let v0 = 0x2::linked_table::remove<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(0x2::tx_context::epoch(arg4) > v0.execution_end_epoch, 7029);
        let (v1, v2, v3, _, _, _, v7, _, _, _, _, v12, _, _, _, _, _, _) = destroy_proposal(v0);
        let v19 = v3;
        if (0x2::balance::value<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&v19) > 0) {
            0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::deposit_gems_for_hive(arg2, 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::burn_hive_and_return_gems(arg1, v19, v2, arg4));
        } else {
            0x2::balance::destroy_zero<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(v19);
        };
        let v20 = ProposalDeleted{
            pool_hive_addr  : 0x2::object::uid_to_address(&arg0.id),
            proposal_id     : v1,
            proposal_type   : v7,
            proposal_status : v12,
        };
        0x2::event::emit<ProposalDeleted>(v20);
    }

    public fun remove_expired_fruit<T0, T1>(arg0: &mut PoolHive<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v2 = 0x2::dynamic_object_field::remove<0x1::ascii::String, BeeFruit<T1>>(&mut arg0.id, v1);
        let (v3, v4) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.bee_fruit_list, &v1);
        assert!(v3, 7016);
        assert!(v0 > v2.end_epoch || 0x2::balance::value<T1>(&v2.available_fruits) == 0 && v2.start_epoch > v0, 7017);
        0x1::vector::remove<0x1::ascii::String>(&mut arg0.bee_fruit_list, v4);
        let BeeFruit {
            id               : v5,
            available_fruits : v6,
            fruits_per_epoch : _,
            start_epoch      : _,
            end_epoch        : _,
            claim_index      : _,
            last_claim_epoch : _,
            module_version   : _,
        } = v2;
        0x2::object::delete(v5);
        0x2::balance::destroy_zero<T1>(v6);
        let v13 = BeeFruitDestroyed{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            bee_fruit_type : v1,
            cur_epoch      : v0,
        };
        0x2::event::emit<BeeFruitDestroyed>(v13);
    }

    public entry fun submit_proposal<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"INVALID_PROPOSAL_TYPE"));
        let v3 = 0x2::coin::into_balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&v3), 7018);
        assert!(arg3 >= 0 && arg3 < 5, 7019);
        if (arg3 == 0) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_FEE_BREAKDOWN"));
            assert!(0x1::option::is_some<vector<u64>>(&arg7), 7019);
            let v4 = *0x1::option::borrow<vector<u64>>(&arg7);
            assert!(0x1::vector::length<u64>(&v4) >= 2, 7019);
        };
        if (arg3 == 1) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_STABLE_CONFIG"));
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v5 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v6 = *0x1::vector::borrow<u64>(&v5, 0);
            let v7 = *0x1::vector::borrow<u64>(&v5, 1);
            let v8 = *0x1::vector::borrow<u64>(&v5, 2);
            assert!(100 < v6 && v6 < 1000000, 7036);
            assert!(v8 > v7 && v8 - v7 > 86400000, 7037);
            assert!(0x1::vector::length<u64>(&v5) >= 3, 7019);
        };
        if (arg3 == 2) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_WEIGHTED_CONFIG"));
            assert!(0x1::option::is_some<vector<u64>>(&arg9) && 0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v9 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v10 = *0x1::option::borrow<vector<u64>>(&arg9);
            assert!(*0x1::vector::borrow<u64>(&v9, 0) < 100, 7034);
            let v11 = 0;
            while (v11 < 0x1::vector::length<u64>(&v10)) {
                assert!(*0x1::vector::borrow<u64>(&v10, v11) > 0, 7033);
                v11 = v11 + 1;
            };
            assert!(0x1::vector::length<u64>(&v9) >= 1, 7019);
        };
        if (arg3 == 3) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_A_AND_GAMMA"));
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v12 = *0x1::option::borrow<vector<u64>>(&arg8);
            let v13 = *0x1::vector::borrow<u64>(&v12, 0);
            let v14 = (*0x1::vector::borrow<u64>(&v12, 2) as u256);
            let v15 = *0x1::vector::borrow<u64>(&v12, 3);
            assert!(v14 >= 10000000000 && v14 <= 500000000000000000 + 1, 7035);
            assert!(v15 > v13 && v15 - v13 > 86400000, 7037);
            assert!(0x1::vector::length<u64>(&v12) >= 4, 7019);
        };
        if (arg3 == 4) {
            v2 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_FEE_PARAMS"));
            assert!(0x1::option::is_some<vector<u64>>(&arg8), 7019);
            let v16 = *0x1::option::borrow<vector<u64>>(&arg8);
            0x7c5640bd867c0fa790281e3771de17b9d881f96af699ccbf6aa6b22bb7ebf7b1::curved_math::assert_new_config_params(*0x1::vector::borrow<u64>(&v16, 0), *0x1::vector::borrow<u64>(&v16, 1), *0x1::vector::borrow<u64>(&v16, 2), *0x1::vector::borrow<u64>(&v16, 3), *0x1::vector::borrow<u64>(&v16, 4), *0x1::vector::borrow<u64>(&v16, 5));
            assert!(0x1::vector::length<u64>(&v16) >= 6, 7019);
        };
        let v17 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            deposit               : 0x2::balance::split<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&mut v3, arg0.vote_config.proposal_required_deposit),
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
            voters                : 0x2::linked_table::new<address, bool>(arg10),
            fruit_life            : 0x1::option::none<FruitLife>(),
            new_params            : arg8,
            new_weights           : arg9,
            new_fee_info          : arg7,
        };
        let v18 = NewProposalKrafted{
            pool_hive_addr        : v1,
            proposal_id           : v17.proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v17.voting_start_epoch,
            voting_end_epoch      : v17.voting_end_epoch,
            execution_start_epoch : v17.execution_start_epoch,
            execution_end_epoch   : v17.execution_end_epoch,
            new_params            : arg8,
            new_weights           : arg9,
            new_fee_info          : arg7,
            fruit_life            : 0x1::option::none<FruitLife>(),
        };
        0x2::event::emit<NewProposalKrafted>(v18);
        let v19 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2);
        let v20 = v19.buzz;
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v20, 0x1::string::utf8(u64_to_ascii(v17.proposal_id)));
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v20, v17.title);
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Description: "));
        0x1::string::append(&mut v20, v17.description);
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Link: "));
        0x1::string::append(&mut v20, v17.link);
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Voting Start Epoch: "));
        0x1::string::append(&mut v20, 0x1::string::utf8(u64_to_ascii(v17.voting_start_epoch)));
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v20, 0x1::string::utf8(b"Voting End Epoch: "));
        0x1::string::append(&mut v20, 0x1::string::utf8(u64_to_ascii(v17.voting_end_epoch)));
        0x1::string::append(&mut v20, 0x1::string::utf8(x"0a"));
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v17);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v21 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg10);
        make_new_governor_buzz(v21, v1, v20, v19.gen_ai, arg10);
        0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::coin_helper::destroy_or_transfer_balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(v3, 0x2::tx_context::sender(arg10), arg10);
    }

    public entry fun submit_proposal_to_add_fruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg9);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x2::coin::into_balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&v2), 7018);
        assert!(v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length < arg7, 7020);
        assert!(arg7 < arg8, 7021);
        assert!(arg3 == 5, 7019);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) < 3, 7023);
        let v3 = FruitLife{
            fruit_typename : 0x1::type_name::get<T1>(),
            start_epoch    : arg7,
            end_epoch      : arg8,
        };
        let v4 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            deposit               : 0x2::balance::split<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(&mut v2, arg0.vote_config.proposal_required_deposit),
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
            voters                : 0x2::linked_table::new<address, bool>(arg9),
            fruit_life            : 0x1::option::some<FruitLife>(v3),
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
        };
        let v5 = NewProposalKrafted{
            pool_hive_addr        : v1,
            proposal_id           : v4.proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v4.voting_start_epoch,
            voting_end_epoch      : v4.voting_end_epoch,
            execution_start_epoch : v4.execution_start_epoch,
            execution_end_epoch   : v4.execution_end_epoch,
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
            fruit_life            : 0x1::option::some<FruitLife>(v3),
        };
        0x2::event::emit<NewProposalKrafted>(v5);
        let v6 = 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, 0x1::string::to_ascii(0x1::string::utf8(b"ADD_FRUIT")));
        let v7 = v6.buzz;
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Proposal ID: "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(v4.proposal_id)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Title: "));
        0x1::string::append(&mut v7, v4.title);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Description: "));
        0x1::string::append(&mut v7, v4.description);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Link: "));
        0x1::string::append(&mut v7, v4.link);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Voting Start Epoch: "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(v4.voting_start_epoch)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x1::string::append(&mut v7, 0x1::string::utf8(b"Voting End Epoch: "));
        0x1::string::append(&mut v7, 0x1::string::utf8(u64_to_ascii(v4.voting_end_epoch)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a"));
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v4);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v8 = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg9);
        make_new_governor_buzz(v8, v1, v7, v6.gen_ai, arg9);
        0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::coin_helper::destroy_or_transfer_balance<0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive::HIVE>(v2, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun transition_into_next_gems_cycle(arg0: &0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::HiveDaoCapability, arg1: &mut PoolsGovernor, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(v0 > arg1.gems_schedule.end_epoch, 7001);
        let v1 = if (arg1.gems_cycle < 5) {
            1000000 / 4
        } else if (arg1.gems_cycle < 10) {
            1000000 / 7
        } else {
            0
        };
        arg1.gems_schedule.start_epoch = v0 + 1;
        arg1.gems_schedule.end_epoch = v0 + 352 + 1;
        arg1.gems_schedule.gems_per_epoch = arg1.gems_schedule.gems_per_epoch + 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div_u128((arg1.gems_schedule.gems_per_epoch as u128), (v1 as u128), (1000000 as u128));
        arg1.gems_cycle = arg1.gems_cycle + 1;
        let v2 = GemsSetForNewHiveCycle{
            gems_cycle     : arg1.gems_cycle,
            start_epoch    : arg1.gems_schedule.start_epoch,
            end_epoch      : arg1.gems_schedule.end_epoch,
            gems_per_epoch : arg1.gems_schedule.gems_per_epoch,
        };
        0x2::event::emit<GemsSetForNewHiveCycle>(v2);
    }

    fun u64_to_ascii(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            let v1 = arg0 % 10;
            arg0 = arg0 / 10;
            0x1::vector::push_back<u8>(&mut v0, (v1 as u8) + 48);
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun unbond_from_bee_box_1_fruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
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
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v9, arg2, v3, v5, arg3, v0, arg4);
        v8
    }

    public fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
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
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v5, arg3, v0, arg4);
        (v8, v11)
    }

    public fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
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
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v5, arg3, v0, arg4);
        (v8, v11, v14)
    }

    public fun unbond_from_bee_box_no_fruit<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, _) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        deposit_gems_and_unbond_shares<T0>(arg0, arg1, v1, arg2, v3, v2, arg3, v0, arg4);
    }

    public fun unlike_governor_buzz(arg0: &mut PoolsGovernor, arg1: &0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg1);
        if (!v2) {
            assert!(v3 == 0x2::tx_context::sender(arg3), 7041);
        };
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::entry_borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), arg3).governor_buzzes, arg2);
        assert!(0x2::linked_table::contains<address, bool>(&v4.likes, v0), 7043);
        let v5 = UserUnLikedGovernorBuzz{
            user_profile_addr : v0,
            username          : v1,
            buzz_index        : arg2,
        };
        0x2::event::emit<UserUnLikedGovernorBuzz>(v5);
        0x2::linked_table::remove<address, bool>(&mut v4.likes, v0);
    }

    public fun unlock_from_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg1);
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

    public fun update_gems_per_epoch(arg0: &mut PoolsGovernor, arg1: &0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::HiveDaoCapability, arg2: u64) {
        assert!(arg0.module_version == 0, 7038);
        assert!(arg2 < 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_available_gems_in_profile(&arg0.governor_profile) / 3, 7040);
        arg0.gems_schedule.gems_per_epoch = arg2;
        let v0 = GemsPerEpochUpdated{new_gems_per_epoch: arg0.gems_schedule.gems_per_epoch};
        0x2::event::emit<GemsPerEpochUpdated>(v0);
    }

    public fun update_pool_hive_points(arg0: &mut PoolsGovernor, arg1: &0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::HiveDaoCapability, arg2: vector<address>, arg3: vector<u64>) {
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

    public fun update_pools_governance_params(arg0: &mut PoolsGovernor, arg1: &0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::HiveDaoCapability, arg2: vector<u64>) {
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
            arg0.vote_config.proposal_required_quorum = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, v5, 100);
        };
        let v6 = *0x1::vector::borrow<u64>(&arg2, 6);
        if (70 > v6 && v6 >= 40) {
            arg0.vote_config.proposal_approval_threshold = 0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::math::mul_div(1000000, v6, 100);
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

    public fun update_system_buzz(arg0: &mut PoolsGovernor, arg1: &0xf8e127328c486cb0df17081a1e12556fb52b97b4b557f0efc7bb58610bb363b0::config::BuidlersRoyaltyCollectionAbility, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, arg2)) {
            let v0 = SystemBuzz{
                buzz   : arg3,
                gen_ai : arg4,
            };
            0x2::linked_table::push_back<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2, v0);
        } else {
            let v1 = 0x2::linked_table::borrow_mut<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2);
            v1.buzz = arg3;
            v1.gen_ai = arg4;
        };
    }

    fun verify_and_extract_bee_box<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::HiveProfile, arg3: &mut 0x2::tx_context::TxContext) : (LpBeeBox<T0>, address, 0x1::string::String) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0xd9dc6a3d4055e119bad7bffbde29b6cc176118825221e42735c55ba980df1f37::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, v0), 7011);
        (get_profile_bee_box<T0>(arg1, v0, arg3), v0, v1)
    }

    // decompiled from Move bytecode v6
}

