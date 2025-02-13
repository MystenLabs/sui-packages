module 0x96c89e8d794e180f2b1443677c3575d182043233af830dfb5588fdaa2b01d6df::events {
    struct FeeEvent has copy, drop {
        creator: address,
        affiliate: address,
        creator_fee: u64,
        affiliate_fee: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    public(friend) fun emit_fee_event(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::type_name::TypeName) {
        let v0 = FeeEvent{
            creator       : arg0,
            affiliate     : arg1,
            creator_fee   : arg2,
            affiliate_fee : arg3,
            coin_type     : arg4,
        };
        0x2::event::emit<FeeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

