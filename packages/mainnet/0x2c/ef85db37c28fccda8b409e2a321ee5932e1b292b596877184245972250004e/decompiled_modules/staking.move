module 0x2cef85db37c28fccda8b409e2a321ee5932e1b292b596877184245972250004e::staking {
    struct Staked has copy, drop {
        player: address,
        amount: u64,
    }

    struct Unstaked has copy, drop {
        player: address,
        amount: u64,
    }

    struct RewardsClaimed has copy, drop {
        player: address,
        gts: u64,
    }

    struct StakePool has key {
        id: 0x2::object::UID,
        staked: 0x2::balance::Balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>,
        rewards: 0x2::balance::Balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>,
        total_staked: u64,
        acc_reward_per_share: u128,
        reward_rate: u128,
        period_finish: u64,
        last_update: u64,
    }

    struct StakePosition has store, key {
        id: 0x2::object::UID,
        amount: u64,
        acc_snapshot: u128,
        pending: u64,
    }

    public(friend) fun add_rewards(arg0: &mut StakePool, arg1: 0x2::balance::Balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        update(arg0, v0);
        let v1 = 0x2::balance::value<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&arg1);
        0x2::balance::join<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&mut arg0.rewards, arg1);
        if (v1 == 0) {
            return
        };
        let v2 = if (arg0.period_finish > v0) {
            ((arg0.period_finish - v0) as u128) * arg0.reward_rate
        } else {
            0
        };
        arg0.reward_rate = ((v1 as u128) * 1000000000000 + v2) / (604800000 as u128);
        arg0.period_finish = v0 + 604800000;
        arg0.last_update = v0;
    }

    public fun claim_rewards(arg0: &mut StakePool, arg1: &mut StakePosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS> {
        update(arg0, 0x2::clock::timestamp_ms(arg2));
        settle_position(arg0, arg1);
        let v0 = 0x2::balance::value<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&arg0.rewards);
        let v1 = if (arg1.pending > v0) {
            v0
        } else {
            arg1.pending
        };
        arg1.pending = arg1.pending - v1;
        if (v1 > 0) {
            let v2 = RewardsClaimed{
                player : 0x2::tx_context::sender(arg3),
                gts    : v1,
            };
            0x2::event::emit<RewardsClaimed>(v2);
        };
        0x2::coin::from_balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(0x2::balance::split<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&mut arg0.rewards, v1), arg3)
    }

    public fun close_position(arg0: StakePosition) {
        let StakePosition {
            id           : v0,
            amount       : v1,
            acc_snapshot : _,
            pending      : v3,
        } = arg0;
        assert!(v1 == 0 && v3 == 0, 3);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StakePool{
            id                   : 0x2::object::new(arg0),
            staked               : 0x2::balance::zero<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(),
            rewards              : 0x2::balance::zero<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(),
            total_staked         : 0,
            acc_reward_per_share : 0,
            reward_rate          : 0,
            period_finish        : 0,
            last_update          : 0,
        };
        0x2::transfer::share_object<StakePool>(v0);
    }

    public fun new_position(arg0: &mut 0x2::tx_context::TxContext) : StakePosition {
        StakePosition{
            id           : 0x2::object::new(arg0),
            amount       : 0,
            acc_snapshot : 0,
            pending      : 0,
        }
    }

    public fun pending_rewards(arg0: &StakePool, arg1: &StakePosition, arg2: u64) : u64 {
        let v0 = arg0.acc_reward_per_share;
        let v1 = v0;
        if (arg0.total_staked > 0 && arg2 > arg0.last_update) {
            let v2 = if (arg2 < arg0.period_finish) {
                arg2
            } else {
                arg0.period_finish
            };
            if (v2 > arg0.last_update) {
                v1 = v0 + arg0.reward_rate * ((v2 - arg0.last_update) as u128) / (arg0.total_staked as u128);
            };
        };
        arg1.pending + (((arg1.amount as u128) * (v1 - arg1.acc_snapshot) / 1000000000000) as u64)
    }

    public fun position_amount(arg0: &StakePosition) : u64 {
        arg0.amount
    }

    fun settle_position(arg0: &StakePool, arg1: &mut StakePosition) {
        arg1.pending = arg1.pending + (((arg1.amount as u128) * (arg0.acc_reward_per_share - arg1.acc_snapshot) / 1000000000000) as u64);
        arg1.acc_snapshot = arg0.acc_reward_per_share;
    }

    public fun stake(arg0: &mut StakePool, arg1: &mut StakePosition, arg2: 0x2::coin::Coin<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&arg2);
        assert!(v0 > 0, 1);
        update(arg0, 0x2::clock::timestamp_ms(arg3));
        settle_position(arg0, arg1);
        0x2::balance::join<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&mut arg0.staked, 0x2::coin::into_balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(arg2));
        arg1.amount = arg1.amount + v0;
        arg0.total_staked = arg0.total_staked + v0;
        let v1 = Staked{
            player : 0x2::tx_context::sender(arg4),
            amount : v0,
        };
        0x2::event::emit<Staked>(v1);
    }

    public fun total_staked(arg0: &StakePool) : u64 {
        arg0.total_staked
    }

    public fun unstake(arg0: &mut StakePool, arg1: &mut StakePosition, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS> {
        assert!(arg2 > 0, 1);
        assert!(arg2 <= arg1.amount, 2);
        update(arg0, 0x2::clock::timestamp_ms(arg3));
        settle_position(arg0, arg1);
        arg1.amount = arg1.amount - arg2;
        arg0.total_staked = arg0.total_staked - arg2;
        let v0 = Unstaked{
            player : 0x2::tx_context::sender(arg4),
            amount : arg2,
        };
        0x2::event::emit<Unstaked>(v0);
        0x2::coin::from_balance<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(0x2::balance::split<0x39019f183d8d19df19bd7c3e14fed735c7a1b11e2aa02669eba1089602394c3e::gts::GTS>(&mut arg0.staked, arg2), arg4)
    }

    fun update(arg0: &mut StakePool, arg1: u64) {
        if (arg1 <= arg0.last_update) {
            return
        };
        if (arg0.total_staked == 0) {
            if (arg0.period_finish > arg0.last_update) {
                arg0.period_finish = arg1 + arg0.period_finish - arg0.last_update;
            };
        } else {
            let v0 = if (arg1 < arg0.period_finish) {
                arg1
            } else {
                arg0.period_finish
            };
            if (v0 > arg0.last_update) {
                arg0.acc_reward_per_share = arg0.acc_reward_per_share + arg0.reward_rate * ((v0 - arg0.last_update) as u128) / (arg0.total_staked as u128);
            };
        };
        arg0.last_update = arg1;
    }

    // decompiled from Move bytecode v7
}

