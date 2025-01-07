module 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_info {
    struct AppInfo has copy, drop, store {
        package_info_id: 0x1::option::Option<0x2::object::ID>,
        package_address: 0x1::option::Option<address>,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    public fun default() : AppInfo {
        AppInfo{
            package_info_id : 0x1::option::none<0x2::object::ID>(),
            package_address : 0x1::option::none<address>(),
            upgrade_cap_id  : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun new(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<0x2::object::ID>) : AppInfo {
        AppInfo{
            package_info_id : arg0,
            package_address : arg1,
            upgrade_cap_id  : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

