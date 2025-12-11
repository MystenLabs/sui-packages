module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::gameplay {
    struct AurTreasuryCapDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RoundDfKey has copy, drop, store {
        round_id: u64,
    }

    struct MinerDfKey has copy, drop, store {
        miner_address: address,
    }

    struct Gameplay has key {
        id: 0x2::object::UID,
        total_blocks: u64,
        current_round_id: u64,
        motherlode: u64,
        sui_bank: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<0x2::sui::SUI>,
        aur_bank: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>,
        deployed_reserve: u64,
        deployed_buy_aur: u64,
        deployed_automate_fee: u64,
        staking_rewards: u64,
        staking_duration_ms: u64,
        miner_rewards_factor: u256,
        total_aur_unclaimed: u64,
        total_refined: u64,
        automate_fixed_fee_per_round: u64,
        automate_random_fixed_fee_per_round: u64,
        automate_fee_per_block: u64,
        automate_nodes: 0x2::linked_table::LinkedTable<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>,
    }

    struct DeployEvent has copy, drop {
        miner_address: address,
        round_id: u64,
        block_ids: vector<u64>,
        amount_per_block: u64,
        cumulative_ends: vector<u64>,
        timestamp_ms: u64,
    }

    struct EndRoundEvent has copy, drop {
        round_id: u64,
        is_motherlode: bool,
        motherlode: u64,
        lucky_cumulative: 0x1::option::Option<u64>,
        lucky_block_id: u64,
        winners: u64,
        total_deployed: u64,
        rewards_deployed: u64,
        rewards_aur: u64,
        total_deployed_of_lucky_block: u64,
        timestamp_ms: u64,
    }

    struct ClaimRewardsSuiEvent has copy, drop {
        amount: u64,
    }

    struct ClaimRewardsAurEvent has copy, drop {
        amount: u64,
    }

    struct GetGameplayInfoBlockResult has copy, drop {
        id: u64,
        total_miner: u64,
        total_deployed: u64,
        my_deployed: u64,
        my_cumulative_start: u64,
        my_cumulative_end: u64,
    }

    struct GetGameplayInfoResult has copy, drop {
        total_blocks: u64,
        current_round_id: u64,
        start_round_at_ms: u64,
        ended_round_at_ms: u64,
        motherlode: u64,
        lucky_block_id: 0x1::option::Option<u64>,
        lucky_cumulative: 0x1::option::Option<u64>,
        blocks: vector<GetGameplayInfoBlockResult>,
    }

    struct GetAutomateResult has copy, drop {
        deployed_amount_per_block: u64,
        blocks_per_round: u64,
        is_auto_strategy: bool,
        round_left: u64,
        block_ids: 0x1::option::Option<vector<u64>>,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Gameplay {
        Gameplay{
            id                                  : 0x2::object::new(arg1),
            total_blocks                        : arg0,
            current_round_id                    : 0,
            motherlode                          : 0,
            sui_bank                            : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::new<0x2::sui::SUI>(),
            aur_bank                            : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::new<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>(),
            deployed_reserve                    : 0,
            deployed_buy_aur                    : 0,
            deployed_automate_fee               : 0,
            staking_rewards                     : 0,
            staking_duration_ms                 : 0,
            miner_rewards_factor                : 0,
            total_aur_unclaimed                 : 0,
            total_refined                       : 0,
            automate_fixed_fee_per_round        : 500000,
            automate_random_fixed_fee_per_round : 1050000,
            automate_fee_per_block              : 100000,
            automate_nodes                      : 0x2::linked_table::new<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(arg1),
        }
    }

    fun borrow_aur_treasury_cap(arg0: &Gameplay) : &0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR> {
        let v0 = AurTreasuryCapDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AurTreasuryCapDfKey>(&arg0.id, v0), 1);
        let v1 = AurTreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<AurTreasuryCapDfKey, 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(&arg0.id, v1)
    }

    public fun borrow_current_round(arg0: &Gameplay) : &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round {
        let v0 = RoundDfKey{round_id: arg0.current_round_id};
        0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg0.id, v0)
    }

    fun borrow_mut_aur_treasury_cap(arg0: &mut Gameplay) : &mut 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR> {
        let v0 = AurTreasuryCapDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AurTreasuryCapDfKey>(&arg0.id, v0), 1);
        let v1 = AurTreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AurTreasuryCapDfKey, 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(&mut arg0.id, v1)
    }

    public entry fun burn_aur(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: 0x2::coin::Coin<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::burn_internal(borrow_mut_aur_treasury_cap(arg1), arg2);
    }

    fun calculate_automate_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg0 * (arg2 + arg1 * arg3)
    }

    public entry fun claim_automate_fee(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        arg2.deployed_automate_fee = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg2.sui_bank, arg2.deployed_automate_fee, arg4), arg3);
    }

    public entry fun claim_rewards_aur(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MinerDfKey{miner_address: v0};
        assert!(0x2::dynamic_field::exists_<MinerDfKey>(&arg1.id, v1), 8);
        process_checkpoint(arg1, v0);
        let v2 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg1.id, v1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::update_rewards(v2, arg1.miner_rewards_factor);
        let v3 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_refined_aur(v2);
        let v4 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(v2);
        let v5 = v3 + v4;
        let v6 = v5;
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_refined_aur(v2, 0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_rewards_aur(v2, 0);
        arg1.total_aur_unclaimed = arg1.total_aur_unclaimed - v4;
        arg1.total_refined = arg1.total_refined - v3;
        if (arg1.total_aur_unclaimed > 0) {
            let v7 = v4 / 10;
            v6 = v5 - v7;
            arg1.miner_rewards_factor = arg1.miner_rewards_factor + ((v7 * 1000000 / arg1.total_aur_unclaimed) as u256);
            arg1.total_refined = arg1.total_refined + v7;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>(&mut arg1.aur_bank, v6, arg2), v0);
        let v8 = ClaimRewardsAurEvent{amount: v6};
        0x2::event::emit<ClaimRewardsAurEvent>(v8);
    }

    public entry fun claim_rewards_sui(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MinerDfKey{miner_address: v0};
        assert!(0x2::dynamic_field::exists_<MinerDfKey>(&arg1.id, v1), 8);
        process_checkpoint(arg1, v0);
        let v2 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg1.id, v1);
        let v3 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_sui(v2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_rewards_sui(v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg1.sui_bank, v3, arg2), v0);
        let v4 = ClaimRewardsSuiEvent{amount: v3};
        0x2::event::emit<ClaimRewardsSuiEvent>(v4);
    }

    public entry fun claim_sui_reserve(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        arg2.deployed_reserve = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg2.sui_bank, arg2.deployed_reserve, arg4), arg3);
    }

    public entry fun claim_sui_to_buy_aur(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        arg2.deployed_buy_aur = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg2.sui_bank, arg2.deployed_buy_aur, arg4), arg3);
    }

    fun deploy_automate(arg0: &mut Gameplay, arg1: &0x2::clock::Clock) {
        let v0 = *0x2::linked_table::front<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg0.automate_nodes);
        while (!0x1::option::is_none<address>(&v0)) {
            let v1 = *0x1::option::borrow<address>(&v0);
            v0 = *0x2::linked_table::next<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg0.automate_nodes, v1);
            let v2 = 0x2::linked_table::borrow_mut<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg0.automate_nodes, v1);
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::decrease_round_left(v2, 1);
            let v3 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_round_left(v2);
            let v4 = 0x2::linked_table::borrow_mut<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg0.automate_nodes, v1);
            if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_is_auto_strategy(v4)) {
                0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::increase_seed(v4, 1);
                deploy_with_amount(arg0, random_block_ids(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_seed(v4), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_blocks_per_round(v4)), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_deployed_amount_per_block(v4), arg1, v1);
            } else {
                deploy_with_amount(arg0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_block_ids(v4), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_deployed_amount_per_block(v4), arg1, v1);
            };
            arg0.deployed_automate_fee = arg0.deployed_automate_fee + 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_fee_per_round(v4);
            if (v3 == 0) {
                0x2::linked_table::remove<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg0.automate_nodes, v1);
            };
        };
    }

    fun deploy_with_amount(arg0: &mut Gameplay, arg1: vector<u64>, arg2: u64, arg3: &0x2::clock::Clock, arg4: address) {
        process_checkpoint(arg0, arg4);
        let v0 = MinerDfKey{miner_address: arg4};
        if (!0x2::dynamic_field::exists_<MinerDfKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::new());
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg1)) {
            let v3 = *0x1::vector::borrow<u64>(&arg1, v2);
            v2 = v2 + 1;
            assert!(0 < v3 && v3 <= arg0.total_blocks, 9);
            let v4 = RoundDfKey{round_id: arg0.current_round_id};
            let v5 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::deploy(0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg0.id, v4), v3, arg2);
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::deploy(0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v0), v3, arg2, v5);
            0x1::vector::push_back<u64>(&mut v1, v5);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v0);
        if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_round_id(v6) != arg0.current_round_id) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_round_id(v6, arg0.current_round_id);
        };
        let v7 = DeployEvent{
            miner_address    : arg4,
            round_id         : arg0.current_round_id,
            block_ids        : arg1,
            amount_per_block : arg2,
            cumulative_ends  : v1,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeployEvent>(v7);
    }

    public entry fun deposit_sui(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0x2::sui::SUI>(&mut arg2.sui_bank, arg3);
    }

    public entry fun end_round(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        end_round_internal(arg1, arg3, arg4, arg5);
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::utils::to_seconds(0x2::clock::timestamp_ms(arg4));
        if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::ended_at(arg2) > v0) {
            return
        };
        let v1 = arg1.staking_rewards;
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::utils::to_seconds(arg1.staking_duration_ms);
        if (v2 == 0) {
            return
        };
        arg1.staking_rewards = 0;
        arg1.staking_duration_ms = 0;
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::operator::set_reward_per_sec_internal(arg2, v1 / v2, arg4);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::operator::set_ended_at_sec_internal(arg2, v0 + v2, arg4);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::operator::deposit_reward_token_custodian(arg2, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg1.sui_bank, v1, arg5));
    }

    fun end_round_internal(arg0: &mut Gameplay, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.current_round_id > 0, 3);
        let v1 = RoundDfKey{round_id: arg0.current_round_id};
        let v2 = 0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg0.id, v1);
        assert!(v0 >= 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_ended_at_ms(v2) && !0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_ended(v2), 2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_is_ended(v2, true);
        let v3 = 0x2::random::new_generator(arg1, arg3);
        let v4 = 0x1::vector::length<u64>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_ids(v2));
        let v5 = get_total_supply(arg0);
        let v6 = borrow_mut_aur_treasury_cap(arg0);
        if (v4 == 0) {
            if (v5 + 500000000 <= 10000000000000000) {
                arg0.motherlode = arg0.motherlode + 500000000;
                0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>(&mut arg0.aur_bank, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::mint_internal(v6, 500000000, arg3));
            };
            let v7 = RoundDfKey{round_id: arg0.current_round_id};
            let v8 = 0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg0.id, v7);
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_lucky_block_id(v8, 0x2::random::generate_u64_in_range(&mut v3, 1, arg0.total_blocks));
            let v9 = EndRoundEvent{
                round_id                      : arg0.current_round_id,
                is_motherlode                 : false,
                motherlode                    : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_motherlode(v8),
                lucky_cumulative              : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_option_lucky_cumulative(v8),
                lucky_block_id                : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_lucky_block_id(v8),
                winners                       : 0,
                total_deployed                : 0,
                rewards_deployed              : 0,
                rewards_aur                   : 0,
                total_deployed_of_lucky_block : 0,
                timestamp_ms                  : v0,
            };
            0x2::event::emit<EndRoundEvent>(v9);
            return
        };
        if (v5 + 500000000 + 1000000000 <= 10000000000000000) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>(&mut arg0.aur_bank, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::mint_internal(v6, 500000000 + 1000000000, arg3));
            arg0.motherlode = arg0.motherlode + 500000000;
            let v10 = RoundDfKey{round_id: arg0.current_round_id};
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_rewards_aur(0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg0.id, v10), 1000000000);
        };
        let v11 = RoundDfKey{round_id: arg0.current_round_id};
        let v12 = 0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg0.id, v11);
        let v13 = *0x1::vector::borrow<u64>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_ids(v12), 0x2::random::generate_u64_in_range(&mut v3, 1 - 1, v4 - 1));
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_lucky_block_id(v12, v13);
        let (v14, v15) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_info(v12, v13);
        if (is_even(v13)) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_lucky_cumulative(v12, 0x1::option::some<u64>(0x2::random::generate_u64_in_range(&mut v3, 1, v15)));
        };
        if (0x2::random::generate_u64_in_range(&mut v3, 1, 256) <= 1) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_is_motherlode(v12, true);
            arg0.motherlode = 0;
        };
        let v16 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_total_deployed(v12);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::set_rewards_deployed(v12, v16 * (1000000 - 60000 - 50000 - 10000) / 1000000);
        arg0.deployed_reserve = arg0.deployed_reserve + v16 * 10000 / 1000000;
        arg0.deployed_buy_aur = arg0.deployed_buy_aur + v16 * 60000 / 1000000;
        arg0.staking_rewards = arg0.staking_rewards + v16 * 50000 / 1000000;
        arg0.staking_duration_ms = arg0.staking_duration_ms + 60000;
        let v17 = EndRoundEvent{
            round_id                      : arg0.current_round_id,
            is_motherlode                 : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_motherlode(v12),
            motherlode                    : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_motherlode(v12),
            lucky_cumulative              : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_option_lucky_cumulative(v12),
            lucky_block_id                : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_lucky_block_id(v12),
            winners                       : v14,
            total_deployed                : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_total_deployed(v12),
            rewards_deployed              : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_rewards_deployed(v12),
            rewards_aur                   : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_rewards_aur(v12),
            total_deployed_of_lucky_block : v15,
            timestamp_ms                  : v0,
        };
        0x2::event::emit<EndRoundEvent>(v17);
    }

    public entry fun get_automate(arg0: &Gameplay, arg1: &0x2::tx_context::TxContext) : GetAutomateResult {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::linked_table::contains<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg0.automate_nodes, v0)) {
            return GetAutomateResult{
                deployed_amount_per_block : 0,
                blocks_per_round          : 0,
                is_auto_strategy          : false,
                round_left                : 0,
                block_ids                 : 0x1::option::none<vector<u64>>(),
            }
        };
        let v1 = 0x2::linked_table::borrow<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg0.automate_nodes, v0);
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_is_auto_strategy(v1);
        if (v2) {
            GetAutomateResult{deployed_amount_per_block: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_deployed_amount_per_block(v1), blocks_per_round: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_blocks_per_round(v1), is_auto_strategy: v2, round_left: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_round_left(v1), block_ids: 0x1::option::none<vector<u64>>()}
        } else {
            GetAutomateResult{deployed_amount_per_block: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_deployed_amount_per_block(v1), blocks_per_round: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_blocks_per_round(v1), is_auto_strategy: v2, round_left: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_round_left(v1), block_ids: 0x1::option::some<vector<u64>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_block_ids(v1))}
        }
    }

    public entry fun get_gameplay_info(arg0: &Gameplay, arg1: &0x2::tx_context::TxContext) : GetGameplayInfoResult {
        assert!(arg0.current_round_id > 0, 3);
        let v0 = RoundDfKey{round_id: arg0.current_round_id};
        let v1 = 0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg0.id, v0);
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_ids(v1);
        let v3 = 0;
        let v4 = 0x1::vector::empty<GetGameplayInfoBlockResult>();
        let v5 = MinerDfKey{miner_address: 0x2::tx_context::sender(arg1)};
        let v6 = if (!0x2::dynamic_field::exists_<MinerDfKey>(&arg0.id, v5)) {
            let v7 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::new();
            &v7
        } else {
            0x2::dynamic_field::borrow<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&arg0.id, v5)
        };
        while (v3 < 0x1::vector::length<u64>(v2)) {
            let v8 = 0x1::vector::borrow<u64>(v2, v3);
            v3 = v3 + 1;
            let (v9, v10) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_info(v1, *v8);
            let (v11, v12, v13) = if (arg0.current_round_id == 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_round_id(v6)) {
                0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_block_info(v6, *v8)
            } else {
                (0, 0, 0)
            };
            let v14 = GetGameplayInfoBlockResult{
                id                  : *v8,
                total_miner         : v9,
                total_deployed      : v10,
                my_deployed         : v11,
                my_cumulative_start : v12,
                my_cumulative_end   : v13,
            };
            0x1::vector::push_back<GetGameplayInfoBlockResult>(&mut v4, v14);
        };
        GetGameplayInfoResult{
            total_blocks      : arg0.total_blocks,
            current_round_id  : arg0.current_round_id,
            start_round_at_ms : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_start_at_ms(v1),
            ended_round_at_ms : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_ended_at_ms(v1),
            motherlode        : arg0.motherlode,
            lucky_block_id    : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_option_lucky_block_id(v1),
            lucky_cumulative  : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_option_lucky_cumulative(v1),
            blocks            : v4,
        }
    }

    public fun get_miner_info(arg0: &mut Gameplay, arg1: &mut 0x2::tx_context::TxContext) : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MinerDfKey{miner_address: v0};
        if (!0x2::dynamic_field::exists_<MinerDfKey>(&arg0.id, v1)) {
            return 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::new()
        };
        process_checkpoint(arg0, v0);
        let v2 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::update_rewards(v2, arg0.miner_rewards_factor);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::clone_miner(v2)
    }

    public fun get_total_supply(arg0: &Gameplay) : u64 {
        0x2::coin::total_supply<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>(borrow_aur_treasury_cap(arg0))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Gameplay>(new(16, arg0));
    }

    fun is_even(arg0: u64) : bool {
        arg0 % 2 == 0
    }

    public entry fun manual_deploy(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: vector<u64>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        assert!(arg1.current_round_id > 0, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::linked_table::contains<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg1.automate_nodes, v0), 10);
        let v1 = 0x1::vector::length<u64>(&arg2);
        assert!(0 < v1 && v1 <= arg1.total_blocks, 11);
        assert!(100000 <= arg3 && arg3 <= 1000000000000000, 7);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v3 = 0x1::vector::length<u64>(&arg2) * arg3;
        assert!(v3 <= v2, 12);
        let v4 = RoundDfKey{round_id: arg1.current_round_id};
        let v5 = 0x2::dynamic_field::borrow_mut<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg1.id, v4);
        let v6 = 0x2::clock::timestamp_ms(arg5);
        assert!(v6 >= 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_start_at_ms(v5), 5);
        assert!(v6 < 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_ended_at_ms(v5), 6);
        deploy_with_amount(arg1, arg2, arg3, arg5, v0);
        let v7 = v2 - v3;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v7, arg6), v0);
        };
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0x2::sui::SUI>(&mut arg1.sui_bank, arg4);
    }

    public entry fun next_round(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg1.current_round_id > 0) {
            let v1 = RoundDfKey{round_id: arg1.current_round_id};
            assert!(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_ended(0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg1.id, v1)), 4);
        };
        let v2 = arg1.current_round_id + 1;
        arg1.current_round_id = v2;
        let v3 = RoundDfKey{round_id: v2};
        0x2::dynamic_field::add<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&mut arg1.id, v3, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::new(v2, arg1.motherlode, v0, v0 + 60000, arg3));
        deploy_automate(arg1, arg2);
    }

    public(friend) fun process_checkpoint(arg0: &mut Gameplay, arg1: address) {
        let v0 = MinerDfKey{miner_address: arg1};
        if (!0x2::dynamic_field::exists_<MinerDfKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&arg0.id, v0);
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_round_id(v1);
        if (v2 == 0) {
            return
        };
        let v3 = RoundDfKey{round_id: v2};
        if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_checkpoint_id(v1) == v2 || !0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_ended(0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg0.id, v3))) {
            return
        };
        let v4 = RoundDfKey{round_id: v2};
        let v5 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_lucky_block_id(0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg0.id, v4));
        let v6 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_checkpoint_id(v6, v2);
        let (v7, v8, v9) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_block_info(v6, v5);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::reset_block_info(v6);
        if (v7 == 0) {
            return
        };
        let v10 = 0;
        let v11 = RoundDfKey{round_id: v2};
        let v12 = 0x2::dynamic_field::borrow<RoundDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::Round>(&arg0.id, v11);
        let (_, v14) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_block_info(v12, v5);
        let v15 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_rewards_aur(v12);
        if (is_even(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_lucky_block_id(v12))) {
            let v16 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_lucky_cumulative(v12);
            if (v8 <= v16 && v16 <= v9) {
                v10 = v15;
                if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_motherlode(v12)) {
                    v10 = v15 + 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_motherlode(v12);
                };
            };
        } else {
            let v17 = v15;
            if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_is_motherlode(v12)) {
                v17 = v15 + 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_motherlode(v12);
            };
            v10 = v17 * v7 / v14;
        };
        let v18 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round::borrow_rewards_deployed(v12) * v7 / v14;
        let v19 = 0x2::dynamic_field::borrow_mut<MinerDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::Miner>(&mut arg0.id, v0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::update_rewards(v19, arg0.miner_rewards_factor);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_rewards_aur(v19, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_aur(v19) + v10);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::set_rewards_sui(v19, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::miner::borrow_rewards_sui(v19) + v18);
        arg0.total_aur_unclaimed = arg0.total_aur_unclaimed + v10;
    }

    fun random_block_ids(arg0: u64, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, 1);
        0x1::vector::push_back<u64>(&mut v0, 2);
        0x1::vector::push_back<u64>(&mut v0, 3);
        0x1::vector::push_back<u64>(&mut v0, 4);
        0x1::vector::push_back<u64>(&mut v0, 5);
        0x1::vector::push_back<u64>(&mut v0, 6);
        0x1::vector::push_back<u64>(&mut v0, 7);
        0x1::vector::push_back<u64>(&mut v0, 8);
        0x1::vector::push_back<u64>(&mut v0, 9);
        0x1::vector::push_back<u64>(&mut v0, 10);
        0x1::vector::push_back<u64>(&mut v0, 11);
        0x1::vector::push_back<u64>(&mut v0, 12);
        0x1::vector::push_back<u64>(&mut v0, 13);
        0x1::vector::push_back<u64>(&mut v0, 14);
        0x1::vector::push_back<u64>(&mut v0, 15);
        0x1::vector::push_back<u64>(&mut v0, 16);
        if (arg1 == 16) {
            return v0
        };
        let v1 = arg0;
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < arg1) {
            v3 = v3 + 1;
            v1 = (v1 * 1664525 + 1013904223) % 4294967296;
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::swap_remove<u64>(&mut v0, v1 % 0x1::vector::length<u64>(&v0)));
        };
        v2
    }

    public entry fun set_aur_treasury_cap(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        set_aur_treasury_cap_internal(arg2, arg3);
    }

    fun set_aur_treasury_cap_internal(arg0: &mut Gameplay, arg1: 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>) {
        let v0 = AurTreasuryCapDfKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<AurTreasuryCapDfKey>(&arg0.id, v0), 0);
        let v1 = AurTreasuryCapDfKey{dummy_field: false};
        0x2::dynamic_field::add<AurTreasuryCapDfKey, 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(&mut arg0.id, v1, arg1);
    }

    public entry fun start_automate(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: u64, arg3: u64, arg4: vector<u64>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!0x2::linked_table::contains<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg1.automate_nodes, v0), 10);
        assert!(arg3 > 0, 14);
        let v1 = 0x1::vector::length<u64>(&arg4);
        assert!(0 < v1 && v1 <= arg1.total_blocks, 16);
        validate_automate_block_ids(arg1, arg4, arg6);
        let v2 = calculate_automate_fee(1, v1, arg1.automate_fixed_fee_per_round, arg1.automate_fee_per_block);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v4 = arg3 * v2 + v1 * arg2 * arg3;
        assert!(v4 <= v3, 12);
        0x2::linked_table::push_back<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg1.automate_nodes, v0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::new_automate(arg2, v1, false, 0x1::option::some<vector<u64>>(arg4), 0x1::option::none<u64>(), arg3, v2));
        let v5 = v3 - v4;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, v5, arg6), v0);
        };
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0x2::sui::SUI>(&mut arg1.sui_bank, arg5);
    }

    public entry fun start_automate_random_blocks(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::linked_table::contains<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg1.automate_nodes, v0), 10);
        assert!(arg4 > 0, 14);
        assert!(0 < arg3 && arg3 <= arg1.total_blocks, 16);
        assert!(100000 <= arg5 && arg5 <= 999999, 17);
        let v1 = calculate_automate_fee(1, arg3, arg1.automate_random_fixed_fee_per_round, arg1.automate_fee_per_block);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        let v3 = arg4 * v1 + arg3 * arg2 * arg4;
        assert!(v3 <= v2, 12);
        0x2::linked_table::push_back<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg1.automate_nodes, v0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::new_automate(arg2, arg3, true, 0x1::option::none<vector<u64>>(), 0x1::option::some<u64>(arg5), arg4, v1));
        let v4 = v2 - v3;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg6, v4, arg7), v0);
        };
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0x2::sui::SUI>(&mut arg1.sui_bank, arg6);
    }

    public entry fun stop_automate(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut Gameplay, arg2: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::linked_table::contains<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&arg1.automate_nodes, v0), 13);
        let v1 = 0x2::linked_table::remove<address, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::Automate>(&mut arg1.automate_nodes, v0);
        let v2 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_round_left(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg1.sui_bank, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_deployed_amount_per_block(&v1) * 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_blocks_per_round(&v1) * v2 + v2 * 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::automate::borrow_fee_per_round(&v1), arg2), v0);
    }

    public entry fun unset_aur_treasury_cap(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        unset_aur_treasury_cap_internal(arg2, arg3);
    }

    fun unset_aur_treasury_cap_internal(arg0: &mut Gameplay, arg1: &0x2::tx_context::TxContext) {
        let v0 = AurTreasuryCapDfKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AurTreasuryCapDfKey>(&arg0.id, v0), 1);
        let v1 = AurTreasuryCapDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(0x2::dynamic_field::remove<AurTreasuryCapDfKey, 0x2::coin::TreasuryCap<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur::AUR>>(&mut arg0.id, v1), 0x2::tx_context::sender(arg1));
    }

    public entry fun update_automate_fee(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: u64, arg4: u64, arg5: u64) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        arg2.automate_fixed_fee_per_round = arg3;
        arg2.automate_random_fixed_fee_per_round = arg4;
        arg2.automate_fee_per_block = arg5;
    }

    fun validate_automate_block_ids(arg0: &Gameplay, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u64, bool>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v1);
            assert!(0 < v2 && v2 <= arg0.total_blocks, 9);
            assert!(!0x2::table::contains<u64, bool>(&v0, v2), 15);
            0x2::table::add<u64, bool>(&mut v0, v2, true);
            v1 = v1 + 1;
        };
        0x2::table::drop<u64, bool>(v0);
    }

    public entry fun withdraw_sui(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut Gameplay, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(&mut arg2.sui_bank, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

