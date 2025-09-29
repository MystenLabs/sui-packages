module 0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::events {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
        old_sqrt_price: u128,
        new_sqrt_price: u128,
        compound: vector<0x1::string::String>,
    }

    struct Compounded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
        compound: vector<0x1::string::String>,
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

    struct AutoFeeCollected has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct AutoRewardCollected has copy, drop {
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun emit_auto_fee_collected(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = AutoFeeCollected{
            owner       : arg0,
            pool_id     : arg2,
            position_id : arg1,
            amount_x    : arg3,
            amount_y    : arg4,
        };
        0x2::event::emit<AutoFeeCollected>(v0);
    }

    public fun emit_auto_reward_collected(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = AutoRewardCollected{
            owner       : arg0,
            pool_id     : arg1,
            position_id : arg2,
            coin_type   : arg3,
            amount      : arg4,
        };
        0x2::event::emit<AutoRewardCollected>(v0);
    }

    public fun emit_automated(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = Automated{
            owner       : arg0,
            position_id : arg1,
            source      : arg2,
        };
        0x2::event::emit<Automated>(v0);
    }

    public fun emit_compounded(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>, arg5: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = Compounded{
            pool_id     : arg0,
            position_id : arg1,
            amount_x    : arg2,
            amount_y    : arg3,
            compound    : arg4,
        };
        0x2::event::emit<Compounded>(v0);
    }

    public fun emit_rebalanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: vector<0x1::string::String>, arg10: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = Rebalanced{
            pool_id         : arg0,
            old_position_id : arg1,
            new_position_id : arg2,
            old_amount_x    : arg3,
            old_amount_y    : arg4,
            new_amount_x    : arg5,
            new_amount_y    : arg6,
            old_sqrt_price  : arg7,
            new_sqrt_price  : arg8,
            compound        : arg9,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = ZappedIn{
            pool_id     : arg0,
            position_id : arg1,
            amount_x    : arg2,
            amount_y    : arg3,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    public fun emit_zapped_out(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x49990ac6ed1ba97163f98cc4f693d268969bb4cc7c7a1eae6d28b5b31918ae2d::registry::ProxyCap) {
        let v0 = ZappedOut{
            pool_id     : arg0,
            position_id : arg1,
            zap_token   : arg2,
            zap_amount  : arg3,
        };
        0x2::event::emit<ZappedOut>(v0);
    }

    // decompiled from Move bytecode v6
}

