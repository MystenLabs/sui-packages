module 0x596141b0aa26bcb463a2939566abe7f7f653c663694f96cf85dc3331f6a19351::events {
    struct PoolCreated has copy, drop {
        pool_id: address,
        creator: address,
        entry_fee: u64,
        max_players: u8,
        fee_bps: u16,
        timestamp: u64,
        deadline: u64,
    }

    struct PlayerJoined has copy, drop {
        pool_id: address,
        player: address,
        position: u8,
        entry_fee: u64,
        timestamp: u64,
    }

    struct PlayerLeft has copy, drop {
        pool_id: address,
        player: address,
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
        winning_position: u8,
        total_pot: u64,
        protocol_fee: u64,
        timestamp: u64,
    }

    struct RewardsDistributed has copy, drop {
        pool_id: address,
        winner: address,
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
        refund_amount: u64,
        timestamp: u64,
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

    public(friend) fun emit_player_joined(arg0: address, arg1: address, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = PlayerJoined{
            pool_id   : arg0,
            player    : arg1,
            position  : arg2,
            entry_fee : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<PlayerJoined>(v0);
    }

    public(friend) fun emit_player_left(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = PlayerLeft{
            pool_id       : arg0,
            player        : arg1,
            refund_amount : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<PlayerLeft>(v0);
    }

    public(friend) fun emit_pool_closed(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = PoolClosed{
            pool_id       : arg0,
            creator       : arg1,
            refund_amount : arg2,
            timestamp     : arg3,
        };
        0x2::event::emit<PoolClosed>(v0);
    }

    public(friend) fun emit_pool_created(arg0: address, arg1: address, arg2: u64, arg3: u8, arg4: u16, arg5: u64, arg6: u64) {
        let v0 = PoolCreated{
            pool_id     : arg0,
            creator     : arg1,
            entry_fee   : arg2,
            max_players : arg3,
            fee_bps     : arg4,
            timestamp   : arg5,
            deadline    : arg6,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun emit_pool_resolved(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PoolResolved{
            pool_id          : arg0,
            winning_position : arg1,
            total_pot        : arg2,
            protocol_fee     : arg3,
            timestamp        : arg4,
        };
        0x2::event::emit<PoolResolved>(v0);
    }

    public(friend) fun emit_rewards_distributed(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RewardsDistributed{
            pool_id   : arg0,
            winner    : arg1,
            amount    : arg2,
            timestamp : arg3,
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

