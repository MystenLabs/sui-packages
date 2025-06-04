module 0x5ca1b3fccbc5753322356c4082b53747cd315124f4b156a436582e7262c44a4a::capability_system {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ModeratorCap has store, key {
        id: 0x2::object::UID,
    }

    struct SystemConfig has store, key {
        id: 0x2::object::UID,
        max_users: u64,
        maintenance_mode: bool,
    }

    public fun create_moderator(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : ModeratorCap {
        ModeratorCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SystemConfig{
            id               : 0x2::object::new(arg0),
            max_users        : 1000,
            maintenance_mode : false,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<SystemConfig>(v1);
    }

    public fun moderate_content(arg0: &ModeratorCap, arg1: u64) : bool {
        arg1 > 0
    }

    public fun toggle_maintenance(arg0: &AdminCap, arg1: &mut SystemConfig) {
        arg1.maintenance_mode = !arg1.maintenance_mode;
    }

    public fun update_max_users(arg0: &AdminCap, arg1: &mut SystemConfig, arg2: u64) {
        arg1.max_users = arg2;
    }

    // decompiled from Move bytecode v6
}

