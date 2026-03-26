module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id {
    struct TenantItemId has copy, drop, store {
        item_id: u64,
        tenant: 0x1::string::String,
    }

    public(friend) fun create_key(arg0: u64, arg1: 0x1::string::String) : TenantItemId {
        TenantItemId{
            item_id : arg0,
            tenant  : arg1,
        }
    }

    public fun item_id(arg0: &TenantItemId) : u64 {
        arg0.item_id
    }

    public fun tenant(arg0: &TenantItemId) : 0x1::string::String {
        arg0.tenant
    }

    // decompiled from Move bytecode v6
}

