module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::events {
    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        goal_amount: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct PassMinted has copy, drop {
        launch_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        deposit_amount: u64,
        token_allocation: u64,
    }

    struct VaultConverted has copy, drop {
        launch_id: 0x2::object::ID,
        total_raised: u64,
        platform_fee: u64,
        creator_fee: u64,
        pool_amount: u64,
        timestamp: u64,
    }

    struct TokensClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct YieldClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        pass_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        is_creator: bool,
    }

    public fun emit_launch_created(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = LaunchCreated{
            launch_id   : arg0,
            creator     : arg1,
            goal_amount : arg2,
            name        : arg3,
            symbol      : arg4,
        };
        0x2::event::emit<LaunchCreated>(v0);
    }

    public fun emit_pass_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = PassMinted{
            launch_id        : arg0,
            pass_id          : arg1,
            owner            : arg2,
            tier             : arg3,
            deposit_amount   : arg4,
            token_allocation : arg5,
        };
        0x2::event::emit<PassMinted>(v0);
    }

    public fun emit_tokens_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = TokensClaimed{
            launch_id : arg0,
            pass_id   : arg1,
            claimer   : arg2,
            amount    : arg3,
        };
        0x2::event::emit<TokensClaimed>(v0);
    }

    public fun emit_vault_converted(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = VaultConverted{
            launch_id    : arg0,
            total_raised : arg1,
            platform_fee : arg2,
            creator_fee  : arg3,
            pool_amount  : arg4,
            timestamp    : arg5,
        };
        0x2::event::emit<VaultConverted>(v0);
    }

    public fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: bool) {
        let v0 = YieldClaimed{
            launch_id  : arg0,
            pass_id    : arg1,
            claimer    : arg2,
            amount     : arg3,
            is_creator : arg4,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

