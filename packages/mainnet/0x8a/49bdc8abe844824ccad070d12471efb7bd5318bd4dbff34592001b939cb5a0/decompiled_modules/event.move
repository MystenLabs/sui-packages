module 0x8a49bdc8abe844824ccad070d12471efb7bd5318bd4dbff34592001b939cb5a0::event {
    struct ClaimFee<phantom T0> has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct OrderCreated<phantom T0, phantom T1> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
    }

    struct OrderExecuted<phantom T0, phantom T1> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
        time: u64,
        spent_x: u64,
        withdrawn_y: u64,
    }

    struct OrderClosed<phantom T0, phantom T1> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
        amount_x: u64,
        amount_y: u64,
    }

    struct PriceUpdated<phantom T0, phantom T1> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
        price_enabled: bool,
        min_price: u128,
        max_price: u128,
    }

    struct StakeTank<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
        deposit: u64,
    }

    struct UnstakeTank<phantom T0> has copy, drop {
        escrow: 0x2::object::ID,
        owner: address,
        buck_value: u64,
        collateral_value: u64,
        bkt_value: u64,
    }

    public fun claim_fee<T0>(arg0: address, arg1: u64) {
        let v0 = ClaimFee<T0>{
            recipient : arg0,
            amount    : arg1,
        };
        0x2::event::emit<ClaimFee<T0>>(v0);
    }

    public fun order_closed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = OrderClosed<T0, T1>{
            escrow   : arg0,
            owner    : arg1,
            amount_x : arg2,
            amount_y : arg3,
        };
        0x2::event::emit<OrderClosed<T0, T1>>(v0);
    }

    public fun order_created<T0, T1>(arg0: 0x2::object::ID, arg1: address) {
        let v0 = OrderCreated<T0, T1>{
            escrow : arg0,
            owner  : arg1,
        };
        0x2::event::emit<OrderCreated<T0, T1>>(v0);
    }

    public fun order_executed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OrderExecuted<T0, T1>{
            escrow      : arg0,
            owner       : arg1,
            time        : arg2,
            spent_x     : arg3,
            withdrawn_y : arg4,
        };
        0x2::event::emit<OrderExecuted<T0, T1>>(v0);
    }

    public fun price_updated<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u128, arg4: u128) {
        let v0 = PriceUpdated<T0, T1>{
            escrow        : arg0,
            owner         : arg1,
            price_enabled : arg2,
            min_price     : arg3,
            max_price     : arg4,
        };
        0x2::event::emit<PriceUpdated<T0, T1>>(v0);
    }

    public fun stake_tank<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = StakeTank<T0>{
            escrow  : arg0,
            owner   : arg1,
            deposit : arg2,
        };
        0x2::event::emit<StakeTank<T0>>(v0);
    }

    public fun unstake_tank<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = UnstakeTank<T0>{
            escrow           : arg0,
            owner            : arg1,
            buck_value       : arg2,
            collateral_value : arg3,
            bkt_value        : arg4,
        };
        0x2::event::emit<UnstakeTank<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

