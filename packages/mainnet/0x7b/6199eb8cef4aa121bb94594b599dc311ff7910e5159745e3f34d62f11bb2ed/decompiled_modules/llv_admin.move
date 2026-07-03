module 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_admin {
    struct LLVGlobal has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        emergency_acl: 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::Acl,
    }

    struct LLVGlobalAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun assert_version(arg0: &LLVGlobal) {
        assert!(arg0.version == 1, 2);
    }

    public(friend) fun emergency_pause_global(arg0: &mut LLVGlobal, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_emergency_pauser(arg0, v0), 5);
        arg0.paused = true;
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_global_paused(true);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_global_emergency_paused(v0);
    }

    public fun get_emergency_pausers(arg0: &LLVGlobal) : vector<address> {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::members_with_role(&arg0.emergency_acl, 1)
    }

    public(friend) fun grant_emergency_pauser(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg2 != @0x0, 9);
        assert!(!is_emergency_pauser(arg0, arg2), 6);
        assert!(0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::role_count(&arg0.emergency_acl, 1) < 10, 8);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::set_role(&mut arg0.emergency_acl, arg2, 1);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_emergency_pauser_updated(arg2, 0x2::tx_context::sender(arg3), true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LLVGlobal{
            id            : 0x2::object::new(arg0),
            version       : 1,
            paused        : false,
            emergency_acl : 0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::empty(),
        };
        0x2::transfer::share_object<LLVGlobal>(v0);
        let v1 = LLVGlobalAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LLVGlobalAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_emergency_pauser(arg0: &LLVGlobal, arg1: address) : bool {
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::has_role(&arg0.emergency_acl, arg1, 1)
    }

    public fun is_global_paused(arg0: &LLVGlobal) : bool {
        arg0.paused
    }

    public(friend) fun migrate(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap) {
        assert!(arg0.version < 1, 4);
        arg0.version = 1;
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_global_migrated(arg0.version, 1);
    }

    public(friend) fun revoke_emergency_pauser(arg0: &mut LLVGlobal, arg1: &LLVGlobalAdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(is_emergency_pauser(arg0, arg2), 7);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_acl::remove_role(&mut arg0.emergency_acl, arg2);
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_emergency_pauser_updated(arg2, 0x2::tx_context::sender(arg3), false);
    }

    public(friend) fun set_global_paused(arg0: &mut LLVGlobal, arg1: bool, arg2: &LLVGlobalAdminCap) {
        assert_version(arg0);
        arg0.paused = arg1;
        0x7b6199eb8cef4aa121bb94594b599dc311ff7910e5159745e3f34d62f11bb2ed::llv_events::emit_global_paused(arg1);
    }

    public fun version(arg0: &LLVGlobal) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

