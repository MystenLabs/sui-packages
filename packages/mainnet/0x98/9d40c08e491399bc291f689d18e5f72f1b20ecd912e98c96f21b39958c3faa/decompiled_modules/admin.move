module 0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Roles has key {
        id: 0x2::object::UID,
        admins: 0x2::table::Table<address, bool>,
        whitelist: 0x2::table::Table<address, bool>,
    }

    public fun add_to_admins(arg0: &AdminCap, arg1: &mut Roles, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.admins, arg2, true);
    }

    public fun add_to_whitelist(arg0: &AdminCap, arg1: &mut Roles, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.whitelist, arg2, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, 0x2::tx_context::sender(arg0), true);
        let v2 = Roles{
            id        : 0x2::object::new(arg0),
            admins    : v1,
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Roles>(v2);
    }

    public fun is_admin(arg0: &Roles, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun is_whitelisted(arg0: &Roles, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun remove_from_admins(arg0: &AdminCap, arg1: &mut Roles, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.admins, arg2);
    }

    public fun remove_from_whitelist(arg0: &AdminCap, arg1: &mut Roles, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.whitelist, arg2);
    }

    // decompiled from Move bytecode v6
}

