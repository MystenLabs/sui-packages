module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::app {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolApp has store, key {
        id: 0x2::object::UID,
        version: u64,
        markets: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PackageCallerCap has store, key {
        id: 0x2::object::UID,
    }

    // decompiled from Move bytecode v6
}

