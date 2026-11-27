module 0xfc6397dc6d8bdaade8f5713ac80c4373337a9f77b714717a2174dccb3af2f316::events {
    struct Deposited has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct Withdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        executor: address,
    }

    struct Repaid has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        executor: address,
    }

    struct AdminWithdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct BridgeCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        bridger: address,
    }

    struct BridgeCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct BridgeWithdrawn has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        bridger: address,
    }

    struct ExecutorSet has copy, drop {
        executor: address,
        approved: bool,
    }

    struct Swapped has copy, drop {
        executor: address,
        pool: address,
        coin_in: 0x1::type_name::TypeName,
        amount_in: u64,
        coin_out: 0x1::type_name::TypeName,
        amount_out: u64,
    }

    struct PositionOpened has copy, drop {
        executor: address,
        protocol: u8,
        pool: address,
        position_id: 0x2::object::ID,
        coin_type_0: 0x1::type_name::TypeName,
        coin_type_1: 0x1::type_name::TypeName,
        mint_amount_0: u64,
        mint_amount_1: u64,
    }

    struct PositionClosed has copy, drop {
        executor: address,
        protocol: u8,
        pool: address,
        position_id: 0x2::object::ID,
        coin_type_0: 0x1::type_name::TypeName,
        coin_type_1: 0x1::type_name::TypeName,
        mint_amount_0: u64,
        mint_amount_1: u64,
        collected_amount_0: u64,
        collected_amount_1: u64,
        fee_amount_0: u64,
        fee_amount_1: u64,
    }

    struct RewardCollected has copy, drop {
        executor: address,
        protocol: u8,
        pool: address,
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct AccountingUpdated has copy, drop {
        executor: address,
        asset: 0x1::type_name::TypeName,
        delta_negative: bool,
        delta_magnitude: u128,
        net_negative: bool,
        net_magnitude: u128,
    }

    public(friend) fun emit_accounting_updated(arg0: address, arg1: 0x1::type_name::TypeName, arg2: bool, arg3: u128, arg4: bool, arg5: u128) {
        let v0 = AccountingUpdated{
            executor        : arg0,
            asset           : arg1,
            delta_negative  : arg2,
            delta_magnitude : arg3,
            net_negative    : arg4,
            net_magnitude   : arg5,
        };
        0x2::event::emit<AccountingUpdated>(v0);
    }

    public(friend) fun emit_admin_withdrawn(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address) {
        let v0 = AdminWithdrawn{
            coin_type : arg0,
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<AdminWithdrawn>(v0);
    }

    public(friend) fun emit_bridge_cap_issued(arg0: 0x2::object::ID, arg1: address) {
        let v0 = BridgeCapIssued{
            cap_id  : arg0,
            bridger : arg1,
        };
        0x2::event::emit<BridgeCapIssued>(v0);
    }

    public(friend) fun emit_bridge_cap_revoked(arg0: 0x2::object::ID) {
        let v0 = BridgeCapRevoked{cap_id: arg0};
        0x2::event::emit<BridgeCapRevoked>(v0);
    }

    public(friend) fun emit_bridge_withdrawn(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address) {
        let v0 = BridgeWithdrawn{
            coin_type : arg0,
            amount    : arg1,
            bridger   : arg2,
        };
        0x2::event::emit<BridgeWithdrawn>(v0);
    }

    public(friend) fun emit_deposited(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address) {
        let v0 = Deposited{
            coin_type : arg0,
            amount    : arg1,
            depositor : arg2,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_executor_set(arg0: address, arg1: bool) {
        let v0 = ExecutorSet{
            executor : arg0,
            approved : arg1,
        };
        0x2::event::emit<ExecutorSet>(v0);
    }

    public(friend) fun emit_position_closed(arg0: address, arg1: u8, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = PositionClosed{
            executor           : arg0,
            protocol           : arg1,
            pool               : arg2,
            position_id        : arg3,
            coin_type_0        : arg4,
            coin_type_1        : arg5,
            mint_amount_0      : arg6,
            mint_amount_1      : arg7,
            collected_amount_0 : arg8,
            collected_amount_1 : arg9,
            fee_amount_0       : arg10,
            fee_amount_1       : arg11,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_opened(arg0: address, arg1: u8, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64) {
        let v0 = PositionOpened{
            executor      : arg0,
            protocol      : arg1,
            pool          : arg2,
            position_id   : arg3,
            coin_type_0   : arg4,
            coin_type_1   : arg5,
            mint_amount_0 : arg6,
            mint_amount_1 : arg7,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_repaid(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address) {
        let v0 = Repaid{
            coin_type : arg0,
            amount    : arg1,
            executor  : arg2,
        };
        0x2::event::emit<Repaid>(v0);
    }

    public(friend) fun emit_reward_collected(arg0: address, arg1: u8, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = RewardCollected{
            executor    : arg0,
            protocol    : arg1,
            pool        : arg2,
            position_id : arg3,
            coin_type   : arg4,
            amount      : arg5,
        };
        0x2::event::emit<RewardCollected>(v0);
    }

    public(friend) fun emit_swapped(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: u64) {
        let v0 = Swapped{
            executor   : arg0,
            pool       : arg1,
            coin_in    : arg2,
            amount_in  : arg3,
            coin_out   : arg4,
            amount_out : arg5,
        };
        0x2::event::emit<Swapped>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: address) {
        let v0 = Withdrawn{
            coin_type : arg0,
            amount    : arg1,
            executor  : arg2,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

