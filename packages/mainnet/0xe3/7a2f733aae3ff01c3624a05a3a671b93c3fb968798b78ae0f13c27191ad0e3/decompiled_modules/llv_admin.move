module 0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
    }

    struct LLVGlobalAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LLVPoolAdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public(friend) fun accept_owner(arg0: &mut LLVGlobal, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 5);
        assert!(*0x1::option::borrow<address>(&arg0.pending_owner) == 0x2::tx_context::sender(arg1), 6);
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_owner);
        arg0.owner = v0;
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_owner_changed(arg0.owner, v0);
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
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            owner         : v0,
            pending_owner : 0x1::option::none<address>(),
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
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_global_migrated(arg0.version, 1);
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
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_global_paused(arg1);
    }

    public(friend) fun set_owner(arg0: &mut LLVGlobal, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        0x2c86748ceda3fe9a35b5138b56fbd2c93a62a128250b686a0d153be3f8fe8784::llv_events::emit_pending_owner_set(arg0.owner, arg1);
    }

    public(friend) fun verify_pool_admin(arg0: &LLVPoolAdminCap, arg1: 0x2::object::ID) {
        assert!(arg0.pool_id == arg1, 1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

