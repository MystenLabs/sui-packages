module 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct LLVGlobalAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_version(arg0: &LLVGlobal) {
        assert!(arg0.version == 1, 2);
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
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_global_migrated(arg0.version, 1);
    }

    public(friend) fun set_global_paused(arg0: &mut LLVGlobal, arg1: bool, arg2: &LLVGlobalAdminCap) {
        assert_version(arg0);
        arg0.paused = arg1;
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_global_paused(arg1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

