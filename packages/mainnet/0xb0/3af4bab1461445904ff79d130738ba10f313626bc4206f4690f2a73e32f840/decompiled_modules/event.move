module 0xb03af4bab1461445904ff79d130738ba10f313626bc4206f4690f2a73e32f840::event {
    struct ClaimReward has copy, drop {
        claimer: address,
        value: u64,
    }

    struct NotifyRewards<phantom T0> has copy, drop {
        value: u64,
    }

    struct DepositLP<phantom T0, phantom T1> has copy, drop {
        from: address,
        amount: u64,
    }

    struct WithdrawLP<phantom T0, phantom T1> has copy, drop {
        from: address,
        amount: u64,
    }

    struct GaugeCreated<phantom T0, phantom T1> has copy, drop {
        pool: 0x2::object::ID,
        gauge: 0x2::object::ID,
        internal_bribe: 0x2::object::ID,
        external_bribe: 0x2::object::ID,
    }

    struct Voted<phantom T0, phantom T1> has copy, drop {
        vsdb: 0x2::object::ID,
        amount: u64,
    }

    struct Abstain<phantom T0, phantom T1> has copy, drop {
        vsdb: 0x2::object::ID,
        amount: u64,
    }

    struct Mint has copy, drop {
        from: address,
        weekly: u64,
        circulating_supply: u64,
        circulating_emission: u64,
    }

    public fun abstain<T0, T1>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Abstain<T0, T1>{
            vsdb   : arg0,
            amount : arg1,
        };
        0x2::event::emit<Abstain<T0, T1>>(v0);
    }

    public fun claim_reward(arg0: address, arg1: u64) {
        let v0 = ClaimReward{
            claimer : arg0,
            value   : arg1,
        };
        0x2::event::emit<ClaimReward>(v0);
    }

    public fun deposit_lp<T0, T1>(arg0: address, arg1: u64) {
        let v0 = DepositLP<T0, T1>{
            from   : arg0,
            amount : arg1,
        };
        0x2::event::emit<DepositLP<T0, T1>>(v0);
    }

    public fun gauge_created<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        let v0 = GaugeCreated<T0, T1>{
            pool           : arg0,
            gauge          : arg1,
            internal_bribe : arg2,
            external_bribe : arg3,
        };
        0x2::event::emit<GaugeCreated<T0, T1>>(v0);
    }

    public fun mint(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Mint{
            from                 : arg0,
            weekly               : arg1,
            circulating_supply   : arg2,
            circulating_emission : arg3,
        };
        0x2::event::emit<Mint>(v0);
    }

    public fun notify_reward<T0>(arg0: u64) {
        let v0 = NotifyRewards<T0>{value: arg0};
        0x2::event::emit<NotifyRewards<T0>>(v0);
    }

    public fun voted<T0, T1>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Voted<T0, T1>{
            vsdb   : arg0,
            amount : arg1,
        };
        0x2::event::emit<Voted<T0, T1>>(v0);
    }

    public fun withdraw_lp<T0, T1>(arg0: address, arg1: u64) {
        let v0 = WithdrawLP<T0, T1>{
            from   : arg0,
            amount : arg1,
        };
        0x2::event::emit<WithdrawLP<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

