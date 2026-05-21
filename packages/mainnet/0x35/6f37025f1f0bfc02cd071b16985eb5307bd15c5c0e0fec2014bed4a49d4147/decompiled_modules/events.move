module 0x356f37025f1f0bfc02cd071b16985eb5307bd15c5c0e0fec2014bed4a49d4147::events {
    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        coin_type: 0x1::ascii::String,
        entry_fee: u64,
        max_players: u8,
        fee_bps: u16,
        timestamp: u64,
        deadline: u64,
    }

    struct PlayerJoined has copy, drop {
        pool_id: address,
        player: address,
        coin_type: 0x1::ascii::String,
        position: u8,
        entry_fee: u64,
        timestamp: u64,
    }

    struct PlayerLeft has copy, drop {
        pool_id: address,
        player: address,
        coin_type: 0x1::ascii::String,
        refund_amount: u64,
        timestamp: u64,
    }

    struct RoundPlayed has copy, drop {
        pool_id: address,
        round_number: u8,
        winning_position: u8,
        timestamp: u64,
    }

    struct PoolResolved has copy, drop {
        pool_id: address,
        coin_type: 0x1::ascii::String,
        winning_position: u8,
        total_pot: u64,
        protocol_fee: u64,
        timestamp: u64,
    }

    struct RewardsDistributed has copy, drop {
        pool_id: address,
        winner: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        timestamp: u64,
    }

    struct ConfigUpdated has copy, drop {
        admin: address,
        fee_bps: u16,
        timestamp: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
        admin: address,
        timestamp: u64,
    }

    struct Paused has copy, drop {
        admin: address,
        paused: bool,
        timestamp: u64,
    }

    struct PoolClosed has copy, drop {
        pool_id: address,
        creator: address,
        coin_type: 0x1::ascii::String,
        refund_amount: u64,
        timestamp: u64,
    }

    struct CoinListed has copy, drop {
        lister: address,
        coin_type: 0x1::ascii::String,
        treasury: address,
        listing_fee: u64,
        timestamp: u64,
    }

    public(friend) fun emit_coin_listed(arg0: address, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: u64) {
        let v0 = CoinListed{
            lister      : arg0,
            coin_type   : arg1,
            treasury    : arg2,
            listing_fee : arg3,
            timestamp   : arg4,
        };
        0x2::event::emit<CoinListed>(v0);
    }

    public(friend) fun emit_config_updated(arg0: address, arg1: u16, arg2: u64) {
        let v0 = ConfigUpdated{
            admin     : arg0,
            fee_bps   : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun emit_paused(arg0: address, arg1: bool, arg2: u64) {
        let v0 = Paused{
            admin     : arg0,
            paused    : arg1,
            timestamp : arg2,
        };
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_player_joined(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u8, arg4: u64, arg5: u64) {
        let v0 = PlayerJoined{
            pool_id   : arg0,
            player    : arg1,
            coin_type : arg2,
            position  : arg3,
            entry_fee : arg4,
            timestamp : arg5,
        };
        0x2::event::emit<PlayerJoined>(v0);
    }

    public(friend) fun emit_player_left(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = PlayerLeft{
            pool_id       : arg0,
            player        : arg1,
            coin_type     : arg2,
            refund_amount : arg3,
            timestamp     : arg4,
        };
        0x2::event::emit<PlayerLeft>(v0);
    }

    public(friend) fun emit_pool_closed(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = PoolClosed{
            pool_id       : arg0,
            creator       : arg1,
            coin_type     : arg2,
            refund_amount : arg3,
            timestamp     : arg4,
        };
        0x2::event::emit<PoolClosed>(v0);
    }

    public(friend) fun emit_pool_created(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u8, arg5: u16, arg6: u64, arg7: u64) {
        let v0 = PoolCreated{
            pool_id     : arg0,
            creator     : arg1,
            coin_type   : arg2,
            entry_fee   : arg3,
            max_players : arg4,
            fee_bps     : arg5,
            timestamp   : arg6,
            deadline    : arg7,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_pool_resolved(arg0: address, arg1: 0x1::ascii::String, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = PoolResolved{
            pool_id          : arg0,
            coin_type        : arg1,
            winning_position : arg2,
            total_pot        : arg3,
            protocol_fee     : arg4,
            timestamp        : arg5,
        };
        0x2::event::emit<PoolResolved>(v0);
    }

    public(friend) fun emit_rewards_distributed(arg0: address, arg1: address, arg2: 0x1::ascii::String, arg3: u64, arg4: u64) {
        let v0 = RewardsDistributed{
            pool_id   : arg0,
            winner    : arg1,
            coin_type : arg2,
            amount    : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<RewardsDistributed>(v0);
    }

    public(friend) fun emit_round_played(arg0: address, arg1: u8, arg2: u8, arg3: u64) {
        let v0 = RoundPlayed{
            pool_id          : arg0,
            round_number     : arg1,
            winning_position : arg2,
            timestamp        : arg3,
        };
        0x2::event::emit<RoundPlayed>(v0);
    }

    public(friend) fun emit_treasury_updated(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = TreasuryUpdated{
            old_treasury : arg0,
            new_treasury : arg1,
            admin        : arg2,
            timestamp    : arg3,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

