module 0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::sam_events {
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

    public(friend) fun finish_super_admin_transfer(arg0: address) {
        let v0 = FinishSuperAdminTransfer{pos0: arg0};
        0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0x2f9a19a1976054c080d10704ad29e42472295a212dea7b7ca203b297af7a5b28::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

