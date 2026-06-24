module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events {
    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        deposit_open: u64,
        deposit_close: u64,
        activation_time: u64,
        individual_deposit_cap: u64,
    }

    struct Deposited has copy, drop {
        launch_id: 0x2::object::ID,
        buyer: address,
        amount: u64,
        platform_fee: u64,
        project_fee: u64,
        pool_amount: u64,
    }

    struct StatusChanged has copy, drop {
        launch_id: 0x2::object::ID,
        old_status: u8,
        new_status: u8,
        timestamp: u64,
    }

    struct PoolActivated has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        base_liquidity: u64,
        quote_liquidity: u64,
        timestamp: u64,
    }

    struct BackerPassMinted has copy, drop {
        launch_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        owner: address,
        tier: u8,
    }

    struct YieldClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    public fun emit_backer_pass_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8) {
        let v0 = BackerPassMinted{
            launch_id : arg0,
            pass_id   : arg1,
            owner     : arg2,
            tier      : arg3,
        };
        0x2::event::emit<BackerPassMinted>(v0);
    }

    public fun emit_deposited(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Deposited{
            launch_id    : arg0,
            buyer        : arg1,
            amount       : arg2,
            platform_fee : arg3,
            project_fee  : arg4,
            pool_amount  : arg5,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun emit_launch_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LaunchCreated{
            launch_id              : arg0,
            creator                : arg1,
            deposit_open           : arg2,
            deposit_close          : arg3,
            activation_time        : arg4,
            individual_deposit_cap : arg5,
        };
        0x2::event::emit<LaunchCreated>(v0);
    }

    public fun emit_pool_activated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PoolActivated{
            launch_id       : arg0,
            pool_id         : arg1,
            base_liquidity  : arg2,
            quote_liquidity : arg3,
            timestamp       : arg4,
        };
        0x2::event::emit<PoolActivated>(v0);
    }

    public fun emit_status_changed(arg0: 0x2::object::ID, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = StatusChanged{
            launch_id  : arg0,
            old_status : arg1,
            new_status : arg2,
            timestamp  : arg3,
        };
        0x2::event::emit<StatusChanged>(v0);
    }

    public fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = YieldClaimed{
            launch_id : arg0,
            claimer   : arg1,
            amount    : arg2,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

