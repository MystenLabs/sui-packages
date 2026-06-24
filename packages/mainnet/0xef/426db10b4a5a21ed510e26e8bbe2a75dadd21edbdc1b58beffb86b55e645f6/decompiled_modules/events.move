module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::events {
    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        name: vector<u8>,
        quote_coin: u8,
        goal: u64,
        nft_type: u8,
        vesting_duration_ms: u64,
    }

    struct NFTMinted has copy, drop {
        launch_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        minter: address,
        token_allocation: u64,
        rarity: u8,
        amount_paid: u64,
    }

    struct FeeDistributed has copy, drop {
        launch_id: 0x2::object::ID,
        platform_fee: u64,
        creator_fee: u64,
        vault_amount: u64,
    }

    struct GoalReached has copy, drop {
        launch_id: 0x2::object::ID,
        total_raised: u64,
        nft_count: u64,
    }

    struct PoolActivated has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
    }

    struct YieldClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct TokensVested has copy, drop {
        launch_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct TakeoverProposed has copy, drop {
        launch_id: 0x2::object::ID,
        proposal_id: 0x2::object::ID,
        proposer: address,
        new_creator: address,
    }

    struct TakeoverExecuted has copy, drop {
        launch_id: 0x2::object::ID,
        old_creator: address,
        new_creator: address,
    }

    public fun emit_fee_distributed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = FeeDistributed{
            launch_id    : arg0,
            platform_fee : arg1,
            creator_fee  : arg2,
            vault_amount : arg3,
        };
        0x2::event::emit<FeeDistributed>(v0);
    }

    public fun emit_goal_reached(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = GoalReached{
            launch_id    : arg0,
            total_raised : arg1,
            nft_count    : arg2,
        };
        0x2::event::emit<GoalReached>(v0);
    }

    public fun emit_launch_created(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u8, arg6: u64) {
        let v0 = LaunchCreated{
            launch_id           : arg0,
            creator             : arg1,
            name                : arg2,
            quote_coin          : arg3,
            goal                : arg4,
            nft_type            : arg5,
            vesting_duration_ms : arg6,
        };
        0x2::event::emit<LaunchCreated>(v0);
    }

    public fun emit_nft_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u8, arg5: u64) {
        let v0 = NFTMinted{
            launch_id        : arg0,
            nft_id           : arg1,
            minter           : arg2,
            token_allocation : arg3,
            rarity           : arg4,
            amount_paid      : arg5,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    public fun emit_pool_activated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = PoolActivated{
            launch_id      : arg0,
            pool_id        : arg1,
            lp_position_id : arg2,
        };
        0x2::event::emit<PoolActivated>(v0);
    }

    public fun emit_takeover_executed(arg0: 0x2::object::ID, arg1: address, arg2: address) {
        let v0 = TakeoverExecuted{
            launch_id   : arg0,
            old_creator : arg1,
            new_creator : arg2,
        };
        0x2::event::emit<TakeoverExecuted>(v0);
    }

    public fun emit_takeover_proposed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address) {
        let v0 = TakeoverProposed{
            launch_id   : arg0,
            proposal_id : arg1,
            proposer    : arg2,
            new_creator : arg3,
        };
        0x2::event::emit<TakeoverProposed>(v0);
    }

    public fun emit_tokens_vested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = TokensVested{
            launch_id : arg0,
            nft_id    : arg1,
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<TokensVested>(v0);
    }

    public fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = YieldClaimed{
            launch_id : arg0,
            nft_id    : arg1,
            claimer   : arg2,
            amount    : arg3,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

