module 0xa5016df20113a62b0a8686aa885cd780f203b883472d53b5c0d188a4696c5497::events {
    struct UserSupplied has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_minted: u64,
        total_user_shares_after: u64,
        share_price: u64,
        timestamp_ms: u64,
    }

    struct UserWithdrew has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        amount: u64,
        shares_burned: u64,
        principal_portion: u64,
        yield_portion: u64,
        total_user_shares_after: u64,
        share_price: u64,
        timestamp_ms: u64,
    }

    struct YieldClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    struct YieldDeposited has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        total_user_shares: u64,
        yield_balance_after: u64,
        share_price: u64,
        timestamp_ms: u64,
    }

    struct YieldLocked has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        total_locked_before: u64,
        total_locked: u64,
        duration_ms: u64,
        end_ms: u64,
        timestamp_ms: u64,
    }

    struct YieldCancelled has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp_ms: u64,
    }

    public(friend) fun emit_user_supplied(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = UserSupplied{
            pool_id                 : arg0,
            user                    : arg1,
            amount                  : arg2,
            shares_minted           : arg3,
            total_user_shares_after : arg4,
            share_price             : arg5,
            timestamp_ms            : arg6,
        };
        0x2::event::emit<UserSupplied>(v0);
    }

    public(friend) fun emit_user_withdrew(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = UserWithdrew{
            pool_id                 : arg0,
            user                    : arg1,
            amount                  : arg2,
            shares_burned           : arg3,
            principal_portion       : arg4,
            yield_portion           : arg5,
            total_user_shares_after : arg6,
            share_price             : arg7,
            timestamp_ms            : arg8,
        };
        0x2::event::emit<UserWithdrew>(v0);
    }

    public(friend) fun emit_yield_cancelled(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = YieldCancelled{
            pool_id      : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<YieldCancelled>(v0);
    }

    public(friend) fun emit_yield_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = YieldClaimed{
            pool_id      : arg0,
            amount       : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<YieldClaimed>(v0);
    }

    public(friend) fun emit_yield_deposited(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = YieldDeposited{
            pool_id             : arg0,
            amount              : arg1,
            total_user_shares   : arg2,
            yield_balance_after : arg3,
            share_price         : arg4,
            timestamp_ms        : arg5,
        };
        0x2::event::emit<YieldDeposited>(v0);
    }

    public(friend) fun emit_yield_locked(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = YieldLocked{
            pool_id             : arg0,
            amount              : arg1,
            total_locked_before : arg2,
            total_locked        : arg3,
            duration_ms         : arg4,
            end_ms              : arg5,
            timestamp_ms        : arg6,
        };
        0x2::event::emit<YieldLocked>(v0);
    }

    // decompiled from Move bytecode v7
}

