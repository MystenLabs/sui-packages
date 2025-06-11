module 0x1075cb7ae27b82a95c68f02484b1bae44595a2fe07681f6929151032575b0fe0::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        package_versions: 0x2::vec_set::VecSet<u16>,
    }

    entry fun add_package_version(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: u16) {
        assert_package_version(arg0);
        0x2::vec_set::insert<u16>(&mut arg0.package_versions, arg2);
    }

    public(friend) fun assert_package_version(arg0: &Config) {
        let v0 = 1;
        if (!0x2::vec_set::contains<u16>(&arg0.package_versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            package_versions : 0x2::vec_set::singleton<u16>(1),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    entry fun remove_package_version(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: u16) {
        assert_package_version(arg0);
        0x2::vec_set::remove<u16>(&mut arg0.package_versions, &arg2);
    }

    // decompiled from Move bytecode v6
}

