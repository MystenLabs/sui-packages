module 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::events {
    struct StartSuperAdminTransfer has copy, drop {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer has copy, drop {
        pos0: address,
    }

    struct NewAdmin has copy, drop {
        pos0: address,
    }

    struct RevokeAdmin has copy, drop {
        pos0: address,
    }

    struct Mint has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        image: 0x1::string::String,
        attributes: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::attributes::Attributes,
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::attributes::Attributes) {
        let v0 = Mint{
            id         : arg0,
            number     : arg1,
            image      : arg2,
            attributes : arg3,
        };
        0x2::event::emit<Mint>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0x146773f468b2b623a10b5ef8cfb921299f1a6a77ceab207a3b070af96fdc049c::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

