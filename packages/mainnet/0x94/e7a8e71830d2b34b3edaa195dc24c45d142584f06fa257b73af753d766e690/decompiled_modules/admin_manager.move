module 0x94e7a8e71830d2b34b3edaa195dc24c45d142584f06fa257b73af753d766e690::admin_manager {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminState has key {
        id: 0x2::object::UID,
        governors: 0x2::table::Table<address, bool>,
        pausers: 0x2::table::Table<address, bool>,
    }

    public entry fun add_governor(arg0: address, arg1: &AdminCap, arg2: &mut AdminState) {
        assert!(0x2::table::contains<address, bool>(&arg2.governors, arg0) == false, 7004);
        0x2::table::add<address, bool>(&mut arg2.governors, arg0, true);
    }

    public entry fun add_pauser(arg0: address, arg1: &AdminCap, arg2: &mut AdminState) {
        assert!(0x2::table::contains<address, bool>(&arg2.pausers, arg0) == false, 7006);
        0x2::table::add<address, bool>(&mut arg2.pausers, arg0, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<address, bool>(arg0);
        let v2 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        0x2::table::add<address, bool>(&mut v2, v0, true);
        let v3 = AdminState{
            id        : 0x2::object::new(arg0),
            governors : v1,
            pausers   : v2,
        };
        0x2::transfer::share_object<AdminState>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun is_governor(arg0: address, arg1: &AdminState) : bool {
        0x2::table::contains<address, bool>(&arg1.governors, arg0)
    }

    public fun is_pauser(arg0: address, arg1: &AdminState) : bool {
        0x2::table::contains<address, bool>(&arg1.pausers, arg0)
    }

    public entry fun rm_governor(arg0: address, arg1: &AdminCap, arg2: &mut AdminState) {
        assert!(0x2::table::contains<address, bool>(&arg2.governors, arg0) == true, 7005);
        0x2::table::remove<address, bool>(&mut arg2.governors, arg0);
    }

    public entry fun rm_pauser(arg0: address, arg1: &AdminCap, arg2: &mut AdminState) {
        assert!(0x2::table::contains<address, bool>(&arg2.pausers, arg0) == true, 7007);
        0x2::table::remove<address, bool>(&mut arg2.pausers, arg0);
    }

    // decompiled from Move bytecode v6
}

