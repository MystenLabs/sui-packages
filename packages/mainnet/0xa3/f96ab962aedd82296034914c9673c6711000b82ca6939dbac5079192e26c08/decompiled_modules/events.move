module 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
        is_compounded: bool,
    }

    struct Compounded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct ZappedIn has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct ZappedOut has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        zap_token: 0x1::type_name::TypeName,
        zap_amount: u64,
    }

    struct Automated has copy, drop {
        owner: address,
        position_id: 0x2::object::ID,
        source: u64,
    }

    struct AutomatedFeeCollected has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct AutomatedRewardCollected has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun emit_automated(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: address, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = Automated{
            owner       : arg1,
            position_id : arg2,
            source      : arg3,
        };
        0x2::event::emit<Automated>(v0);
    }

    public fun emit_automated_fee_collected(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = AutomatedFeeCollected{
            owner       : arg1,
            pool_id     : arg3,
            position_id : arg2,
            amount_x    : arg4,
            amount_y    : arg5,
        };
        0x2::event::emit<AutomatedFeeCollected>(v0);
    }

    public fun emit_automated_reward_collected(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = AutomatedRewardCollected{
            owner       : arg1,
            pool_id     : arg2,
            position_id : arg3,
            coin_type   : arg4,
            amount      : arg5,
        };
        0x2::event::emit<AutomatedRewardCollected>(v0);
    }

    public fun emit_compounded(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = Compounded{
            pool_id     : arg1,
            position_id : arg2,
            amount_x    : arg3,
            amount_y    : arg4,
        };
        0x2::event::emit<Compounded>(v0);
    }

    public fun emit_rebalanced(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        let v0 = Rebalanced{
            pool_id         : arg1,
            old_position_id : arg2,
            new_position_id : arg3,
            old_amount_x    : arg4,
            old_amount_y    : arg5,
            new_amount_x    : arg6,
            new_amount_y    : arg7,
            is_compounded   : arg8,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = ZappedIn{
            pool_id     : arg1,
            position_id : arg2,
            amount_x    : arg3,
            amount_y    : arg4,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    public fun emit_zapped_out(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: u64) {
        let v0 = ZappedOut{
            pool_id     : arg1,
            position_id : arg2,
            zap_token   : arg3,
            zap_amount  : arg4,
        };
        0x2::event::emit<ZappedOut>(v0);
    }

    // decompiled from Move bytecode v6
}

