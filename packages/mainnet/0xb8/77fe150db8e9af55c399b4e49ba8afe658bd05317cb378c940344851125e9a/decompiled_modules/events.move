module 0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::events {
    struct New<phantom T0> has copy, drop {
        new_super_admin: address,
        super_admin_recipient: address,
        acl: address,
        delay: u64,
    }

    struct StartSuperAdminTransfer<phantom T0> has copy, drop {
        new_admin: address,
        start: u64,
    }

    struct FinishSuperAdminTransfer<phantom T0> has copy, drop {
        new_admin: address,
    }

    struct NewAdmin<phantom T0> has copy, drop {
        admin: address,
    }

    struct RevokeAdmin<phantom T0> has copy, drop {
        admin: address,
    }

    struct AdminDestroyed<phantom T0> has copy, drop {
        pos0: address,
    }

    struct SuperAdminDestroyed<phantom T0> has copy, drop {
        pos0: address,
    }

    struct RoleAdded<phantom T0> has copy, drop {
        pos0: address,
        pos1: u8,
    }

    struct RoleRemoved<phantom T0> has copy, drop {
        pos0: address,
        pos1: u8,
    }

    public(friend) fun admin_destroyed<T0>(arg0: address) {
        let v0 = AdminDestroyed<T0>{pos0: arg0};
        0x2::event::emit<AdminDestroyed<T0>>(v0);
    }

    public(friend) fun finish_super_admin_transfer<T0>(arg0: address) {
        let v0 = FinishSuperAdminTransfer<T0>{new_admin: arg0};
        0x2::event::emit<FinishSuperAdminTransfer<T0>>(v0);
    }

    public(friend) fun new_admin<T0>(arg0: address) {
        let v0 = NewAdmin<T0>{admin: arg0};
        0x2::event::emit<NewAdmin<T0>>(v0);
    }

    public(friend) fun new_super_admin<T0>(arg0: address, arg1: address, arg2: address, arg3: u64) {
        let v0 = New<T0>{
            new_super_admin       : arg1,
            super_admin_recipient : arg2,
            acl                   : arg0,
            delay                 : arg3,
        };
        0x2::event::emit<New<T0>>(v0);
    }

    public(friend) fun revoke_admin<T0>(arg0: address) {
        let v0 = RevokeAdmin<T0>{admin: arg0};
        0x2::event::emit<RevokeAdmin<T0>>(v0);
    }

    public(friend) fun role_added<T0>(arg0: address, arg1: u8) {
        let v0 = RoleAdded<T0>{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<RoleAdded<T0>>(v0);
    }

    public(friend) fun role_removed<T0>(arg0: address, arg1: u8) {
        let v0 = RoleRemoved<T0>{
            pos0 : arg0,
            pos1 : arg1,
        };
        0x2::event::emit<RoleRemoved<T0>>(v0);
    }

    public(friend) fun start_super_admin_transfer<T0>(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer<T0>{
            new_admin : arg0,
            start     : arg1,
        };
        0x2::event::emit<StartSuperAdminTransfer<T0>>(v0);
    }

    public(friend) fun super_admin_destroyed<T0>(arg0: address) {
        let v0 = SuperAdminDestroyed<T0>{pos0: arg0};
        0x2::event::emit<SuperAdminDestroyed<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

