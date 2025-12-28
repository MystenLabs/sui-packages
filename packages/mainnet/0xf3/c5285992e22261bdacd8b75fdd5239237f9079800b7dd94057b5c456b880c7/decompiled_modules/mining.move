module 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::mining {
    struct MiningState has store, key {
        id: 0x2::object::UID,
        admin: address,
        token_state_id: address,
        active: bool,
        current_reward_rate: u64,
        total_distributed: u64,
        next_halving: u64,
        halving_count: u64,
        staked_balance: 0x2::balance::Balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>,
    }

    struct SequencerStake has store, key {
        id: 0x2::object::UID,
        sequencer: address,
        stake_amount: u64,
        performance_score: u64,
        uptime_percentage: u64,
        last_claim: u64,
        total_earned: u64,
    }

    struct MiningStats has store {
        dummy_field: bool,
    }

    struct MiningRewardDistributed has copy, drop {
        sequencer: address,
        batch_count: u64,
        tx_count: u64,
        base_reward: u64,
        bonuses: u64,
        total_reward: u64,
    }

    struct SequencerStaked has copy, drop {
        sequencer: address,
        stake_amount: u64,
        performance_score: u64,
    }

    struct SequencerUnstaked has copy, drop {
        sequencer: address,
        amount: u64,
    }

    struct MiningHalving has copy, drop {
        old_rate: u64,
        new_rate: u64,
        halving_count: u64,
    }

    fun calculate_speed_bonus(arg0: u64) : u64 {
        if (arg0 >= 90) {
            20
        } else if (arg0 >= 70) {
            20 * 3 / 4
        } else if (arg0 >= 50) {
            20 / 2
        } else {
            0
        }
    }

    fun calculate_stake_bonus(arg0: u64) : u64 {
        if (arg0 >= 1000000) {
            50
        } else if (arg0 >= 500000) {
            50 * 3 / 4
        } else if (arg0 >= 100000) {
            50 / 2
        } else {
            0
        }
    }

    fun calculate_uptime_bonus(arg0: u64) : u64 {
        if (arg0 >= 9990) {
            150 - 100
        } else if (arg0 >= 9950) {
            25
        } else if (arg0 >= 9900) {
            10
        } else {
            0
        }
    }

    fun calculate_volume_bonus(arg0: u64) : u64 {
        if (arg0 >= 10000) {
            25
        } else if (arg0 >= 5000) {
            25 * 3 / 4
        } else if (arg0 >= 1000) {
            25 / 2
        } else {
            0
        }
    }

    fun check_and_apply_halving(arg0: &mut MiningState, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.next_halving) {
            let v1 = arg0.current_reward_rate;
            arg0.current_reward_rate = v1 * 8 / 10;
            arg0.halving_count = arg0.halving_count + 1;
            arg0.next_halving = v0 + 31536000;
            let v2 = MiningHalving{
                old_rate      : v1,
                new_rate      : arg0.current_reward_rate,
                halving_count : arg0.halving_count,
            };
            0x2::event::emit<MiningHalving>(v2);
        };
    }

    public fun current_reward_rate(arg0: &MiningState) : u64 {
        arg0.current_reward_rate
    }

    public entry fun distribute_batch_rewards(arg0: &mut MiningState, arg1: &mut 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::TokenState, arg2: &0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::AdminCap, arg3: &mut SequencerStake, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(arg4 > 0 && arg4 <= 1000, 2);
        assert!(arg5 <= 100000, 2);
        assert!(arg6 <= 10000, 2);
        assert!(arg0.admin == 0x2::tx_context::sender(arg8), 1);
        check_and_apply_halving(arg0, arg7);
        let v0 = arg4 * arg0.current_reward_rate;
        let v1 = (((v0 as u128) * ((calculate_speed_bonus(arg3.performance_score) + calculate_volume_bonus(arg5) + calculate_stake_bonus(arg3.stake_amount) + calculate_uptime_bonus(arg6)) as u128) / 100) as u64);
        let v2 = v0 + arg5 * 5 / 1000 + v1;
        assert!(0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::mining_pool_balance(arg1) >= v2, 3);
        0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::distribute_mining_reward(arg2, arg1, arg3.sequencer, v2, arg8);
        arg3.total_earned = arg3.total_earned + v2;
        arg3.uptime_percentage = arg6;
        arg3.last_claim = 0x2::clock::timestamp_ms(arg7);
        arg0.total_distributed = arg0.total_distributed + v2;
        let v3 = MiningRewardDistributed{
            sequencer    : arg3.sequencer,
            batch_count  : arg4,
            tx_count     : arg5,
            base_reward  : v0,
            bonuses      : v1,
            total_reward : v2,
        };
        0x2::event::emit<MiningRewardDistributed>(v3);
    }

    public entry fun force_halving(arg0: &mut MiningState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        let v0 = arg0.current_reward_rate;
        arg0.current_reward_rate = v0 * 8 / 10;
        arg0.halving_count = arg0.halving_count + 1;
        arg0.next_halving = 0x2::clock::timestamp_ms(arg1) + 31536000;
        let v1 = MiningHalving{
            old_rate      : v0,
            new_rate      : arg0.current_reward_rate,
            halving_count : arg0.halving_count,
        };
        0x2::event::emit<MiningHalving>(v1);
    }

    public fun get_sequencer_performance(arg0: &SequencerStake) : u64 {
        arg0.performance_score
    }

    public fun get_sequencer_stake(arg0: &SequencerStake) : u64 {
        arg0.stake_amount
    }

    public entry fun init_mining(arg0: &0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::TokenState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MiningState{
            id                  : 0x2::object::new(arg2),
            admin               : 0x2::tx_context::sender(arg2),
            token_state_id      : 0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::token_state_address(arg0),
            active              : true,
            current_reward_rate : 25,
            total_distributed   : 0,
            next_halving        : 0x2::clock::timestamp_ms(arg1) + 31536000,
            halving_count       : 0,
            staked_balance      : 0x2::balance::zero<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(),
        };
        0x2::transfer::share_object<MiningState>(v0);
    }

    public fun is_mining_active(arg0: &MiningState) : bool {
        arg0.active
    }

    public entry fun set_mining_active(arg0: &mut MiningState, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.active = arg1;
    }

    public entry fun stake_for_sequencing(arg0: &mut MiningState, arg1: 0x2::coin::Coin<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 4);
        assert!(arg2 <= 100, 5);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&arg1);
        assert!(v1 > 0, 5);
        0x2::balance::join<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.staked_balance, 0x2::coin::into_balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(arg1));
        let v2 = SequencerStake{
            id                : 0x2::object::new(arg4),
            sequencer         : v0,
            stake_amount      : v1,
            performance_score : arg2,
            uptime_percentage : 10000,
            last_claim        : 0x2::clock::timestamp_ms(arg3),
            total_earned      : 0,
        };
        0x2::transfer::transfer<SequencerStake>(v2, v0);
        let v3 = SequencerStaked{
            sequencer         : v0,
            stake_amount      : v1,
            performance_score : arg2,
        };
        0x2::event::emit<SequencerStaked>(v3);
    }

    public fun total_rewards_distributed(arg0: &MiningState) : u64 {
        arg0.total_distributed
    }

    public entry fun withdraw_sequencer_stake(arg0: &mut MiningState, arg1: SequencerStake, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.sequencer == v0, 1);
        let v1 = arg1.stake_amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>>(0x2::coin::from_balance<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(0x2::balance::split<0xf3c5285992e22261bdacd8b75fdd5239237f9079800b7dd94057b5c456b880c7::limen_token::LIMEN_TOKEN>(&mut arg0.staked_balance, v1), arg2), v0);
        let SequencerStake {
            id                : v2,
            sequencer         : _,
            stake_amount      : _,
            performance_score : _,
            uptime_percentage : _,
            last_claim        : _,
            total_earned      : _,
        } = arg1;
        0x2::object::delete(v2);
        let v9 = SequencerUnstaked{
            sequencer : v0,
            amount    : v1,
        };
        0x2::event::emit<SequencerUnstaked>(v9);
    }

    // decompiled from Move bytecode v6
}

