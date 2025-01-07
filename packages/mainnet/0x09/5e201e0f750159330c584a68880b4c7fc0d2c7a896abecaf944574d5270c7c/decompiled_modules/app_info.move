module 0x95e201e0f750159330c584a68880b4c7fc0d2c7a896abecaf944574d5270c7c::app_info {
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

