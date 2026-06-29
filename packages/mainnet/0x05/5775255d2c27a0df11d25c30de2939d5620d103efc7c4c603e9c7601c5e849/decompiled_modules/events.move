module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::events {
    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        coin_type: 0x1::string::String,
        mint_price: u64,
        max_supply: u64,
        goal: u64,
        quote_coin: u8,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        minter: address,
        nft_number: u64,
        amount_paid: u64,
    }

    struct GoalReached has copy, drop {
        launch_id: 0x2::object::ID,
        total_raised: u64,
        nft_count: u64,
        timestamp_ms: u64,
    }

    struct PoolActivated has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct YieldClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct TokensVested has copy, drop {
        nft_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        holder: address,
        tokens_vested: u64,
        tokens_total: u64,
    }

    struct NFTEvolved has copy, drop {
        nft_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        old_state: u8,
        new_state: u8,
    }

    struct StageAwakened has copy, drop {
        launch_id: 0x2::object::ID,
        stage: u8,
    }

    struct StageEvolved has copy, drop {
        launch_id: 0x2::object::ID,
        stage: u8,
    }

    struct StageLegendary has copy, drop {
        launch_id: 0x2::object::ID,
        stage: u8,
    }

    public fun emit_goal_reached(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = GoalReached{
            launch_id    : arg0,
            total_raised : arg1,
            nft_count    : arg2,
            timestamp_ms : arg3,
        };
        0x2::event::emit<GoalReached>(v0);
    }

    public fun emit_launch_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u8) {
        let v0 = LaunchCreated{
            launch_id  : arg0,
            creator    : arg1,
            name       : arg2,
            coin_type  : arg3,
            mint_price : arg4,
            max_supply : arg5,
            goal       : arg6,
            quote_coin : arg7,
        };
        0x2::event::emit<LaunchCreated>(v0);
    }

    public fun emit_nft_evolved(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: u8) {
        let v0 = NFTEvolved{
            nft_id    : arg0,
            launch_id : arg1,
            old_state : arg2,
            new_state : arg3,
        };
        0x2::event::emit<NFTEvolved>(v0);
    }

    public fun emit_nft_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = NFTMinted{
            nft_id      : arg0,
            launch_id   : arg1,
            minter      : arg2,
            nft_number  : arg3,
            amount_paid : arg4,
        };
        0x2::event::emit<NFTMinted>(v0);
    }

    public fun emit_pool_activated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = PoolActivated{
            launch_id      : arg0,
            pool_id        : arg1,
            lp_position_id : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<PoolActivated>(v0);
    }

    public fun emit_stage_awakened(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = StageAwakened{
            launch_id : arg0,
            stage     : arg1,
        };
        0x2::event::emit<StageAwakened>(v0);
    }

    public fun emit_stage_evolved(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = StageEvolved{
            launch_id : arg0,
            stage     : arg1,
        };
        0x2::event::emit<StageEvolved>(v0);
    }

    public fun emit_stage_legendary(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = StageLegendary{
            launch_id : arg0,
            stage     : arg1,
        };
        0x2::event::emit<StageLegendary>(v0);
    }

    public fun emit_tokens_vested(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = TokensVested{
            nft_id        : arg0,
            launch_id     : arg1,
            holder        : arg2,
            tokens_vested : arg3,
            tokens_total  : arg4,
        };
        0x2::event::emit<TokensVested>(v0);
    }

    public fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = YieldClaimed{
            nft_id    : arg0,
            launch_id : arg1,
            claimer   : arg2,
            amount    : arg3,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    // decompiled from Move bytecode v7
}

