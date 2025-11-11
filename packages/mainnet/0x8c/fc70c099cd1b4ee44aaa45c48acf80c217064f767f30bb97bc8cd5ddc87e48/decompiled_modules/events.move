module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::events {
    struct TipSent has copy, drop {
        from: address,
        to: address,
        amount: u64,
        message: 0x1::string::String,
    }

    struct ProfileCreated has copy, drop {
        address: address,
        name: 0x1::string::String,
    }

    public fun emit_profile_created(arg0: address, arg1: 0x1::string::String) {
        let v0 = ProfileCreated{
            address : arg0,
            name    : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun emit_tip_sent(arg0: address, arg1: address, arg2: u64, arg3: 0x1::string::String) {
        let v0 = TipSent{
            from    : arg0,
            to      : arg1,
            amount  : arg2,
            message : arg3,
        };
        0x2::event::emit<TipSent>(v0);
    }

    // decompiled from Move bytecode v6
}

