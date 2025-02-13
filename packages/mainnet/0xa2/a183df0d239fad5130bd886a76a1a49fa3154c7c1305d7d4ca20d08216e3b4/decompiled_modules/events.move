module 0xa2a183df0d239fad5130bd886a76a1a49fa3154c7c1305d7d4ca20d08216e3b4::events {
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

