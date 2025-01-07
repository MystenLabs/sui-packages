module 0xe0ba97571bf5d433622eb78df37c0088ab738dda3702f6941b757454b4f45a3e::events {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        x_token: 0x1::string::String,
        y_token: 0x1::string::String,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        x_amount: u64,
        y_amount: u64,
        lp_amount: u64,
        index: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        x_amount: u64,
        y_amount: u64,
        lp_amount: u64,
        index: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        x_in: u64,
        x_out: u64,
        y_in: u64,
        y_out: u64,
        index: u64,
    }

    struct TransactionFeeWithdrawal has copy, drop {
        pool_id: 0x2::object::ID,
        x_amount: u64,
        y_amount: u64,
        recipient: address,
    }

    struct PoolFeeWithdraw has copy, drop {
        pool_id: 0x2::object::ID,
        x_amount: u64,
        y_amount: u64,
        recipient: address,
    }

    struct PoolFeeConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        old_x_fee: u32,
        old_y_fee: u32,
        new_x_fee: u32,
        new_y_fee: u32,
        time: u64,
    }

    struct PoolTradingTimeChange has copy, drop {
        pool_id: 0x2::object::ID,
        new_time: u64,
    }

    struct PoolWhiteListSet has copy, drop {
        pool_id: 0x2::object::ID,
        action: u8,
        target: address,
    }

    struct PoolBlackListSet has copy, drop {
        pool_id: 0x2::object::ID,
        action: u8,
        target: address,
    }

    struct LPLocked has copy, drop {
        owner: address,
        lp_amount: u64,
        expired_time: u64,
    }

    struct LPUnlocked has copy, drop {
        lp_amount: u64,
    }

    struct LPUnlockDelay has copy, drop {
        unlock_time: u64,
    }

    struct Test has copy, drop {
        time: u64,
    }

    public fun emit_liqudity_added(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LiquidityAdded{
            pool_id   : arg0,
            x_amount  : arg1,
            y_amount  : arg2,
            lp_amount : arg3,
            index     : arg4,
        };
        0x2::event::emit<LiquidityAdded>(v0);
    }

    public fun emit_liqudity_removed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LiquidityRemoved{
            pool_id   : arg0,
            x_amount  : arg1,
            y_amount  : arg2,
            lp_amount : arg3,
            index     : arg4,
        };
        0x2::event::emit<LiquidityRemoved>(v0);
    }

    public fun emit_lp_locked(arg0: address, arg1: u64, arg2: u64) {
        let v0 = LPLocked{
            owner        : arg0,
            lp_amount    : arg1,
            expired_time : arg2,
        };
        0x2::event::emit<LPLocked>(v0);
    }

    public fun emit_lp_unlock_delay(arg0: u64) {
        let v0 = LPUnlockDelay{unlock_time: arg0};
        0x2::event::emit<LPUnlockDelay>(v0);
    }

    public fun emit_lp_unlocked(arg0: u64) {
        let v0 = LPUnlocked{lp_amount: arg0};
        0x2::event::emit<LPUnlocked>(v0);
    }

    public fun emit_pool_blacklist_set(arg0: 0x2::object::ID, arg1: u8, arg2: address) {
        let v0 = PoolBlackListSet{
            pool_id : arg0,
            action  : arg1,
            target  : arg2,
        };
        0x2::event::emit<PoolBlackListSet>(v0);
    }

    public fun emit_pool_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = PoolCreated{
            pool_id : arg0,
            x_token : arg1,
            y_token : arg2,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public fun emit_pool_fee_config_updated(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: u64) {
        let v0 = PoolFeeConfigUpdated{
            pool_id   : arg0,
            old_x_fee : arg1,
            old_y_fee : arg2,
            new_x_fee : arg3,
            new_y_fee : arg4,
            time      : arg5,
        };
        0x2::event::emit<PoolFeeConfigUpdated>(v0);
    }

    public fun emit_pool_fee_withdraw(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = PoolFeeWithdraw{
            pool_id   : arg0,
            x_amount  : arg1,
            y_amount  : arg2,
            recipient : arg3,
        };
        0x2::event::emit<PoolFeeWithdraw>(v0);
    }

    public fun emit_pool_tradingtime_change(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PoolTradingTimeChange{
            pool_id  : arg0,
            new_time : arg1,
        };
        0x2::event::emit<PoolTradingTimeChange>(v0);
    }

    public fun emit_pool_whitelist_set(arg0: 0x2::object::ID, arg1: u8, arg2: address) {
        let v0 = PoolWhiteListSet{
            pool_id : arg0,
            action  : arg1,
            target  : arg2,
        };
        0x2::event::emit<PoolWhiteListSet>(v0);
    }

    public fun emit_swap(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = Swapped{
            pool_id : arg0,
            sender  : arg1,
            x_in    : arg2,
            x_out   : arg3,
            y_in    : arg4,
            y_out   : arg5,
            index   : arg6,
        };
        0x2::event::emit<Swapped>(v0);
    }

    public fun emit_transaction_fee_withdraw(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = TransactionFeeWithdrawal{
            pool_id   : arg0,
            x_amount  : arg1,
            y_amount  : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TransactionFeeWithdrawal>(v0);
    }

    public fun test(arg0: u64) {
        let v0 = Test{time: arg0};
        0x2::event::emit<Test>(v0);
    }

    // decompiled from Move bytecode v6
}

