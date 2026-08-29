module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events {
    struct LaunchEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        creator: address,
        pit_mode: u8,
        reflection: bool,
        virtual_quote: u64,
        virtual_token: u64,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
    }

    struct TradeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        quote_amount: u64,
        token_amount: u64,
        pit_fee: u64,
        reflection_fee: u64,
        creator_fee: u64,
        platform_fee: u64,
        raised: u64,
        token_reserve: u64,
        quote_real: u64,
    }

    struct PitNudgeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        metric: u64,
        round: u64,
    }

    struct BellEvent has copy, drop {
        winner_id: 0x1::option::Option<0x2::object::ID>,
        round: u64,
        pot: u64,
    }

    struct PitSettleEvent has copy, drop {
        winner_id: 0x2::object::ID,
        amount: u64,
        mode: u8,
    }

    struct ClaimEvent has copy, drop {
        pool_id: 0x2::object::ID,
        who: address,
        amount: u64,
        kind: u8,
    }

    struct GraduationEvent has copy, drop {
        pool_id: 0x2::object::ID,
        raised: u64,
        token_reserve: u64,
        quote_real: u64,
    }

    struct LockEvent has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        beneficiary: address,
        unlock_ms: u64,
        token_amount: u64,
        quote_amount: u64,
    }

    struct BluefinLockEvent has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        beneficiary: address,
        unlock_ms: u64,
        token_amount: u64,
        quote_amount: u64,
        bluefin_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct LpClaimEvent has copy, drop {
        lock_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        who: address,
        token_amount: u64,
        quote_amount: u64,
    }

    public fun emit_bell(arg0: 0x1::option::Option<0x2::object::ID>, arg1: u64, arg2: u64) {
        let v0 = BellEvent{
            winner_id : arg0,
            round     : arg1,
            pot       : arg2,
        };
        0x2::event::emit<BellEvent>(v0);
    }

    public fun emit_bluefin_lock(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::object::ID, arg7: 0x2::object::ID) {
        let v0 = BluefinLockEvent{
            lock_id         : arg0,
            pool_id         : arg1,
            beneficiary     : arg2,
            unlock_ms       : arg3,
            token_amount    : arg4,
            quote_amount    : arg5,
            bluefin_pool_id : arg6,
            position_id     : arg7,
        };
        0x2::event::emit<BluefinLockEvent>(v0);
    }

    public fun emit_claim(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u8) {
        let v0 = ClaimEvent{
            pool_id : arg0,
            who     : arg1,
            amount  : arg2,
            kind    : arg3,
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    public fun emit_graduation(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = GraduationEvent{
            pool_id       : arg0,
            raised        : arg1,
            token_reserve : arg2,
            quote_real    : arg3,
        };
        0x2::event::emit<GraduationEvent>(v0);
    }

    public fun emit_launch(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u8, arg5: bool, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::ascii::String) {
        let v0 = LaunchEvent{
            pool_id       : arg0,
            token         : arg1,
            quote         : arg2,
            creator       : arg3,
            pit_mode      : arg4,
            reflection    : arg5,
            virtual_quote : arg6,
            virtual_token : arg7,
            name          : arg8,
            symbol        : arg9,
        };
        0x2::event::emit<LaunchEvent>(v0);
    }

    public fun emit_lock(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = LockEvent{
            lock_id      : arg0,
            pool_id      : arg1,
            beneficiary  : arg2,
            unlock_ms    : arg3,
            token_amount : arg4,
            quote_amount : arg5,
        };
        0x2::event::emit<LockEvent>(v0);
    }

    public fun emit_lp_claim(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = LpClaimEvent{
            lock_id      : arg0,
            pool_id      : arg1,
            who          : arg2,
            token_amount : arg3,
            quote_amount : arg4,
        };
        0x2::event::emit<LpClaimEvent>(v0);
    }

    public fun emit_pit_nudge(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PitNudgeEvent{
            pool_id : arg0,
            metric  : arg1,
            round   : arg2,
        };
        0x2::event::emit<PitNudgeEvent>(v0);
    }

    public fun emit_pit_settle(arg0: 0x2::object::ID, arg1: u64, arg2: u8) {
        let v0 = PitSettleEvent{
            winner_id : arg0,
            amount    : arg1,
            mode      : arg2,
        };
        0x2::event::emit<PitSettleEvent>(v0);
    }

    public fun emit_trade(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = TradeEvent{
            pool_id        : arg0,
            trader         : arg1,
            is_buy         : arg2,
            quote_amount   : arg3,
            token_amount   : arg4,
            pit_fee        : arg5,
            reflection_fee : arg6,
            creator_fee    : arg7,
            platform_fee   : arg8,
            raised         : arg9,
            token_reserve  : arg10,
            quote_real     : arg11,
        };
        0x2::event::emit<TradeEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

