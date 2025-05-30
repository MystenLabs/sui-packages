module 0x939f4cf5a6202d356d062cd9c5a5b19f6bd720f1797f9b8a90560d53a69c5580::dragon_food {
    struct LendingPoolCapability has store, key {
        id: 0x2::object::UID,
    }

    struct DragonFood has store, key {
        id: 0x2::object::UID,
        dragon_food_cap: 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonFoodCapability,
        emissions: EmissionSchedule,
        hive_available: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>,
        honey_available: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>,
        ongoing_cycle: u64,
        cur_cycle_start_epoch: u64,
        cycle_duration: u64,
        max_dragonbees_per_psn: u64,
        added_hive_energy: u128,
        total_hive_energy: 0x2::linked_table::LinkedTable<u64, u128>,
        removed_hive_energy: u128,
        added_honey_health: u128,
        total_honey_health: 0x2::linked_table::LinkedTable<u64, u128>,
        removed_honey_health: u128,
        vote_config: VoteConfig,
        active_pool_hives: u64,
        pool_hives: 0x2::linked_table::LinkedTable<0x1::ascii::String, address>,
        module_version: u64,
    }

    struct EmissionSchedule has store {
        start_epoch: u64,
        hive_per_epoch: u64,
        honey_per_epoch: u64,
        change_pct_per_cycle: u64,
        hive_increase_votes: 0x2::linked_table::LinkedTable<u64, u128>,
        hive_decrease_votes: 0x2::linked_table::LinkedTable<u64, u128>,
        hive_same_votes: 0x2::linked_table::LinkedTable<u64, u128>,
        honey_increase_votes: 0x2::linked_table::LinkedTable<u64, u128>,
        honey_decrease_votes: 0x2::linked_table::LinkedTable<u64, u128>,
        honey_same_votes: 0x2::linked_table::LinkedTable<u64, u128>,
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
        pool_addr: address,
        total_staked: u64,
        staked_for_honey: u64,
        honey_available: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>,
        hive_available: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>,
        global_hive_claim_index: u256,
        global_honey_claim_index: u256,
        last_claim_epoch: u64,
        last_claim_honey_epoch: u64,
        ongoing_cycle: u64,
        cur_cycle_start_epoch: u64,
        bribes: Bribes,
        added_hive_energy: u128,
        active_hive_energy: 0x2::linked_table::LinkedTable<u64, u128>,
        removed_hive_energy: u128,
        added_honey_health: u128,
        active_honey_health: 0x2::linked_table::LinkedTable<u64, u128>,
        removed_honey_health: u128,
        resting_dragons: 0x2::linked_table::LinkedTable<address, DragonsDen<T0>>,
        additional_rewards: vector<0x1::ascii::String>,
        proposal_list: 0x2::linked_table::LinkedTable<u64, Proposal>,
        next_proposal_id: u64,
        module_version: u64,
    }

    struct UnbondingPositions<phantom T0> has store, key {
        id: 0x2::object::UID,
        unbonded_balance: 0x2::balance::Balance<T0>,
        user_psns: 0x2::linked_table::LinkedTable<address, UserUnbondingPsn>,
    }

    struct UserUnbondingPsn has store {
        unlocking_amts: 0x2::linked_table::LinkedTable<u64, u64>,
    }

    struct Bribes has store {
        voting_bribes: vector<0x1::string::String>,
        hive_bribe: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>,
        honey_bribe: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>,
        hive_fee_claim_indexes: 0x2::linked_table::LinkedTable<u64, u256>,
        honey_fee_claim_indexes: 0x2::linked_table::LinkedTable<u64, u256>,
    }

    struct VotingBribes<phantom T0> has store, key {
        id: 0x2::object::UID,
        bribe: 0x2::balance::Balance<T0>,
        is_meme_token: bool,
        cycle_to_hive_bribes_map: 0x2::linked_table::LinkedTable<u64, u64>,
        cycle_to_honey_bribes_map: 0x2::linked_table::LinkedTable<u64, u64>,
    }

    struct DragonsDen<phantom T0> has store {
        staked_balance: 0x2::balance::Balance<T0>,
        hive_claim_index: u256,
        honey_claim_index: u256,
        locked_bees: vector<u64>,
        unlocking_bees: vector<u64>,
        dragon_bees: 0x2::linked_table::LinkedTable<u64, LockedDragonBee>,
        active_hive_energy: u128,
        active_honey_health: u128,
        increment_cycle: u64,
        increase_in_energy: u128,
        increase_in_health: u128,
        decrease_in_energy: u128,
        decrease_in_health: u128,
        dao_vote_cycle: u64,
        bribes_claimed_till: u64,
        fees_claimed_till: u64,
        hive_fee_claim_indexes: 0x2::linked_table::LinkedTable<u64, u256>,
        honey_fee_claim_indexes: 0x2::linked_table::LinkedTable<u64, u256>,
        rewards_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        is_locked: bool,
    }

    struct LockedDragonBee has store {
        version: u64,
        mystical_bee: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee,
        locked_at_cycle: u64,
        withdrawable_at_cycle: u64,
        hive_energy: u128,
        honey_health: u128,
        increment_cycle: u64,
        temp_hive_energy: u128,
        temp_honey_health: u128,
    }

    struct Proposal has store {
        proposal_id: u64,
        proposer: address,
        deposit: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>,
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

    struct HoneyFruit<phantom T0> has store, key {
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
        start_epoch: u64,
        honey_per_epoch: u64,
    }

    struct DragonFoodCycleUpdated has copy, drop {
        hive_per_epoch: u64,
        honey_per_epoch: u64,
        cur_cycle: u64,
        cur_cycle_start_epoch: u64,
        cycle_duration: u64,
        cur_total_hive_energy: u128,
        cur_total_honey_health: u128,
    }

    struct FoodCycleUpdatedForPoolHive has copy, drop {
        pool_hive_addr: address,
        cur_cycle: u64,
        cur_cycle_start_epoch: u64,
        cur_total_hive_energy: u128,
        cur_total_honey_health: u128,
    }

    struct TrainerVotedForEmissions has copy, drop {
        trainer_addr: address,
        hive_energy: u128,
        honey_health: u128,
        hive_vote_type: u8,
        honey_vote_type: u8,
        dao_vote_cycle: u64,
    }

    struct BribeClaimedByTrainerTwoPool has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        claimed_cycles: vector<u64>,
        claimed_hive_bribes_a: vector<u64>,
        claimed_honey_bribes_a: vector<u64>,
        claimed_hive_bribes_b: vector<u64>,
        claimed_honey_bribes_b: vector<u64>,
        bribe_a_bal: u64,
        bribe_b_bal: u64,
    }

    struct BribeClaimedByTrainerThreePool has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        claimed_cycles: vector<u64>,
        claimed_hive_bribes_a: vector<u64>,
        claimed_honey_bribes_a: vector<u64>,
        claimed_hive_bribes_b: vector<u64>,
        claimed_honey_bribes_b: vector<u64>,
        claimed_hive_bribes_c: vector<u64>,
        claimed_honey_bribes_c: vector<u64>,
        bribe_a_bal: u64,
        bribe_b_bal: u64,
        bribe_c_bal: u64,
    }

    struct TradingFeeClaimedByTrainer has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        claimed_cycles: vector<u64>,
        claimed_hive_fees: vector<u64>,
        claimed_honey_fees: vector<u64>,
        hive_fee_bal: u64,
        honey_fee_bal: u64,
    }

    struct DragonFoodVotingConfigUpdated has copy, drop {
        proposal_required_deposit: u64,
        voting_start_delay: u64,
        voting_period_length: u64,
        execution_delay: u64,
        execution_period_length: u64,
        proposal_required_quorum: u64,
        proposal_approval_threshold: u64,
    }

    struct PoolHiveKrafted has copy, drop {
        pool_id: address,
        lp_identifier: 0x1::ascii::String,
        pool_hive_addr: address,
        cur_epoch: u64,
        ongoing_cycle: u64,
        cur_cycle_start_epoch: u64,
        accepted_bribes_vec: vector<0x1::string::String>,
    }

    struct RipeFruitsClaimed<phantom T0> has copy, drop {
        fruit_type: 0x1::ascii::String,
        trainer_addr: address,
        user_name: 0x1::string::String,
        fruit_global_claim_index: u256,
        earned_fruits: u64,
        pool_hive_addr: address,
    }

    struct EmissionsRcvdByPoolHive has copy, drop {
        pool_hive_addr: address,
        hive_earned: u64,
        honey_earned: u64,
        hive_per_epoch: u256,
        honey_per_epoch: u256,
        hive_index_increment: u256,
        honey_index_increment: u256,
        global_honey_claim_index: u256,
        global_hive_claim_index: u256,
        last_claim_epoch: u64,
    }

    struct BribeAddedForEmissions has copy, drop {
        pool_hive_addr: address,
        coin_type: 0x1::string::String,
        bribe_for_hive_emisions: u64,
        bribe_for_honey_emisions: u64,
        for_cycle: u64,
    }

    struct BribeMarkedAsToken has copy, drop {
        pool_hive_addr: address,
        coin_type: 0x1::string::String,
    }

    struct AddedToDragonDen has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        username: 0x1::string::String,
        lp_balance_added: u64,
        is_dragon_bee_locked: bool,
        hive_earned: u64,
        honey_earned: u64,
        hive_claim_index: u256,
        honey_claim_index: u256,
    }

    struct UnbondingFromDragonDen has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        is_dragon_bee_locked: bool,
        lp_balance_unbonded: u64,
        hive_earned: u64,
        honey_earned: u64,
        hive_claim_index: u256,
        honey_claim_index: u256,
    }

    struct NewUnbondingPosition has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        unlockable_epoch: u64,
        unbonded_amount: u64,
    }

    struct UnbondingPositionUnlocked has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        unbondable_epoches: vector<u64>,
        unbondable_amounts: vector<u64>,
        total_unbonded_amount: u64,
    }

    struct MoreFruitsAdded has copy, drop {
        pool_hive_addr: address,
        honey_fruit_type: 0x1::ascii::String,
        fruits_added: u64,
        additional_per_epoch: u64,
        fruits_per_epoch: u64,
        available_fruits: u64,
    }

    struct HoneyFruitDestroyed has copy, drop {
        pool_hive_addr: address,
        honey_fruit_type: 0x1::ascii::String,
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
        voter_trainer: address,
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

    struct HoneyFruitKraftedForPoolHive has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        honey_fruit_identifier: 0x1::type_name::TypeName,
    }

    struct ProposalExecuted has copy, drop {
        pool_hive_addr: address,
        proposal_id: u64,
        proposal_type: u64,
    }

    struct FeedingFoodToBee has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        bee_version: u64,
        locked_at_cycle: u64,
        hive_earned: u64,
        honey_earned: u64,
        staked_for_honey: u64,
    }

    struct AddHiveAndEnergyForNextCycle has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        increment_cycle: u64,
        net_energy_increase: u128,
        net_health_increase: u128,
        new_increase_in_energy: u128,
        new_increase_in_health: u128,
    }

    struct DragonBeeWithdrawalRequested has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        bee_version: u64,
        withdrawable_at_cycle: u64,
    }

    struct RestedLockedDragonBeeReturnedInWild has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        bee_version: u64,
        hive_earned: u64,
        honey_earned: u64,
        unlocked_at_cycle: u64,
        staked_for_honey: u64,
    }

    struct FeesClaimedForEmissions has copy, drop {
        pool_hive_addr: address,
        is_added: bool,
        hive_fee_claimed: u64,
        honey_fee_claimed: u64,
        cycle: u64,
        hive_fee_index_increment: u256,
        honey_fee_index_increment: u256,
    }

    struct VotingPowerIncreasedForLockedBees has copy, drop {
        bee_versions: vector<u64>,
        hive_energy_vec: vector<u128>,
        honey_health_vec: vector<u128>,
    }

    struct ActiveVotesForTrainerUpdated has copy, drop {
        trainer_addr: address,
        cur_cycle: u64,
        active_hive_energy: u128,
        active_honey_health: u128,
    }

    struct LockedLP has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
    }

    struct UnlockedLP has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
    }

    struct LiquidatedLP has copy, drop {
        pool_hive_addr: address,
        trainer_addr: address,
        amt_liquidated: u64,
    }

    struct PoolHiveMigrated has copy, drop {
        pool_id: address,
        new_pool_hive_addr: address,
    }

    public fun kraft_genesis_honey(arg0: &mut DragonFood, arg1: 0x2::coin::TreasuryCap<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY> {
        let (v0, v1) = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::kraft_genesis_honey(&arg0.dragon_food_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg0.honey_available, v0);
        v1
    }

    fun access_dragon_den<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : DragonsDen<T0> {
        if (0x2::linked_table::contains<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1)) {
            0x2::linked_table::remove<address, DragonsDen<T0>>(&mut arg0.resting_dragons, arg1)
        } else {
            DragonsDen<T0>{staked_balance: 0x2::balance::zero<T0>(), hive_claim_index: arg0.global_hive_claim_index, honey_claim_index: arg0.global_honey_claim_index, locked_bees: 0x1::vector::empty<u64>(), unlocking_bees: 0x1::vector::empty<u64>(), dragon_bees: 0x2::linked_table::new<u64, LockedDragonBee>(arg2), active_hive_energy: 0, active_honey_health: 0, increment_cycle: 0, increase_in_energy: 0, increase_in_health: 0, decrease_in_energy: 0, decrease_in_health: 0, dao_vote_cycle: 0, bribes_claimed_till: 0, fees_claimed_till: 0, hive_fee_claim_indexes: 0x2::linked_table::new<u64, u256>(arg2), honey_fee_claim_indexes: 0x2::linked_table::new<u64, u256>(arg2), rewards_indexes: 0x2::linked_table::new<0x1::ascii::String, u256>(arg2), is_locked: false}
        }
    }

    public fun access_dragon_den_fruit_claim_index<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: 0x1::ascii::String) : u256 {
        *0x2::linked_table::borrow<0x1::ascii::String, u256>(&0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1).rewards_indexes, arg2)
    }

    public fun access_dragons_den_with_rewards_0_fruits<T0>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u256, u256, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2);
        let (_, _, v4, v5) = get_expected_yield<T0>(arg0, arg1, v1, v0);
        let (_, _, v8, v9) = get_expected_yield<T0>(arg0, arg1, v1, v0 + 1);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.honey_claim_index, v1.hive_claim_index, 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.rewards_indexes), v4, v5, v8, v9, v1.is_locked)
    }

    public fun access_dragons_den_with_rewards_1_fruits<T0, T1>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u256, u256, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2);
        let (_, _, v4, v5) = get_expected_yield<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let (_, _, v9, v10) = get_expected_yield<T0>(arg0, arg1, v1, v0 + 1);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.honey_claim_index, v1.hive_claim_index, 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.rewards_indexes), v4, v5, v9, v10, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0 + 1), v1.is_locked)
    }

    public fun access_dragons_den_with_rewards_2_fruits<T0, T1, T2>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u256, u256, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2);
        let (_, _, v4, v5) = get_expected_yield<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T2>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let (_, _, v10, v11) = get_expected_yield<T0>(arg0, arg1, v1, v0 + 1);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.honey_claim_index, v1.hive_claim_index, 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.rewards_indexes), v4, v5, v10, v11, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0 + 1), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0 + 1), v1.is_locked)
    }

    public fun access_dragons_den_with_rewards_3_fruits<T0, T1, T2, T3>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u256, u256, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::tx_context::epoch(arg3);
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        let v1 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2);
        let (_, _, v4, v5) = get_expected_yield<T0>(arg0, arg1, v1, v0);
        let v6 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T1>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v7 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T2>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v8 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, HoneyFruit<T3>>(&arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let (_, _, v11, v12) = get_expected_yield<T0>(arg0, arg1, v1, v0 + 1);
        (0x2::balance::value<T0>(&v1.staked_balance), v1.honey_claim_index, v1.hive_claim_index, 0x2::linked_table::length<0x1::ascii::String, u256>(&v1.rewards_indexes), v4, v5, v11, v12, calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T1>(v6, v1, arg1.total_staked, v0 + 1), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T2>(v7, v1, arg1.total_staked, v0 + 1), calculate_fruit_rewards<T0, T3>(v8, v1, arg1.total_staked, v0), calculate_fruit_rewards<T0, T3>(v8, v1, arg1.total_staked, v0 + 1), v1.is_locked)
    }

    fun accrue_yield_for_dragon_den<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        0x2::object::uid_to_address(&arg1.id);
        let v0 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>();
        let v1 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>();
        update_food_cycle(arg0, arg4);
        update_food_cycle_for_pool_hive<T0>(arg0, arg1, arg4);
        accrue_yield_for_pool_hive<T0>(arg0, arg1, arg4);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::balance::value<T0>(&arg2.staked_balance);
        if (v4 > 0 && arg1.global_hive_claim_index > arg2.hive_claim_index) {
            v2 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg1.global_hive_claim_index - arg2.hive_claim_index) as u256), (v4 as u256), (1000000 as u256)) as u64);
        };
        arg2.hive_claim_index = arg1.global_hive_claim_index;
        let v5 = if (0x1::vector::length<u64>(&arg2.locked_bees) > 0) {
            if (v4 > 0) {
                arg1.global_honey_claim_index > arg2.honey_claim_index
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            v3 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg1.global_honey_claim_index - arg2.honey_claim_index) as u256), (v4 as u256), (1000000 as u256)) as u64);
        };
        arg2.honey_claim_index = arg1.global_honey_claim_index;
        if (v2 > 0) {
            let v6 = &mut arg1.hive_available;
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v0, safe_claim_bribe<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v6, v2));
        };
        if (v3 > 0) {
            let v7 = &mut arg1.honey_available;
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v1, safe_claim_bribe<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(v7, v3));
        };
        (v0, v1)
    }

    public entry fun accrue_yield_for_pool_hive<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let (v1, v2, v3, v4) = get_votes_rcvd_for_cycle<T0>(arg0, arg1, arg0.ongoing_cycle);
        if (v1 == 0 && v3 == 0) {
            arg1.last_claim_epoch = v0;
            arg1.last_claim_honey_epoch = v0;
        };
        let v5 = v0 - arg1.last_claim_epoch;
        let v6 = v0 - arg1.last_claim_honey_epoch;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        if (v0 >= arg0.emissions.start_epoch) {
            if (v5 > 0 && arg1.total_staked > 0) {
                let v11 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg0.emissions.hive_per_epoch as u256), (v1 as u256), (v2 as u256)) as u64);
                v9 = v11;
                let v12 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v5 * v11) as u256), (1000000 as u256), (arg1.total_staked as u256));
                v7 = v12;
                arg1.global_hive_claim_index = arg1.global_hive_claim_index + v12;
                arg1.last_claim_epoch = v0;
            };
            if (v6 > 0 && arg1.staked_for_honey > 0) {
                let v13 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg0.emissions.honey_per_epoch as u256), (v3 as u256), (v4 as u256)) as u64);
                v10 = v13;
                let v14 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v6 * v13) as u256), (1000000 as u256), (arg1.staked_for_honey as u256));
                v8 = v14;
                arg1.global_honey_claim_index = arg1.global_honey_claim_index + v14;
                arg1.last_claim_honey_epoch = v0;
            };
            let v15 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1.total_staked as u256), (v7 as u256), (1000000 as u256)) as u64);
            let v16 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1.total_staked as u256), (v8 as u256), (1000000 as u256)) as u64);
            let v17 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>();
            let v18 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>();
            if (v15 <= 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&arg0.hive_available)) {
                0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v17, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg0.hive_available, v15));
            };
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg1.hive_available, v17);
            if (v16 <= 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg0.honey_available)) {
                0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v18, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg0.honey_available, v16));
            };
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg1.honey_available, v18);
            let v19 = EmissionsRcvdByPoolHive{
                pool_hive_addr           : 0x2::object::uid_to_address(&arg1.id),
                hive_earned              : v15,
                honey_earned             : v16,
                hive_per_epoch           : (v9 as u256),
                honey_per_epoch          : (v10 as u256),
                hive_index_increment     : v7,
                honey_index_increment    : v8,
                global_honey_claim_index : arg1.global_honey_claim_index,
                global_hive_claim_index  : arg1.global_hive_claim_index,
                last_claim_epoch         : arg1.last_claim_epoch,
            };
            0x2::event::emit<EmissionsRcvdByPoolHive>(v19);
        };
    }

    public fun add_bribe_for_emissions<T0, T1>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        update_food_cycle(arg0, arg6);
        assert!(arg3 > arg0.ongoing_cycle, 7062);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v1, v0);
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.bribes.voting_bribes, &v1), 7056);
        assert!(0x2::coin::value<T1>(&arg2) >= arg4 + arg5, 7057);
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, VotingBribes<T1>>(&mut arg1.id, v1);
        0x2::balance::join<T1>(&mut v3.bribe, 0x2::balance::split<T1>(&mut v2, arg4 + arg5));
        if (!0x2::linked_table::contains<u64, u64>(&v3.cycle_to_hive_bribes_map, arg3)) {
            0x2::linked_table::push_back<u64, u64>(&mut v3.cycle_to_hive_bribes_map, arg3, 0);
            0x2::linked_table::push_back<u64, u64>(&mut v3.cycle_to_honey_bribes_map, arg3, 0);
        };
        *0x2::linked_table::borrow_mut<u64, u64>(&mut v3.cycle_to_hive_bribes_map, arg3) = *0x2::linked_table::borrow<u64, u64>(&v3.cycle_to_hive_bribes_map, arg3) + arg4;
        *0x2::linked_table::borrow_mut<u64, u64>(&mut v3.cycle_to_honey_bribes_map, arg3) = *0x2::linked_table::borrow<u64, u64>(&v3.cycle_to_honey_bribes_map, arg3) + arg5;
        let v4 = BribeAddedForEmissions{
            pool_hive_addr           : 0x2::object::uid_to_address(&arg1.id),
            coin_type                : v0,
            bribe_for_hive_emisions  : arg4,
            bribe_for_honey_emisions : arg5,
            for_cycle                : arg3,
        };
        0x2::event::emit<BribeAddedForEmissions>(v4);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun add_hive_bribe_for_pool_hive<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        update_food_cycle(arg0, arg4);
        update_food_cycle_for_pool_hive<T0>(arg0, arg1, arg4);
        let v0 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg2);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg1.bribes.hive_bribe, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v0, arg3));
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg4), arg4);
        let v1 = (*0x2::linked_table::borrow<u64, u128>(&arg1.active_hive_energy, arg1.ongoing_cycle) as u256);
        assert!(v1 > 0, 7068);
        let v2 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg3 as u256), (1000000 as u256), v1);
        if (!0x2::linked_table::contains<u64, u256>(&arg1.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle)) {
            0x2::linked_table::push_back<u64, u256>(&mut arg1.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle, 0);
            0x2::linked_table::push_back<u64, u256>(&mut arg1.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle, 0);
        };
        *0x2::linked_table::borrow_mut<u64, u256>(&mut arg1.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle) = *0x2::linked_table::borrow<u64, u256>(&arg1.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle) + v2;
        let v3 = FeesClaimedForEmissions{
            pool_hive_addr            : 0x2::object::uid_to_address(&arg1.id),
            is_added                  : true,
            hive_fee_claimed          : arg3,
            honey_fee_claimed         : 0,
            cycle                     : arg0.ongoing_cycle,
            hive_fee_index_increment  : v2,
            honey_fee_index_increment : 0,
        };
        0x2::event::emit<FeesClaimedForEmissions>(v3);
    }

    public fun add_hive_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3 && arg3.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg6);
        let (v4, v5, v6, v7) = internal_add_hive_to_dragon_bee<T0>(arg0, arg1, arg2, arg3, v0, arg5, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v3, arg7), arg8);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_trainer(arg4, v7);
        let v8 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg8);
        let v9 = &mut v8;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, v4, arg8);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v8);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v3, v5);
        v3
    }

    public fun add_honey_bribe_for_pool_hive<T0>(arg0: &mut DragonFood, arg1: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::HoneyManager<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg2: &mut PoolHive<T0>, arg3: &mut 0x2::token::TokenPolicy<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg4: &mut 0x2::token::Token<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg2.module_version == 3, 7038);
        update_food_cycle(arg0, arg6);
        update_food_cycle_for_pool_hive<T0>(arg0, arg2, arg6);
        let v0 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::unwrap_honey_tokens_to_coins(&arg0.dragon_food_cap, arg1, arg3, arg4, arg5, arg6));
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg2.bribes.honey_bribe, v0);
        let v1 = (*0x2::linked_table::borrow<u64, u128>(&arg2.active_honey_health, arg2.ongoing_cycle) as u256);
        assert!(v1 > 0, 7068);
        let v2 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v0) as u256), (1000000 as u256), v1);
        if (!0x2::linked_table::contains<u64, u256>(&arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle)) {
            0x2::linked_table::push_back<u64, u256>(&mut arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle, 0);
            0x2::linked_table::push_back<u64, u256>(&mut arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle, 0);
        };
        *0x2::linked_table::borrow_mut<u64, u256>(&mut arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle) = *0x2::linked_table::borrow<u64, u256>(&arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle) + v2;
        let v3 = FeesClaimedForEmissions{
            pool_hive_addr            : 0x2::object::uid_to_address(&arg2.id),
            is_added                  : true,
            hive_fee_claimed          : 0,
            honey_fee_claimed         : arg5,
            cycle                     : arg0.ongoing_cycle,
            hive_fee_index_increment  : 0,
            honey_fee_index_increment : v2,
        };
        0x2::event::emit<FeesClaimedForEmissions>(v3);
    }

    public fun add_honey_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::HoneyManager<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg7: &mut 0x2::token::TokenPolicy<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg8: &mut 0x2::token::Token<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3 && arg3.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::unwrap_honey_tokens_to_coins(&arg1.dragon_food_cap, arg6, arg7, arg8, arg9, arg10));
        let (v4, v5, v6, v7) = internal_add_honey_to_dragon_bee<T0>(arg0, arg1, arg2, arg3, v0, arg5, v3, arg10);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_trainer(arg4, v7);
        let v8 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg10);
        let v9 = &mut v8;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, v4, arg10);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v8);
        v5
    }

    public fun add_more_fruits<T0, T1>(arg0: &mut PoolHive<T0>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(arg0.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg3);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v2, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.additional_rewards, &v1);
        assert!(v2, 7016);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg0.id, v1);
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
                v4.claim_index = v4.claim_index + (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v4.fruits_per_epoch * v7) as u256), (1000000 as u256), (arg0.total_staked as u256)) as u256);
                v4.last_claim_epoch = v0;
            };
        };
        0x2::balance::join<T1>(&mut v4.available_fruits, 0x2::balance::split<T1>(&mut arg1, arg2));
        let v8 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(1000000, arg2, v4.end_epoch - v6);
        v4.fruits_per_epoch = v4.fruits_per_epoch + v8;
        let v9 = MoreFruitsAdded{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg0.id),
            honey_fruit_type     : v1,
            fruits_added         : arg2,
            additional_per_epoch : v8,
            fruits_per_epoch     : v4.fruits_per_epoch,
            available_fruits     : 0x2::balance::value<T1>(&v4.available_fruits),
        };
        0x2::event::emit<MoreFruitsAdded>(v9);
        arg1
    }

    public fun add_more_fruits_coins<T0, T1>(arg0: &mut PoolHive<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        let v0 = add_more_fruits<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3);
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun add_unbonding_positions_if_not_exists<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"UNBONDING_PSN"))) {
            let v0 = UnbondingPositions<T0>{
                id               : 0x2::object::new(arg1),
                unbonded_balance : 0x2::balance::zero<T0>(),
                user_psns        : 0x2::linked_table::new<address, UserUnbondingPsn>(arg1),
            };
            0x2::dynamic_object_field::add<0x1::string::String, UnbondingPositions<T0>>(&mut arg0.id, 0x1::string::utf8(b"UNBONDING_PSN"), v0);
        };
    }

    fun calculate_fruit_rewards<T0, T1>(arg0: &HoneyFruit<T1>, arg1: &DragonsDen<T0>, arg2: u64, arg3: u64) : u64 {
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
            v4 = v3 + 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg0.fruits_per_epoch * v2) as u256), (1000000 as u256), (arg2 as u256));
        };
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v6 = v4;
        if (0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.rewards_indexes, v5)) {
            v6 = *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg1.rewards_indexes, v5);
        };
        (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v4 - v6) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64)
    }

    public entry fun castVote<T0>(arg0: &mut PoolHive<T0>, arg1: &0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg1);
        internal_castVote<T0>(arg0, v0, v1, arg2, arg3, arg4);
    }

    public fun castVote_withCompProfile<T0>(arg0: &mut PoolHive<T0>, arg1: &0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg1);
        internal_castVote<T0>(arg0, v0, v1, arg2, arg3, arg4);
    }

    fun claim_bribes_for_user<T0, T1, T2, T3>(arg0: &mut PoolHive<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : (0x2::balance::Balance<T1>, bool, 0x2::balance::Balance<T2>, bool, 0x2::balance::Balance<T3>, bool) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, VotingBribes<T1>>(&mut arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 0));
        let v1 = &mut v0.bribe;
        let v2 = v0.is_meme_token;
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, VotingBribes<T2>>(&mut arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 1));
        let v4 = &mut v3.bribe;
        let v5 = 0x2::balance::zero<T3>();
        let v6 = false;
        if (arg4) {
            let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, VotingBribes<T3>>(&mut arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 2));
            let v8 = &mut v7.bribe;
            0x2::balance::join<T3>(&mut v5, safe_claim_bribe<T3>(v8, arg3));
            v6 = v7.is_meme_token;
        };
        (safe_claim_bribe<T1>(v1, arg1), v2, safe_claim_bribe<T2>(v4, arg2), v3.is_meme_token, v5, v6)
    }

    public fun claim_fees_from_yield_flow_for_pool<T0>(arg0: &mut DragonFood, arg1: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg2: &mut PoolHive<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg2.module_version == 3, 7038);
        update_food_cycle(arg0, arg3);
        update_food_cycle_for_pool_hive<T0>(arg0, arg2, arg3);
        let (v0, v1) = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::claim_fees_from_pool_flow(arg1, &arg0.dragon_food_cap, arg2.pool_addr, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v3);
        let v5 = 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v2);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg2.bribes.hive_bribe, v3);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg2.bribes.honey_bribe, v2);
        let v6 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v4 as u256), (1000000 as u256), (*0x2::linked_table::borrow<u64, u128>(&arg2.active_hive_energy, arg2.ongoing_cycle) as u256));
        let v7 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v5 as u256), (1000000 as u256), (*0x2::linked_table::borrow<u64, u128>(&arg2.active_honey_health, arg2.ongoing_cycle) as u256));
        if (!0x2::linked_table::contains<u64, u256>(&arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle)) {
            0x2::linked_table::push_back<u64, u256>(&mut arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle, 0);
            0x2::linked_table::push_back<u64, u256>(&mut arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle, 0);
        };
        *0x2::linked_table::borrow_mut<u64, u256>(&mut arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle) = *0x2::linked_table::borrow<u64, u256>(&arg2.bribes.hive_fee_claim_indexes, arg0.ongoing_cycle) + v6;
        *0x2::linked_table::borrow_mut<u64, u256>(&mut arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle) = *0x2::linked_table::borrow<u64, u256>(&arg2.bribes.honey_fee_claim_indexes, arg0.ongoing_cycle) + v7;
        let v8 = FeesClaimedForEmissions{
            pool_hive_addr            : 0x2::object::uid_to_address(&arg2.id),
            is_added                  : false,
            hive_fee_claimed          : v4,
            honey_fee_claimed         : v5,
            cycle                     : arg0.ongoing_cycle,
            hive_fee_index_increment  : v6,
            honey_fee_index_increment : v7,
        };
        0x2::event::emit<FeesClaimedForEmissions>(v8);
    }

    fun claim_fruit_for_dragons_den<T0, T1>(arg0: &mut HoneyFruit<T1>, arg1: &mut DragonsDen<T0>, arg2: address, arg3: u64, arg4: u64, arg5: address, arg6: 0x1::string::String, arg7: bool) : 0x2::balance::Balance<T1> {
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
            arg0.claim_index = arg0.claim_index + 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg0.fruits_per_epoch * v3) as u256), (1000000 as u256), (arg3 as u256));
            arg0.last_claim_epoch = arg4;
        };
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.rewards_indexes, v4)) {
            let v5 = 0;
            if (!arg7) {
                v5 = arg0.claim_index;
            };
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.rewards_indexes, v4, v5);
        };
        let v6 = 0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg1.rewards_indexes, v4);
        let v7 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((arg0.claim_index - *v6) as u256), (0x2::balance::value<T0>(&arg1.staked_balance) as u256), (1000000 as u256)) as u64);
        *v6 = arg0.claim_index;
        if (v7 > 0) {
            0x2::balance::join<T1>(&mut v0, 0x2::balance::split<T1>(&mut arg0.available_fruits, v7));
        };
        let v8 = RipeFruitsClaimed<T1>{
            fruit_type               : v4,
            trainer_addr             : arg5,
            user_name                : arg6,
            fruit_global_claim_index : arg0.claim_index,
            earned_fruits            : v7,
            pool_hive_addr           : arg2,
        };
        0x2::event::emit<RipeFruitsClaimed<T1>>(v8);
        v0
    }

    fun claim_rewards_and_unbond_shares<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: address, arg3: &mut DragonsDen<T0>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(&arg3.staked_balance) >= arg4, 7008);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        let (v2, v3) = accrue_yield_for_dragon_den<T0>(arg0, arg1, arg3, arg5, arg7);
        let v4 = v3;
        let v5 = v2;
        if (arg4 > 0) {
            if (!arg6) {
                assert!(!arg3.is_locked, 7065);
            };
            arg1.total_staked = arg1.total_staked - arg4;
            if (0x1::vector::length<u64>(&arg3.locked_bees) > 0) {
                arg1.staked_for_honey = arg1.staked_for_honey - arg4;
            };
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg3.staked_balance, arg4));
        };
        let v6 = UnbondingFromDragonDen{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg1.id),
            trainer_addr         : arg2,
            is_dragon_bee_locked : 0x1::vector::length<u64>(&arg3.locked_bees) > 0,
            lp_balance_unbonded  : arg4,
            hive_earned          : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v5),
            honey_earned         : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v4),
            hive_claim_index     : arg3.hive_claim_index,
            honey_claim_index    : arg3.honey_claim_index,
        };
        0x2::event::emit<UnbondingFromDragonDen>(v6);
        if (0x2::balance::value<T0>(&v0) > 0) {
            let v7 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UnbondingPositions<T0>>(&mut arg1.id, 0x1::string::utf8(b"UNBONDING_PSN"));
            if (!0x2::linked_table::contains<address, UserUnbondingPsn>(&v7.user_psns, arg2)) {
                let v8 = UserUnbondingPsn{unlocking_amts: 0x2::linked_table::new<u64, u64>(arg7)};
                0x2::linked_table::push_back<address, UserUnbondingPsn>(&mut v7.user_psns, arg2, v8);
            };
            let v9 = 0x2::linked_table::borrow_mut<address, UserUnbondingPsn>(&mut v7.user_psns, arg2);
            let v10 = arg5 + 1;
            let v11 = 0x2::balance::value<T0>(&v0);
            let v12 = v11;
            if (0x2::linked_table::contains<u64, u64>(&v9.unlocking_amts, v10)) {
                v12 = v11 + *0x2::linked_table::borrow<u64, u64>(&v9.unlocking_amts, v10);
                0x2::linked_table::remove<u64, u64>(&mut v9.unlocking_amts, v10);
            };
            0x2::linked_table::push_back<u64, u64>(&mut v9.unlocking_amts, v10, v12);
            let v13 = NewUnbondingPosition{
                pool_hive_addr   : v1,
                trainer_addr     : arg2,
                unlockable_epoch : v10,
                unbonded_amount  : v12,
            };
            0x2::event::emit<NewUnbondingPosition>(v13);
            0x2::balance::join<T0>(&mut v7.unbonded_balance, 0x2::balance::withdraw_all<T0>(&mut v0));
        };
        (v5, v4, v0)
    }

    fun claim_trading_fees_for_user<T0>(arg0: &mut PoolHive<T0>, arg1: &mut DragonsDen<T0>, arg2: u256, arg3: u256, arg4: u64, arg5: u64) : (vector<u64>, vector<u64>, vector<u64>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        while (arg4 <= arg5) {
            0x1::vector::push_back<u64>(&mut v2, arg4);
            if (!0x2::linked_table::contains<u64, u256>(&arg0.bribes.hive_fee_claim_indexes, arg4)) {
                0x2::linked_table::push_back<u64, u256>(&mut arg0.bribes.hive_fee_claim_indexes, arg4, 0);
                0x2::linked_table::push_back<u64, u256>(&mut arg0.bribes.honey_fee_claim_indexes, arg4, 0);
            };
            let v5 = *0x2::linked_table::borrow<u64, u256>(&arg0.bribes.hive_fee_claim_indexes, arg4);
            let v6 = *0x2::linked_table::borrow<u64, u256>(&arg0.bribes.honey_fee_claim_indexes, arg4);
            if (!0x2::linked_table::contains<u64, u256>(&arg1.hive_fee_claim_indexes, arg4)) {
                0x2::linked_table::push_back<u64, u256>(&mut arg1.hive_fee_claim_indexes, arg4, 0);
                0x2::linked_table::push_back<u64, u256>(&mut arg1.honey_fee_claim_indexes, arg4, 0);
            };
            let v7 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v5 - *0x2::linked_table::borrow<u64, u256>(&arg1.hive_fee_claim_indexes, arg4)) as u256), arg2, (1000000 as u256)) as u64);
            let v8 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256(((v6 - *0x2::linked_table::borrow<u64, u256>(&arg1.honey_fee_claim_indexes, arg4)) as u256), arg3, (1000000 as u256)) as u64);
            v0 = v0 + v7;
            v1 = v1 + v8;
            0x1::vector::push_back<u64>(&mut v3, v7);
            0x1::vector::push_back<u64>(&mut v4, v8);
            *0x2::linked_table::borrow_mut<u64, u256>(&mut arg1.hive_fee_claim_indexes, arg4) = v5;
            *0x2::linked_table::borrow_mut<u64, u256>(&mut arg1.honey_fee_claim_indexes, arg4) = v6;
            arg4 = arg4 + 1;
        };
        let v9 = &mut arg0.bribes.hive_bribe;
        let v10 = safe_claim_bribe<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v9, v0);
        let v11 = &mut arg0.bribes.honey_bribe;
        (v2, v3, v4, v10, safe_claim_bribe<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(v11, v1))
    }

    public fun claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg5);
        let (v3, v4, v5, v6, v7, v8, v9) = internal_claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, v0, arg6);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_trainer(arg5, v9);
        let v10 = verify_and_extract_dragon_den<T0>(arg1, arg4, v0, arg6);
        let v11 = &mut v10;
        feed_dragon_bee<T0>(arg0, arg1, arg4, arg2, v0, arg5, v11, v8, v6, arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v10);
        (lock_hive_if_trading_disabled(arg5, arg2, v7), v3, v4, v5)
    }

    public fun claim_voting_rewards_three_pool_dragon_school<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg5);
        let (v3, v4, v5, v6, v7, v8, v9) = internal_claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, v0, arg6);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_dragon_school(arg5, v9);
        let v10 = verify_and_extract_dragon_den<T0>(arg1, arg4, v0, arg6);
        let v11 = &mut v10;
        feed_dragon_bee_school<T0>(arg0, arg1, arg4, arg2, v0, arg5, v11, v8, v6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v10);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        (v7, v3, v4, v5)
    }

    public fun claim_voting_rewards_two_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg5);
        let (v3, v4, v5, v6, v7, v8) = internal_claim_voting_rewards_two_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, v0, false, arg6);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_trainer(arg5, v8);
        let v9 = verify_and_extract_dragon_den<T0>(arg1, arg4, v0, arg6);
        let v10 = &mut v9;
        feed_dragon_bee<T0>(arg0, arg1, arg4, arg2, v0, arg5, v10, v7, v5, arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v9);
        (lock_hive_if_trading_disabled(arg5, arg2, v6), v3, v4)
    }

    public fun claim_voting_rewards_two_pool_dragon_school<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg5);
        let (v3, v4, v5, v6, v7, v8) = internal_claim_voting_rewards_two_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, v0, false, arg6);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_dragon_school(arg5, v8);
        let v9 = verify_and_extract_dragon_den<T0>(arg1, arg4, v0, arg6);
        let v10 = &mut v9;
        feed_dragon_bee_school<T0>(arg0, arg1, arg4, arg2, v0, arg5, v10, v7, v5);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v9);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        (v6, v3, v4)
    }

    public fun claim_voting_rewards_two_pool_with_burn_tax<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &0x2::coin::TreasuryCap<T2>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg5: &mut PoolHive<T0>, arg6: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg6);
        let (v3, v4, v5, v6, v7, v8) = internal_claim_voting_rewards_two_pool<T0, T1, T2>(arg1, arg3, arg4, arg5, v0, true, arg7);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_trainer(arg6, v8);
        let v9 = verify_and_extract_dragon_den<T0>(arg1, arg5, v0, arg7);
        let v10 = &mut v9;
        feed_dragon_bee<T0>(arg0, arg1, arg5, arg3, v0, arg6, v10, v7, v5, arg7);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg5.resting_dragons, v0, v9);
        (lock_hive_if_trading_disabled(arg6, arg3, v6), v3, v4)
    }

    fun compute_bribe_for_user<T0>(arg0: &VotingBribes<T0>, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        if (0x2::linked_table::contains<u64, u64>(&arg0.cycle_to_hive_bribes_map, arg1) && arg4 > 0) {
            v0 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((*0x2::linked_table::borrow<u64, u64>(&arg0.cycle_to_hive_bribes_map, arg1) as u256), arg2, arg4) as u64);
        };
        if (0x2::linked_table::contains<u64, u64>(&arg0.cycle_to_honey_bribes_map, arg1) && arg5 > 0) {
            v1 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((*0x2::linked_table::borrow<u64, u64>(&arg0.cycle_to_honey_bribes_map, arg1) as u256), arg3, arg5) as u64);
        };
        (v0, v1)
    }

    fun compute_bribes_for_user<T0, T1, T2, T3>(arg0: &mut PoolHive<T0>, arg1: u256, arg2: u256, arg3: u64, arg4: u64, arg5: bool) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0x1::vector::empty<u64>();
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0x2::dynamic_object_field::borrow<0x1::string::String, VotingBribes<T1>>(&arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 0));
        while (arg3 <= arg4) {
            0x1::vector::push_back<u64>(&mut v6, arg3);
            if (!0x2::linked_table::contains<u64, u128>(&arg0.active_hive_energy, arg3)) {
                0x2::linked_table::push_back<u64, u128>(&mut arg0.active_hive_energy, arg3, 0);
                0x2::linked_table::push_back<u64, u128>(&mut arg0.active_honey_health, arg3, 0);
            };
            let (v14, v15) = compute_bribe_for_user<T1>(v13, arg3, arg1, arg2, (*0x2::linked_table::borrow<u64, u128>(&arg0.active_hive_energy, arg3) as u256), (*0x2::linked_table::borrow<u64, u128>(&arg0.active_honey_health, arg3) as u256));
            v0 = v0 + v14;
            v1 = v1 + v15;
            0x1::vector::push_back<u64>(&mut v7, v14);
            0x1::vector::push_back<u64>(&mut v8, v15);
            arg3 = arg3 + 1;
        };
        let v16 = 0x2::dynamic_object_field::borrow<0x1::string::String, VotingBribes<T2>>(&arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 1));
        while (arg3 <= arg4) {
            let (v17, v18) = compute_bribe_for_user<T2>(v16, arg3, arg1, arg2, (*0x2::linked_table::borrow<u64, u128>(&arg0.active_hive_energy, arg3) as u256), (*0x2::linked_table::borrow<u64, u128>(&arg0.active_honey_health, arg3) as u256));
            v2 = v2 + v17;
            v3 = v3 + v18;
            0x1::vector::push_back<u64>(&mut v9, v17);
            0x1::vector::push_back<u64>(&mut v10, v18);
            arg3 = arg3 + 1;
        };
        let v19 = 0;
        if (arg5) {
            let v20 = 0x2::dynamic_object_field::borrow<0x1::string::String, VotingBribes<T3>>(&arg0.id, *0x1::vector::borrow<0x1::string::String>(&arg0.bribes.voting_bribes, 2));
            while (arg3 <= arg4) {
                let (v21, v22) = compute_bribe_for_user<T3>(v20, arg3, arg1, arg2, (*0x2::linked_table::borrow<u64, u128>(&arg0.active_hive_energy, arg3) as u256), (*0x2::linked_table::borrow<u64, u128>(&arg0.active_honey_health, arg3) as u256));
                v4 = v4 + v21;
                v5 = v5 + v22;
                0x1::vector::push_back<u64>(&mut v11, v21);
                0x1::vector::push_back<u64>(&mut v12, v22);
                arg3 = arg3 + 1;
            };
            v19 = v4 + v5;
        };
        (v6, v7, v8, v9, v10, v11, v12, v0 + v1, v2 + v3, v19)
    }

    public fun deposit_hive_as_lp_incentives(arg0: &mut DragonFood, arg1: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg1);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg0.hive_available, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v0, arg2));
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v0, 0x2::tx_context::sender(arg3), arg3);
    }

    public fun deposit_honey_as_incentives(arg0: &mut DragonFood, arg1: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg0.honey_available, arg1);
    }

    fun destroy_fruit_rewards<T0>(arg0: HoneyFruit<T0>) : (0x2::balance::Balance<T0>, u64, u64, u64, u256, u64, u64) {
        let HoneyFruit {
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

    fun destroy_proposal(arg0: Proposal) : (u64, address, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64, u64, 0x1::option::Option<FruitLife>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>, 0x1::option::Option<vector<u64>>) {
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

    public entry fun evaluateProposal<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: u64, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg2), 7024);
        let v0 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg2);
        assert!(0x2::tx_context::epoch(arg4) > v0.voting_end_epoch && v0.proposal_status <= 1, 7028);
        let v1 = v0.yes_votes + v0.no_votes;
        let v2 = arg1.total_staked;
        let v3 = if (v2 == 0) {
            0
        } else {
            0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((1000000 as u128), (v1 as u128), (v2 as u128))
        };
        let v4 = 0;
        if (arg0.vote_config.proposal_required_quorum > v3) {
            v0.proposal_status = 5;
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_hive_for_distribution(arg3, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v0.deposit));
        } else {
            let v5 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u128((1000000 as u128), (v0.yes_votes as u128), (v1 as u128));
            v4 = v5;
            if (v5 >= arg0.vote_config.proposal_approval_threshold) {
                v0.proposal_status = 3;
            } else {
                v0.proposal_status = 4;
            };
            0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v0.deposit), v0.proposer, arg4);
        };
        let v6 = ProposalEvaluated{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg1.id),
            proposal_id          : v0.proposal_id,
            proposal_status      : v0.proposal_status,
            yes_votes            : v0.yes_votes,
            no_votes             : v0.no_votes,
            total_possible_votes : v2,
            votes_quorum         : v3,
            yes_votes_threshold  : v4,
        };
        0x2::event::emit<ProposalEvaluated>(v6);
    }

    public entry fun executeProposalToAddFruit<T0, T1>(arg0: &mut PoolHive<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(arg0.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg1), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg1);
        let v2 = if (v1.proposal_type == 5) {
            if (v1.proposal_status == 3) {
                if (v0 >= v1.execution_start_epoch) {
                    v0 <= v1.execution_end_epoch
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 7030);
        v1.proposal_status = 7;
        let v3 = 0x1::option::extract<FruitLife>(&mut v1.fruit_life);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0.additional_rewards) < 3, 7023);
        let v4 = HoneyFruit<T1>{
            id               : 0x2::object::new(arg2),
            available_fruits : 0x2::balance::zero<T1>(),
            fruits_per_epoch : 0,
            start_epoch      : v3.start_epoch,
            end_epoch        : v3.end_epoch,
            claim_index      : 0,
            last_claim_epoch : v0,
            module_version   : 3,
        };
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::dynamic_object_field::add<0x1::ascii::String, HoneyFruit<T1>>(&mut arg0.id, v5, v4);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg0.additional_rewards, v5);
        let v6 = HoneyFruitKraftedForPoolHive{
            pool_hive_addr         : 0x2::object::uid_to_address(&arg0.id),
            proposal_id            : v1.proposal_id,
            honey_fruit_identifier : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<HoneyFruitKraftedForPoolHive>(v6);
    }

    public entry fun executeThreePoolProposal<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut PoolHive<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>, arg2: &mut 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LiquidityPool<T0, T1, T2, T3>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        let v2 = if (v1.proposal_status == 3) {
            if (v0 >= v1.execution_start_epoch) {
                v0 <= v1.execution_end_epoch
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 7030);
        v1.proposal_status = 7;
        if (v1.proposal_type == 0) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut v1.new_fee_info);
            0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::update_fee_for_pool<T0, T1, T2, T3>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1));
        };
        if (v1.proposal_type == 1) {
            let v4 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::update_stable_config<T0, T1, T2, T3>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2));
        };
        if (v1.proposal_type == 2) {
            let v5 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::update_weighted_config<T0, T1, T2, T3>(arg2, &arg0.dragon_food_cap, 0x1::option::extract<vector<u64>>(&mut v1.new_weights), *0x1::vector::borrow<u64>(&v5, 0));
        };
        if (v1.proposal_type == 3) {
            let v6 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::update_curved_A_and_gamma<T0, T1, T2, T3>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), (*0x1::vector::borrow<u64>(&v6, 2) as u256), *0x1::vector::borrow<u64>(&v6, 3));
        };
        if (v1.proposal_type == 4) {
            let v7 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::update_curved_config_fee_params<T0, T1, T2, T3>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), *0x1::vector::borrow<u64>(&v7, 2), *0x1::vector::borrow<u64>(&v7, 3), *0x1::vector::borrow<u64>(&v7, 4), *0x1::vector::borrow<u64>(&v7, 5));
        };
        let v8 = ProposalExecuted{
            pool_hive_addr : 0x2::object::uid_to_address(&arg1.id),
            proposal_id    : v1.proposal_id,
            proposal_type  : v1.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v8);
    }

    public entry fun executeTwoPoolProposal<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut PoolHive<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>, arg2: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<T0, T1, T2>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg4);
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg1.proposal_list, arg3), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg1.proposal_list, arg3);
        let v2 = if (v1.proposal_status == 3) {
            if (v0 >= v1.execution_start_epoch) {
                v0 <= v1.execution_end_epoch
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 7030);
        v1.proposal_status = 7;
        if (v1.proposal_type == 0) {
            let v3 = 0x1::option::extract<vector<u64>>(&mut v1.new_fee_info);
            0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::update_fee_for_pool<T0, T1, T2>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v3, 0), *0x1::vector::borrow<u64>(&v3, 1));
        };
        if (v1.proposal_type == 1) {
            let v4 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::update_stable_config<T0, T1, T2>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v4, 0), *0x1::vector::borrow<u64>(&v4, 1), *0x1::vector::borrow<u64>(&v4, 2));
        };
        if (v1.proposal_type == 2) {
            let v5 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::update_weighted_config<T0, T1, T2>(arg2, &arg0.dragon_food_cap, 0x1::option::extract<vector<u64>>(&mut v1.new_weights), *0x1::vector::borrow<u64>(&v5, 0));
        };
        if (v1.proposal_type == 3) {
            let v6 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::update_curved_A_and_gamma<T0, T1, T2>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v6, 0), *0x1::vector::borrow<u64>(&v6, 1), (*0x1::vector::borrow<u64>(&v6, 2) as u256), *0x1::vector::borrow<u64>(&v6, 3));
        };
        if (v1.proposal_type == 4) {
            let v7 = 0x1::option::extract<vector<u64>>(&mut v1.new_params);
            0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::update_curved_config_fee_params<T0, T1, T2>(arg2, &arg0.dragon_food_cap, *0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v7, 1), *0x1::vector::borrow<u64>(&v7, 2), *0x1::vector::borrow<u64>(&v7, 3), *0x1::vector::borrow<u64>(&v7, 4), *0x1::vector::borrow<u64>(&v7, 5));
        };
        let v8 = ProposalExecuted{
            pool_hive_addr : 0x2::object::uid_to_address(&arg1.id),
            proposal_id    : v1.proposal_id,
            proposal_type  : v1.proposal_type,
        };
        0x2::event::emit<ProposalExecuted>(v8);
    }

    public fun feed_bee_in_den<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg5);
        let v3 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::withdraw_bee_for_food(&arg1.dragon_food_cap, arg3, arg5, arg6, 0x2::object::uid_to_address(&arg4.id));
        let (v4, v5) = internal_lock_dragon_bee<T0>(arg1, arg4, v3, v0, arg7);
        let v6 = v4;
        let v7 = verify_and_extract_dragon_den<T0>(arg1, arg4, v0, arg7);
        let v8 = &mut v7;
        feed_dragon_bee<T0>(arg0, arg1, arg4, arg2, v0, arg5, v8, v5, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v6), arg7);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v7);
        lock_hive_if_trading_disabled(arg5, arg2, v6)
    }

    fun feed_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: address, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: &mut DragonsDen<T0>, arg7: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        update_values_if_inconsistent<T0>(arg1, arg2, arg6);
        if (0x1::vector::length<u64>(&arg6.locked_bees) > 0) {
            update_votes_for_locked_bees<T0>(arg1, arg4, arg6);
            let v0 = 0;
            let v1 = 0;
            let v2 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg6.locked_bees)) {
                let v3 = 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut arg6.dragon_bees, *0x1::vector::borrow<u64>(&arg6.locked_bees, v0));
                if (v0 == 0x1::vector::length<u64>(&arg6.locked_bees) - 1) {
                    0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_trainer_with_honey(arg0, arg3, arg5, &mut v3.mystical_bee, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg7), arg9);
                };
                if (v3.locked_at_cycle == arg1.ongoing_cycle || v3.withdrawable_at_cycle > 0 && v3.withdrawable_at_cycle <= arg1.ongoing_cycle) {
                    v0 = v0 + 1;
                    continue
                };
                if (v3.increment_cycle < arg1.ongoing_cycle) {
                    v3.increment_cycle = 0;
                    v3.hive_energy = v3.temp_hive_energy;
                    v3.honey_health = v3.temp_honey_health;
                };
                0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_trainer_with_honey(arg0, arg3, arg5, &mut v3.mystical_bee, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg7, (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v3.honey_health as u256), (0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg7) as u256), (arg6.active_honey_health as u256)) as u64)), arg9);
                0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::charge_mystical_bee(&arg1.dragon_food_cap, &mut v3.mystical_bee, (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v3.hive_energy as u256), (arg8 as u256), (arg6.active_hive_energy as u256)) as u64));
                let (v4, v5) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_bee_power(&v3.mystical_bee);
                v3.increment_cycle = arg1.ongoing_cycle;
                v3.temp_hive_energy = v4;
                v3.temp_honey_health = v5;
                v1 = v1 + ((v4 - 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v3.hive_energy, v3.temp_hive_energy)) as u128);
                v2 = v2 + ((v5 - 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v3.honey_health, v3.temp_honey_health)) as u128);
                v0 = v0 + 1;
            };
            arg6.increment_cycle = arg1.ongoing_cycle;
            arg6.increase_in_energy = arg6.increase_in_energy + v1;
            arg6.increase_in_health = arg6.increase_in_health + v2;
            arg1.added_hive_energy = arg1.added_hive_energy + v1;
            arg1.added_honey_health = arg1.added_honey_health + v2;
            arg2.added_hive_energy = arg2.added_hive_energy + v1;
            arg2.added_honey_health = arg2.added_honey_health + v2;
            let v6 = AddHiveAndEnergyForNextCycle{
                pool_hive_addr         : 0x2::object::uid_to_address(&arg2.id),
                trainer_addr           : arg4,
                increment_cycle        : arg6.increment_cycle,
                net_energy_increase    : v1,
                net_health_increase    : v2,
                new_increase_in_energy : arg6.increase_in_energy,
                new_increase_in_health : arg6.increase_in_health,
            };
            0x2::event::emit<AddHiveAndEnergyForNextCycle>(v6);
        } else {
            assert!(0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg7) == 0, 7050);
        };
        0x2::balance::destroy_zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(arg7);
    }

    fun feed_dragon_bee_school<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: address, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg6: &mut DragonsDen<T0>, arg7: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg8: u64) {
        update_values_if_inconsistent<T0>(arg1, arg2, arg6);
        if (0x1::vector::length<u64>(&arg6.locked_bees) > 0) {
            update_votes_for_locked_bees<T0>(arg1, arg4, arg6);
            let v0 = 0;
            let v1 = 0;
            let v2 = 0;
            while (v0 < 0x1::vector::length<u64>(&arg6.locked_bees)) {
                let v3 = 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut arg6.dragon_bees, v0);
                if (v0 == 0x1::vector::length<u64>(&arg6.locked_bees) - 1) {
                    0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_school_with_honey(arg0, arg3, arg5, &mut v3.mystical_bee, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg7));
                };
                if (v3.locked_at_cycle == arg1.ongoing_cycle || v3.withdrawable_at_cycle > 0 && v3.withdrawable_at_cycle <= arg1.ongoing_cycle) {
                    v0 = v0 + 1;
                    continue
                };
                if (v3.increment_cycle < arg1.ongoing_cycle) {
                    v3.increment_cycle = 0;
                    v3.hive_energy = v3.temp_hive_energy;
                    v3.honey_health = v3.temp_honey_health;
                };
                0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_school_with_honey(arg0, arg3, arg5, &mut v3.mystical_bee, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut arg7, (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v3.honey_health as u256), (0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg7) as u256), (arg6.active_honey_health as u256)) as u64)));
                0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::charge_mystical_bee(&arg1.dragon_food_cap, &mut v3.mystical_bee, (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v3.hive_energy as u256), (arg8 as u256), (arg6.active_hive_energy as u256)) as u64));
                let (v4, v5) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_bee_power(&v3.mystical_bee);
                v3.increment_cycle = arg1.ongoing_cycle;
                v3.temp_hive_energy = v4;
                v3.temp_honey_health = v5;
                v1 = v1 + ((v4 - 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v3.hive_energy, v3.temp_hive_energy)) as u128);
                v2 = v2 + ((v5 - 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v3.honey_health, v3.temp_honey_health)) as u128);
                v0 = v0 + 1;
            };
            arg6.increment_cycle = arg1.ongoing_cycle;
            arg6.increase_in_energy = arg6.increase_in_energy + v1;
            arg6.increase_in_health = arg6.increase_in_health + v2;
            arg1.added_hive_energy = arg1.added_hive_energy + v1;
            arg1.added_honey_health = arg1.added_honey_health + v2;
            arg2.added_hive_energy = arg2.added_hive_energy + v1;
            arg2.added_honey_health = arg2.added_honey_health + v2;
            let v6 = AddHiveAndEnergyForNextCycle{
                pool_hive_addr         : 0x2::object::uid_to_address(&arg2.id),
                trainer_addr           : arg4,
                increment_cycle        : arg6.increment_cycle,
                net_energy_increase    : v1,
                net_health_increase    : v2,
                new_increase_in_energy : arg6.increase_in_energy,
                new_increase_in_health : arg6.increase_in_health,
            };
            0x2::event::emit<AddHiveAndEnergyForNextCycle>(v6);
        } else {
            assert!(0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg7) == 0, 7050);
        };
        0x2::balance::destroy_zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(arg7);
    }

    public fun game_master_add_hive_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg6);
        let (v4, v5, v6, v7) = internal_add_hive_to_dragon_bee<T0>(arg0, arg1, arg2, arg3, v0, arg5, 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v3, arg7), arg8);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_dragon_school(arg4, v7);
        let v8 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg8);
        let v9 = &mut v8;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, v4);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v8);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v3, v5);
        v3
    }

    public fun game_master_add_honey_to_locked_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::HoneyManager<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg7: &mut 0x2::token::TokenPolicy<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg8: &mut 0x2::token::Token<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::honey_trade::unwrap_honey_tokens_to_coins(&arg1.dragon_food_cap, arg6, arg7, arg8, arg9, arg10));
        let (v4, v5, v6, v7) = internal_add_honey_to_dragon_bee<T0>(arg0, arg1, arg2, arg3, v0, arg5, v3, arg10);
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_honey_in_dragon_school(arg4, v7);
        let v8 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg10);
        let v9 = &mut v8;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, v4);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v8);
        v5
    }

    public fun game_master_feed_bee_in_den<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let (v3, v4) = internal_lock_dragon_bee<T0>(arg1, arg3, arg5, v0, arg6);
        let v5 = v3;
        let v6 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg6);
        let v7 = &mut v6;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v7, v4, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v5));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v6);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        v5
    }

    public fun game_master_request_withdrawal_for_dragon_bee<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg2);
        internal_process_withdrawl_request<T0>(arg0, arg1, v0, arg3, arg4);
    }

    public fun game_master_withdraw_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>) {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let (v3, v4, v5) = internal_withdraw_dragon_bee<T0>(arg1, arg3, v0, arg5, arg6);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = access_dragon_den<T0>(arg3, v0, arg6);
        if (0x1::vector::length<u64>(&v9.locked_bees) == 0 && 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v6) > 0) {
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::charge_mystical_bee(&arg1.dragon_food_cap, &mut v8, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7));
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_school_with_honey(arg0, arg2, arg4, &mut v8, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v6));
        };
        let v10 = &mut v9;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v9);
        (v8, v7)
    }

    public fun get_bees_list_in_dragons_den<T0>(arg0: &PoolHive<T0>, arg1: address) : (vector<u64>, vector<u64>) {
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v0 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1);
        (v0.locked_bees, v0.unlocking_bees)
    }

    public fun get_bribes_for_pool_hive<T0, T1>(arg0: &PoolHive<T0>, arg1: u64) : (u64, u64, u64, u64, u64) {
        let v0 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v1 = 0x2::dynamic_object_field::borrow<0x1::string::String, VotingBribes<T1>>(&arg0.id, v0);
        let v2 = 0;
        let v3 = 0;
        if (0x2::linked_table::contains<u64, u64>(&v1.cycle_to_hive_bribes_map, arg1)) {
            v2 = *0x2::linked_table::borrow<u64, u64>(&v1.cycle_to_hive_bribes_map, arg1);
            v3 = *0x2::linked_table::borrow<u64, u64>(&v1.cycle_to_honey_bribes_map, arg1);
        };
        let v4 = 0;
        let v5 = *0x2::linked_table::front<u64, u64>(&v1.cycle_to_hive_bribes_map);
        let v6 = 0;
        let v7 = *0x2::linked_table::back<u64, u64>(&v1.cycle_to_hive_bribes_map);
        if (0x1::option::is_some<u64>(&v5)) {
            v4 = *0x1::option::borrow<u64>(&v5);
        };
        if (0x1::option::is_some<u64>(&v7)) {
            v6 = *0x1::option::borrow<u64>(&v7);
        };
        (0x2::balance::value<T1>(&v1.bribe), v2, v3, v4, v6)
    }

    public fun get_claimed_fee_indexes_for_user<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: u64) : (u256, u256) {
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1);
        if (!0x2::linked_table::contains<u64, u256>(&v0.hive_fee_claim_indexes, arg2)) {
            return (0, 0)
        };
        (*0x2::linked_table::borrow<u64, u256>(&v0.hive_fee_claim_indexes, arg2), *0x2::linked_table::borrow<u64, u256>(&v0.honey_fee_claim_indexes, arg2))
    }

    public fun get_dragon_food(arg0: &DragonFood) : (address, u64, u64, u64, u64, u64, u64, u64, u64) {
        (0x2::object::uid_to_address(&arg0.id), 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&arg0.hive_available), 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg0.honey_available), arg0.ongoing_cycle, arg0.cur_cycle_start_epoch, arg0.cycle_duration, arg0.max_dragonbees_per_psn, arg0.active_pool_hives, arg0.module_version)
    }

    public fun get_dragon_food_changes(arg0: &DragonFood) : (u64, u128, u128, u128, u128) {
        (arg0.ongoing_cycle, arg0.added_hive_energy, arg0.removed_hive_energy, arg0.added_honey_health, arg0.removed_honey_health)
    }

    fun get_expected_yield<T0>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: &DragonsDen<T0>, arg3: u64) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3) = get_votes_rcvd_for_cycle<T0>(arg0, arg1, arg0.ongoing_cycle);
        let v4 = arg3 - arg1.last_claim_epoch;
        let v5 = arg3 - arg1.last_claim_honey_epoch;
        let v6 = arg1.global_hive_claim_index;
        let v7 = v6;
        let v8 = 0;
        let v9 = if (v0 > 0) {
            if (v4 > 0) {
                arg1.total_staked > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v9) {
            let v10 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((((0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg0.emissions.hive_per_epoch as u256), (v0 as u256), (v1 as u256)) as u64) * v4) as u256), (1000000 as u256), (arg1.total_staked as u256));
            v7 = v6 + v10;
            v8 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1.total_staked as u256), (v10 as u256), (1000000 as u256)) as u64);
        };
        let v11 = arg1.global_honey_claim_index;
        let v12 = v11;
        let v13 = 0;
        let v14 = if (v2 > 0) {
            if (v5 > 0) {
                arg1.staked_for_honey > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v14) {
            let v15 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((((0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg0.emissions.honey_per_epoch as u256), (v2 as u256), (v3 as u256)) as u64) * v5) as u256), (1000000 as u256), (arg1.staked_for_honey as u256));
            v12 = v11 + v15;
            v13 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((arg1.staked_for_honey as u256), (v15 as u256), (1000000 as u256)) as u64);
        };
        let v16 = 0x2::balance::value<T0>(&arg2.staked_balance);
        let v17 = 0;
        let v18 = 0;
        if (v16 > 0 && v7 > arg2.hive_claim_index) {
            v17 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v16 as u256), ((v7 - arg2.hive_claim_index) as u256), (1000000 as u256)) as u64);
        };
        let v19 = if (v16 > 0) {
            if (0x1::vector::length<u64>(&arg2.locked_bees) > 0) {
                v12 > arg2.honey_claim_index
            } else {
                false
            }
        } else {
            false
        };
        if (v19) {
            v18 = (0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div_u256((v16 as u256), ((v12 - arg2.honey_claim_index) as u256), (1000000 as u256)) as u64);
        };
        (v13, v8, v18, v17)
    }

    public fun get_food_emissions(arg0: &DragonFood) : (u64, u64, u64, u64) {
        (arg0.emissions.start_epoch, arg0.emissions.hive_per_epoch, arg0.emissions.honey_per_epoch, arg0.emissions.change_pct_per_cycle)
    }

    public fun get_hive_emissions_votes(arg0: &DragonFood, arg1: u64) : (u128, u128, u128) {
        (*0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_increase_votes, arg1), *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_decrease_votes, arg1), *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_same_votes, arg1))
    }

    public fun get_honey_emissions_votes(arg0: &DragonFood, arg1: u64) : (u128, u128, u128) {
        (*0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_increase_votes, arg1), *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_decrease_votes, arg1), *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_same_votes, arg1))
    }

    public fun get_locked_bees_info<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: u64) : (u64, 0x1::string::String, address, u64, u256, u64, u64, address, 0x1::option::Option<address>, 0x1::option::Option<address>, bool, u64, bool, u64, u8, u64, u8, u64, u128, u64, u64, u64, u128, u64, u64, u64, u64, u64, bool) {
        let v0 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29) = if (0x2::linked_table::contains<u64, LockedDragonBee>(&v0.dragon_bees, arg2)) {
            let (v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_bee_info(&0x2::linked_table::borrow<u64, LockedDragonBee>(&v0.dragon_bees, arg2).mystical_bee);
            (v30, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v31, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v32, v33, v34, v35, v36, v37, v38)
        } else {
            (0, 0x1::option::none<address>(), false, 0, false, 0, 0, 0, 0, 0, 0, 0x1::string::utf8(b"0x0"), 0, 0, 0, 0, 0, 0, 0, 0, 0, false, @0x0, 0, 0, 0, 0, @0x0, 0x1::option::none<address>())
        };
        (v1, v12, v23, v24, v25, v26, v27, v28, v29, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22)
    }

    public fun get_locked_dragon_bees_vote_info<T0>(arg0: &PoolHive<T0>, arg1: address, arg2: 0x1::option::Option<u64>, arg3: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, vector<u128>, vector<u64>, vector<u128>, vector<u128>, u64) {
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u128>(), 0)
        };
        let v0 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg0.resting_dragons, arg1);
        if (0x1::vector::length<u64>(&v0.locked_bees) == 0) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0x1::vector::empty<u128>(), 0)
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<u128>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0x1::vector::empty<u128>();
        let v8 = 0x1::vector::empty<u128>();
        let v9 = if (0x1::option::is_some<u64>(&arg2)) {
            arg2
        } else {
            *0x2::linked_table::front<u64, LockedDragonBee>(&v0.dragon_bees)
        };
        let v10 = 0;
        while (0x1::option::is_some<u64>(&v9) && v10 < arg3) {
            let v11 = 0x1::option::borrow<u64>(&v9);
            let v12 = 0x2::linked_table::borrow<u64, LockedDragonBee>(&v0.dragon_bees, *v11);
            0x1::vector::push_back<u64>(&mut v1, v12.version);
            0x1::vector::push_back<u64>(&mut v2, v12.locked_at_cycle);
            0x1::vector::push_back<u64>(&mut v3, v12.withdrawable_at_cycle);
            0x1::vector::push_back<u128>(&mut v4, v12.hive_energy);
            0x1::vector::push_back<u128>(&mut v5, v12.honey_health);
            0x1::vector::push_back<u64>(&mut v6, v12.increment_cycle);
            0x1::vector::push_back<u128>(&mut v7, v12.temp_hive_energy);
            0x1::vector::push_back<u128>(&mut v8, v12.temp_honey_health);
            v9 = *0x2::linked_table::next<u64, LockedDragonBee>(&v0.dragon_bees, *v11);
            v10 = v10 + 1;
        };
        (v1, v2, v3, v4, v5, v6, v7, v8, 0x1::vector::length<u64>(&v0.locked_bees))
    }

    public fun get_ongoing_cycle(arg0: &DragonFood) : (u64, u64, u64) {
        (arg0.ongoing_cycle, arg0.cur_cycle_start_epoch, arg0.cycle_duration)
    }

    public fun get_pool_hive<T0>(arg0: &PoolHive<T0>) : (u64, u64, u64, u64, u256, u256, u64, u64, vector<0x1::string::String>, u64, u64, u64, u64, u64, u128, u64, u128, u64, vector<0x1::ascii::String>) {
        let v0 = *0x2::linked_table::back<u64, u128>(&arg0.active_hive_energy);
        let v1 = 0;
        if (0x1::option::is_some<u64>(&v0)) {
            v1 = *0x2::linked_table::borrow<u64, u128>(&arg0.active_hive_energy, *0x1::option::borrow<u64>(&v0));
        };
        let v2 = *0x2::linked_table::back<u64, u128>(&arg0.active_honey_health);
        let v3 = 0;
        if (0x1::option::is_some<u64>(&v2)) {
            v3 = *0x2::linked_table::borrow<u64, u128>(&arg0.active_honey_health, *0x1::option::borrow<u64>(&v2));
        };
        let v4 = *0x2::linked_table::back<u64, u256>(&arg0.bribes.hive_fee_claim_indexes);
        let v5 = *0x2::linked_table::back<u64, u256>(&arg0.bribes.honey_fee_claim_indexes);
        let v6 = 0;
        let v7 = 0;
        if (0x1::option::is_some<u64>(&v4)) {
            v6 = *0x1::option::borrow<u64>(&v4);
        };
        if (0x1::option::is_some<u64>(&v5)) {
            v7 = *0x1::option::borrow<u64>(&v5);
        };
        (arg0.total_staked, arg0.staked_for_honey, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg0.honey_available), 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&arg0.hive_available), arg0.global_honey_claim_index, arg0.global_hive_claim_index, arg0.last_claim_epoch, arg0.last_claim_honey_epoch, arg0.bribes.voting_bribes, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&arg0.bribes.hive_bribe), 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg0.bribes.honey_bribe), v6, v7, *0x1::option::borrow<u64>(&v0), v1, *0x1::option::borrow<u64>(&v2), v3, arg0.next_proposal_id, arg0.additional_rewards)
    }

    public fun get_pool_hive_addr<T0>(arg0: &DragonFood) : address {
        *0x2::linked_table::borrow<0x1::ascii::String, address>(&arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_pool_hive_changes<T0>(arg0: &PoolHive<T0>) : (u64, u128, u128, u128, u128) {
        (arg0.ongoing_cycle, arg0.added_hive_energy, arg0.removed_hive_energy, arg0.added_honey_health, arg0.removed_honey_health)
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

    public fun get_total_votes_for_directing_emissions(arg0: &DragonFood, arg1: u64) : (u128, u128) {
        (*0x2::linked_table::borrow<u64, u128>(&arg0.total_hive_energy, arg1), *0x2::linked_table::borrow<u64, u128>(&arg0.total_honey_health, arg1))
    }

    public fun get_user_unbonding_positions<T0>(arg0: &PoolHive<T0>, arg1: address) : (vector<u64>, vector<u64>) {
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, UnbondingPositions<T0>>(&arg0.id, 0x1::string::utf8(b"UNBONDING_PSN"));
        if (!0x2::linked_table::contains<address, UserUnbondingPsn>(&v0.user_psns, arg1)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>())
        };
        let v1 = 0x2::linked_table::borrow<address, UserUnbondingPsn>(&v0.user_psns, arg1);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = *0x2::linked_table::front<u64, u64>(&v1.unlocking_amts);
        while (0x1::option::is_some<u64>(&v4)) {
            let v5 = *0x1::option::borrow<u64>(&v4);
            0x1::vector::push_back<u64>(&mut v2, v5);
            0x1::vector::push_back<u64>(&mut v3, *0x2::linked_table::borrow<u64, u64>(&v1.unlocking_amts, v5));
            v4 = *0x2::linked_table::next<u64, u64>(&v1.unlocking_amts, v5);
        };
        (v2, v3)
    }

    public fun get_user_vote_info<T0>(arg0: &PoolHive<T0>, arg1: u64, arg2: address) : (bool, bool, u64) {
        let v0 = 0x2::linked_table::borrow<u64, Proposal>(&arg0.proposal_list, arg1);
        if (!0x2::linked_table::contains<address, Vote>(&v0.voters, arg2)) {
            return (false, false, 0)
        };
        let v1 = 0x2::linked_table::borrow<address, Vote>(&v0.voters, arg2);
        (true, v1.vote, v1.staked_amt)
    }

    public fun get_vote_config(arg0: &DragonFood) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.vote_config.proposal_required_deposit, arg0.vote_config.voting_start_delay, arg0.vote_config.voting_period_length, arg0.vote_config.execution_delay, arg0.vote_config.execution_period_length, arg0.vote_config.proposal_required_quorum, arg0.vote_config.proposal_approval_threshold)
    }

    public fun get_votes_rcvd_for_cycle<T0>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: u64) : (u128, u128, u128, u128) {
        let v0 = arg2 - 1;
        let v1 = 0;
        let v2 = 0;
        if (0x2::linked_table::contains<u64, u128>(&arg1.active_hive_energy, v0)) {
            v1 = *0x2::linked_table::borrow<u64, u128>(&arg1.active_hive_energy, v0);
        };
        if (0x2::linked_table::contains<u64, u128>(&arg1.active_honey_health, v0)) {
            v2 = *0x2::linked_table::borrow<u64, u128>(&arg1.active_honey_health, v0);
        };
        let v3 = 0;
        let v4 = 0;
        if (0x2::linked_table::contains<u64, u128>(&arg0.total_hive_energy, v0)) {
            v3 = *0x2::linked_table::borrow<u64, u128>(&arg0.total_hive_energy, v0);
        };
        if (0x2::linked_table::contains<u64, u128>(&arg0.total_honey_health, v0)) {
            v4 = *0x2::linked_table::borrow<u64, u128>(&arg0.total_honey_health, v0);
        };
        (v1, v3, v2, v4)
    }

    public fun get_votes_recvd_by_pool_hive_for_cycle<T0>(arg0: &PoolHive<T0>, arg1: u64) : (u128, u128) {
        let v0 = 0;
        let v1 = 0;
        if (0x2::linked_table::contains<u64, u128>(&arg0.active_hive_energy, arg1)) {
            v0 = *0x2::linked_table::borrow<u64, u128>(&arg0.active_hive_energy, arg1);
        };
        if (0x2::linked_table::contains<u64, u128>(&arg0.active_honey_health, arg1)) {
            v1 = *0x2::linked_table::borrow<u64, u128>(&arg0.active_honey_health, arg1);
        };
        (v0, v1)
    }

    public fun get_voting_info_for_dragons_den<T0>(arg0: &DragonFood, arg1: &PoolHive<T0>, arg2: address, arg3: &0x2::tx_context::TxContext) : (u64, u256, u256, u64, u64, u128, u128, u64, u128, u128, u128, u128, u64, u64, u64, u64, u64) {
        if (!0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2)) {
            return (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2);
        (0x2::balance::value<T0>(&v0.staked_balance), v0.honey_claim_index, v0.hive_claim_index, 0x1::vector::length<u64>(&v0.locked_bees), 0x1::vector::length<u64>(&v0.unlocking_bees), v0.active_hive_energy, v0.active_honey_health, v0.increment_cycle, v0.increase_in_energy, v0.increase_in_health, v0.decrease_in_energy, v0.decrease_in_health, v0.dao_vote_cycle, v0.bribes_claimed_till, v0.fees_claimed_till, 0x2::linked_table::length<u64, u256>(&v0.hive_fee_claim_indexes), 0x2::linked_table::length<u64, u256>(&v0.honey_fee_claim_indexes))
    }

    public entry fun increment_dragon_food(arg0: &mut DragonFood) {
        assert!(arg0.module_version < 3, 7039);
        arg0.module_version = 3;
    }

    public entry fun increment_pool_hive<T0>(arg0: &mut PoolHive<T0>) {
        assert!(arg0.module_version < 3, 7039);
        arg0.module_version = 3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingPoolCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LendingPoolCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_dragon_food_emissions(arg0: 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonFoodCapability, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0x2::tx_context::epoch(arg13), 7000);
        assert!(arg7 < 100 && arg8 < 100, 7048);
        let v0 = 1;
        let v1 = EmissionSchedule{
            start_epoch          : arg1,
            hive_per_epoch       : 0,
            honey_per_epoch      : 0,
            change_pct_per_cycle : arg12,
            hive_increase_votes  : 0x2::linked_table::new<u64, u128>(arg13),
            hive_decrease_votes  : 0x2::linked_table::new<u64, u128>(arg13),
            hive_same_votes      : 0x2::linked_table::new<u64, u128>(arg13),
            honey_increase_votes : 0x2::linked_table::new<u64, u128>(arg13),
            honey_decrease_votes : 0x2::linked_table::new<u64, u128>(arg13),
            honey_same_votes     : 0x2::linked_table::new<u64, u128>(arg13),
        };
        let v2 = VoteConfig{
            proposal_required_deposit   : arg2,
            voting_start_delay          : arg3,
            voting_period_length        : arg4,
            execution_delay             : arg5,
            execution_period_length     : arg6,
            proposal_required_quorum    : 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(1000000, arg7, 100),
            proposal_approval_threshold : 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(1000000, arg8, 100),
        };
        let v3 = DragonFood{
            id                     : 0x2::object::new(arg13),
            dragon_food_cap        : arg0,
            emissions              : v1,
            hive_available         : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            honey_available        : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            ongoing_cycle          : v0,
            cur_cycle_start_epoch  : arg9,
            cycle_duration         : arg10,
            max_dragonbees_per_psn : arg11,
            added_hive_energy      : 0,
            total_hive_energy      : 0x2::linked_table::new<u64, u128>(arg13),
            removed_hive_energy    : 0,
            added_honey_health     : 0,
            total_honey_health     : 0x2::linked_table::new<u64, u128>(arg13),
            removed_honey_health   : 0,
            vote_config            : v2,
            active_pool_hives      : 0,
            pool_hives             : 0x2::linked_table::new<0x1::ascii::String, address>(arg13),
            module_version         : 3,
        };
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.hive_same_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.hive_increase_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.hive_decrease_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.honey_same_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.honey_increase_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.emissions.honey_decrease_votes, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.total_hive_energy, v0, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v3.total_honey_health, v0, 0);
        0x2::transfer::share_object<DragonFood>(v3);
    }

    fun internal_add_hive_to_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: address, arg5: u64, arg6: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        let v0 = 0x2::tx_context::epoch(arg7);
        update_food_cycle(arg1, arg7);
        update_food_cycle_for_pool_hive<T0>(arg1, arg3, arg7);
        let v1 = access_dragon_den<T0>(arg3, arg4, arg7);
        let v2 = &mut v1;
        update_votes_for_locked_bees<T0>(arg1, arg4, v2);
        assert!(v1.bribes_claimed_till == arg1.ongoing_cycle && v1.fees_claimed_till == arg1.ongoing_cycle, 7064);
        assert!(0x2::linked_table::contains<u64, LockedDragonBee>(&v1.dragon_bees, arg5), 7052);
        let v3 = &mut v1;
        let (v4, v5) = accrue_yield_for_dragon_den<T0>(arg1, arg3, v3, v0, arg7);
        let v6 = v4;
        let (v7, v8) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::dragon_food_infuse_bee_with_energy(&arg1.dragon_food_cap, arg0, arg2, &mut 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut v1.dragon_bees, arg5).mystical_bee, arg6);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v6, v7);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v1);
        (0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v6), v6, v5, v8)
    }

    fun internal_add_honey_to_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: address, arg5: u64, arg6: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        let v0 = 0x2::tx_context::epoch(arg7);
        update_food_cycle(arg1, arg7);
        update_food_cycle_for_pool_hive<T0>(arg1, arg3, arg7);
        let v1 = access_dragon_den<T0>(arg3, arg4, arg7);
        let v2 = &mut v1;
        update_votes_for_locked_bees<T0>(arg1, arg4, v2);
        assert!(v1.bribes_claimed_till == arg1.ongoing_cycle && v1.fees_claimed_till == arg1.ongoing_cycle, 7064);
        assert!(0x2::linked_table::contains<u64, LockedDragonBee>(&v1.dragon_bees, arg5), 7052);
        let v3 = &mut v1;
        let (v4, v5) = accrue_yield_for_dragon_den<T0>(arg1, arg3, v3, v0, arg7);
        let v6 = v4;
        let (v7, v8) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::dragon_food_infuse_bee_with_health(&arg1.dragon_food_cap, arg0, arg2, &mut 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut v1.dragon_bees, arg5).mystical_bee, arg6);
        0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v6, v7);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v1);
        (0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v6), v6, v5, v8)
    }

    fun internal_castVote<T0>(arg0: &mut PoolHive<T0>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg3), 7024);
        let v1 = 0x2::linked_table::borrow_mut<u64, Proposal>(&mut arg0.proposal_list, arg3);
        assert!(v0 >= v1.voting_start_epoch && v0 <= v1.voting_end_epoch, 7025);
        if (v1.proposal_status == 0) {
            v1.proposal_status = 1;
        };
        let v2 = 0x2::balance::value<T0>(&0x2::linked_table::borrow_mut<address, DragonsDen<T0>>(&mut arg0.resting_dragons, arg1).staked_balance);
        assert!(v2 > 0, 7026);
        if (0x2::linked_table::contains<address, Vote>(&v1.voters, arg1)) {
            let v3 = 0x2::linked_table::remove<address, Vote>(&mut v1.voters, arg1);
            if (v3.vote) {
                v1.yes_votes = v1.yes_votes - v3.staked_amt;
            } else {
                v1.no_votes = v1.no_votes - v3.staked_amt;
            };
        };
        if (arg4 == true) {
            v1.yes_votes = v1.yes_votes + v2;
        } else {
            v1.no_votes = v1.no_votes + v2;
        };
        let v4 = Vote{
            vote       : arg4,
            staked_amt : v2,
        };
        0x2::linked_table::push_back<address, Vote>(&mut v1.voters, arg1, v4);
        let v5 = VoteCasted{
            pool_hive_addr : 0x2::object::uid_to_address(&arg0.id),
            proposal_id    : v1.proposal_id,
            voter          : arg2,
            voter_trainer  : arg1,
            vote           : arg4,
            staked_amt     : v2,
            yes_votes      : v1.yes_votes,
            no_votes       : v1.no_votes,
            total_staked   : arg0.total_staked,
        };
        0x2::event::emit<VoteCasted>(v5);
    }

    fun internal_claim_voting_rewards_three_pool<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg2: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg3: &mut PoolHive<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, u64, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        update_food_cycle(arg0, arg5);
        update_food_cycle_for_pool_hive<T0>(arg0, arg3, arg5);
        let v0 = access_dragon_den<T0>(arg3, arg4, arg5);
        let v1 = &mut v0;
        update_votes_for_locked_bees<T0>(arg0, arg4, v1);
        if (0x1::vector::length<u64>(&v0.locked_bees) == 0 || v0.active_hive_energy == 0 && v0.active_honey_health == 0) {
            v0.bribes_claimed_till = arg0.ongoing_cycle;
            v0.fees_claimed_till = arg0.ongoing_cycle;
            0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v0);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T2>(), 0x2::balance::zero<T3>(), 0, 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(), 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(), 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>())
        };
        let v2 = (v0.active_hive_energy as u256);
        let v3 = (v0.active_honey_health as u256);
        let v4 = arg0.ongoing_cycle;
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14) = compute_bribes_for_user<T0, T1, T2, T3>(arg3, v2, v3, v0.bribes_claimed_till + 1, v4, true);
        let (v15, _, v17, _, v19, _) = claim_bribes_for_user<T0, T1, T2, T3>(arg3, v12, v13, v14, true);
        let v21 = v19;
        let v22 = v17;
        let v23 = v15;
        v0.bribes_claimed_till = v4;
        let v24 = BribeClaimedByTrainerThreePool{
            pool_hive_addr         : 0x2::object::uid_to_address(&arg3.id),
            trainer_addr           : arg4,
            claimed_cycles         : v5,
            claimed_hive_bribes_a  : v6,
            claimed_honey_bribes_a : v7,
            claimed_hive_bribes_b  : v8,
            claimed_honey_bribes_b : v9,
            claimed_hive_bribes_c  : v10,
            claimed_honey_bribes_c : v11,
            bribe_a_bal            : 0x2::balance::value<T1>(&v23),
            bribe_b_bal            : 0x2::balance::value<T2>(&v22),
            bribe_c_bal            : 0x2::balance::value<T3>(&v21),
        };
        0x2::event::emit<BribeClaimedByTrainerThreePool>(v24);
        let v25 = arg0.ongoing_cycle;
        claim_fees_from_yield_flow_for_pool<T0>(arg0, arg2, arg3, arg5);
        let v26 = &mut v0;
        let (v27, v28, v29, v30, v31) = claim_trading_fees_for_user<T0>(arg3, v26, v2, v3, v0.fees_claimed_till, v25);
        let v32 = v31;
        let v33 = v30;
        v0.fees_claimed_till = v25;
        let v34 = TradingFeeClaimedByTrainer{
            pool_hive_addr     : 0x2::object::uid_to_address(&arg3.id),
            trainer_addr       : arg4,
            claimed_cycles     : v27,
            claimed_hive_fees  : v28,
            claimed_honey_fees : v29,
            hive_fee_bal       : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v33),
            honey_fee_bal      : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v32),
        };
        0x2::event::emit<TradingFeeClaimedByTrainer>(v34);
        let v35 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>();
        let v36 = 0;
        while (v36 < 0x1::vector::length<u64>(&v0.locked_bees)) {
            let (v37, v38) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::dragon_food_claim_gov_yield(&arg0.dragon_food_cap, arg1, &mut 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut v0.dragon_bees, *0x1::vector::borrow<u64>(&v0.locked_bees, v36)).mystical_bee);
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v33, v37);
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v35, v38);
            v36 = v36 + 1;
        };
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v0);
        (v23, v22, v21, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v33), v33, v32, v35)
    }

    fun internal_claim_voting_rewards_two_pool<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg2: &mut 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::YieldFlow, arg3: &mut PoolHive<T0>, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, u64, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        update_food_cycle(arg0, arg6);
        update_food_cycle_for_pool_hive<T0>(arg0, arg3, arg6);
        let v0 = access_dragon_den<T0>(arg3, arg4, arg6);
        let v1 = &mut v0;
        update_votes_for_locked_bees<T0>(arg0, arg4, v1);
        let v2 = if (0x1::vector::length<u64>(&v0.locked_bees) == 0) {
            true
        } else if (v0.active_hive_energy == 0) {
            if (v0.active_honey_health == 0) {
                0x1::vector::length<u64>(&v0.unlocking_bees) == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            v0.bribes_claimed_till = arg0.ongoing_cycle;
            v0.fees_claimed_till = arg0.ongoing_cycle;
            0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v0);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T2>(), 0, 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(), 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(), 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>())
        };
        let v3 = (v0.active_hive_energy as u256);
        let v4 = (v0.active_honey_health as u256);
        let v5 = arg0.ongoing_cycle;
        let (v6, v7, v8, v9, v10, _, _, v13, v14, v15) = compute_bribes_for_user<T0, T1, T2, T2>(arg3, v3, v4, v0.bribes_claimed_till + 1, v5, false);
        let (v16, v17, v18, v19, v20, _) = claim_bribes_for_user<T0, T1, T2, T2>(arg3, v13, v14, v15, false);
        let v22 = v18;
        let v23 = v16;
        0x2::balance::destroy_zero<T2>(v20);
        if (v17 || v19) {
            assert!(arg5, 7069);
        };
        v0.bribes_claimed_till = v5;
        let v24 = BribeClaimedByTrainerTwoPool{
            pool_hive_addr         : 0x2::object::uid_to_address(&arg3.id),
            trainer_addr           : arg4,
            claimed_cycles         : v6,
            claimed_hive_bribes_a  : v7,
            claimed_honey_bribes_a : v8,
            claimed_hive_bribes_b  : v9,
            claimed_honey_bribes_b : v10,
            bribe_a_bal            : 0x2::balance::value<T1>(&v23),
            bribe_b_bal            : 0x2::balance::value<T2>(&v22),
        };
        0x2::event::emit<BribeClaimedByTrainerTwoPool>(v24);
        let v25 = arg0.ongoing_cycle;
        claim_fees_from_yield_flow_for_pool<T0>(arg0, arg2, arg3, arg6);
        let v26 = &mut v0;
        let (v27, v28, v29, v30, v31) = claim_trading_fees_for_user<T0>(arg3, v26, v3, v4, v0.fees_claimed_till, v25);
        let v32 = v31;
        let v33 = v30;
        v0.fees_claimed_till = v25;
        let v34 = TradingFeeClaimedByTrainer{
            pool_hive_addr     : 0x2::object::uid_to_address(&arg3.id),
            trainer_addr       : arg4,
            claimed_cycles     : v27,
            claimed_hive_fees  : v28,
            claimed_honey_fees : v29,
            hive_fee_bal       : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v33),
            honey_fee_bal      : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v32),
        };
        0x2::event::emit<TradingFeeClaimedByTrainer>(v34);
        let v35 = 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>();
        let v36 = 0;
        while (v36 < 0x1::vector::length<u64>(&v0.locked_bees)) {
            let (v37, v38) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::dragon_food_claim_gov_yield(&arg0.dragon_food_cap, arg1, &mut 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut v0.dragon_bees, *0x1::vector::borrow<u64>(&v0.locked_bees, v36)).mystical_bee);
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v33, v37);
            0x2::balance::join<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v35, v38);
            v36 = v36 + 1;
        };
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, arg4, v0);
        (v23, v22, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v33), v33, v32, v35)
    }

    fun internal_deposit_no_fruits<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: 0x2::balance::Balance<T0>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg6);
        stake_lp<T0>(arg4, arg5, arg0, arg1, arg2, arg3, v0, arg6)
    }

    fun internal_deposit_with_1_fruits<T0, T1>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: 0x2::balance::Balance<T0>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 1, 7006);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v2 = claim_fruit_for_dragons_den<T0, T1>(v1, arg2, 0x2::object::uid_to_address(&arg1.id), arg1.total_staked, v0, arg4, arg5, false);
        let (v3, v4) = stake_lp<T0>(arg4, arg5, arg0, arg1, arg2, arg3, v0, arg6);
        (v3, v4, v2)
    }

    fun internal_deposit_with_2_fruits<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: 0x2::balance::Balance<T0>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 2, 7006);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v3 = claim_fruit_for_dragons_den<T0, T1>(v2, arg2, v1, arg1.total_staked, v0, arg4, arg5, false);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v5 = claim_fruit_for_dragons_den<T0, T2>(v4, arg2, v1, arg1.total_staked, v0, arg4, arg5, false);
        let (v6, v7) = stake_lp<T0>(arg4, arg5, arg0, arg1, arg2, arg3, v0, arg6);
        (v6, v7, v3, v5)
    }

    fun internal_deposit_with_3_fruits<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: 0x2::balance::Balance<T0>, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 3, 7006);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v3 = claim_fruit_for_dragons_den<T0, T1>(v2, arg2, v1, arg1.total_staked, v0, arg4, arg5, false);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v5 = claim_fruit_for_dragons_den<T0, T2>(v4, arg2, v1, arg1.total_staked, v0, arg4, arg5, false);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T3>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v7 = claim_fruit_for_dragons_den<T0, T3>(v6, arg2, v1, arg1.total_staked, v0, arg4, arg5, false);
        let (v8, v9) = stake_lp<T0>(arg4, arg5, arg0, arg1, arg2, arg3, v0, arg6);
        (v8, v9, v3, v5, v7)
    }

    fun internal_lock_dragon_bee<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        let v0 = 0x2::tx_context::epoch(arg4);
        let v1 = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_bee_version(&arg2);
        update_food_cycle(arg0, arg4);
        update_food_cycle_for_pool_hive<T0>(arg0, arg1, arg4);
        let v2 = access_dragon_den<T0>(arg1, arg3, arg4);
        let v3 = &mut v2;
        update_votes_for_locked_bees<T0>(arg0, arg3, v3);
        let v4 = if (v2.active_hive_energy > 0) {
            true
        } else if (v2.active_honey_health > 0) {
            true
        } else {
            0x1::vector::length<u64>(&v2.locked_bees) > 0
        };
        if (v4) {
            assert!(v2.bribes_claimed_till == arg0.ongoing_cycle && v2.fees_claimed_till == arg0.ongoing_cycle, 7064);
        } else {
            v2.fees_claimed_till = arg0.ongoing_cycle;
            v2.bribes_claimed_till = arg0.ongoing_cycle;
            v2.honey_claim_index = arg1.global_honey_claim_index;
        };
        assert!(0x1::vector::length<u64>(&v2.locked_bees) < arg0.max_dragonbees_per_psn, 7070);
        let v5 = &mut v2;
        let (v6, v7) = accrue_yield_for_dragon_den<T0>(arg0, arg1, v5, v0, arg4);
        let v8 = v7;
        let v9 = v6;
        let (v10, v11) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_bee_power(&arg2);
        if (0x1::vector::length<u64>(&v2.locked_bees) == 0) {
            arg1.staked_for_honey = arg1.staked_for_honey + 0x2::balance::value<T0>(&v2.staked_balance);
        };
        let v12 = LockedDragonBee{
            version               : v1,
            mystical_bee          : arg2,
            locked_at_cycle       : arg0.ongoing_cycle,
            withdrawable_at_cycle : 0,
            hive_energy           : 0,
            honey_health          : 0,
            increment_cycle       : arg0.ongoing_cycle,
            temp_hive_energy      : v10,
            temp_honey_health     : v11,
        };
        0x1::vector::push_back<u64>(&mut v2.locked_bees, v1);
        0x2::linked_table::push_back<u64, LockedDragonBee>(&mut v2.dragon_bees, v1, v12);
        v2.increment_cycle = arg0.ongoing_cycle;
        v2.increase_in_energy = v2.increase_in_energy + v10;
        v2.increase_in_health = v2.increase_in_health + v11;
        arg0.added_hive_energy = arg0.added_hive_energy + v10;
        arg0.added_honey_health = arg0.added_honey_health + v11;
        arg1.added_hive_energy = arg1.added_hive_energy + v10;
        arg1.added_honey_health = arg1.added_honey_health + v11;
        let v13 = FeedingFoodToBee{
            pool_hive_addr   : 0x2::object::uid_to_address(&arg1.id),
            trainer_addr     : arg3,
            bee_version      : v1,
            locked_at_cycle  : arg0.ongoing_cycle,
            hive_earned      : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v9),
            honey_earned     : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v8),
            staked_for_honey : arg1.staked_for_honey,
        };
        0x2::event::emit<FeedingFoodToBee>(v13);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg1.resting_dragons, arg3, v2);
        (v9, v8)
    }

    fun internal_process_withdrawl_request<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        update_food_cycle(arg0, arg4);
        update_food_cycle_for_pool_hive<T0>(arg0, arg1, arg4);
        let v0 = access_dragon_den<T0>(arg1, arg2, arg4);
        let v1 = &mut v0;
        update_votes_for_locked_bees<T0>(arg0, arg2, v1);
        assert!(v0.bribes_claimed_till == arg0.ongoing_cycle && v0.fees_claimed_till == arg0.ongoing_cycle, 7064);
        assert!(0x2::linked_table::contains<u64, LockedDragonBee>(&v0.dragon_bees, arg3), 7052);
        let v2 = 0x2::linked_table::borrow_mut<u64, LockedDragonBee>(&mut v0.dragon_bees, arg3);
        let v3 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v2.hive_energy, v2.temp_hive_energy);
        let v4 = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::max_u128(v2.honey_health, v2.temp_honey_health);
        assert!(v2.withdrawable_at_cycle == 0, 7063);
        v2.withdrawable_at_cycle = arg0.ongoing_cycle + 1;
        v0.increment_cycle = arg0.ongoing_cycle;
        0x1::vector::push_back<u64>(&mut v0.unlocking_bees, arg3);
        v0.decrease_in_energy = v0.decrease_in_energy + v3;
        v0.decrease_in_health = v0.decrease_in_health + v4;
        arg0.removed_hive_energy = arg0.removed_hive_energy + v3;
        arg0.removed_honey_health = arg0.removed_honey_health + v4;
        arg1.removed_hive_energy = arg1.removed_hive_energy + v3;
        arg1.removed_honey_health = arg1.removed_honey_health + v4;
        let v5 = DragonBeeWithdrawalRequested{
            pool_hive_addr        : 0x2::object::uid_to_address(&arg1.id),
            trainer_addr          : arg2,
            bee_version           : arg3,
            withdrawable_at_cycle : arg0.ongoing_cycle + 1,
        };
        0x2::event::emit<DragonBeeWithdrawalRequested>(v5);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg1.resting_dragons, arg2, v0);
    }

    fun internal_unbond_no_fruits<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 0, 7006);
        claim_rewards_and_unbond_shares<T0>(arg0, arg1, arg3, arg2, arg4, v0, false, arg5)
    }

    fun internal_unbond_with_1_fruits<T0, T1>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::epoch(arg6);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 1, 7006);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v2 = claim_fruit_for_dragons_den<T0, T1>(v1, arg2, 0x2::object::uid_to_address(&arg1.id), arg1.total_staked, v0, arg3, arg4, true);
        let (v3, v4, v5) = claim_rewards_and_unbond_shares<T0>(arg0, arg1, arg3, arg2, arg5, v0, false, arg6);
        (v3, v4, v2, v5)
    }

    fun internal_unbond_with_2_fruits<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 2, 7006);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v3 = claim_fruit_for_dragons_den<T0, T1>(v2, arg2, v1, arg1.total_staked, v0, arg3, arg4, true);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v5 = claim_fruit_for_dragons_den<T0, T2>(v4, arg2, v1, arg1.total_staked, v0, arg3, arg4, true);
        let (v6, v7, v8) = claim_rewards_and_unbond_shares<T0>(arg0, arg1, arg3, arg2, arg5, v0, false, arg6);
        (v6, v7, v3, v5, v8)
    }

    fun internal_unbond_with_3_fruits<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>, arg3: address, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::tx_context::epoch(arg6);
        let v1 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) == 3, 7006);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T1>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v3 = claim_fruit_for_dragons_den<T0, T1>(v2, arg2, v1, arg1.total_staked, v0, arg3, arg4, true);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T2>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        let v5 = claim_fruit_for_dragons_den<T0, T2>(v4, arg2, v1, arg1.total_staked, v0, arg3, arg4, true);
        let v6 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, HoneyFruit<T3>>(&mut arg1.id, 0x1::type_name::into_string(0x1::type_name::get<T3>()));
        let v7 = claim_fruit_for_dragons_den<T0, T3>(v6, arg2, v1, arg1.total_staked, v0, arg3, arg4, true);
        let (v8, v9, v10) = claim_rewards_and_unbond_shares<T0>(arg0, arg1, arg3, arg2, arg5, v0, false, arg6);
        (v8, v9, v3, v5, v7, v10)
    }

    fun internal_vote_on_emissions<T0>(arg0: &mut DragonFood, arg1: address, arg2: &mut DragonsDen<T0>, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.ongoing_cycle;
        update_food_cycle(arg0, arg5);
        assert!(arg2.dao_vote_cycle < v0, 7054);
        if (0x1::vector::length<u64>(&arg2.locked_bees) == 0) {
            return
        };
        update_votes_for_locked_bees<T0>(arg0, arg1, arg2);
        let v1 = arg2.active_hive_energy;
        let v2 = arg2.active_honey_health;
        if (arg3 == 0) {
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.hive_same_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_same_votes, v0) + v1;
        } else if (arg3 == 1) {
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.hive_increase_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_increase_votes, v0) + v1;
        } else {
            assert!(arg3 == 2, 7060);
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.hive_decrease_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_decrease_votes, v0) + v1;
        };
        if (arg4 == 0) {
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.honey_same_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_same_votes, v0) + v2;
        } else if (arg4 == 1) {
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.honey_increase_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_increase_votes, v0) + v2;
        } else {
            assert!(arg4 == 2, 7060);
            *0x2::linked_table::borrow_mut<u64, u128>(&mut arg0.emissions.honey_decrease_votes, v0) = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_decrease_votes, v0) + v2;
        };
        arg2.dao_vote_cycle = arg0.ongoing_cycle;
        let v3 = TrainerVotedForEmissions{
            trainer_addr    : arg1,
            hive_energy     : v1,
            honey_health    : v2,
            hive_vote_type  : arg3,
            honey_vote_type : arg4,
            dao_vote_cycle  : arg2.dao_vote_cycle,
        };
        0x2::event::emit<TrainerVotedForEmissions>(v3);
    }

    fun internal_withdraw_dragon_bee<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg4);
        update_food_cycle(arg0, arg4);
        update_food_cycle_for_pool_hive<T0>(arg0, arg1, arg4);
        let v1 = access_dragon_den<T0>(arg1, arg2, arg4);
        let v2 = &mut v1;
        update_votes_for_locked_bees<T0>(arg0, arg2, v2);
        assert!(v1.bribes_claimed_till == arg0.ongoing_cycle && v1.fees_claimed_till == arg0.ongoing_cycle, 7064);
        assert!(0x2::linked_table::contains<u64, LockedDragonBee>(&v1.dragon_bees, arg3), 7052);
        let v3 = &mut v1;
        let (v4, v5) = accrue_yield_for_dragon_den<T0>(arg0, arg1, v3, v0, arg4);
        let v6 = v5;
        let v7 = v4;
        let (_, v9) = 0x1::vector::index_of<u64>(&v1.locked_bees, &arg3);
        0x1::vector::remove<u64>(&mut v1.locked_bees, v9);
        let (_, v11) = 0x1::vector::index_of<u64>(&v1.unlocking_bees, &arg3);
        0x1::vector::remove<u64>(&mut v1.unlocking_bees, v11);
        let v12 = 0x2::linked_table::remove<u64, LockedDragonBee>(&mut v1.dragon_bees, arg3);
        assert!(v12.withdrawable_at_cycle > 0 && v12.withdrawable_at_cycle <= arg0.ongoing_cycle, 7061);
        let v13 = v12.withdrawable_at_cycle - 1;
        assert!(v1.bribes_claimed_till >= v13 && v1.fees_claimed_till >= v13, 7064);
        let LockedDragonBee {
            version               : v14,
            mystical_bee          : v15,
            locked_at_cycle       : _,
            withdrawable_at_cycle : _,
            hive_energy           : _,
            honey_health          : _,
            increment_cycle       : _,
            temp_hive_energy      : _,
            temp_honey_health     : _,
        } = v12;
        if (0x1::vector::length<u64>(&v1.locked_bees) == 0) {
            arg1.staked_for_honey = arg1.staked_for_honey - 0x2::balance::value<T0>(&v1.staked_balance);
        };
        let v23 = RestedLockedDragonBeeReturnedInWild{
            pool_hive_addr    : 0x2::object::uid_to_address(&arg1.id),
            trainer_addr      : arg2,
            bee_version       : v14,
            hive_earned       : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7),
            honey_earned      : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v6),
            unlocked_at_cycle : arg0.ongoing_cycle,
            staked_for_honey  : arg1.staked_for_honey,
        };
        0x2::event::emit<RestedLockedDragonBeeReturnedInWild>(v23);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg1.resting_dragons, arg2, v1);
        (v15, v7, v6)
    }

    public entry fun kraft_new_pool_hive_three_pool<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        update_food_cycle(arg0, arg2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>());
        let v1 = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v6, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v7 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v7, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v8 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v8, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        let v9 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v9, v6);
        0x1::vector::push_back<0x1::string::String>(&mut v9, v7);
        0x1::vector::push_back<0x1::string::String>(&mut v9, v8);
        let v10 = Bribes{
            voting_bribes           : v9,
            hive_bribe              : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            honey_bribe             : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            hive_fee_claim_indexes  : 0x2::linked_table::new<u64, u256>(arg2),
            honey_fee_claim_indexes : 0x2::linked_table::new<u64, u256>(arg2),
        };
        let v11 = PoolHive<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>{
            id                       : v3,
            pool_addr                : 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::get_pool_addr<T0, T1, T2, T3>(arg1),
            total_staked             : 0,
            staked_for_honey         : 0,
            honey_available          : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            hive_available           : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            global_hive_claim_index  : 0,
            global_honey_claim_index : 0,
            last_claim_epoch         : v2,
            last_claim_honey_epoch   : v2,
            ongoing_cycle            : arg0.ongoing_cycle,
            cur_cycle_start_epoch    : arg0.cur_cycle_start_epoch,
            bribes                   : v10,
            added_hive_energy        : 0,
            active_hive_energy       : 0x2::linked_table::new<u64, u128>(arg2),
            removed_hive_energy      : 0,
            added_honey_health       : 0,
            active_honey_health      : 0x2::linked_table::new<u64, u128>(arg2),
            removed_honey_health     : 0,
            resting_dragons          : 0x2::linked_table::new<address, DragonsDen<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>>(arg2),
            additional_rewards       : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list            : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id         : 1,
            module_version           : 3,
        };
        let v12 = UnbondingPositions<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>{
            id               : 0x2::object::new(arg2),
            unbonded_balance : 0x2::balance::zero<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>(),
            user_psns        : 0x2::linked_table::new<address, UserUnbondingPsn>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, UnbondingPositions<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>>(&mut v11.id, 0x1::string::utf8(b"UNBONDING_PSN"), v12);
        let v13 = VotingBribes<T0>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T0>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T0>>(&mut v11.id, v6, v13);
        let v14 = VotingBribes<T1>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T1>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T1>>(&mut v11.id, v7, v14);
        let v15 = VotingBribes<T2>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T2>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T2>>(&mut v11.id, v8, v15);
        0x2::linked_table::push_back<u64, u128>(&mut v11.active_hive_energy, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v11.active_honey_health, arg0.ongoing_cycle, 0);
        0x2::transfer::share_object<PoolHive<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>>(v11);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v16 = PoolHiveKrafted{
            pool_id               : 0x2::object::id_to_address(&v1),
            lp_identifier         : v0,
            pool_hive_addr        : v5,
            cur_epoch             : v2,
            ongoing_cycle         : arg0.ongoing_cycle,
            cur_cycle_start_epoch : arg0.cur_cycle_start_epoch,
            accepted_bribes_vec   : v9,
        };
        0x2::event::emit<PoolHiveKrafted>(v16);
        0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::set_pool_hive_addr<T0, T1, T2, T3>(arg1, &arg0.dragon_food_cap, v5);
    }

    public entry fun kraft_new_pool_hive_two_pool<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        update_food_cycle(arg0, arg2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>());
        let v1 = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1);
        let v2 = 0x2::tx_context::epoch(arg2);
        assert!(!0x2::linked_table::contains<0x1::ascii::String, address>(&arg0.pool_hives, v0), 7005);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v6, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v7 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v7, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v8, v6);
        0x1::vector::push_back<0x1::string::String>(&mut v8, v7);
        let v9 = Bribes{
            voting_bribes           : v8,
            hive_bribe              : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            honey_bribe             : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            hive_fee_claim_indexes  : 0x2::linked_table::new<u64, u256>(arg2),
            honey_fee_claim_indexes : 0x2::linked_table::new<u64, u256>(arg2),
        };
        let v10 = PoolHive<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>{
            id                       : v3,
            pool_addr                : 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::get_pool_addr<T0, T1, T2>(arg1),
            total_staked             : 0,
            staked_for_honey         : 0,
            honey_available          : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            hive_available           : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            global_hive_claim_index  : 0,
            global_honey_claim_index : 0,
            last_claim_epoch         : v2,
            last_claim_honey_epoch   : v2,
            ongoing_cycle            : arg0.ongoing_cycle,
            cur_cycle_start_epoch    : arg0.cur_cycle_start_epoch,
            bribes                   : v9,
            added_hive_energy        : 0,
            active_hive_energy       : 0x2::linked_table::new<u64, u128>(arg2),
            removed_hive_energy      : 0,
            added_honey_health       : 0,
            active_honey_health      : 0x2::linked_table::new<u64, u128>(arg2),
            removed_honey_health     : 0,
            resting_dragons          : 0x2::linked_table::new<address, DragonsDen<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>>(arg2),
            additional_rewards       : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list            : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id         : 1,
            module_version           : 3,
        };
        let v11 = UnbondingPositions<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>{
            id               : 0x2::object::new(arg2),
            unbonded_balance : 0x2::balance::zero<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>(),
            user_psns        : 0x2::linked_table::new<address, UserUnbondingPsn>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, UnbondingPositions<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>>(&mut v10.id, 0x1::string::utf8(b"UNBONDING_PSN"), v11);
        let v12 = VotingBribes<T0>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T0>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T0>>(&mut v10.id, v6, v12);
        let v13 = VotingBribes<T1>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T1>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T1>>(&mut v10.id, v7, v13);
        0x2::linked_table::push_back<u64, u128>(&mut v10.active_hive_energy, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut v10.active_honey_health, arg0.ongoing_cycle, 0);
        0x2::transfer::share_object<PoolHive<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>>(v10);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, v0, v5);
        arg0.active_pool_hives = arg0.active_pool_hives + 1;
        let v14 = PoolHiveKrafted{
            pool_id               : 0x2::object::id_to_address(&v1),
            lp_identifier         : v0,
            pool_hive_addr        : v5,
            cur_epoch             : v2,
            ongoing_cycle         : arg0.ongoing_cycle,
            cur_cycle_start_epoch : arg0.cur_cycle_start_epoch,
            accepted_bribes_vec   : v8,
        };
        0x2::event::emit<PoolHiveKrafted>(v14);
        0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::set_pool_hive_addr<T0, T1, T2>(arg1, &arg0.dragon_food_cap, v5);
    }

    public fun liquidate_locked_lp<T0>(arg0: &LendingPoolCapability, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>, 0x2::balance::Balance<T0>) {
        let v0 = verify_and_extract_dragon_den<T0>(arg1, arg2, arg3, arg5);
        assert!(v0.is_locked, 7066);
        let v1 = LiquidatedLP{
            pool_hive_addr : 0x2::object::uid_to_address(&arg2.id),
            trainer_addr   : arg3,
            amt_liquidated : arg4,
        };
        0x2::event::emit<LiquidatedLP>(v1);
        let v2 = &mut v0;
        let v3 = 0x2::tx_context::epoch(arg5);
        let (v4, v5, v6) = claim_rewards_and_unbond_shares<T0>(arg1, arg2, arg3, v2, arg4, v3, true, arg5);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, arg3, v0);
        (v4, v5, v6)
    }

    fun lock_hive_if_trading_disabled(arg0: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg1: &0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg2: 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        if (!0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg1)) {
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::lock_assets_with_trainer(arg0, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut arg2), 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>());
        };
        arg2
    }

    public fun lock_lp_tokens_for_school<T0>(arg0: &LendingPoolCapability, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg3);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg4);
        v3.is_locked = true;
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        let v4 = LockedLP{
            pool_hive_addr : 0x2::object::uid_to_address(&arg2.id),
            trainer_addr   : v0,
        };
        0x2::event::emit<LockedLP>(v4);
    }

    public fun lock_lp_tokens_for_trainer<T0>(arg0: &LendingPoolCapability, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg3);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg4);
        v3.is_locked = true;
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        let v4 = LockedLP{
            pool_hive_addr : 0x2::object::uid_to_address(&arg2.id),
            trainer_addr   : v0,
        };
        0x2::event::emit<LockedLP>(v4);
    }

    public fun mark_bribe_as_meme_token<T0, T1>(arg0: &0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MemepadCapability, arg1: &mut PoolHive<T0>) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = 0x1::string::utf8(b"BRIBES::");
        0x1::string::append(&mut v1, v0);
        assert!(0x1::vector::contains<0x1::string::String>(&arg1.bribes.voting_bribes, &v1), 7056);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, VotingBribes<T1>>(&mut arg1.id, v1).is_meme_token = true;
        let v2 = BribeMarkedAsToken{
            pool_hive_addr : 0x2::object::uid_to_address(&arg1.id),
            coin_type      : v0,
        };
        0x2::event::emit<BribeMarkedAsToken>(v2);
    }

    public entry fun migrate_dragon_food_to_v2(arg0: 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::DragonFoodInMigration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11) = 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::destroy_dragon_food_in_migration(arg0);
        let v12 = v5;
        let v13 = EmissionSchedule{
            start_epoch          : (*0x1::vector::borrow<u128>(&v12, 8) as u64),
            hive_per_epoch       : (*0x1::vector::borrow<u128>(&v12, 9) as u64),
            honey_per_epoch      : (*0x1::vector::borrow<u128>(&v12, 10) as u64),
            change_pct_per_cycle : (*0x1::vector::borrow<u128>(&v12, 11) as u64),
            hive_increase_votes  : v6,
            hive_decrease_votes  : v7,
            hive_same_votes      : v8,
            honey_increase_votes : v9,
            honey_decrease_votes : v10,
            honey_same_votes     : v11,
        };
        let v14 = VoteConfig{
            proposal_required_deposit   : (*0x1::vector::borrow<u128>(&v12, 12) as u64),
            voting_start_delay          : (*0x1::vector::borrow<u128>(&v12, 13) as u64),
            voting_period_length        : (*0x1::vector::borrow<u128>(&v12, 14) as u64),
            execution_delay             : (*0x1::vector::borrow<u128>(&v12, 15) as u64),
            execution_period_length     : (*0x1::vector::borrow<u128>(&v12, 16) as u64),
            proposal_required_quorum    : (*0x1::vector::borrow<u128>(&v12, 17) as u64),
            proposal_approval_threshold : (*0x1::vector::borrow<u128>(&v12, 18) as u64),
        };
        let v15 = DragonFood{
            id                     : 0x2::object::new(arg2),
            dragon_food_cap        : v0,
            emissions              : v13,
            hive_available         : v1,
            honey_available        : v2,
            ongoing_cycle          : (*0x1::vector::borrow<u128>(&v12, 0) as u64),
            cur_cycle_start_epoch  : (*0x1::vector::borrow<u128>(&v12, 1) as u64),
            cycle_duration         : (*0x1::vector::borrow<u128>(&v12, 2) as u64),
            max_dragonbees_per_psn : (arg1 as u64),
            added_hive_energy      : (*0x1::vector::borrow<u128>(&v12, 3) as u128),
            total_hive_energy      : v3,
            removed_hive_energy    : (*0x1::vector::borrow<u128>(&v12, 4) as u128),
            added_honey_health     : (*0x1::vector::borrow<u128>(&v12, 5) as u128),
            total_honey_health     : v4,
            removed_honey_health   : (*0x1::vector::borrow<u128>(&v12, 6) as u128),
            vote_config            : v14,
            active_pool_hives      : (*0x1::vector::borrow<u128>(&v12, 7) as u64),
            pool_hives             : 0x2::linked_table::new<0x1::ascii::String, address>(arg2),
            module_version         : 3,
        };
        0x2::transfer::share_object<DragonFood>(v15);
    }

    public entry fun migrate_pool_hive_to_v2<T0, T1, T2, T3, T4>(arg0: 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::PoolHiveInMigration<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = 0x6a7ea1255160d2d3c77aa80440f17d4ae9092ef547141a34185e5b41c1c31c66::dragon_food::destroy_pool_hive_in_migration<T0>(arg0);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = v6;
        let v14 = v3;
        let v15 = v2;
        let v16 = Bribes{
            voting_bribes           : v15,
            hive_bribe              : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(),
            honey_bribe             : 0x2::balance::zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(),
            hive_fee_claim_indexes  : 0x2::linked_table::new<u64, u256>(arg2),
            honey_fee_claim_indexes : 0x2::linked_table::new<u64, u256>(arg2),
        };
        let v17 = PoolHive<T0>{
            id                       : 0x2::object::new(arg2),
            pool_addr                : @0x0,
            total_staked             : (*0x1::vector::borrow<u256>(&v14, 0) as u64),
            staked_for_honey         : (*0x1::vector::borrow<u256>(&v14, 1) as u64),
            honey_available          : v0,
            hive_available           : v1,
            global_hive_claim_index  : (*0x1::vector::borrow<u256>(&v14, 2) as u256),
            global_honey_claim_index : (*0x1::vector::borrow<u256>(&v14, 3) as u256),
            last_claim_epoch         : (*0x1::vector::borrow<u256>(&v14, 4) as u64),
            last_claim_honey_epoch   : (*0x1::vector::borrow<u256>(&v14, 5) as u64),
            ongoing_cycle            : (*0x1::vector::borrow<u256>(&v14, 6) as u64),
            cur_cycle_start_epoch    : (*0x1::vector::borrow<u256>(&v14, 7) as u64),
            bribes                   : v16,
            added_hive_energy        : (*0x1::vector::borrow<u256>(&v14, 8) as u128),
            active_hive_energy       : v4,
            removed_hive_energy      : (*0x1::vector::borrow<u256>(&v14, 9) as u128),
            added_honey_health       : (*0x1::vector::borrow<u256>(&v14, 10) as u128),
            active_honey_health      : v5,
            removed_honey_health     : (*0x1::vector::borrow<u256>(&v14, 11) as u128),
            resting_dragons          : 0x2::linked_table::new<address, DragonsDen<T0>>(arg2),
            additional_rewards       : 0x1::vector::empty<0x1::ascii::String>(),
            proposal_list            : 0x2::linked_table::new<u64, Proposal>(arg2),
            next_proposal_id         : 1,
            module_version           : 3,
        };
        let v18 = VotingBribes<T1>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T1>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T1>>(&mut v17.id, *0x1::vector::borrow<0x1::string::String>(&v15, 0), v18);
        let v19 = VotingBribes<T2>{
            id                        : 0x2::object::new(arg2),
            bribe                     : 0x2::balance::zero<T2>(),
            is_meme_token             : false,
            cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
            cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
        };
        0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T2>>(&mut v17.id, *0x1::vector::borrow<0x1::string::String>(&v15, 1), v19);
        if (arg1) {
            let v20 = VotingBribes<T3>{
                id                        : 0x2::object::new(arg2),
                bribe                     : 0x2::balance::zero<T3>(),
                is_meme_token             : false,
                cycle_to_hive_bribes_map  : 0x2::linked_table::new<u64, u64>(arg2),
                cycle_to_honey_bribes_map : 0x2::linked_table::new<u64, u64>(arg2),
            };
            0x2::dynamic_object_field::add<0x1::string::String, VotingBribes<T3>>(&mut v17.id, *0x1::vector::borrow<0x1::string::String>(&v15, 2), v20);
        };
        let v21 = *0x2::linked_table::front<address, 0x2::balance::Balance<T0>>(&v13);
        while (0x1::option::is_some<address>(&v21)) {
            let v22 = *0x1::option::borrow<address>(&v21);
            v21 = *0x2::linked_table::next<address, 0x2::balance::Balance<T0>>(&v13, v22);
            let v23 = 0x2::linked_table::new<u64, LockedDragonBee>(arg2);
            let v24 = 0x1::vector::empty<u64>();
            let v25 = 0x1::vector::empty<u64>();
            let v26 = 0;
            let v27 = 0;
            let v28 = 0;
            let v29 = 0;
            let v30 = 0;
            let v31 = 0;
            let v32 = 0;
            let v33 = 0;
            let v34 = 0;
            let v35 = 0;
            if (0x2::linked_table::contains<address, 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee>(&v11, v22)) {
                let v36 = 0x2::linked_table::remove<address, vector<u64>>(&mut v10, v22);
                let v37 = *0x1::vector::borrow<u64>(&v36, 0);
                let v38 = *0x1::vector::borrow<u64>(&v36, 2);
                v26 = v38;
                v27 = (*0x1::vector::borrow<u64>(&v36, 3) as u128);
                v28 = (*0x1::vector::borrow<u64>(&v36, 4) as u128);
                let v39 = *0x1::vector::borrow<u64>(&v36, 5);
                let v40 = *0x1::vector::borrow<u64>(&v36, 7);
                v31 = (v39 as u128);
                v32 = (v40 as u128);
                v33 = *0x1::vector::borrow<u64>(&v36, 9);
                v34 = *0x1::vector::borrow<u64>(&v36, 10);
                v35 = *0x1::vector::borrow<u64>(&v36, 11);
                let v41 = *0x1::vector::borrow<u64>(&v36, 12);
                0x1::vector::push_back<u64>(&mut v24, v37);
                if (v41 > 0) {
                    0x1::vector::push_back<u64>(&mut v25, v37);
                    v30 = (v40 as u128);
                    v29 = (v39 as u128);
                };
                let v42 = LockedDragonBee{
                    version               : (v37 as u64),
                    mystical_bee          : 0x2::linked_table::remove<address, 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee>(&mut v11, v22),
                    locked_at_cycle       : (*0x1::vector::borrow<u64>(&v36, 1) as u64),
                    withdrawable_at_cycle : (v41 as u64),
                    hive_energy           : (v39 as u128),
                    honey_health          : (v40 as u128),
                    increment_cycle       : (v38 as u64),
                    temp_hive_energy      : (*0x1::vector::borrow<u64>(&v36, 6) as u128),
                    temp_honey_health     : (*0x1::vector::borrow<u64>(&v36, 8) as u128),
                };
                0x2::linked_table::push_back<u64, LockedDragonBee>(&mut v23, (v37 as u64), v42);
            };
            let v43 = 0x2::linked_table::remove<address, vector<u256>>(&mut v12, v22);
            let v44 = DragonsDen<T0>{
                staked_balance          : 0x2::linked_table::remove<address, 0x2::balance::Balance<T0>>(&mut v13, v22),
                hive_claim_index        : *0x1::vector::borrow<u256>(&v43, 0),
                honey_claim_index       : *0x1::vector::borrow<u256>(&v43, 1),
                locked_bees             : v24,
                unlocking_bees          : v25,
                dragon_bees             : v23,
                active_hive_energy      : v31,
                active_honey_health     : v32,
                increment_cycle         : v26,
                increase_in_energy      : v27,
                increase_in_health      : v28,
                decrease_in_energy      : v29,
                decrease_in_health      : v30,
                dao_vote_cycle          : v33,
                bribes_claimed_till     : v34,
                fees_claimed_till       : v35,
                hive_fee_claim_indexes  : 0x2::linked_table::new<u64, u256>(arg2),
                honey_fee_claim_indexes : 0x2::linked_table::new<u64, u256>(arg2),
                rewards_indexes         : 0x2::linked_table::new<0x1::ascii::String, u256>(arg2),
                is_locked               : false,
            };
            0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut v17.resting_dragons, v22, v44);
        };
        0x2::linked_table::destroy_empty<address, 0x2::balance::Balance<T0>>(v13);
        0x2::linked_table::drop<address, vector<u256>>(v12);
        0x2::linked_table::destroy_empty<address, 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::MysticalBee>(v11);
        0x2::linked_table::destroy_empty<address, vector<u64>>(v10);
        0x2::transfer::share_object<PoolHive<T0>>(v17);
    }

    public entry fun removeExpiredProposal<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<u64, Proposal>(&arg0.proposal_list, arg2), 7024);
        let v0 = 0x2::linked_table::remove<u64, Proposal>(&mut arg0.proposal_list, arg2);
        assert!(0x2::tx_context::epoch(arg3) > v0.execution_end_epoch, 7029);
        let (v1, _, v3, _, _, _, v7, _, _, _, _, v12, _, _, _, _, _, _) = destroy_proposal(v0);
        let v19 = v3;
        if (0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v19) > 0) {
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::deposit_hive_for_distribution(arg1, v19);
        } else {
            0x2::balance::destroy_zero<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v19);
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
        assert!(arg0.module_version == 3, 7038);
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (v2, v3) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.additional_rewards, &v1);
        assert!(v2, 7016);
        0x1::vector::remove<0x1::ascii::String>(&mut arg0.additional_rewards, v3);
        let (v4, _, v6, v7, _, _, _) = destroy_fruit_rewards<T1>(0x2::dynamic_object_field::remove<0x1::ascii::String, HoneyFruit<T1>>(&mut arg0.id, v1));
        let v11 = v4;
        if (0x2::balance::value<T1>(&v11) > 0) {
            assert!(v0 > v7, 7017);
            0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<T1>(v11, 0x2::tx_context::sender(arg1), arg1);
        } else {
            assert!(v0 > v6 + 2, 7017);
            0x2::balance::destroy_zero<T1>(v11);
        };
        let v12 = HoneyFruitDestroyed{
            pool_hive_addr   : 0x2::object::uid_to_address(&arg0.id),
            honey_fruit_type : v1,
            cur_epoch        : v0,
        };
        0x2::event::emit<HoneyFruitDestroyed>(v12);
    }

    public fun request_withdrawal_for_dragon_bee<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg2);
        internal_process_withdrawl_request<T0>(arg0, arg1, v0, arg3, arg4);
    }

    fun safe_claim_bribe<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T0>(arg0) < arg1) {
            return 0x2::balance::withdraw_all<T0>(arg0)
        };
        0x2::balance::split<T0>(arg0, arg1)
    }

    fun stake_lp<T0>(arg0: address, arg1: 0x1::string::String, arg2: &mut DragonFood, arg3: &mut PoolHive<T0>, arg4: &mut DragonsDen<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>) {
        let (v0, v1) = accrue_yield_for_dragon_den<T0>(arg2, arg3, arg4, arg6, arg7);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&arg5);
        arg3.total_staked = arg3.total_staked + v4;
        if (0x1::vector::length<u64>(&arg4.locked_bees) > 0) {
            arg3.staked_for_honey = arg3.staked_for_honey + v4;
        };
        0x2::balance::join<T0>(&mut arg4.staked_balance, arg5);
        let v5 = AddedToDragonDen{
            pool_hive_addr       : 0x2::object::uid_to_address(&arg3.id),
            trainer_addr         : arg0,
            username             : arg1,
            lp_balance_added     : v4,
            is_dragon_bee_locked : 0x1::vector::length<u64>(&arg4.locked_bees) > 0,
            hive_earned          : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v3),
            honey_earned         : 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v2),
            hive_claim_index     : arg4.hive_claim_index,
            honey_claim_index    : arg4.honey_claim_index,
        };
        0x2::event::emit<AddedToDragonDen>(v5);
        (v3, v2)
    }

    public fun stake_lp_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6) = internal_deposit_no_fruits<T0>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v7 = v5;
        let v8 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v8, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        lock_hive_if_trading_disabled(arg4, arg2, v7)
    }

    public fun stake_lp_0_fruits_with_comp_trainer<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg2, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6) = internal_deposit_no_fruits<T0>(arg1, arg2, v4, arg5, v0, v1, arg6);
        let v7 = v5;
        let v8 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg2, arg3, v0, arg4, v8, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg3), 7067);
        v7
    }

    public fun stake_lp_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7) = internal_deposit_with_1_fruits<T0, T1>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v8 = v5;
        let v9 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v8), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v8), v7)
    }

    public fun stake_lp_1_fruits_with_comp_trainer<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7) = internal_deposit_with_1_fruits<T0, T1>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v8 = v5;
        let v9 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v8));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        (v8, v7)
    }

    public fun stake_lp_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8) = internal_deposit_with_2_fruits<T0, T1, T2>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v9 = v5;
        let v10 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v9), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v9), v7, v8)
    }

    public fun stake_lp_2_fruits_with_comp_trainer<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8) = internal_deposit_with_2_fruits<T0, T1, T2>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v9 = v5;
        let v10 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v9));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        (v9, v7, v8)
    }

    public fun stake_lp_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9) = internal_deposit_with_3_fruits<T0, T1, T2, T3>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v10 = v5;
        let v11 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v11, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v10), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v10), v7, v8, v9)
    }

    public fun stake_lp_3_fruits_with_comp_trainer<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = access_dragon_den<T0>(arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9) = internal_deposit_with_3_fruits<T0, T1, T2, T3>(arg1, arg3, v4, arg5, v0, v1, arg6);
        let v10 = v5;
        let v11 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg3, arg2, v0, arg4, v11, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v10));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg2), 7067);
        (v10, v7, v8, v9)
    }

    public entry fun submit_proposal<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::option::Option<vector<u64>>, arg8: 0x1::option::Option<vector<u64>>, arg9: 0x1::option::Option<vector<u64>>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg10);
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v1 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v1), 7018);
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
            0x6c442d664dffc25e3fda48f15370ffaecac1f94ecb6debb46cd41ac4b38bddfa::curved_math::assert_new_config_params(*0x1::vector::borrow<u64>(&v14, 0), *0x1::vector::borrow<u64>(&v14, 1), *0x1::vector::borrow<u64>(&v14, 2), *0x1::vector::borrow<u64>(&v14, 3), *0x1::vector::borrow<u64>(&v14, 4), *0x1::vector::borrow<u64>(&v14, 5));
            assert!(0x1::vector::length<u64>(&v14) >= 6, 7019);
        };
        let v15 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg10),
            deposit               : 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v1, arg0.vote_config.proposal_required_deposit),
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
        let v16 = NewProposalKrafted{
            pool_hive_addr        : 0x2::object::uid_to_address(&arg1.id),
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
        0x2::event::emit<NewProposalKrafted>(v16);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v15);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v1, 0x2::tx_context::sender(arg10), arg10);
    }

    public entry fun submit_proposal_to_add_fruit<T0, T1>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: 0x2::coin::Coin<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg9);
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        let v1 = 0x2::coin::into_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(arg2);
        assert!(arg0.vote_config.proposal_required_deposit <= 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v1), 7018);
        assert!(v0 + arg0.vote_config.voting_start_delay + arg0.vote_config.voting_period_length + arg0.vote_config.execution_delay + arg0.vote_config.execution_period_length < arg7, 7020);
        assert!(arg7 < arg8, 7021);
        assert!(arg3 == 5, 7019);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.additional_rewards) < 3, 7023);
        let v2 = FruitLife{
            fruit_typename : 0x1::type_name::get<T1>(),
            start_epoch    : arg7,
            end_epoch      : arg8,
        };
        let v3 = Proposal{
            proposal_id           : arg1.next_proposal_id,
            proposer              : 0x2::tx_context::sender(arg9),
            deposit               : 0x2::balance::split<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&mut v1, arg0.vote_config.proposal_required_deposit),
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
            fruit_life            : 0x1::option::some<FruitLife>(v2),
            new_params            : 0x1::option::none<vector<u64>>(),
            new_weights           : 0x1::option::none<vector<u64>>(),
            new_fee_info          : 0x1::option::none<vector<u64>>(),
        };
        let v4 = NewProposalKrafted{
            pool_hive_addr        : 0x2::object::uid_to_address(&arg1.id),
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
        0x2::event::emit<NewProposalKrafted>(v4);
        0x2::linked_table::push_back<u64, Proposal>(&mut arg1.proposal_list, arg1.next_proposal_id, v3);
        arg1.next_proposal_id = arg1.next_proposal_id + 1;
        0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::coin_helper::destroy_or_transfer_balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(v1, 0x2::tx_context::sender(arg9), arg9);
    }

    public fun unbond_from_dragon_den_0_fruits<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T0>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7) = internal_unbond_no_fruits<T0>(arg1, arg3, v4, v0, arg5, arg6);
        let v8 = v5;
        let v9 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v9, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v8), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v8), v7)
    }

    public fun unbond_from_dragon_den_0_fruits_with_comp_trainer<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T0>) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7) = internal_unbond_no_fruits<T0>(arg1, arg2, v4, v0, arg5, arg6);
        let v8 = v5;
        let v9 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg2, arg3, v0, arg4, v9, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v8));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg3), 7067);
        (v8, v7)
    }

    public fun unbond_from_dragon_den_1_fruits<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8) = internal_unbond_with_1_fruits<T0, T1>(arg1, arg3, v4, v0, v1, arg5, arg6);
        let v9 = v5;
        let v10 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v9), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v9), v7, v8)
    }

    public fun unbond_from_dragon_den_1_fruits_with_comp_trainer<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8) = internal_unbond_with_1_fruits<T0, T1>(arg1, arg2, v4, v0, v1, arg5, arg6);
        let v9 = v5;
        let v10 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg2, arg3, v0, arg4, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v9));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg3), 7067);
        (v9, v7, v8)
    }

    public fun unbond_from_dragon_den_2_fruits<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9) = internal_unbond_with_2_fruits<T0, T1, T2>(arg1, arg3, v4, v0, v1, arg5, arg6);
        let v10 = v5;
        let v11 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v11, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v10), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v10), v7, v8, v9)
    }

    public fun unbond_from_dragon_den_2_fruits_with_comp_trainer<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9) = internal_unbond_with_2_fruits<T0, T1, T2>(arg1, arg2, v4, v0, v1, arg5, arg6);
        let v10 = v5;
        let v11 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg2, arg3, v0, arg4, v11, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v10));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg3), 7067);
        (v10, v7, v8, v9)
    }

    public fun unbond_from_dragon_den_3_fruits<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg3: &mut PoolHive<T0>, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg3, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9, v10) = internal_unbond_with_3_fruits<T0, T1, T2, T3>(arg1, arg3, v4, v0, v1, arg5, arg6);
        let v11 = v5;
        let v12 = &mut v3;
        feed_dragon_bee<T0>(arg0, arg1, arg3, arg2, v0, arg4, v12, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v11), arg6);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg3.resting_dragons, v0, v3);
        (lock_hive_if_trading_disabled(arg4, arg2, v11), v7, v8, v9, v10)
    }

    public fun unbond_from_dragon_den_3_fruits_with_comp_trainer<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x2::balance::Balance<T3>, 0x2::balance::Balance<T0>) {
        let (v0, v1, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg4);
        let v3 = verify_and_extract_dragon_den<T0>(arg1, arg2, v0, arg6);
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9, v10) = internal_unbond_with_3_fruits<T0, T1, T2, T3>(arg1, arg2, v4, v0, v1, arg5, arg6);
        let v11 = v5;
        let v12 = &mut v3;
        feed_dragon_bee_school<T0>(arg0, arg1, arg2, arg3, v0, arg4, v12, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v11));
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, v0, v3);
        assert!(0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::is_trading_enabled(arg3), 7067);
        (v11, v7, v8, v9, v10)
    }

    public fun unlock_lp_tokens<T0>(arg0: &LendingPoolCapability, arg1: &mut DragonFood, arg2: &mut PoolHive<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = verify_and_extract_dragon_den<T0>(arg1, arg2, arg3, arg4);
        v0.is_locked = false;
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg2.resting_dragons, arg3, v0);
        let v1 = UnlockedLP{
            pool_hive_addr : 0x2::object::uid_to_address(&arg2.id),
            trainer_addr   : arg3,
        };
        0x2::event::emit<UnlockedLP>(v1);
    }

    public fun unlock_unbonding_position<T0>(arg0: &mut PoolHive<T0>, arg1: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let (v1, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg1);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, UnbondingPositions<T0>>(&mut arg0.id, 0x1::string::utf8(b"UNBONDING_PSN"));
        if (!0x2::linked_table::contains<address, UserUnbondingPsn>(&v4.user_psns, v1)) {
            return v0
        };
        let v5 = 0x2::linked_table::borrow_mut<address, UserUnbondingPsn>(&mut v4.user_psns, v1);
        let v6 = 0;
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = *0x2::linked_table::front<u64, u64>(&v5.unlocking_amts);
        while (0x1::option::is_some<u64>(&v9)) {
            let v10 = *0x1::option::borrow<u64>(&v9);
            v9 = *0x2::linked_table::next<u64, u64>(&v5.unlocking_amts, v10);
            if (v10 <= 0x2::tx_context::epoch(arg2)) {
                let v11 = 0x2::linked_table::remove<u64, u64>(&mut v5.unlocking_amts, v10);
                v6 = v6 + v11;
                0x1::vector::push_back<u64>(&mut v7, v10);
                0x1::vector::push_back<u64>(&mut v8, v11);
            };
        };
        if (0x2::linked_table::length<u64, u64>(&v5.unlocking_amts) == 0) {
            let UserUnbondingPsn { unlocking_amts: v12 } = 0x2::linked_table::remove<address, UserUnbondingPsn>(&mut v4.user_psns, v1);
            0x2::linked_table::destroy_empty<u64, u64>(v12);
        };
        let v13 = UnbondingPositionUnlocked{
            pool_hive_addr        : 0x2::object::uid_to_address(&arg0.id),
            trainer_addr          : v1,
            unbondable_epoches    : v7,
            unbondable_amounts    : v8,
            total_unbonded_amount : v6,
        };
        0x2::event::emit<UnbondingPositionUnlocked>(v13);
        if (v6 > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut v4.unbonded_balance, v6));
        };
        v0
    }

    public fun update_emissions_per_epoch(arg0: &mut DragonFood, arg1: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 3, 7038);
        assert!(arg3 * 352 < 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&arg0.hive_available) / 3, 7040);
        assert!(arg2 * 352 < 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&arg0.honey_available) / 3, 7040);
        assert!(arg4 < 10, 7059);
        arg0.emissions.hive_per_epoch = arg3;
        arg0.emissions.honey_per_epoch = arg2;
        arg0.emissions.change_pct_per_cycle = arg4;
        arg0.emissions.start_epoch = 0x2::tx_context::epoch(arg5) + 1;
        let v0 = HivePerEpochUpdated{
            hive_per_epoch  : arg0.emissions.hive_per_epoch,
            start_epoch     : arg0.emissions.start_epoch,
            honey_per_epoch : arg0.emissions.honey_per_epoch,
        };
        0x2::event::emit<HivePerEpochUpdated>(v0);
    }

    public fun update_food_cycle(arg0: &mut DragonFood, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        let v1 = arg0.ongoing_cycle;
        if (v0 < arg0.cur_cycle_start_epoch + arg0.cycle_duration) {
            return
        };
        arg0.ongoing_cycle = arg0.ongoing_cycle + 1;
        arg0.cur_cycle_start_epoch = v0;
        let v2 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_increase_votes, v1);
        let v3 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_decrease_votes, v1);
        let v4 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.hive_same_votes, v1);
        if (v2 > v3 && v2 > v4) {
            arg0.emissions.hive_per_epoch = arg0.emissions.hive_per_epoch + arg0.emissions.hive_per_epoch * arg0.emissions.change_pct_per_cycle / 100;
        };
        if (v3 > v2 && v3 > v4) {
            arg0.emissions.hive_per_epoch = arg0.emissions.hive_per_epoch - arg0.emissions.hive_per_epoch * arg0.emissions.change_pct_per_cycle / 100;
        };
        if (v4 > v2) {
        };
        let v5 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_increase_votes, v1);
        let v6 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_decrease_votes, v1);
        let v7 = *0x2::linked_table::borrow<u64, u128>(&arg0.emissions.honey_same_votes, v1);
        if (v5 > v6 && v5 > v7) {
            arg0.emissions.honey_per_epoch = arg0.emissions.honey_per_epoch + arg0.emissions.honey_per_epoch * arg0.emissions.change_pct_per_cycle / 100;
        };
        if (v6 > v5 && v6 > v7) {
            arg0.emissions.honey_per_epoch = arg0.emissions.honey_per_epoch - arg0.emissions.honey_per_epoch * arg0.emissions.change_pct_per_cycle / 100;
        };
        if (v7 > v5) {
        };
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.hive_same_votes, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.hive_increase_votes, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.hive_decrease_votes, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.honey_same_votes, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.honey_increase_votes, arg0.ongoing_cycle, 0);
        0x2::linked_table::push_back<u64, u128>(&mut arg0.emissions.honey_decrease_votes, arg0.ongoing_cycle, 0);
        if (!0x2::linked_table::contains<u64, u128>(&arg0.total_hive_energy, v1)) {
            0x2::linked_table::push_back<u64, u128>(&mut arg0.total_hive_energy, v1, 0);
        };
        let v8 = *0x2::linked_table::borrow<u64, u128>(&arg0.total_hive_energy, v1) + arg0.added_hive_energy - arg0.removed_hive_energy;
        0x2::linked_table::push_back<u64, u128>(&mut arg0.total_hive_energy, arg0.ongoing_cycle, v8);
        if (!0x2::linked_table::contains<u64, u128>(&arg0.total_honey_health, v1)) {
            0x2::linked_table::push_back<u64, u128>(&mut arg0.total_honey_health, v1, 0);
        };
        let v9 = *0x2::linked_table::borrow<u64, u128>(&arg0.total_honey_health, v1) + arg0.added_honey_health - arg0.removed_honey_health;
        0x2::linked_table::push_back<u64, u128>(&mut arg0.total_honey_health, arg0.ongoing_cycle, v9);
        arg0.added_hive_energy = 0;
        arg0.removed_hive_energy = 0;
        arg0.added_honey_health = 0;
        arg0.removed_honey_health = 0;
        let v10 = DragonFoodCycleUpdated{
            hive_per_epoch         : arg0.emissions.hive_per_epoch,
            honey_per_epoch        : arg0.emissions.honey_per_epoch,
            cur_cycle              : arg0.ongoing_cycle,
            cur_cycle_start_epoch  : arg0.cur_cycle_start_epoch,
            cycle_duration         : arg0.cycle_duration,
            cur_total_hive_energy  : v8,
            cur_total_honey_health : v9,
        };
        0x2::event::emit<DragonFoodCycleUpdated>(v10);
    }

    public fun update_food_cycle_for_pool_hive<T0>(arg0: &DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.ongoing_cycle;
        if (0x2::tx_context::epoch(arg2) < arg1.cur_cycle_start_epoch + arg0.cycle_duration) {
            return
        };
        arg1.ongoing_cycle = arg0.ongoing_cycle;
        arg1.cur_cycle_start_epoch = arg0.cur_cycle_start_epoch;
        let v1 = 0;
        if (0x2::linked_table::contains<u64, u128>(&arg1.active_hive_energy, v0)) {
            v1 = *0x2::linked_table::borrow<u64, u128>(&arg1.active_hive_energy, v0);
        };
        let v2 = v1 + arg1.added_hive_energy - arg1.removed_hive_energy;
        0x2::linked_table::push_back<u64, u128>(&mut arg1.active_hive_energy, arg1.ongoing_cycle, v2);
        let v3 = 0;
        if (0x2::linked_table::contains<u64, u128>(&arg1.active_honey_health, v0)) {
            v3 = *0x2::linked_table::borrow<u64, u128>(&arg1.active_honey_health, v0);
        };
        let v4 = v3 + arg1.added_honey_health - arg1.removed_honey_health;
        0x2::linked_table::push_back<u64, u128>(&mut arg1.active_honey_health, arg1.ongoing_cycle, v4);
        arg1.added_hive_energy = 0;
        arg1.removed_hive_energy = 0;
        arg1.added_honey_health = 0;
        arg1.removed_honey_health = 0;
        let v5 = FoodCycleUpdatedForPoolHive{
            pool_hive_addr         : 0x2::object::uid_to_address(&arg1.id),
            cur_cycle              : arg1.ongoing_cycle,
            cur_cycle_start_epoch  : arg1.cur_cycle_start_epoch,
            cur_total_hive_energy  : v2,
            cur_total_honey_health : v4,
        };
        0x2::event::emit<FoodCycleUpdatedForPoolHive>(v5);
    }

    public fun update_pools_governance_params(arg0: &mut DragonFood, arg1: &0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::yield_flow::DragonDaoCapability, arg2: vector<u64>) {
        assert!(arg0.module_version == 3, 7038);
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
            arg0.vote_config.proposal_required_quorum = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(1000000, v5, 100);
        };
        let v6 = *0x1::vector::borrow<u64>(&arg2, 6);
        if (70 > v6 && v6 >= 40) {
            arg0.vote_config.proposal_approval_threshold = 0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::math::mul_div(1000000, v6, 100);
        };
        let v7 = *0x1::vector::borrow<u64>(&arg2, 7);
        if (15 > v7 && v7 >= 1) {
            arg0.cycle_duration = v7;
        };
        let v8 = *0x1::vector::borrow<u64>(&arg2, 8);
        if (v8 >= 0) {
            arg0.max_dragonbees_per_psn = v8;
        };
        let v9 = DragonFoodVotingConfigUpdated{
            proposal_required_deposit   : arg0.vote_config.proposal_required_deposit,
            voting_start_delay          : arg0.vote_config.voting_start_delay,
            voting_period_length        : arg0.vote_config.voting_period_length,
            execution_delay             : arg0.vote_config.execution_delay,
            execution_period_length     : arg0.vote_config.execution_period_length,
            proposal_required_quorum    : arg0.vote_config.proposal_required_quorum,
            proposal_approval_threshold : arg0.vote_config.proposal_approval_threshold,
        };
        0x2::event::emit<DragonFoodVotingConfigUpdated>(v9);
    }

    public fun update_three_pool_hive_address<T0, T1, T2, T3>(arg0: &mut DragonFood, arg1: &mut 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LiquidityPool<T0, T1, T2, T3>, arg2: &mut PoolHive<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::get_liquidity_pool_id<T0, T1, T2, T3>(arg1);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        arg2.pool_addr = 0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::get_pool_addr<T0, T1, T2, T3>(arg1);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::LP<T0, T1, T2, T3>>()), v0);
        0xb0e95627dfee7e43bb8d119f6a63abd4cbbc8f8abc17d403844e47244bd91e67::three_pool::set_pool_hive_addr<T0, T1, T2, T3>(arg1, &arg0.dragon_food_cap, v0);
        let v1 = PoolHiveMigrated{
            pool_id            : arg2.pool_addr,
            new_pool_hive_addr : v0,
        };
        0x2::event::emit<PoolHiveMigrated>(v1);
    }

    public fun update_two_pool_hive_address<T0, T1, T2>(arg0: &mut DragonFood, arg1: &mut 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LiquidityPool<T0, T1, T2>, arg2: &mut PoolHive<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::get_liquidity_pool_id<T0, T1, T2>(arg1);
        let v0 = 0x2::object::uid_to_address(&arg2.id);
        arg2.pool_addr = 0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::get_pool_addr<T0, T1, T2>(arg1);
        0x2::linked_table::push_back<0x1::ascii::String, address>(&mut arg0.pool_hives, 0x1::type_name::into_string(0x1::type_name::get<0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::LP<T0, T1, T2>>()), v0);
        0x1609ad341cc5ef030d782ee7c2d84070d0768c6cede910e216c3ff1873a84bc1::two_pool::set_pool_hive_addr<T0, T1, T2>(arg1, &arg0.dragon_food_cap, v0);
        let v1 = PoolHiveMigrated{
            pool_id            : arg2.pool_addr,
            new_pool_hive_addr : v0,
        };
        0x2::event::emit<PoolHiveMigrated>(v1);
    }

    fun update_values_if_inconsistent<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut DragonsDen<T0>) {
        if ((arg2.active_hive_energy > 0 || arg2.active_honey_health > 0) && 0x1::vector::length<u64>(&arg2.locked_bees) == 0) {
            let v0 = arg2.active_hive_energy;
            let v1 = arg2.active_honey_health;
            arg2.active_hive_energy = 0;
            arg2.active_honey_health = 0;
            arg1.removed_hive_energy = arg1.removed_hive_energy + v0;
            arg1.removed_honey_health = arg1.removed_honey_health + v1;
            arg0.removed_hive_energy = arg0.removed_hive_energy + v0;
            arg0.removed_honey_health = arg0.removed_honey_health + v1;
        };
    }

    fun update_votes_for_locked_bees<T0>(arg0: &DragonFood, arg1: address, arg2: &mut DragonsDen<T0>) {
        let v0 = arg0.ongoing_cycle;
        if (arg2.increment_cycle > 0 && arg2.increment_cycle < v0) {
            if (arg2.decrease_in_energy <= arg2.active_hive_energy + arg2.increase_in_energy) {
                arg2.active_hive_energy = arg2.active_hive_energy + arg2.increase_in_energy - arg2.decrease_in_energy;
            };
            if (arg2.decrease_in_health <= arg2.active_honey_health + arg2.increase_in_health) {
                arg2.active_honey_health = arg2.active_honey_health + arg2.increase_in_health - arg2.decrease_in_health;
            };
            arg2.increment_cycle = 0;
            arg2.increase_in_energy = 0;
            arg2.increase_in_health = 0;
            arg2.decrease_in_energy = 0;
            arg2.decrease_in_health = 0;
            let v1 = ActiveVotesForTrainerUpdated{
                trainer_addr        : arg1,
                cur_cycle           : v0,
                active_hive_energy  : arg2.active_hive_energy,
                active_honey_health : arg2.active_honey_health,
            };
            0x2::event::emit<ActiveVotesForTrainerUpdated>(v1);
        };
    }

    fun verify_and_extract_dragon_den<T0>(arg0: &DragonFood, arg1: &mut PoolHive<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : DragonsDen<T0> {
        assert!(arg0.module_version == 3 && arg1.module_version == 3, 7038);
        assert!(0x2::linked_table::contains<address, DragonsDen<T0>>(&arg1.resting_dragons, arg2), 7011);
        access_dragon_den<T0>(arg1, arg2, arg3)
    }

    public entry fun vote_on_global_emissions<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg2);
        let v3 = verify_and_extract_dragon_den<T0>(arg0, arg1, v0, arg5);
        let v4 = &mut v3;
        internal_vote_on_emissions<T0>(arg0, v0, v4, arg3, arg4, arg5);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg1.resting_dragons, v0, v3);
    }

    public entry fun vote_on_global_emissions_with_comp_trainer<T0>(arg0: &mut DragonFood, arg1: &mut PoolHive<T0>, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonSchool, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_dragon_school_meta_info(arg2);
        let v3 = verify_and_extract_dragon_den<T0>(arg0, arg1, v0, arg5);
        let v4 = &mut v3;
        internal_vote_on_emissions<T0>(arg0, v0, v4, arg3, arg4, arg5);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg1.resting_dragons, v0, v3);
    }

    public fun withdraw_dragon_bee<T0>(arg0: &0x2::clock::Clock, arg1: &mut DragonFood, arg2: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::BeesManager, arg3: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::YieldFarm, arg4: &mut PoolHive<T0>, arg5: &mut 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::DragonTrainer, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE> {
        assert!(arg1.module_version == 3, 7038);
        let (v0, _, _) = 0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::get_trainer_meta_info(arg5);
        let (v3, v4, v5) = internal_withdraw_dragon_bee<T0>(arg1, arg4, v0, arg6, arg7);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = access_dragon_den<T0>(arg4, v0, arg7);
        if (0x1::vector::length<u64>(&v9.locked_bees) == 0 && 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&v6) > 0) {
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::charge_mystical_bee(&arg1.dragon_food_cap, &mut v8, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7));
            0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::infuse_bee_and_trainer_with_honey(arg0, arg3, arg5, &mut v8, 0x2::balance::withdraw_all<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::honey::HONEY>(&mut v6), arg7);
        };
        0x84f8a4ed68568c4f30592d03dfcaf7bedcae27e3a1e84a1ba7dfd4886c511cbc::dragon_trainer::dragon_food_deposit_bee(&arg1.dragon_food_cap, arg2, arg5, v8);
        let v10 = &mut v9;
        feed_dragon_bee<T0>(arg0, arg1, arg4, arg3, v0, arg5, v10, v6, 0x2::balance::value<0x50c2216a078d3bdf5081fe436df9f42dfdbe538ebd9c935913ce2436362cff90::hive::HIVE>(&v7), arg7);
        0x2::linked_table::push_back<address, DragonsDen<T0>>(&mut arg4.resting_dragons, v0, v9);
        lock_hive_if_trading_disabled(arg5, arg3, v7)
    }

    // decompiled from Move bytecode v6
}

