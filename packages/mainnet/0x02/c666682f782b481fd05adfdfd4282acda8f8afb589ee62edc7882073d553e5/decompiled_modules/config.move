module 0x2c666682f782b481fd05adfdfd4282acda8f8afb589ee62edc7882073d553e5::config {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        admin_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 801);
    }

    public fun destroy_admin_cap(arg0: AdminCap, arg1: &mut GlobalConfig) {
        let v0 = 0x2::object::id<AdminCap>(&arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.admin_caps, &v0), 802);
        let v1 = 0x2::object::id<AdminCap>(&arg0);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.admin_caps, &v1);
        let AdminCap { id: v2 } = arg0;
        0x2::object::delete(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::vec_set::empty<0x2::object::ID>();
        0x2::vec_set::insert<0x2::object::ID>(&mut v1, 0x2::object::id<AdminCap>(&v0));
        let v2 = GlobalConfig{
            id         : 0x2::object::new(arg0),
            version    : 1,
            admin_caps : v1,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun issue_additional_admin_cap(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<AdminCap>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.admin_caps, &v0), 802);
        let v1 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.admin_caps, 0x2::object::id<AdminCap>(&v1));
        0x2::transfer::transfer<AdminCap>(v1, arg2);
    }

    entry fun migrate(arg0: &mut GlobalConfig, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.admin_caps, &v0), 802);
        assert!(arg0.version < 1, 803);
        arg0.version = 1;
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

