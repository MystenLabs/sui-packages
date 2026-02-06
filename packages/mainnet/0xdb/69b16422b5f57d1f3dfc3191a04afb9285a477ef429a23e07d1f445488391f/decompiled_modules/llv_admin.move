module 0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        owner: address,
    }

    struct LLVGlobalAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LLVPoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public fun assert_version(arg0: &LLVGlobal) {
        assert!(arg0.version == 1, 2);
    }

    public(friend) fun create_pool_admin_cap(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : LLVPoolAdminCap {
        LLVPoolAdminCap{
            id      : 0x2::object::new(arg1),
            pool_id : arg0,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = LLVGlobal{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
            owner   : v0,
        };
        0x2::transfer::share_object<LLVGlobal>(v1);
        let v2 = LLVGlobalAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LLVGlobalAdminCap>(v2, v0);
    }

    public fun is_global_paused(arg0: &LLVGlobal) : bool {
        arg0.paused
    }

    public(friend) fun migrate(arg0: &mut LLVGlobal, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 3);
        arg0.version = 1;
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_events::emit_global_migrated(arg0.version);
    }

    public fun owner(arg0: &LLVGlobal) : address {
        arg0.owner
    }

    public fun pool_id(arg0: &LLVPoolAdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun set_global_paused(arg0: &mut LLVGlobal, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.paused = arg1;
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_events::emit_global_paused(arg1);
    }

    public(friend) fun set_owner(arg0: &mut LLVGlobal, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.owner = arg1;
        0xdb69b16422b5f57d1f3dfc3191a04afb9285a477ef429a23e07d1f445488391f::llv_events::emit_owner_changed(arg0.owner, arg1);
    }

    public fun verify_pool_admin(arg0: &LLVPoolAdminCap, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

