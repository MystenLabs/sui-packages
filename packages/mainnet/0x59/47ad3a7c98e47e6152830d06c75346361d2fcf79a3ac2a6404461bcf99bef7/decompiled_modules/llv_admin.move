module 0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
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
        let v0 = LLVGlobal{
            id      : 0x2::object::new(arg0),
            version : 1,
            paused  : false,
        };
        0x2::transfer::share_object<LLVGlobal>(v0);
        let v1 = LLVGlobalAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LLVGlobalAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_global_paused(arg0: &LLVGlobal) : bool {
        arg0.paused
    }

    public(friend) fun migrate(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap) {
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_events::emit_global_migrated(arg0.version, 1);
    }

    public fun pool_id(arg0: &LLVPoolAdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun set_global_paused(arg0: &mut LLVGlobal, arg1: bool, arg2: &LLVGlobalAdminCap) {
        assert_version(arg0);
        arg0.paused = arg1;
        0x35348a749469dbac580a8a9c86223df3398a3b0086b6254b01e7af6c36b5b0ef::llv_events::emit_global_paused(arg1);
    }

    public(friend) fun verify_pool_admin(arg0: &LLVPoolAdminCap, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

