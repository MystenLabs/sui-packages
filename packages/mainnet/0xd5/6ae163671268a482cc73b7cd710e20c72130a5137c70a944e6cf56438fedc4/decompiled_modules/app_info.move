module 0xd56ae163671268a482cc73b7cd710e20c72130a5137c70a944e6cf56438fedc4::app_info {
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

