module 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::versionControl {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u16>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg1.versions, arg2);
    }

    public fun assert_vaild_package_version(arg0: &GlobalConfig) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(versions(arg0), &v0)) {
            err_invaild_package_version();
        };
    }

    fun err_invaild_package_version() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u16>(package_version()),
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg1.versions, &arg2);
    }

    public fun versions(arg0: &GlobalConfig) : &0x2::vec_set::VecSet<u16> {
        &arg0.versions
    }

    // decompiled from Move bytecode v6
}

