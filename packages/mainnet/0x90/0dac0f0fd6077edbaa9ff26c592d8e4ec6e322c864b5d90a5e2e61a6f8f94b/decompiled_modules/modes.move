module 0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::modes {
    struct StateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct State<phantom T0> has store {
        claim: 0x2::balance::Balance<T0>,
        buyback: 0x2::balance::Balance<T0>,
        rewards: 0x2::balance::Balance<T0>,
        total_staked: u64,
        acc_per_token: u256,
        queued: u64,
        streaming: u64,
        last_ms: u64,
        end_ms: u64,
        total_rewards: u64,
    }

    struct Stake<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        tokens: 0x2::balance::Balance<T0>,
        reward_debt: u256,
    }

    struct FeesDistributed has copy, drop {
        pool: 0x2::object::ID,
        creator: u64,
        buyback: u64,
        holders: u64,
    }

    struct RewardsReleased has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
        to_buyback: bool,
        streaming_left: u64,
        end_ms: u64,
    }

    struct Staked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct Unstaked has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_staked: u64,
    }

    struct RewardsClaimed has copy, drop {
        pool: 0x2::object::ID,
        stake: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct CreatorClaimed has copy, drop {
        pool: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    public(friend) fun add<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Stake<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: address) {
        let v0 = 0x2::object::uid_to_inner(arg0);
        assert!(arg1.pool_id == v0, 902);
        let v1 = 0x2::balance::value<T0>(&arg2);
        assert!(v1 > 0, 903);
        let v2 = state_mut<T1>(arg0);
        v2.total_staked = v2.total_staked + v1;
        0x2::balance::join<T0>(&mut arg1.tokens, arg2);
        arg1.reward_debt = (0x2::balance::value<T0>(&arg1.tokens) as u256) * v2.acc_per_token;
        let v3 = Staked{
            pool         : v0,
            stake        : 0x2::object::id<Stake<T0, T1>>(arg1),
            owner        : arg3,
            amount       : v1,
            total_staked : v2.total_staked,
        };
        0x2::event::emit<Staked>(v3);
    }

    public(friend) fun claim<T0, T1>(arg0: &mut 0x2::object::UID, arg1: &mut Stake<T0, T1>, arg2: address) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::object::uid_to_inner(arg0);
        assert!(arg1.pool_id == v0, 902);
        let v1 = state_mut<T1>(arg0);
        let v2 = (0x2::balance::value<T0>(&arg1.tokens) as u256) * v1.acc_per_token;
        let v3 = (((v2 - arg1.reward_debt) / 1000000000000000000) as u64);
        arg1.reward_debt = v2;
        let v4 = 0x2::balance::value<T1>(&v1.rewards) - v1.queued + v1.streaming;
        let v5 = if (v3 < v4) {
            v3
        } else {
            v4
        };
        if (v5 > 0) {
            let v6 = RewardsClaimed{
                pool   : v0,
                stake  : 0x2::object::id<Stake<T0, T1>>(arg1),
                owner  : arg2,
                amount : v5,
            };
            0x2::event::emit<RewardsClaimed>(v6);
        };
        0x2::balance::split<T1>(&mut v1.rewards, v5)
    }

    public(friend) fun distribute<T0>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::object::uid_to_inner(arg0);
        let v2 = state_mut<T0>(arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        let (_, v4, v5) = split_of(arg1);
        let v6 = 0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::math::mul_div(v0, v4, 10000);
        let v7 = v6;
        let v8 = 0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::math::mul_div(v0, v5, 10000);
        let v9 = 0;
        if (v8 > 0) {
            if (v2.total_staked > 0) {
                v2.queued = v2.queued + v8;
                0x2::balance::join<T0>(&mut v2.rewards, 0x2::balance::split<T0>(&mut arg2, v8));
                v9 = v8;
            } else {
                v7 = v6 + v8;
            };
        };
        0x2::balance::join<T0>(&mut v2.buyback, 0x2::balance::split<T0>(&mut arg2, v7));
        0x2::balance::join<T0>(&mut v2.claim, arg2);
        let v10 = FeesDistributed{
            pool    : v1,
            creator : 0x2::balance::value<T0>(&arg2),
            buyback : v7,
            holders : v9,
        };
        0x2::event::emit<FeesDistributed>(v10);
    }

    public fun has_holders(arg0: u8) : bool {
        arg0 == 2 || arg0 == 3
    }

    public fun is_mode(arg0: u8) : bool {
        arg0 <= 3
    }

    public fun pending<T0, T1>(arg0: &0x2::object::UID, arg1: &Stake<T0, T1>) : u64 {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StateKey>(arg0, v0)) {
            return 0
        };
        let v1 = StateKey{dummy_field: false};
        ((((0x2::balance::value<T0>(&arg1.tokens) as u256) * 0x2::dynamic_field::borrow<StateKey, State<T1>>(arg0, v1).acc_per_token - arg1.reward_debt) / 1000000000000000000) as u64)
    }

    public(friend) fun release<T0>(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = state_mut<T0>(arg0);
        let v2 = v1.streaming;
        let v3 = if (v2 == 0 || arg1 <= v1.last_ms) {
            0
        } else if (arg1 >= v1.end_ms) {
            v2
        } else {
            0x900dac0f0fd6077edbaa9ff26c592d8e4ec6e322c864b5d90a5e2e61a6f8f94b::math::mul_div(v2, arg1 - v1.last_ms, v1.end_ms - v1.last_ms)
        };
        v1.streaming = v2 - v3;
        if (arg1 > v1.last_ms) {
            v1.last_ms = arg1;
        };
        if (v1.queued > 0) {
            v1.streaming = v1.streaming + v1.queued;
            v1.queued = 0;
            v1.end_ms = arg1 + 259200000;
        };
        if (v3 == 0) {
            return
        };
        let v4 = v1.total_staked == 0;
        if (v4) {
            0x2::balance::join<T0>(&mut v1.buyback, 0x2::balance::split<T0>(&mut v1.rewards, v3));
        } else {
            v1.acc_per_token = v1.acc_per_token + (v3 as u256) * 1000000000000000000 / (v1.total_staked as u256);
            v1.total_rewards = v1.total_rewards + v3;
        };
        let v5 = RewardsReleased{
            pool           : v0,
            amount         : v3,
            to_buyback     : v4,
            streaming_left : v1.streaming,
            end_ms         : v1.end_ms,
        };
        0x2::event::emit<RewardsReleased>(v5);
    }

    public fun reward_stream_ms() : u64 {
        259200000
    }

    public fun split_of(arg0: u8) : (u64, u64, u64) {
        if (arg0 == 0) {
            (10000, 0, 0)
        } else if (arg0 == 1) {
            (0, 10000, 0)
        } else if (arg0 == 2) {
            (0, 0, 10000)
        } else {
            assert!(arg0 == 3, 900);
            (5000, 2500, 2500)
        }
    }

    public(friend) fun stake<T0, T1>(arg0: &mut 0x2::object::UID, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : Stake<T0, T1> {
        assert!(has_holders(arg1), 901);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 903);
        let v1 = 0x2::object::uid_to_inner(arg0);
        let v2 = state_mut<T1>(arg0);
        v2.total_staked = v2.total_staked + v0;
        let v3 = Stake<T0, T1>{
            id          : 0x2::object::new(arg4),
            pool_id     : v1,
            tokens      : arg2,
            reward_debt : (v0 as u256) * v2.acc_per_token,
        };
        let v4 = Staked{
            pool         : v1,
            stake        : 0x2::object::id<Stake<T0, T1>>(&v3),
            owner        : arg3,
            amount       : v0,
            total_staked : v2.total_staked,
        };
        0x2::event::emit<Staked>(v4);
        v3
    }

    public fun stake_amount<T0, T1>(arg0: &Stake<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun stake_pool<T0, T1>(arg0: &Stake<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun state_mut<T0>(arg0: &mut 0x2::object::UID) : &mut State<T0> {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StateKey>(arg0, v0)) {
            let v1 = StateKey{dummy_field: false};
            let v2 = State<T0>{
                claim         : 0x2::balance::zero<T0>(),
                buyback       : 0x2::balance::zero<T0>(),
                rewards       : 0x2::balance::zero<T0>(),
                total_staked  : 0,
                acc_per_token : 0,
                queued        : 0,
                streaming     : 0,
                last_ms       : 0,
                end_ms        : 0,
                total_rewards : 0,
            };
            0x2::dynamic_field::add<StateKey, State<T0>>(arg0, v1, v2);
        };
        let v3 = StateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<StateKey, State<T0>>(arg0, v3)
    }

    public fun stats<T0>(arg0: &0x2::object::UID) : (u64, u64, u64, u64, u64, u64) {
        let v0 = StateKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<StateKey>(arg0, v0)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v1 = StateKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<StateKey, State<T0>>(arg0, v1);
        (0x2::balance::value<T0>(&v2.claim), 0x2::balance::value<T0>(&v2.buyback), 0x2::balance::value<T0>(&v2.rewards), v2.total_staked, v2.queued + v2.streaming, v2.total_rewards)
    }

    public(friend) fun take_buyback<T0>(arg0: &mut 0x2::object::UID, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = state_mut<T0>(arg0);
        let v1 = if (0x2::balance::value<T0>(&v0.buyback) > arg1) {
            arg1
        } else {
            0x2::balance::value<T0>(&v0.buyback)
        };
        0x2::balance::split<T0>(&mut v0.buyback, v1)
    }

    public(friend) fun take_claim<T0>(arg0: &mut 0x2::object::UID, arg1: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut state_mut<T0>(arg0).claim);
        let v2 = CreatorClaimed{
            pool    : v0,
            creator : arg1,
            amount  : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<CreatorClaimed>(v2);
        v1
    }

    public(friend) fun unstake<T0, T1>(arg0: &mut 0x2::object::UID, arg1: Stake<T0, T1>, arg2: address) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::uid_to_inner(arg0);
        assert!(arg1.pool_id == v0, 902);
        let Stake {
            id          : v1,
            pool_id     : _,
            tokens      : v3,
            reward_debt : _,
        } = arg1;
        let v5 = v3;
        let v6 = v1;
        let v7 = 0x2::balance::value<T0>(&v5);
        let v8 = state_mut<T1>(arg0);
        v8.total_staked = v8.total_staked - v7;
        let v9 = Unstaked{
            pool         : v0,
            stake        : 0x2::object::uid_to_inner(&v6),
            owner        : arg2,
            amount       : v7,
            total_staked : v8.total_staked,
        };
        0x2::event::emit<Unstaked>(v9);
        0x2::object::delete(v6);
        v5
    }

    // decompiled from Move bytecode v7
}

