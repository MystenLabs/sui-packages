module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event {
    struct MetalChallengedEvent has copy, drop {
        account: address,
        index: u256,
        prediction: u256,
        random: u256,
        challenger: address,
        defender: address,
        winner: address,
        coins: u256,
        tokens: u256,
        won: u256,
    }

    struct TidalWonEvent has copy, drop {
        account: address,
        coins: u256,
        prediction: u256,
        random: u256,
        shares: u256,
        tokens: u256,
    }

    struct TidalBoughtEvent has copy, drop {
        account: address,
        coins: u256,
        rate: u256,
        shares: u256,
        tokens: u256,
    }

    struct TidalSoldEvent has copy, drop {
        account: address,
        shares: u256,
        rate: u256,
        coins: u256,
    }

    struct CycleStakedEvent has copy, drop {
        account: address,
        tokens: u256,
    }

    struct CycleUnstakedEvent has copy, drop {
        account: address,
        tokens: u256,
    }

    struct CycleReleasedEvent has copy, drop {
        account: address,
        coins: u256,
        tokens: u256,
    }

    struct CycleClaimedEvent has copy, drop {
        account: address,
        coins: u256,
        tokens: u256,
    }

    struct DicerRolledEvent has copy, drop {
        account: address,
        tokens: u256,
        low: u256,
        high: u256,
        random: u256,
        chance: u256,
        payout: u256,
    }

    struct ForumSentEvent has copy, drop {
        account: address,
        message: 0x1::string::String,
    }

    public(friend) fun cycle_claimed(arg0: address, arg1: u256, arg2: u256) {
        let v0 = CycleClaimedEvent{
            account : arg0,
            coins   : arg1,
            tokens  : arg2,
        };
        0x2::event::emit<CycleClaimedEvent>(v0);
    }

    public(friend) fun cycle_released(arg0: address, arg1: u256, arg2: u256) {
        let v0 = CycleReleasedEvent{
            account : arg0,
            coins   : arg1,
            tokens  : arg2,
        };
        0x2::event::emit<CycleReleasedEvent>(v0);
    }

    public(friend) fun cycle_staked(arg0: address, arg1: u256) {
        let v0 = CycleStakedEvent{
            account : arg0,
            tokens  : arg1,
        };
        0x2::event::emit<CycleStakedEvent>(v0);
    }

    public(friend) fun cycle_unstaked(arg0: address, arg1: u256) {
        let v0 = CycleUnstakedEvent{
            account : arg0,
            tokens  : arg1,
        };
        0x2::event::emit<CycleUnstakedEvent>(v0);
    }

    public(friend) fun dicer_rolled(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = DicerRolledEvent{
            account : arg0,
            tokens  : arg1,
            low     : arg2,
            high    : arg3,
            random  : arg4,
            chance  : arg5,
            payout  : arg6,
        };
        0x2::event::emit<DicerRolledEvent>(v0);
    }

    public(friend) fun forum_sent(arg0: address, arg1: 0x1::string::String) {
        let v0 = ForumSentEvent{
            account : arg0,
            message : arg1,
        };
        0x2::event::emit<ForumSentEvent>(v0);
    }

    public(friend) fun metal_challenged(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: address, arg5: address, arg6: address, arg7: u256, arg8: u256, arg9: u256) {
        let v0 = MetalChallengedEvent{
            account    : arg0,
            index      : arg1,
            prediction : arg2,
            random     : arg3,
            challenger : arg4,
            defender   : arg5,
            winner     : arg6,
            coins      : arg7,
            tokens     : arg8,
            won        : arg9,
        };
        0x2::event::emit<MetalChallengedEvent>(v0);
    }

    public(friend) fun tidal_bought(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256) {
        let v0 = TidalBoughtEvent{
            account : arg0,
            coins   : arg1,
            rate    : arg2,
            shares  : arg3,
            tokens  : arg4,
        };
        0x2::event::emit<TidalBoughtEvent>(v0);
    }

    public(friend) fun tidal_sold(arg0: address, arg1: u256, arg2: u256, arg3: u256) {
        let v0 = TidalSoldEvent{
            account : arg0,
            shares  : arg1,
            rate    : arg2,
            coins   : arg3,
        };
        0x2::event::emit<TidalSoldEvent>(v0);
    }

    public(friend) fun tidal_won(arg0: address, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = TidalWonEvent{
            account    : arg0,
            coins      : arg1,
            prediction : arg2,
            random     : arg3,
            shares     : arg4,
            tokens     : arg5,
        };
        0x2::event::emit<TidalWonEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

