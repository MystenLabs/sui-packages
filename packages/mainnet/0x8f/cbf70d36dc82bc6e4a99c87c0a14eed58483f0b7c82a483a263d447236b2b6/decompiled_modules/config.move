module 0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AmbassadorConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::acl::ACL,
        pause_table: 0x2::table::Table<0x2::object::ID, bool>,
        requested_time_table: 0x2::table::Table<0x2::object::ID, u64>,
        ambassadors_owner_table: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        ambassador_config_id: 0x2::object::ID,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct SetPauseEvent has copy, drop {
        ambassador_id: 0x2::object::ID,
        paused: bool,
    }

    struct SetRequestedTimeEvent has copy, drop {
        ambassador_id: 0x2::object::ID,
        requested_time: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut AmbassadorConfig, arg2: address, arg3: u8) {
        0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut AmbassadorConfig, arg2: address, arg3: u8) {
        0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public(friend) fun check_staff(arg0: &AmbassadorConfig, arg1: address) {
        assert!(0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::acl::has_role(&arg0.acl, arg1, 0), 0);
    }

    public(friend) fun get_ambassador_id_by_owner(arg0: &AmbassadorConfig, arg1: address) : 0x2::object::ID {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.ambassadors_owner_table, arg1), 1);
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.ambassadors_owner_table, arg1)
    }

    public(friend) fun get_ambassador_pause(arg0: &AmbassadorConfig, arg1: 0x2::object::ID) : bool {
        !0x2::table::contains<0x2::object::ID, bool>(&arg0.pause_table, arg1) && false || *0x2::table::borrow<0x2::object::ID, bool>(&arg0.pause_table, arg1)
    }

    public(friend) fun get_ambassador_requested_time(arg0: &AmbassadorConfig, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.requested_time_table, arg1)) {
            0
        } else {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.requested_time_table, arg1)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AmbassadorConfig{
            id                      : 0x2::object::new(arg0),
            acl                     : 0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::acl::new(arg0),
            pause_table             : 0x2::table::new<0x2::object::ID, bool>(arg0),
            requested_time_table    : 0x2::table::new<0x2::object::ID, u64>(arg0),
            ambassadors_owner_table : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = &mut v0;
        add_role(&v1, v3, v2, 0);
        0x2::transfer::transfer<AdminCap>(v1, v2);
        0x2::transfer::share_object<AmbassadorConfig>(v0);
        let v4 = InitConfigEvent{
            admin_cap_id         : 0x2::object::id<AdminCap>(&v1),
            ambassador_config_id : 0x2::object::id<AmbassadorConfig>(&v0),
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    public(friend) fun remove_staff(arg0: &AdminCap, arg1: &mut AmbassadorConfig, arg2: address) {
        remove_role(arg0, arg1, arg2, 0);
    }

    public(friend) fun set_ambassador_owner(arg0: &mut AmbassadorConfig, arg1: 0x2::object::ID, arg2: address) {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.ambassadors_owner_table, arg2)) {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.ambassadors_owner_table, arg2, arg1);
        };
    }

    public(friend) fun set_ambassador_pause(arg0: &mut AmbassadorConfig, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_staff(arg0, 0x2::tx_context::sender(arg3));
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.pause_table, arg1, arg2);
        let v0 = SetPauseEvent{
            ambassador_id : arg1,
            paused        : arg2,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    public(friend) fun set_ambassador_requested_time(arg0: &mut AmbassadorConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_staff(arg0, 0x2::tx_context::sender(arg3));
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.requested_time_table, arg1, arg2);
        let v0 = SetRequestedTimeEvent{
            ambassador_id  : arg1,
            requested_time : arg2,
        };
        0x2::event::emit<SetRequestedTimeEvent>(v0);
    }

    public(friend) fun set_staff(arg0: &AdminCap, arg1: &mut AmbassadorConfig, arg2: address) {
        add_role(arg0, arg1, arg2, 0);
    }

    // decompiled from Move bytecode v6
}

