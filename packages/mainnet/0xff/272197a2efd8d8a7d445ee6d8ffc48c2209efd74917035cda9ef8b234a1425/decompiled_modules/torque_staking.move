module 0xff272197a2efd8d8a7d445ee6d8ffc48c2209efd74917035cda9ef8b234a1425::torque_staking {
    struct DurationStake<phantom T0> has store {
        duration: u64,
        claim_interval: u64,
        reward_percentage: u64,
        staked_amount: u64,
        balance: 0x2::balance::Balance<T0>,
        last_claim_time: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RewardSender has store, key {
        id: 0x2::object::UID,
        sender: address,
    }

    struct TORQUE_STAKING has drop {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : DurationStake<T0> {
        assert!(0x2::tx_context::epoch(arg4) <= arg0, 0);
        DurationStake<T0>{
            duration          : arg0,
            claim_interval    : arg1,
            reward_percentage : arg2,
            staked_amount     : 0x2::coin::value<T0>(&arg3),
            balance           : 0x2::coin::into_balance<T0>(arg3),
            last_claim_time   : 0,
        }
    }

    public fun claim_interval<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.claim_interval
    }

    public fun claim_rewards<T0>(arg0: &mut DurationStake<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(v0 >= arg0.last_claim_time + arg0.claim_interval, 2);
        let v1 = arg0.staked_amount * arg0.reward_percentage / 100;
        assert!(0x2::coin::value<T0>(arg1) >= v1, 3);
        arg0.last_claim_time = v0;
        0x2::coin::split<T0>(arg1, v1, arg2)
    }

    public fun destroy<T0>(arg0: DurationStake<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let DurationStake {
            duration          : v0,
            claim_interval    : _,
            reward_percentage : _,
            staked_amount     : _,
            balance           : v4,
            last_claim_time   : _,
        } = arg0;
        assert!(0x2::tx_context::epoch(arg1) >= v0, 1);
        0x2::coin::from_balance<T0>(v4, arg1)
    }

    public fun duration<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.duration
    }

    public fun fund_rewards_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : RewardSender {
        let v0 = RewardSender{
            id     : 0x2::object::new(arg1),
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0.sender);
        v0
    }

    fun init(arg0: TORQUE_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun reward_percentage<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.reward_percentage
    }

    public fun set_claim_interval<T0>(arg0: &AdminCap, arg1: &mut DurationStake<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.claim_interval = arg2;
    }

    public fun set_reward_percentage<T0>(arg0: &AdminCap, arg1: &mut DurationStake<T0>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.reward_percentage = arg2;
    }

    public fun unstake<T0>(arg0: DurationStake<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let DurationStake {
            duration          : v0,
            claim_interval    : _,
            reward_percentage : _,
            staked_amount     : _,
            balance           : v4,
            last_claim_time   : _,
        } = arg0;
        assert!(0x2::tx_context::epoch(arg1) >= v0, 1);
        0x2::coin::from_balance<T0>(v4, arg1)
    }

    public fun withdraw_excess_rewards<T0>(arg0: &RewardSender, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.sender, 0);
        assert!(0x2::coin::value<T0>(arg1) >= arg2, 1);
        0x2::coin::split<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

