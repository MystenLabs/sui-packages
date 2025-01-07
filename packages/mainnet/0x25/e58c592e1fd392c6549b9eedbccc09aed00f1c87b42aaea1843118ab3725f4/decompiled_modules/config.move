module 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        package_version: u64,
        ticks: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
    }

    struct InitConfigEvent has copy, drop, store {
        global_config_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct FetchTickEvent has copy, drop, store {
        p: 0x1::string::String,
        tick: 0x1::string::String,
        tick_id: 0x2::object::ID,
    }

    public(friend) fun add_tick(arg0: &mut GlobalConfig, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        if (0x2::linked_table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.ticks, arg1)) {
            abort 0
        };
        0x2::linked_table::push_back<0x2::object::ID, 0x2::object::ID>(&mut arg0.ticks, arg1, arg2);
    }

    public fun checked_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 1);
    }

    public fun contains_tick(arg0: &GlobalConfig, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.ticks, arg1)
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) : Account {
        Account{id: 0x2::object::new(arg0)}
    }

    public fun fetch_tick(arg0: &GlobalConfig, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        assert!(contains_tick(arg0, tick_key(arg1, arg2)), 2);
        let v0 = FetchTickEvent{
            p       : arg1,
            tick    : arg2,
            tick_id : *0x2::linked_table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.ticks, tick_key(arg1, arg2)),
        };
        0x2::event::emit<FetchTickEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            package_version : 1,
            ticks           : 0x2::linked_table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GlobalConfig>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = InitConfigEvent{
            global_config_id : 0x2::object::id<GlobalConfig>(&v0),
            admin_cap_id     : 0x2::object::id<AdminCap>(&v1),
        };
        0x2::event::emit<InitConfigEvent>(v2);
    }

    public fun package_version() : u64 {
        1
    }

    public fun tick_key(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x2::object::ID {
        0x1::string::append(&mut arg0, arg1);
        0x2::object::id_from_bytes(0x2::hash::blake2b256(0x1::string::bytes(&arg0)))
    }

    // decompiled from Move bytecode v6
}

