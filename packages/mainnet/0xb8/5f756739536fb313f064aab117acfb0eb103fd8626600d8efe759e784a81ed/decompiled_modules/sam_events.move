module 0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::sam_events {
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
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::event_wrapper::emit_event<FinishSuperAdminTransfer>(v0);
    }

    public(friend) fun new_admin(arg0: address) {
        let v0 = NewAdmin{pos0: arg0};
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::event_wrapper::emit_event<NewAdmin>(v0);
    }

    public(friend) fun revoke_admin(arg0: address) {
        let v0 = RevokeAdmin{pos0: arg0};
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::event_wrapper::emit_event<RevokeAdmin>(v0);
    }

    public(friend) fun start_super_admin_transfer(arg0: address, arg1: u64) {
        let v0 = StartSuperAdminTransfer{
            new_admin : arg0,
            start     : arg1,
        };
        0xb85f756739536fb313f064aab117acfb0eb103fd8626600d8efe759e784a81ed::event_wrapper::emit_event<StartSuperAdminTransfer>(v0);
    }

    // decompiled from Move bytecode v6
}

