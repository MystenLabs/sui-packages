module 0x91180a1cea7ec2263b4d58e7581dd90e66981ca428a3f533248ff557fd1e72f5::artfi_staking {
    struct DurationStake<phantom T0> has store {
        duration: u64,
        claim_interval: u64,
        reward: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun claim_interval<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.claim_interval
    }

    public fun destroy<T0>(arg0: DurationStake<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let DurationStake {
            duration       : v0,
            claim_interval : _,
            reward         : _,
            balance        : v3,
        } = arg0;
        assert!(0x2::tx_context::epoch(arg1) >= v0, 1);
        0x2::coin::from_balance<T0>(v3, arg1)
    }

    public fun duration<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.duration
    }

    public fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : DurationStake<T0> {
        assert!(0x2::tx_context::epoch(arg4) <= arg0, 0);
        DurationStake<T0>{
            duration       : arg0,
            claim_interval : arg1,
            reward         : arg2,
            balance        : 0x2::coin::into_balance<T0>(arg3),
        }
    }

    public fun reward<T0>(arg0: &DurationStake<T0>) : u64 {
        arg0.reward
    }

    public fun set_claim_interval<T0>(arg0: &mut DurationStake<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.claim_interval = arg1;
    }

    public fun set_reward<T0>(arg0: &mut DurationStake<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        arg0.reward = arg1;
    }

    // decompiled from Move bytecode v6
}

