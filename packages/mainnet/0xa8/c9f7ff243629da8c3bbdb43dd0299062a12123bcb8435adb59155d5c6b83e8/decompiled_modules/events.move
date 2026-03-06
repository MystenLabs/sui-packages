module 0xa8c9f7ff243629da8c3bbdb43dd0299062a12123bcb8435adb59155d5c6b83e8::events {
    struct PoolCreated has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
    }

    struct PositionCreated has copy, drop {
        protocol: 0x1::string::String,
        wrapper_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        supplier: address,
        amount: u64,
        timestamp: u64,
    }

    struct Withdrawn has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        receiver: address,
        amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct ProtocolFeesCollected has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    struct IncentivesCompounded has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        amount: u64,
        shares: u64,
        timestamp: u64,
    }

    struct ReferralFeesCollected has copy, drop {
        protocol: 0x1::string::String,
        pool_id: 0x2::object::ID,
        amount: u64,
        timestamp: u64,
    }

    public fun emit_deposited(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64) {
        let v0 = Deposited{
            protocol  : arg0,
            pool_id   : arg1,
            supplier  : arg2,
            amount    : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public fun emit_incentives_compounded(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = IncentivesCompounded{
            protocol  : arg0,
            pool_id   : arg1,
            amount    : arg2,
            shares    : arg3,
            timestamp : arg4,
        };
        0x2::event::emit<IncentivesCompounded>(v0);
    }

    public fun emit_pool_created(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) {
        let v0 = PoolCreated{
            protocol   : arg0,
            pool_id    : arg1,
            asset_type : arg2,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public fun emit_position_created(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = PositionCreated{
            protocol    : arg0,
            wrapper_id  : arg1,
            position_id : arg2,
            owner       : arg3,
        };
        0x2::event::emit<PositionCreated>(v0);
    }

    public fun emit_protocol_fees_collected(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ProtocolFeesCollected{
            protocol  : arg0,
            pool_id   : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<ProtocolFeesCollected>(v0);
    }

    public fun emit_referral_fees_collected(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ReferralFeesCollected{
            protocol  : arg0,
            pool_id   : arg1,
            amount    : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<ReferralFeesCollected>(v0);
    }

    public fun emit_withdrawn(arg0: 0x1::string::String, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Withdrawn{
            protocol   : arg0,
            pool_id    : arg1,
            receiver   : arg2,
            amount     : arg3,
            fee_amount : arg4,
            timestamp  : arg5,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

