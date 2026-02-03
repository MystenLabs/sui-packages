module 0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins {
    struct VOULTRON_ADMINS has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Admins has store, key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, 0x2::object::ID>,
        blacklist: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public fun add_admin(arg0: &SuperAdminCap, arg1: &mut Admins, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.whitelist, arg2), 1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.whitelist, arg2, *0x2::object::uid_as_inner(&v0.id));
        0x2::transfer::transfer<AdminCap>(v0, arg2);
    }

    public fun blacklist_admin(arg0: &SuperAdminCap, arg1: &mut Admins, arg2: address) {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.whitelist, arg2), 0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.blacklist, arg2, 0x2::table::remove<address, 0x2::object::ID>(&mut arg1.whitelist, arg2));
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_admin(arg0: &Admins, arg1: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.blacklist, 0x2::tx_context::sender(arg1)), 4);
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg0.whitelist, 0x2::tx_context::sender(arg1)), 3);
    }

    fun init(arg0: VOULTRON_ADMINS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperAdminCap{id: 0x2::object::new(arg1)};
        let v1 = Admins{
            id        : 0x2::object::new(arg1),
            whitelist : 0x2::table::new<address, 0x2::object::ID>(arg1),
            blacklist : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::table::add<address, 0x2::object::ID>(&mut v1.whitelist, 0x2::tx_context::sender(arg1), *0x2::object::uid_as_inner(&v2.id));
        0x2::table::add<address, 0x2::object::ID>(&mut v1.whitelist, @0xecaa612d83f644a6f9eb1f7cbe7a560bf1030bbd07b7def159bead044b1b3fd3, *0x2::object::uid_as_inner(&v3.id));
        0x2::transfer::public_transfer<SuperAdminCap>(v0, @0x81df8cb661f0c3db2c372be6e2103291d2da4f6f5b59e3aac9bb726562d559f7);
        0x2::transfer::public_share_object<Admins>(v1);
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v3, @0xecaa612d83f644a6f9eb1f7cbe7a560bf1030bbd07b7def159bead044b1b3fd3);
    }

    public fun is_admin(arg0: &Admins, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.whitelist, arg1)
    }

    public fun is_blacklisted(arg0: &Admins, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.blacklist, arg1)
    }

    public fun rewhitelist_admin(arg0: &SuperAdminCap, arg1: &mut Admins, arg2: address) {
        assert!(0x2::table::contains<address, 0x2::object::ID>(&arg1.blacklist, arg2), 2);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.whitelist, arg2, 0x2::table::remove<address, 0x2::object::ID>(&mut arg1.blacklist, arg2));
    }

    // decompiled from Move bytecode v6
}

