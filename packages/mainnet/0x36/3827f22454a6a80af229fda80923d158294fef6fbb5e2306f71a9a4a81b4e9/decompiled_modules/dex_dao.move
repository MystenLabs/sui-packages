module 0x363827f22454a6a80af229fda80923d158294fef6fbb5e2306f71a9a4a81b4e9::dex_dao {
    struct PoolsGovernor has store, key {
        id: 0x2::object::UID,
        governor_profile: 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile,
        managed_buzzes: 0x2::linked_table::LinkedTable<0x1::ascii::String, SystemBuzz>,
        buzzes_to_store: u64,
        hive_emissions_schedule: EmissionSchedule,
        total_emission_points: u64,
        emission_points_map: 0x2::linked_table::LinkedTable<address, u64>,
        pool_hive_cap: 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::PoolHiveCapability,
        unbonding_duration: u64,
        vote_config: VoteConfig,
        active_pool_hives: u64,
        pool_hives: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct SystemBuzz has store {
        buzz: 0x1::string::String,
    }

    struct EmissionSchedule has copy, store {
        start_epoch: u64,
        end_epoch: u64,
        hive_per_epoch: u64,
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
        likes: 0x2::linked_table::LinkedTable<address, bool>,
        user_buzzes: 0x2::linked_table::LinkedTable<address, Dialogues>,
    }

    struct Dialogues has store {
        dialogues: 0x2::linked_table::LinkedTable<u64, Dialogue>,
    }

    struct Dialogue has store {
        buzz: 0x1::string::String,
        upvotes: 0x2::linked_table::LinkedTable<address, bool>,
    }

    struct PoolHive<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_unbonding: u64,
        locked_via_tax: 0x2::balance::Balance<T0>,
        lp_bee_boxes: 0x2::linked_table::LinkedTable<address, LpBeeBox<T0>>,
        gems_available: 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::HiveGems,
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
        deposit: 0x2::balance::Balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>,
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
        voters: 0x2::linked_table::LinkedTable<address, Vote>,
        fruit_life: 0x1::option::Option<FruitLife>,
        new_params: 0x1::option::Option<vector<u64>>,
        new_weights: 0x1::option::Option<vector<u64>>,
        new_fee_info: 0x1::option::Option<vector<u64>>,
    }

    struct Vote has drop, store {
        vote: bool,
        staked_amt: u64,
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

    struct HivePerEpochUpdated has copy, drop {
        hive_per_epoch: u64,
        end_epoch: u64,
        start_epoch: u64,
    }

    struct PoolHiveEmissionPointsUpdated has copy, drop {
        pool_hive_identifier: address,
        new_emission_points: u64,
        total_emission_points: u64,
    }

    struct PoolsGovernorUpdated has copy, drop {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
        buzzes_to_store: u64,
    }

    struct PoolHiveKrafted has copy, drop {
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
        hive_per_epoch_for_hive: u256,
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
        hive_gems_earned: u64,
        claim_index: u256,
    }

    struct UnlockFromBeeBox has copy, drop {
        pool_hive_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        staker_addr: address,
        lp_balance_unlocked: u64,
        unlocked_epoches: vector<u64>,
    }

    struct EmergencyUnlockFromBeeBox has copy, drop {
        pool_hive_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        staker_addr: address,
        lp_balance_unlocked: u64,
        tax_amt: u64,
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
        voter: 0x1::string::String,
        voter_profile: address,
        vote: bool,
        staked_amt: u64,
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

    struct NewGovernorBuzz has copy, drop {
        proposal_id: u64,
        count: u64,
        pool_hive: address,
        buzz: 0x1::string::String,
    }

    struct UserLikedGovernorBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
    }

    struct UserBuzzOnDexDaoBuzzDetected has copy, drop {
        user_profile_addr: address,
        governance_buzz_index: u64,
        username: 0x1::string::String,
        dialogue_index: u64,
        user_buzz: 0x1::string::String,
    }

    struct UserBuzzOnDexDaoBuzzDeleted has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
        dialogue_index: u64,
    }

    struct UserUpvotedDexGovernanceBuzz has copy, drop {
        user_profile_addr: address,
        username: 0x1::string::String,
        governance_buzz_index: u64,
        user_buzz_by_profile: address,
        dialogue_index: u64,
    }

    struct GovernorBuzzDestroyed has copy, drop {
        index: u64,
        pool_hive: address,
        buzz: 0x1::string::String,
    }

    fun accrue_hive_for_bee_box<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut LpBeeBox<T0>, arg3: u64) : 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::HiveGems {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = *0x2::linked_table::borrow<address, u64>(&arg0.emission_points_map, v0);
        if (v1 == 0) {
            arg1.last_claim_epoch = arg3;
            return 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::zero()
        };
        let v2 = arg3 - arg1.last_claim_epoch;
        let v3 = 0;
        if (v2 > 0 && arg1.total_staked > 0 && arg3 >= arg0.hive_emissions_schedule.start_epoch && arg3 <= arg0.hive_emissions_schedule.end_epoch) {
            let v4 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((arg0.hive_emissions_schedule.hive_per_epoch as u256), (v1 as u256), (arg0.total_emission_points as u256)) as u64);
            let v5 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((v2 * v4) as u256), (1000000 as u256), (arg1.total_staked as u256));
            arg1.global_claim_index = arg1.global_claim_index + v5;
            arg1.last_claim_epoch = arg3;
            let v6 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((arg1.total_staked as u256), (v5 as u256), (1000000 as u256)) as u64);
            let v7 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::zero();
            if (v6 <= 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_available_gems_in_profile(&arg0.governor_profile)) {
                0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::join(&mut v7, 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::withdraw_gems_from_comp_profile(&mut arg0.governor_profile, v6));
            };
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::join(&mut arg1.gems_available, v7);
            let v8 = KraftedGemsForPoolHive{
                pool_hive_addr          : v0,
                gems_earned_by_hive     : v6,
                hive_per_epoch_for_hive : (v4 as u256),
                index_increment         : v5,
                global_claim_index      : arg1.global_claim_index,
                last_claim_epoch        : arg1.last_claim_epoch,
            };
            0x2::event::emit<KraftedGemsForPoolHive>(v8);
        };
        let v9 = 0x2::balance::value<T0>(&arg2.staked_balance);
        if (v9 > 0 && arg1.global_claim_index > arg2.claim_index) {
            let v10 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((arg1.global_claim_index - arg2.claim_index) as u256), (v9 as u256), (1000000 as u256)) as u64);
            v3 = v10;
            arg2.claim_index = arg1.global_claim_index;
            arg2.total_gems_earned = arg2.total_gems_earned + v10;
        };
        if (v3 > 0) {
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::split(&mut arg1.gems_available, v3)
        } else {
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::zero()
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
                v4.claim_index = v4.claim_index + (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((v4.fruits_per_epoch * v7) as u256), (1000000 as u256), (arg0.total_staked as u256)) as u256);
                v4.last_claim_epoch = v0;
            };
        };
        0x2::balance::join<T1>(&mut v4.available_fruits, 0x2::balance::split<T1>(&mut arg1, arg2));
        let v8 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div(1000000, arg2, v4.end_epoch - v6);
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
        0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::destroy_or_transfer_balance<T1>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    fun authority_check(arg0: bool, arg1: address, arg2: address) {
        assert!(arg0 || arg1 == arg2, 7007);
    }

    public fun burn_lp_tokens_for_hive_three_pool<T0, T1, T2, T3>(arg0: &mut PoolHive<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>, arg1: &mut 0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &0x2::tx_context::TxContext) {
        0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::dangerous_burn_lp_coins<T0, T1, T2, T3>(arg1, 0x2::balance::withdraw_all<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>(&mut arg0.locked_via_tax));
    }

    public fun burn_lp_tokens_for_hive_two_pool<T0, T1, T2>(arg0: &mut PoolHive<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>, arg1: &mut 0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LiquidityPool<T0, T1, T2>, arg2: &0x2::tx_context::TxContext) {
        0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::dangerous_burn_lp_coins<T0, T1, T2>(arg1, 0x2::balance::withdraw_all<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>(&mut arg0.locked_via_tax));
    }

    fun calculate_fruit_rewards<T0, T1>(arg0: &BeeFruit<T1>, arg1: &LpBeeBox<T0>, arg2: u64, arg3: u64) : u64 {
        if (arg0.start_epoch > arg3) {
            return 0
        };
        let v0 = if (arg0.end_epoch > arg3) {
            arg3
        } else {
            arg0.end_epoch
        };
        let v1 = if (arg0.last_claim_epoch > arg0.start_epoch) {
            arg0.last_claim_epoch
        } else {
            arg0.start_epoch
        };
        let v2 = 0;
        if (v0 > v1) {
            v2 = v0 - v1;
        };
        let v3 = arg0.claim_index;
        let v4 = v3;
        if (v2 > 0 && arg2 > 0) {
            v4 = v3 + 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((arg0.fruits_per_epoch * v2) as u256), (1000000 as u256), (arg2 as u256));
        };
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v6 = v4;
        if (0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruits, v5)) {
            v6 = *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg1.bee_fruits, v5);
        };
        (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((v4 - v6) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64)
    }

    public entry fun castVote<T0>(arg0: &mut PoolHive<T0>, arg1: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let (v1, v2, v3, v4) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg1);
        authority_check(v3, v4, 0x2::tx_context::sender(arg4));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 7024);
        let v5 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(v0 >= v5.voting_start_epoch && v0 <= v5.voting_end_epoch, 7025);
        if (v5.proposal_status == 0) {
            v5.proposal_status = 1;
        };
        let v6 = 0x2::balance::value<T0>(&0x2::linked_table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v1).staked_balance);
        assert!(v6 > 0, 7026);
        if (0x2::linked_table::contains<address, Vote>(&v5.voters, v1)) {
            let v7 = 0x2::linked_table::remove<address, Vote>(&mut v5.voters, v1);
            if (v7.vote) {
                v5.yes_votes = v5.yes_votes - v7.staked_amt;
            } else {
                v5.no_votes = v5.no_votes - v7.staked_amt;
            };
        };
        if (arg3 == true) {
            v5.yes_votes = v5.yes_votes + v6;
        } else {
            v5.no_votes = v5.no_votes + v6;
        };
        let v8 = Vote{
            vote       : arg3,
            staked_amt : v6,
        };
        0x2::linked_table::push_back<address, Vote>(&mut v5.voters, v1, v8);
        let v9 = VoteCasted{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            proposal_id    : v5.proposal_id,
            voter          : v2,
            voter_profile  : v1,
            vote           : arg3,
            staked_amt     : v6,
            yes_votes      : v5.yes_votes,
            no_votes       : v5.no_votes,
            total_staked   : arg0.total_staked,
        };
        0x2::event::emit<VoteCasted>(v9);
    }

    public fun check_if_all_are_hives(arg0: &PoolsGovernor, arg1: vector<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            if (!0x2::linked_table::contains<address, u64>(&arg0.emission_points_map, *0x1::vector::borrow<address>(&arg1, v0))) {
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
        if (v3 > 0 && arg3 > 0) {
            arg0.claim_index = arg0.claim_index + 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((arg0.fruits_per_epoch * v3) as u256), (1000000 as u256), (arg3 as u256));
            arg0.last_claim_epoch = arg4;
        };
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruits, v4)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4, arg0.claim_index);
        };
        let v5 = 0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg1.bee_fruits, v4);
        let v6 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256(((arg0.claim_index - *v5) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64);
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

    public entry fun cleanup_gov_buzzes(arg0: &mut PoolsGovernor, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        let v1 = 0x2::linked_table::length<u64, GovernorBuzz>(&v0.governor_buzzes);
        if (v1 > arg0.buzzes_to_store) {
            let v2 = 0;
            while (v2 <= 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::min_u64(v1 - arg0.buzzes_to_store, arg1)) {
                let v3 = *0x2::linked_table::front<u64, GovernorBuzz>(&v0.governor_buzzes);
                let v4 = *0x1::option::borrow<u64>(&v3);
                destroy_governor_buzz(v4, 0x2::linked_table::remove<u64, GovernorBuzz>(&mut v0.governor_buzzes, v4));
                v2 = v2 + 1;
            };
        };
    }

    public entry fun del_comment_from_governance_buzz(arg0: &mut PoolsGovernor, arg1: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg1);
        authority_check(v2, v3, 0x2::tx_context::sender(arg4));
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes"))).governor_buzzes, arg2);
        assert!(0x2::linked_table::contains<address, Dialogues>(&v4.user_buzzes, v0), 7049);
        let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.user_buzzes, v0);
        assert!(0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg3), 7049);
        let Dialogue {
            buzz    : _,
            upvotes : v7,
        } = 0x2::linked_table::remove<u64, Dialogue>(&mut v5.dialogues, arg3);
        0x2::linked_table::drop<address, bool>(v7);
        let v8 = UserBuzzOnDexDaoBuzzDeleted{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg2,
            dialogue_index        : arg3,
        };
        0x2::event::emit<UserBuzzOnDexDaoBuzzDeleted>(v8);
    }

    fun deposit_hive_and_unbond_shares<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: address, arg4: LpBeeBox<T0>, arg5: u64, arg6: u64) {
        assert!(0x2::balance::value<T0>(&arg4.staked_balance) >= arg5, 7008);
        let v0 = &mut arg4;
        let v1 = accrue_hive_for_bee_box<T0>(arg0, arg1, v0, arg6);
        let v2 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::value(&v1);
        if (v2 > 0) {
            0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::deposit_gems_in_profile(arg2, v1);
        } else {
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::destroy_zero(v1);
        };
        if (arg5 > 0) {
            let v3 = arg6 + arg0.unbonding_duration;
            arg1.total_staked = arg1.total_staked - arg5;
            0x2::balance::join<T0>(&mut arg4.unbonding_balance, 0x2::balance::split<T0>(&mut arg4.staked_balance, arg5));
            if (0x2::linked_table::contains<u64, u64>(&arg4.unbonding_psns, v3)) {
                *0x2::linked_table::borrow_mut<u64, u64>(&mut arg4.unbonding_psns, v3) = *0x2::linked_table::borrow<u64, u64>(&arg4.unbonding_psns, v3) + arg5;
            } else {
                0x2::linked_table::push_back<u64, u64>(&mut arg4.unbonding_psns, v3, arg5);
            };
            arg1.total_unbonding = arg1.total_unbonding + arg5;
            let v4 = UnbondingFromBeeBox{
                pool_hive_addr      : 0x2::object::uid_to_address(&arg1.id),
                profile_addr        : arg3,
                lp_balance_unbonded : arg5,
                unlock_epoch        : v3,
                hive_gems_earned    : v2,
                claim_index         : arg4.claim_index,
            };
            0x2::event::emit<UnbondingFromBeeBox>(v4);
        };
        0x2::linked_table::push_back<address, LpBeeBox<T0>>(&mut arg1.lp_bee_boxes, arg3, arg4);
    }

    public fun deposit_hive_as_incentives(arg0: &mut PoolsGovernor, arg1: &mut 0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HiveVault, arg2: 0x2::coin::Coin<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::burn_hive_for_gems(arg1, &mut arg0.governor_profile, arg2, arg3, arg4);
    }

    fun deposit_into_bee_box<T0>(arg0: address, arg1: 0x1::string::String, arg2: &mut PoolsGovernor, arg3: &mut PoolHive<T0>, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg5: LpBeeBox<T0>, arg6: 0x2::balance::Balance<T0>, arg7: u64) {
        let v0 = &mut arg5;
        let v1 = accrue_hive_for_bee_box<T0>(arg2, arg3, v0, arg7);
        let v2 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::value(&v1);
        if (v2 > 0) {
            0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::deposit_gems_in_profile(arg4, v1);
        } else {
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::destroy_zero(v1);
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

    public fun deposit_into_bee_box_0_fruits<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::make_forever_subscriber_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let (v1, v2, v3, v4) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg2);
        authority_check(v3, v4, 0x2::tx_context::sender(arg4));
        let v5 = get_profile_bee_box<T0>(arg1, v1, arg4);
        deposit_into_bee_box<T0>(v1, v2, arg0, arg1, arg2, v5, arg3, v0);
    }

    public fun deposit_into_bee_box_1_fruits<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::make_forever_subscriber_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 1, 7006);
        let (v2, v3, v4, v5) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg2);
        authority_check(v4, v5, 0x2::tx_context::sender(arg4));
        let v6 = get_profile_bee_box<T0>(arg1, v2, arg4);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = &mut v6;
        let v9 = claim_fruit_for_bee_box<T0, T1>(v7, v8, v1, arg1.total_staked, v0, v2, v3);
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0);
        v9
    }

    public fun deposit_into_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::make_forever_subscriber_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 2, 7006);
        let (v2, v3, v4, v5) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg2);
        authority_check(v4, v5, 0x2::tx_context::sender(arg4));
        let v6 = get_profile_bee_box<T0>(arg1, v2, arg4);
        let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v8 = &mut v6;
        let v9 = claim_fruit_for_bee_box<T0, T1>(v7, v8, v1, arg1.total_staked, v0, v2, v3);
        let v10 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v11 = &mut v6;
        let v12 = claim_fruit_for_bee_box<T0, T2>(v10, v11, v1, arg1.total_staked, v0, v2, v3);
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0);
        (v9, v12)
    }

    public fun deposit_into_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::make_forever_subscriber_of_comp_profile(0, arg2, &mut arg0.governor_profile, arg4);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 3, 7006);
        let (v2, v3, v4, v5) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg2);
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
        deposit_into_bee_box<T0>(v2, v3, arg0, arg1, arg2, v6, arg3, v0);
        (v9, v12, v15)
    }

    fun destroy_fruit_rewards<T0>(arg0: BeeFruit<T0>) : (0x2::balance::Balance<T0>, u64, u64, u64, u256, u64, u64) {
        let BeeFruit {
            id               : v0,
            available_fruits : v1,
            fruits_per_epoch : v2,
            start_epoch      : v3,
            end_epoch        : v4,
            claim_index      : v5,
            last_claim_epoch : v6,
            module_version   : v7,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5, v6, v7)
    }

    fun destroy_governor_buzz(arg0: u64, arg1: GovernorBuzz) {
        let GovernorBuzz {
            pool_hive   : v0,
            buzz        : v1,
            likes       : v2,
            user_buzzes : v3,
        } = arg1;
        let v4 = v3;
        0x2::linked_table::drop<address, bool>(v2);
        while (0x2::linked_table::length<address, Dialogues>(&v4) > 0) {
            let v5 = *0x2::linked_table::front<address, Dialogues>(&v4);
            let Dialogues { dialogues: v6 } = 0x2::linked_table::remove<address, Dialogues>(&mut v4, *0x1::option::borrow<address>(&v5));
            while (0x2::linked_table::length<u64, Dialogue>(&v6) > 0) {
                let v7 = *0x2::linked_table::front<u64, Dialogue>(&v6);
                let Dialogue {
                    buzz    : _,
                    upvotes : v9,
                } = 0x2::linked_table::remove<u64, Dialogue>(&mut v6, *0x1::option::borrow<u64>(&v7));
                0x2::linked_table::drop<address, bool>(v9);
            };
            0x2::linked_table::destroy_empty<u64, Dialogue>(v6);
        };
        0x2::linked_table::destroy_empty<address, Dialogues>(v4);
        let v10 = GovernorBuzzDestroyed{
            index     : arg0,
            pool_hive : v0,
            buzz      : v1,
        };
        0x2::event::emit<GovernorBuzzDestroyed>(v10);
    }

    fun destroy_proposal(arg0: Proposal) : (u64, address, 0x2::balance::Balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, 0x1::option::Option<FruitLife>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>) {
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
        0x2::linked_table::drop<address, Vote>(v14);
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v15, v16, v17, v18)
    }

    public entry fun evaluateProposal<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HiveVault, arg3: u64, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveDisperser, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch(arg5);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        let v2 = v1.yes_votes + v1.no_votes;
        let v3 = arg1.total_staked;
        let v4 = if (v3 == 0) {
            0
        } else {
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u128((1000000 as u128), (v2 as u128), (v3 as u128))
        };
        let v5 = 0;
        let v6 = if (arg0.vote_config.proposal_required_quorum > v4) {
            v1.proposal_status = 5;
            0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::deposit_gems_for_hive(arg4, 0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::burn_hive_and_return_gems(arg2, 0x2::balance::withdraw_all<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&mut v1.deposit), v1.proposer, arg5));
            0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_CANCELLED"))
        } else {
            let v7 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u128((1000000 as u128), (v1.yes_votes as u128), (v2 as u128));
            v5 = v7;
            let v6 = if (v7 >= arg0.vote_config.proposal_approval_threshold) {
                v1.proposal_status = 3;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_PASSED"))
            } else {
                v1.proposal_status = 4;
                0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_STATUS_REJECTED"))
            };
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::destroy_or_transfer_balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(0x2::balance::withdraw_all<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&mut v1.deposit), v1.proposer, arg5);
            v6
        };
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v6).buzz);
        };
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v1.proposal_id)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v8, v1.title);
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a566f74696e672073746174697374696373203a3a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a546f74616c20706f737369626c6520766f7465733a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v3)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a546f74616c20766f746573206361737465643a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v2)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a252070617274696369706174696f6e3a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v4 * 100 / 1000000)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a59657320766f7465733a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v1.yes_votes)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a4e6f20766f7465733a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v1.no_votes)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a59657320766f746573207468726573686f6c643a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v5)));
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v0, v8, v1.proposal_id, arg5);
        let v10 = ProposalEvaluated{
            pool_hive_addr       : v0,
            proposal_id          : v1.proposal_id,
            proposal_status      : v1.proposal_status,
            yes_votes            : v1.yes_votes,
            no_votes             : v1.no_votes,
            total_possible_votes : v3,
            votes_quorum         : v4,
            yes_votes_threshold  : v5,
        };
        0x2::event::emit<ProposalEvaluated>(v10);
    }

    public entry fun executeProposalToAddFruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 7038);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg2), 7024);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg2);
        v2.proposal_status = 7;
        let v3 = 0x1::option::extract<FruitLife>(&mut v2.fruit_life);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) < 3, 7023);
        let v4 = BeeFruit<T1>{
            id               : 0x2::object::new(arg3),
            available_fruits : 0x2::balance::zero<T1>(),
            fruits_per_epoch : 0,
            start_epoch      : v3.start_epoch,
            end_epoch        : v3.end_epoch,
            claim_index      : 0,
            last_claim_epoch : 0x2::tx_context::epoch(arg3),
            module_version   : 0,
        };
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::dynamic_object_field::add<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, v5, v4);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg1.bee_fruit_list, v5);
        let v6 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1)) {
            0x1::string::append(&mut v6, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1).buzz);
        };
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v6, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v2.proposal_id)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v6, v2.title);
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a467275697420547970652041646465643a20"));
        0x1::string::append(&mut v6, 0x1::string::from_ascii(v5));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a446973747269627574696f6e207374617274732066726f6d2065706f63683a20"));
        0x1::string::append(&mut v6, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v3.start_epoch)));
        0x1::string::append(&mut v6, 0x1::string::utf8(x"0a446973747269627574696f6e20656e64732061742065706f63683a20"));
        0x1::string::append(&mut v6, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v3.end_epoch)));
        let v7 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v7, v0, v6, v2.proposal_id, arg3);
        let v8 = BeeFruitKraftedForPoolHive{
            pool_hive_addr       : v0,
            proposal_id          : v2.proposal_id,
            bee_fruit_identifier : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<BeeFruitKraftedForPoolHive>(v8);
    }

    public entry fun executeThreePoolProposal<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>, arg2: &mut 0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LiquidityPool<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        v2.proposal_status = 7;
        if (v2.proposal_type == 0) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_FEE_BREAKDOWN_EXECUTED"));
            let v3 = 0x1::option::extract<vector<u64>>(&mut v2.new_fee_info);
            0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::update_fee_for_pool<T0, T1, T2, T3>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1));
        };
        if (v2.proposal_type == 1) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_STABLE_CONFIG_EXECUTED"));
            let v4 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::update_stable_config<T0, T1, T2, T3>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2));
        };
        if (v2.proposal_type == 2) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_WEIGHTED_CONFIG_EXECUTED"));
            let v5 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::update_weighted_config<T0, T1, T2, T3>(arg2, &arg0.pool_hive_cap, 0x1::option::extract<vector<u64>>(&mut v2.new_weights), *0x1::vector::borrow<u64>(&v5, 0));
        };
        if (v2.proposal_type == 3) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_A_AND_GAMMA_EXECUTED"));
            let v6 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::update_curved_A_and_gamma<T0, T1, T2, T3>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), (*0x1::vector::borrow<u64>(&v6, 2) as u256), *0x1::vector::borrow<u64>(&v6, 3));
        };
        if (v2.proposal_type == 4) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_FEE_PARAMS_EXECUTED"));
            let v7 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::update_curved_config_fee_params<T0, T1, T2, T3>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), *0x1::vector::borrow<u64>(&v7, 2), *0x1::vector::borrow<u64>(&v7, 3), *0x1::vector::borrow<u64>(&v7, 4), *0x1::vector::borrow<u64>(&v7, 5));
        };
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1).buzz);
        };
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v2.proposal_id)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v8, v2.title);
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v0, v8, v2.proposal_id, arg4);
        let v10 = ProposalExecuted{
            pool_hive_addr : v0,
            proposal_id    : v2.proposal_id,
            proposal_type  : v2.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v10);
    }

    public entry fun executeTwoPoolProposal<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>, arg2: &mut 0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = 0x1::string::to_ascii(0x1::string::utf8(b"PROPOSAL_EXECUTED"));
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v2 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        v2.proposal_status = 7;
        if (v2.proposal_type == 0) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_FEE_BREAKDOWN_EXECUTED"));
            let v3 = 0x1::option::extract<vector<u64>>(&mut v2.new_fee_info);
            0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::update_fee_for_pool<T0, T1, T2>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1));
        };
        if (v2.proposal_type == 1) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_STABLE_CONFIG_EXECUTED"));
            let v4 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::update_stable_config<T0, T1, T2>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2));
        };
        if (v2.proposal_type == 2) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_WEIGHTED_CONFIG_EXECUTED"));
            let v5 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::update_weighted_config<T0, T1, T2>(arg2, &arg0.pool_hive_cap, 0x1::option::extract<vector<u64>>(&mut v2.new_weights), *0x1::vector::borrow<u64>(&v5, 0));
        };
        if (v2.proposal_type == 3) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_A_AND_GAMMA_EXECUTED"));
            let v6 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::update_curved_A_and_gamma<T0, T1, T2>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), (*0x1::vector::borrow<u64>(&v6, 2) as u256), *0x1::vector::borrow<u64>(&v6, 3));
        };
        if (v2.proposal_type == 4) {
            v1 = 0x1::string::to_ascii(0x1::string::utf8(b"UPDATE_CURVED_FEE_PARAMS_EXECUTED"));
            let v7 = 0x1::option::extract<vector<u64>>(&mut v2.new_params);
            0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::update_curved_config_fee_params<T0, T1, T2>(arg2, &arg0.pool_hive_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), *0x1::vector::borrow<u64>(&v7, 2), *0x1::vector::borrow<u64>(&v7, 3), *0x1::vector::borrow<u64>(&v7, 4), *0x1::vector::borrow<u64>(&v7, 5));
        };
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v1).buzz);
        };
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v8, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v2.proposal_id)));
        0x1::string::append(&mut v8, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v8, v2.title);
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v0, v8, v2.proposal_id, arg4);
        let v10 = ProposalExecuted{
            pool_hive_addr : v0,
            proposal_id    : v2.proposal_id,
            proposal_type  : v2.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v10);
    }

    public fun get_hive_emissions_schedule(arg0: &PoolsGovernor) : (u64, u64, u64) {
        (arg0.hive_emissions_schedule.start_epoch, arg0.hive_emissions_schedule.end_epoch, arg0.hive_emissions_schedule.hive_per_epoch)
    }

    public fun get_lp_bee_box<T0>(arg0: &PoolHive<T0>, arg1: address) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64) {
        if (!0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1)) {
            return (0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0)
        };
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

    public fun get_lp_bee_box_with_rewards_0_fruits<T0>(arg0: &PoolsGovernor, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2)) {
            return (0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2);
        let (v2, v3, _, v5) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v0);
        let (_, _, _, v9) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v0 + 1);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.total_gems_earned, v1.claim_index, v2, v3, 0x2::balance::value<T0>(&v1.unbonding_balance), 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.bee_fruits), v5, v9)
    }

    public fun get_lp_bee_box_with_rewards_1_fruits<T0, T1>(arg0: &PoolsGovernor, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2)) {
            return (0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0, 0, 0, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2);
        let (v2, v3, _, v5) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = v0 + 1;
        let (_, _, _, v11) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v7);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.total_gems_earned, v1.claim_index, v2, v3, 0x2::balance::value<T0>(&v1.unbonding_balance), 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.bee_fruits), v5, v11, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v7))
    }

    public fun get_lp_bee_box_with_rewards_2_fruits<T0, T1, T2>(arg0: &PoolsGovernor, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2)) {
            return (0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0, 0, 0, 0, 0, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2);
        let (v2, v3, _, v5) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T2>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v8 = v0 + 1;
        let (_, _, _, v12) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v8);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.total_gems_earned, v1.claim_index, v2, v3, 0x2::balance::value<T0>(&v1.unbonding_balance), 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.bee_fruits), v5, v12, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v8), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0))
    }

    public fun get_lp_bee_box_with_rewards_3_fruits<T0, T1, T2, T3>(arg0: &PoolsGovernor, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u64, u256, vector<u64>, vector<u64>, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2)) {
            return (0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, arg2);
        let (v2, v3, _, v5) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T2>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v8 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, BeeFruit<T3>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v9 = v0 + 1;
        let (_, _, _, v13) = get_unbonding_psns_and_expected_hive<T0>(arg0, arg1, v1, v9);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.total_gems_earned, v1.claim_index, v2, v3, 0x2::balance::value<T0>(&v1.unbonding_balance), 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.bee_fruits), v5, v13, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v9), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v9), calculate_fruit_rewards<T0, T3>(v8, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T3>(v8, v1, arg1.total_staked, v9))
    }

    public fun get_managed_buzzes(arg0: &PoolsGovernor, arg1: 0x1::option::Option<0x1::ascii::String>, arg2: u64) : (vector<0x1::ascii::String>, vector<0x1::string::String>, u64) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = if (0x1::option::is_some<0x1::ascii::String>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x1::ascii::String>(&v3) && v4 < arg2) {
            let v5 = *0x1::option::borrow<0x1::ascii::String>(&v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v5);
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5).buzz);
            v3 = *0x2::linked_table::next<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes))
    }

    public fun get_pool_hive<T0>(arg0: &PoolHive<T0>) : (u64, u64, u64, u256, u64, u64, vector<0x1::ascii::String>) {
        (arg0.total_staked, arg0.total_unbonding, 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::value(&arg0.gems_available), arg0.global_claim_index, arg0.last_claim_epoch, arg0.next_proposal_id, arg0.bee_fruit_list)
    }

    public fun get_pool_hive_addr<T0>(arg0: &PoolsGovernor) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_pool_hive_points<T0>(arg0: &PoolsGovernor) : (address, u64, u64) {
        let v0 = *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        (v0, *0x2::linked_table::borrow<address, u64>(&arg0.emission_points_map, v0), arg0.total_emission_points)
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

    public fun get_pools_governor(arg0: &PoolsGovernor) : (address, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), arg0.total_emission_points, arg0.unbonding_duration, arg0.active_pool_hives, arg0.module_version)
    }

    fun get_profile_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : LpBeeBox<T0> {
        if (0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, arg1)) {
            0x2::linked_table::remove<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, arg1)
        } else {
            LpBeeBox<T0>{staked_balance: 0x2::balance::zero<T0>(), total_gems_earned: 0, claim_index: arg0.global_claim_index, unbonding_psns: 0x2::linked_table::new<u64, u64>(arg2), unbonding_balance: 0x2::balance::zero<T0>(), bee_fruits: 0x2::linked_table::new<0x1::ascii::String, u256>(arg2)}
        }
    }

    public fun get_unbonding_duration(arg0: &PoolsGovernor) : u64 {
        arg0.unbonding_duration
    }

    fun get_unbonding_psns_and_expected_hive<T0>(arg0: &PoolsGovernor, arg1: &PoolHive<T0>, arg2: &LpBeeBox<T0>, arg3: u64) : (vector<u64>, vector<u64>, u64, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = *0x2::linked_table::front<u64, u64>(&arg2.unbonding_psns);
        while (0x1::option::is_some<u64>(&v2)) {
            let v3 = *0x1::option::borrow<u64>(&v2);
            0x1::vector::push_back<u64>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, *0x2::linked_table::borrow<u64, u64>(&arg2.unbonding_psns, v3));
            v2 = *0x2::linked_table::next<u64, u64>(&arg2.unbonding_psns, v3);
        };
        let v4 = *0x2::linked_table::borrow<address, u64>(&arg0.emission_points_map, *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v5 = arg3 - arg1.last_claim_epoch;
        let v6 = arg1.global_claim_index;
        let v7 = v6;
        let v8 = 0;
        if (v4 > 0 && v5 > 0 && arg1.total_staked > 0) {
            let v9 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((((0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((arg0.hive_emissions_schedule.hive_per_epoch as u256), (v4 as u256), (arg0.total_emission_points as u256)) as u64) * v5) as u256), (1000000 as u256), (arg1.total_staked as u256));
            v7 = v6 + v9;
            v8 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((arg1.total_staked as u256), (v9 as u256), (1000000 as u256)) as u64);
        };
        let v10 = 0x2::balance::value<T0>(&arg2.staked_balance);
        let v11 = 0;
        if (v10 > 0 && v7 > arg2.claim_index) {
            v11 = (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u256((v10 as u256), ((v7 - arg2.claim_index) as u256), (1000000 as u256)) as u64);
        };
        (v0, v1, v8, v11)
    }

    public fun get_user_vote_info<T0>(arg0: &PoolHive<T0>, arg1: u64, arg2: address) : (bool, bool, u64) {
        let v0 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        if (!0x2::linked_table::contains<address, Vote>(&v0.voters, arg2)) {
            return (false, false, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, Vote>(&v0.voters, arg2);
        (true, v1.vote, v1.staked_amt)
    }

    public fun get_vote_config(arg0: &PoolsGovernor) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.vote_config.proposal_required_deposit, arg0.vote_config.voting_start_delay, arg0.vote_config.voting_period_length, arg0.vote_config.execution_delay, arg0.vote_config.execution_period_length, arg0.vote_config.proposal_required_quorum, arg0.vote_config.proposal_approval_threshold)
    }

    public fun has_user_liked(arg0: &PoolsGovernor, arg1: address, arg2: u64) : bool {
        0x2::linked_table::contains<address, bool>(&0x2::linked_table::borrow<u64, GovernorBuzz>(&0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_from_profile<PoolGovernorBuzzes>(&arg0.governor_profile, 0x1::ascii::string(b"pool_governor_buzzes")).governor_buzzes, arg2).likes, arg1)
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

    public fun initialize_pools_manager(arg0: &0x2::clock::Clock, arg1: 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::PoolHiveCapability, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x4ae4217ce30ab816efdda3d13ba947b6afce321beb20f53ef9ef6405e735b247::dsui_vault::DSuiVault, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfileMappingStore, arg5: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveManager, arg6: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::DSuiDisperser<0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::dsui::DSUI>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 > 0x2::tx_context::epoch(arg19), 7000);
        assert!(arg18 < 7, 7010);
        assert!(arg16 < 100 && arg17 < 100, 7048);
        let (v0, v1) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::kraft_owned_hive_profile(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg19);
        let v2 = v0;
        let v3 = PoolGovernorBuzzes{
            id              : 0x2::object::new(arg19),
            governor_buzzes : 0x2::linked_table::new<u64, GovernorBuzz>(arg19),
            count           : 0,
        };
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::add_to_composable_profile<PoolGovernorBuzzes>(&mut v2, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")), v3);
        let v4 = EmissionSchedule{
            start_epoch    : arg10,
            end_epoch      : arg10 + 352,
            hive_per_epoch : 0,
        };
        let v5 = VoteConfig{
            proposal_required_deposit   : arg11,
            voting_start_delay          : arg12,
            voting_period_length        : arg13,
            execution_delay             : arg14,
            execution_period_length     : arg15,
            proposal_required_quorum    : 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div(1000000, arg16, 100),
            proposal_approval_threshold : 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div(1000000, arg17, 100),
        };
        let v6 = PoolsGovernor{
            id                      : 0x2::object::new(arg19),
            governor_profile        : v2,
            managed_buzzes          : 0x2::linked_table::new<0x1::ascii::String, SystemBuzz>(arg19),
            buzzes_to_store         : 240,
            hive_emissions_schedule : v4,
            total_emission_points   : 0,
            emission_points_map     : 0x2::linked_table::new<address, u64>(arg19),
            pool_hive_cap           : arg1,
            unbonding_duration      : arg18,
            vote_config             : v5,
            active_pool_hives       : 0,
            pool_hives              : 0x2::linked_table::new<0x1::ascii::String, address>(arg19),
            module_version          : 0,
        };
        let v7 = HivePerEpochUpdated{
            hive_per_epoch : v6.hive_emissions_schedule.hive_per_epoch,
            end_epoch      : v6.hive_emissions_schedule.end_epoch,
            start_epoch    : v6.hive_emissions_schedule.start_epoch,
        };
        0x2::event::emit<HivePerEpochUpdated>(v7);
        0x2::transfer::share_object<PoolsGovernor>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg19), 0x2::tx_context::sender(arg19));
    }

    public entry fun interact_with_governance_buzz(arg0: &0x2::clock::Clock, arg1: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveAppAccessCapability, arg2: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveManager, arg3: &mut PoolsGovernor, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg4);
        authority_check(v2, v3, 0x2::tx_context::sender(arg9));
        assert!(0x1::string::length(&arg7) < 2400, 7044);
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes"))).governor_buzzes, arg5);
        if (0x2::linked_table::contains<address, Dialogues>(&v4.user_buzzes, v0)) {
            let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.user_buzzes, v0);
            if (0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg6)) {
                0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v5.dialogues, arg6).buzz = arg7;
            } else {
                let v6 = Dialogue{
                    buzz    : arg7,
                    upvotes : 0x2::linked_table::new<address, bool>(arg9),
                };
                0x2::linked_table::push_back<u64, Dialogue>(&mut v5.dialogues, arg6, v6);
            };
        } else {
            let v7 = Dialogue{
                buzz    : arg7,
                upvotes : 0x2::linked_table::new<address, bool>(arg9),
            };
            let v8 = Dialogues{dialogues: 0x2::linked_table::new<u64, Dialogue>(arg9)};
            0x2::linked_table::push_back<u64, Dialogue>(&mut v8.dialogues, 0, v7);
            0x2::linked_table::push_back<address, Dialogues>(&mut v4.user_buzzes, v0, v8);
        };
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg8, arg9);
        let v9 = UserBuzzOnDexDaoBuzzDetected{
            user_profile_addr     : v0,
            governance_buzz_index : arg5,
            username              : v1,
            dialogue_index        : arg6,
            user_buzz             : arg7,
        };
        0x2::event::emit<UserBuzzOnDexDaoBuzzDetected>(v9);
    }

    public entry fun kraft_new_pool_hive_three_token_amm<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut 0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>());
        let v1 = 0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            locked_via_tax     : 0x2::balance::zero<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>(),
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>>(arg2),
            gems_available     : 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::LP<T0, T1, T2, T3>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.emission_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = 0x1::string::to_ascii(0x1::string::utf8(b"POOL_HIVE_KRAFTED"));
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v7)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v7).buzz);
        };
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v5, v8, 0, arg2);
        let v10 = PoolHiveKrafted{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKrafted>(v10);
        0x2b943bea9db57b2e3548151098c774614db36e867160487eff40abca78f6e901::three_pool::set_pool_hive_addr<T0, T1, T2, T3>(arg1, &arg0.pool_hive_cap, v5);
    }

    public entry fun kraft_new_pool_hive_two_token_amm<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut 0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>());
        let v1 = 0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = PoolHive<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>{
            id                 : v3,
            total_staked       : 0,
            total_unbonding    : 0,
            locked_via_tax     : 0x2::balance::zero<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>(),
            lp_bee_boxes       : 0x2::linked_table::new<address, LpBeeBox<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>>(arg2),
            gems_available     : 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::hive_gems::zero(),
            global_claim_index : 0,
            last_claim_epoch   : v2,
            bee_fruit_list     : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list      : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id   : 1,
            module_version     : 0,
        };
        0x2::transfer::share_object<PoolHive<0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::LP<T0, T1, T2>>>(v6);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        0x2::linked_table::push_back<address, u64>(&mut arg0.emission_points_map, v5, 0);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v7 = 0x1::string::to_ascii(0x1::string::utf8(b"POOL_HIVE_KRAFTED"));
        let v8 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v7)) {
            0x1::string::append(&mut v8, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v7).buzz);
        };
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v5, v8, 0, arg2);
        let v10 = PoolHiveKrafted{
            pool_id        : 0x2::object::id_to_address(&v1),
            lp_identifier  : v0,
            pool_hive_addr : v5,
            cur_epoch      : v2,
        };
        0x2::event::emit<PoolHiveKrafted>(v10);
        0xfb6cdb11e8431cdbd65a9d92cf5698908b20bfd47663085ce7496ac7c29cc31::two_pool::set_pool_hive_addr<T0, T1, T2>(arg1, &arg0.pool_hive_cap, v5);
    }

    public fun like_governor_buzz(arg0: &0x2::clock::Clock, arg1: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveAppAccessCapability, arg2: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveManager, arg3: &mut PoolsGovernor, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg4);
        authority_check(v2, v3, 0x2::tx_context::sender(arg7));
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes"))).governor_buzzes, arg5);
        assert!(!0x2::linked_table::contains<address, bool>(&v4.likes, v0), 7042);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg6, arg7);
        let v5 = UserLikedGovernorBuzz{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg5,
        };
        0x2::event::emit<UserLikedGovernorBuzz>(v5);
        0x2::linked_table::push_back<address, bool>(&mut v4.likes, v0, true);
    }

    fun make_new_governor_buzz(arg0: &mut PoolGovernorBuzzes, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) < 2400, 7044);
        let v0 = arg0.count;
        let v1 = GovernorBuzz{
            pool_hive   : arg1,
            buzz        : arg2,
            likes       : 0x2::linked_table::new<address, bool>(arg4),
            user_buzzes : 0x2::linked_table::new<address, Dialogues>(arg4),
        };
        0x2::linked_table::push_back<u64, GovernorBuzz>(&mut arg0.governor_buzzes, v0, v1);
        arg0.count = arg0.count + 1;
        let v2 = NewGovernorBuzz{
            proposal_id : arg3,
            count       : v0,
            pool_hive   : arg1,
            buzz        : arg2,
        };
        0x2::event::emit<NewGovernorBuzz>(v2);
    }

    public fun query_across_likes(arg0: &PoolsGovernor, arg1: u64, arg2: 0x1::option::Option<address>, arg3: u64) : (vector<address>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x2::linked_table::borrow<u64, GovernorBuzz>(&0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_from_profile<PoolGovernorBuzzes>(&arg0.governor_profile, 0x1::ascii::string(b"pool_governor_buzzes")).governor_buzzes, arg1);
        let v2 = if (0x1::option::is_some<address>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<address, bool>(&v1.likes)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg3) {
            let v5 = *0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, v5);
            v3 = *0x2::linked_table::next<address, bool>(&v1.likes, v5);
            v4 = v4 + 1;
        };
        (v0, 0x2::linked_table::length<address, bool>(&v1.likes))
    }

    public fun query_emission_points_map(arg0: &PoolsGovernor, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, u64>(&arg0.emission_points_map)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = *0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, v5);
            0x1::vector::push_back<u64>(&mut v1, *0x2::linked_table::borrow<address, u64>(&arg0.emission_points_map, v5));
            v3 = *0x2::linked_table::next<address, u64>(&arg0.emission_points_map, v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, u64>(&arg0.emission_points_map))
    }

    public entry fun removeExpiredProposal<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HiveVault, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveDisperser, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 0, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 7024);
        let (v0, v1, v2, _, _, _, v6, _, _, _, _, v11, _, _, _, _, _, _) = destroy_proposal(0x2::linked_table::remove<u64, Proposal>(&mut arg0.proposal_list, arg3));
        let v18 = v2;
        if (0x2::balance::value<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&v18) > 0) {
            0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::deposit_gems_for_hive(arg2, 0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::burn_hive_and_return_gems(arg1, v18, v1, arg4));
        } else {
            0x2::balance::destroy_zero<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(v18);
        };
        let v19 = ProposalDeleted{
            pool_hive_addr  : 0x2::object::uid_to_address(&arg0.id),
            proposal_id     : v0,
            proposal_type   : v6,
            proposal_status : v11,
        };
        0x2::event::emit<ProposalDeleted>(v19);
    }

    public fun remove_expired_fruit<T0, T1>(arg0: &mut PoolHive<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v2, v3) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.bee_fruit_list, &v1);
        assert!(v2, 7016);
        0x1::vector::remove<0x1::ascii::String>(&mut arg0.bee_fruit_list, v3);
        let (v4, _, v6, v7, _, _, _) = destroy_fruit_rewards<T1>(0x2::dynamic_object_field::remove<0x1::ascii::String, BeeFruit<T1>>(&mut arg0.id, v1));
        let v11 = v4;
        if (0x2::balance::value<T1>(&v11) > 0) {
            assert!(v0 > v7, 7017);
            0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::destroy_or_transfer_balance<T1>(v11, 0x2::tx_context::sender(arg1), arg1);
        } else {
            assert!(v0 > v6 + 2, 7017);
            0x2::balance::destroy_zero<T1>(v11);
        };
        let v12 = BeeFruitDestroyed{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            bee_fruit_type : v1,
            cur_epoch      : v0,
        };
        0x2::event::emit<BeeFruitDestroyed>(v12);
    }

    public entry fun submit_proposal<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"INVALID_PROPOSAL_TYPE"));
        let v3 = 0x2::coin::into_balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&v3), 7018);
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
            0x95f32fc217fdd8715c6486ab5785dac79e9e55d7b19b05a1c000ff49a2c92c70::curved_math::assert_new_config_params(*0x1::vector::borrow<u64>(&v16, 0), *0x1::vector::borrow<u64>(&v16, 1), *0x1::vector::borrow<u64>(&v16, 2), *0x1::vector::borrow<u64>(&v16, 3), *0x1::vector::borrow<u64>(&v16, 4), *0x1::vector::borrow<u64>(&v16, 5));
            assert!(0x1::vector::length<u64>(&v16) >= 6, 7019);
        };
        let v17 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            deposit               : 0x2::balance::split<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&mut v3, arg0.vote_config.proposal_required_deposit),
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
            voters                : 0x2::linked_table::new<address, Vote>(arg10),
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
        let v19 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2)) {
            0x1::string::append(&mut v19, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2).buzz);
        };
        let v20 = v17.proposal_id;
        0x1::string::append(&mut v19, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v19, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v20)));
        0x1::string::append(&mut v19, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v19, v17.title);
        0x1::string::append(&mut v19, 0x1::string::utf8(x"0a4465736372697074696f6e3a20"));
        0x1::string::append(&mut v19, v17.description);
        0x1::string::append(&mut v19, 0x1::string::utf8(x"0a4c696e6b3a20"));
        0x1::string::append(&mut v19, v17.link);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v17);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v21 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v21, v1, v19, v20, arg10);
        0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::destroy_or_transfer_balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(v3, 0x2::tx_context::sender(arg10), arg10);
    }

    public entry fun submit_proposal_to_add_fruit<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg9);
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let v2 = 0x1::string::to_ascii(0x1::string::utf8(b"ADD_FRUIT"));
        let v3 = 0x2::coin::into_balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&v3), 7018);
        assert!(v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length < arg7, 7020);
        assert!(arg7 < arg8, 7021);
        assert!(arg3 == 5, 7019);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) < 3, 7023);
        let v4 = FruitLife{
            fruit_typename : 0x1::type_name::get<T1>(),
            start_epoch    : arg7,
            end_epoch      : arg8,
        };
        let v5 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            deposit               : 0x2::balance::split<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(&mut v3, arg0.vote_config.proposal_required_deposit),
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
            voters                : 0x2::linked_table::new<address, Vote>(arg9),
            fruit_life            : 0x1::option::some<FruitLife>(v4),
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
        };
        let v6 = NewProposalKrafted{
            pool_hive_addr        : v1,
            proposal_id           : v5.proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            title                 : arg4,
            description           : arg5,
            link                  : arg6,
            proposal_type         : arg3,
            voting_start_epoch    : v5.voting_start_epoch,
            voting_end_epoch      : v5.voting_end_epoch,
            execution_start_epoch : v5.execution_start_epoch,
            execution_end_epoch   : v5.execution_end_epoch,
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
            fruit_life            : 0x1::option::some<FruitLife>(v4),
        };
        0x2::event::emit<NewProposalKrafted>(v6);
        let v7 = 0x1::string::utf8(b"");
        if (0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2)) {
            0x1::string::append(&mut v7, 0x2::linked_table::borrow<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, v2).buzz);
        };
        let v8 = v5.proposal_id;
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a0a50726f706f73616c2049443a20"));
        0x1::string::append(&mut v7, 0x1::string::utf8(0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::u64_to_ascii(v8)));
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a5469746c653a20"));
        0x1::string::append(&mut v7, v5.title);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4465736372697074696f6e3a20"));
        0x1::string::append(&mut v7, v5.description);
        0x1::string::append(&mut v7, 0x1::string::utf8(x"0a4c696e6b3a20"));
        0x1::string::append(&mut v7, v5.link);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v5);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        let v9 = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg0.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes")));
        make_new_governor_buzz(v9, v1, v7, v8, arg9);
        0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::coin_helper::destroy_or_transfer_balance<0xdd9632ef1c108b77fe228d9626caada6d620fbbcdf23f8fff09dd066ab1c984e::hive::HIVE>(v3, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun unbond_from_bee_box_0_fruits<T0>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 0, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let (v1, v2, _) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        deposit_hive_and_unbond_shares<T0>(arg0, arg1, arg2, v2, v1, arg3, v0);
    }

    public fun unbond_from_bee_box_1_fruits<T0, T1>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.bee_fruit_list) == 1, 7006);
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3, v4) = verify_and_extract_bee_box<T0>(arg0, arg1, arg2, arg4);
        let v5 = v2;
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = &mut v5;
        let v8 = claim_fruit_for_bee_box<T0, T1>(v6, v7, v1, arg1.total_staked, v0, v3, v4);
        deposit_hive_and_unbond_shares<T0>(arg0, arg1, arg2, v3, v5, arg3, v0);
        v8
    }

    public fun unbond_from_bee_box_2_fruits<T0, T1, T2>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
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
        deposit_hive_and_unbond_shares<T0>(arg0, arg1, arg2, v3, v5, arg3, v0);
        (v8, v11)
    }

    public fun unbond_from_bee_box_3_fruits<T0, T1, T2, T3>(arg0: &mut PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
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
        deposit_hive_and_unbond_shares<T0>(arg0, arg1, arg2, v3, v5, arg3, v0);
        (v8, v11, v14)
    }

    public fun unlock_from_bee_box<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg1);
        authority_check(v2, v3, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg0.lp_bee_boxes, v0), 7011);
        let v4 = 0x2::linked_table::borrow_mut<address, LpBeeBox<T0>>(&mut arg0.lp_bee_boxes, v0);
        if (arg2 > 0) {
            arg0.total_staked = arg0.total_staked - arg2;
            let v6 = 0x2::balance::split<T0>(&mut v4.staked_balance, arg2);
            let v7 = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div_u128((arg2 as u128), (0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::constants::emergency_unlock_tax() as u128), (100 as u128));
            0x2::balance::join<T0>(&mut arg0.locked_via_tax, 0x2::balance::split<T0>(&mut v6, (v7 as u64)));
            let v8 = EmergencyUnlockFromBeeBox{
                pool_hive_addr      : 0x2::object::uid_to_address(&arg0.id),
                username            : v1,
                profile_addr        : v0,
                staker_addr         : v3,
                lp_balance_unlocked : arg2,
                tax_amt             : v7,
            };
            0x2::event::emit<EmergencyUnlockFromBeeBox>(v8);
            v6
        } else {
            let v9 = 0;
            let v10 = 0x1::vector::empty<u64>();
            let v11 = *0x2::linked_table::front<u64, u64>(&v4.unbonding_psns);
            while (0x1::option::is_some<u64>(&v11)) {
                let v12 = *0x1::option::borrow<u64>(&v11);
                if (0x2::tx_context::epoch(arg3) >= v12) {
                    0x2::linked_table::remove<u64, u64>(&mut v4.unbonding_psns, v12);
                    v9 = v9 + *0x2::linked_table::borrow<u64, u64>(&v4.unbonding_psns, v12);
                    0x1::vector::push_back<u64>(&mut v10, v12);
                };
                v11 = *0x2::linked_table::next<u64, u64>(&v4.unbonding_psns, v12);
            };
            assert!(v9 > 0, 7012);
            arg0.total_unbonding = arg0.total_unbonding - v9;
            let v13 = UnlockFromBeeBox{
                pool_hive_addr      : 0x2::object::uid_to_address(&arg0.id),
                username            : v1,
                profile_addr        : v0,
                staker_addr         : v3,
                lp_balance_unlocked : v9,
                unlocked_epoches    : v10,
            };
            0x2::event::emit<UnlockFromBeeBox>(v13);
            0x2::balance::split<T0>(&mut v4.unbonding_balance, v9)
        }
    }

    public fun update_hive_per_epoch(arg0: &mut PoolsGovernor, arg1: &0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::HiveDaoCapability, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 7038);
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg2 * 352 < 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_available_gems_in_profile(&arg0.governor_profile) / 3, 7040);
        arg0.hive_emissions_schedule.hive_per_epoch = arg2;
        arg0.hive_emissions_schedule.end_epoch = v0 + 352;
        arg0.hive_emissions_schedule.start_epoch = v0 + 1;
        let v1 = HivePerEpochUpdated{
            hive_per_epoch : arg0.hive_emissions_schedule.hive_per_epoch,
            end_epoch      : arg0.hive_emissions_schedule.end_epoch,
            start_epoch    : arg0.hive_emissions_schedule.start_epoch,
        };
        0x2::event::emit<HivePerEpochUpdated>(v1);
    }

    public fun update_pool_hive_points(arg0: &mut PoolsGovernor, arg1: &0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::HiveDaoCapability, arg2: vector<address>, arg3: vector<u64>) {
        assert!(arg0.module_version == 0, 7038);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 7004);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0);
            assert!(0x2::linked_table::contains<address, u64>(&arg0.emission_points_map, v1), 7002);
            arg0.total_emission_points = arg0.total_emission_points - 0x2::linked_table::remove<address, u64>(&mut arg0.emission_points_map, v1) + v2;
            0x2::linked_table::push_back<address, u64>(&mut arg0.emission_points_map, v1, v2);
            let v3 = PoolHiveEmissionPointsUpdated{
                pool_hive_identifier  : v1,
                new_emission_points   : v2,
                total_emission_points : arg0.total_emission_points,
            };
            0x2::event::emit<PoolHiveEmissionPointsUpdated>(v3);
            v0 = v0 + 1;
        };
    }

    public fun update_pools_governance_params(arg0: &mut PoolsGovernor, arg1: &0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::HiveDaoCapability, arg2: vector<u64>) {
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
            arg0.vote_config.proposal_required_quorum = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div(1000000, v5, 100);
        };
        let v6 = *0x1::vector::borrow<u64>(&arg2, 6);
        if (70 > v6 && v6 >= 40) {
            arg0.vote_config.proposal_approval_threshold = 0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::math::mul_div(1000000, v6, 100);
        };
        let v7 = *0x1::vector::borrow<u64>(&arg2, 7);
        if (7 >= v7 && v7 >= 1) {
            arg0.unbonding_duration = v7;
        };
        let v8 = *0x1::vector::borrow<u64>(&arg2, 8);
        if (v8 >= 42) {
            arg0.buzzes_to_store = v8;
        };
        let v9 = PoolsGovernorUpdated{
            proposal_required_deposit   : arg0.vote_config.proposal_required_deposit,
            voting_start_delay          : arg0.vote_config.voting_start_delay,
            voting_period_length        : arg0.vote_config.voting_period_length,
            execution_delay             : arg0.vote_config.execution_delay,
            execution_period_length     : arg0.vote_config.execution_period_length,
            proposal_required_quorum    : arg0.vote_config.proposal_required_quorum,
            proposal_approval_threshold : arg0.vote_config.proposal_approval_threshold,
            buzzes_to_store             : arg0.buzzes_to_store,
        };
        0x2::event::emit<PoolsGovernorUpdated>(v9);
    }

    public fun update_system_buzz(arg0: &mut PoolsGovernor, arg1: &0xb2daad3cfd62e10e0434af18ff824f89c03ab523f0502dddfdbc72953f2da9b4::config::DegenHiveDeployerCap, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        if (!0x2::linked_table::contains<0x1::ascii::String, SystemBuzz>(&arg0.managed_buzzes, arg2)) {
            let v0 = SystemBuzz{buzz: arg3};
            0x2::linked_table::push_back<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2, v0);
        } else {
            0x2::linked_table::borrow_mut<0x1::ascii::String, SystemBuzz>(&mut arg0.managed_buzzes, arg2).buzz = arg3;
        };
    }

    public entry fun upvote_dialogue_on_buzz(arg0: &0x2::clock::Clock, arg1: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveAppAccessCapability, arg2: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveManager, arg3: &mut PoolsGovernor, arg4: &mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg5: u64, arg6: address, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg4);
        authority_check(v2, v3, 0x2::tx_context::sender(arg9));
        let v4 = 0x2::linked_table::borrow_mut<u64, GovernorBuzz>(&mut 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::borrow_mut_from_composable_profile<PoolGovernorBuzzes>(&mut arg3.governor_profile, 0x1::string::to_ascii(0x1::string::utf8(b"pool_governor_buzzes"))).governor_buzzes, arg5);
        assert!(0x2::linked_table::contains<address, Dialogues>(&v4.user_buzzes, arg6), 7046);
        let v5 = 0x2::linked_table::borrow_mut<address, Dialogues>(&mut v4.user_buzzes, arg6);
        assert!(0x2::linked_table::contains<u64, Dialogue>(&v5.dialogues, arg7), 7047);
        let v6 = 0x2::linked_table::borrow_mut<u64, Dialogue>(&mut v5.dialogues, arg7);
        assert!(!0x2::linked_table::contains<address, bool>(&v6.upvotes, v0), 7045);
        0x2::linked_table::push_back<address, bool>(&mut v6.upvotes, v0, true);
        0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::consume_entropy_of_profile(arg0, arg1, arg2, arg4, arg8, arg9);
        let v7 = UserUpvotedDexGovernanceBuzz{
            user_profile_addr     : v0,
            username              : v1,
            governance_buzz_index : arg5,
            user_buzz_by_profile  : arg6,
            dialogue_index        : arg7,
        };
        0x2::event::emit<UserUpvotedDexGovernanceBuzz>(v7);
    }

    fun verify_and_extract_bee_box<T0>(arg0: &PoolsGovernor, arg1: &mut PoolHive<T0>, arg2: &0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::HiveProfile, arg3: &mut 0x2::tx_context::TxContext) : (LpBeeBox<T0>, address, 0x1::string::String) {
        assert!(arg0.module_version == 0 && arg1.module_version == 0, 7038);
        let (v0, v1, v2, v3) = 0x6687af8a0372520704813c0760e8230f8e4ba8e02944a62b6e7891290b421d3c::hive_profile::get_profile_meta_info(arg2);
        authority_check(v2, v3, 0x2::tx_context::sender(arg3));
        assert!(0x2::linked_table::contains<address, LpBeeBox<T0>>(&arg1.lp_bee_boxes, v0), 7011);
        (get_profile_bee_box<T0>(arg1, v0, arg3), v0, v1)
    }

    // decompiled from Move bytecode v6
}

