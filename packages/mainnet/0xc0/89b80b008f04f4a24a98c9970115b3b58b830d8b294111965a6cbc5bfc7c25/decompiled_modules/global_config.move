module 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::global_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        acl: 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::ACL,
        paused: bool,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
    }

    struct MemberRolesUpdatedEvent has copy, drop {
        member: address,
        old_roles: u128,
        new_roles: u128,
    }

    struct MemberRemovedEvent has copy, drop {
        member: address,
    }

    struct PauseEvent has copy, drop {
        is_paused: bool,
    }

    public fun get_permission(arg0: &GlobalConfig, arg1: address) : u128 {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg1)
    }

    public fun has_role(arg0: &GlobalConfig, arg1: address, arg2: u8) : bool {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::has_role(&arg0.acl, arg1, arg2)
    }

    public fun remove_member(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::remove_member(&mut arg0.acl, arg2);
        let v0 = MemberRemovedEvent{member: arg2};
        0x2::event::emit<MemberRemovedEvent>(v0);
    }

    public fun set_roles(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address, arg3: u128) {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::set_roles(&mut arg0.acl, arg2, arg3);
        let v0 = MemberRolesUpdatedEvent{
            member    : arg2,
            old_roles : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg2),
            new_roles : arg3,
        };
        0x2::event::emit<MemberRolesUpdatedEvent>(v0);
    }

    public fun add_keeper(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::add_role(&mut arg0.acl, arg2, 0);
        let v0 = MemberRolesUpdatedEvent{
            member    : arg2,
            old_roles : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg2),
            new_roles : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg2),
        };
        0x2::event::emit<MemberRolesUpdatedEvent>(v0);
    }

    public fun assert_keeper(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg1), 0), 13906834891602919425);
    }

    public fun assert_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.paused, 13906834913077886979);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalConfig{
            id     : 0x2::object::new(arg0),
            acl    : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::new(arg0),
            paused : false,
        };
        let v2 = InitEvent{
            admin_cap_id     : 0x2::object::id<AdminCap>(&v0),
            global_config_id : 0x2::object::id<GlobalConfig>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_keeper(arg0: &GlobalConfig, arg1: address) : bool {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::has_role(&arg0.acl, arg1, 0)
    }

    public fun pause(arg0: &mut GlobalConfig, arg1: &AdminCap) {
        if (arg0.paused) {
            return
        };
        arg0.paused = true;
        let v0 = PauseEvent{is_paused: true};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun remove_keeper(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::remove_role(&mut arg0.acl, arg2, 0);
        let v0 = MemberRolesUpdatedEvent{
            member    : arg2,
            old_roles : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg2),
            new_roles : 0xc089b80b008f04f4a24a98c9970115b3b58b830d8b294111965a6cbc5bfc7c25::acl::get_permission(&arg0.acl, arg2),
        };
        0x2::event::emit<MemberRolesUpdatedEvent>(v0);
    }

    public fun role_keeper() : u8 {
        0
    }

    public fun unpause(arg0: &mut GlobalConfig, arg1: &AdminCap) {
        if (!arg0.paused) {
            return
        };
        arg0.paused = false;
        let v0 = PauseEvent{is_paused: false};
        0x2::event::emit<PauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

