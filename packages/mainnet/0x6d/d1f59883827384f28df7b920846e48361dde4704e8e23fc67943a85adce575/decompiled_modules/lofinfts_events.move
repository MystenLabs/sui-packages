module 0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::lofinfts_events {
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

    struct AirdropPositionCreated has copy, drop {
        number: u64,
        made_by: address,
    }

    struct Mint has copy, drop {
        id: 0x2::object::ID,
        number: u64,
    }

    struct Reveal has copy, drop {
        id: 0x2::object::ID,
        number: u64,
    }

    public(friend) fun airdrop_position_created(arg0: u64, arg1: address) {
        let v0 = AirdropPositionCreated{
            number  : arg0,
            made_by : arg1,
        };
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::event_wrapper::emit_event<AirdropPositionCreated>(v0);
    }

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Mint{
            id     : arg0,
            number : arg1,
        };
        0x2::event::emit<Mint>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun reveal(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = Reveal{
            id     : arg0,
            number : arg1,
        };
        0x2::event::emit<Reveal>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0x6dd1f59883827384f28df7b920846e48361dde4704e8e23fc67943a85adce575::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

