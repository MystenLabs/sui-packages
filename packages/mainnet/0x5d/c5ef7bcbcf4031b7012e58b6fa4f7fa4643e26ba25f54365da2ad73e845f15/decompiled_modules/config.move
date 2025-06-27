module 0x5dc5ef7bcbcf4031b7012e58b6fa4f7fa4643e26ba25f54365da2ad73e845f15::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        package_versions: 0x2::vec_set::VecSet<u16>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        buck_reserve: 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>,
    }

    public fun add_package_version(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: u16) {
        0x2::vec_set::insert<u16>(&mut arg0.package_versions, arg2);
    }

    public fun add_reserve(arg0: &mut Config, arg1: 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) {
        assert_package_version(arg0);
        0x2::balance::join<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.buck_reserve, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1));
    }

    public fun add_whitelist<T0>(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    public(friend) fun assert_is_whitelisted<T0>(arg0: &Config) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted();
        };
    }

    public(friend) fun assert_package_version(arg0: &Config) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.package_versions, &v0)) {
            err_invalid_package_version();
        };
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun err_not_whitelisted() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            package_versions : 0x2::vec_set::singleton<u16>(package_version()),
            whitelist        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            buck_reserve     : 0x2::balance::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_package_version(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: u16) {
        0x2::vec_set::remove<u16>(&mut arg0.package_versions, &arg2);
    }

    public fun remove_whitelist<T0>(arg0: &mut Config, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public(friend) fun take_from_reserve(arg0: &mut Config, arg1: u64) : 0x2::balance::Balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        assert_package_version(arg0);
        0x2::balance::split<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&mut arg0.buck_reserve, 0x1::u64::min(0x2::balance::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&arg0.buck_reserve), arg1))
    }

    // decompiled from Move bytecode v6
}

