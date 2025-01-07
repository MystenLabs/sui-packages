module 0xc7f1c4e53d9685b592bbb9fef499c4d6fb2df0532c51bf6257e8cf78151e45f8::vesting {
    struct VestingOperatorCapability has key {
        id: 0x2::object::UID,
    }

    struct VestedDistributionPool<phantom T0> has key {
        id: 0x2::object::UID,
        user: address,
        amount: u64,
        balance: 0x2::balance::Balance<T0>,
        claimedAmount: u64,
        currentPeriod: u64,
        periodUnlockPercentage: vector<u64>,
        unlockCooldownMs: u64,
        lastUnlockTimestampMs: u64,
        poolCreationTimestampMs: u64,
    }

    public entry fun claim_rewards_vested_distribution_pool<T0>(arg0: &mut VestedDistributionPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.claimedAmount < arg0.amount, 0);
        if (arg0.lastUnlockTimestampMs != arg0.poolCreationTimestampMs) {
            assert!(v0 - arg0.lastUnlockTimestampMs >= arg0.unlockCooldownMs, 0);
        };
        let v1 = (v0 - arg0.lastUnlockTimestampMs) / arg0.unlockCooldownMs;
        let v2 = (v0 - arg0.lastUnlockTimestampMs) / arg0.unlockCooldownMs;
        if (arg0.lastUnlockTimestampMs == arg0.poolCreationTimestampMs) {
            v1 = 1;
        };
        if (arg0.lastUnlockTimestampMs == arg0.poolCreationTimestampMs && v2 > 0) {
            v1 = v2;
        };
        let v3 = 0;
        while (v3 < v1) {
            let v4 = arg0.amount * *0x1::vector::borrow<u64>(&arg0.periodUnlockPercentage, arg0.currentPeriod) / 100000;
            arg0.claimedAmount = arg0.claimedAmount + v4;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v4, arg2), 0x2::tx_context::sender(arg2));
            arg0.currentPeriod = arg0.currentPeriod + 1;
            v3 = v3 + 1;
        };
        arg0.lastUnlockTimestampMs = v0;
    }

    public entry fun create_vested_distribution_pool<T0>(arg0: &mut VestingOperatorCapability, arg1: address, arg2: u64, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<u64>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = VestedDistributionPool<T0>{
            id                      : 0x2::object::new(arg7),
            user                    : arg1,
            amount                  : arg2,
            balance                 : 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg3), arg2),
            claimedAmount           : 0,
            currentPeriod           : 0,
            periodUnlockPercentage  : arg4,
            unlockCooldownMs        : arg5,
            lastUnlockTimestampMs   : 0x2::clock::timestamp_ms(arg6),
            poolCreationTimestampMs : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::transfer::transfer<VestedDistributionPool<T0>>(v0, arg1);
    }

    public entry fun get_vested_distribution_pool_amount<T0>(arg0: &mut VestedDistributionPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public entry fun get_vested_distribution_pool_claimed_amount<T0>(arg0: &mut VestedDistributionPool<T0>) : u64 {
        arg0.claimedAmount
    }

    public entry fun get_vested_distribution_pool_user<T0>(arg0: &mut VestedDistributionPool<T0>) : address {
        arg0.user
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingOperatorCapability{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VestingOperatorCapability>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

