module 0x7bf0bd74001fdfaaa2796af8dbc6f9bf129a8098fe298a1cd497ca726d7c52d0::version {
    struct VersionTable has store, key {
        id: 0x2::object::UID,
        versions: 0x2::table::Table<0x1::type_name::TypeName, u16>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun check_version_eq<T0: drop>(arg0: &VersionTable, arg1: u16) {
        assert!(arg1 == *0x2::table::borrow<0x1::type_name::TypeName, u16>(&arg0.versions, 0x1::type_name::get<T0>()), 9223372285962878977);
    }

    public fun check_version_gte<T0: drop>(arg0: &VersionTable, arg1: u16) {
        assert!(arg1 >= *0x2::table::borrow<0x1::type_name::TypeName, u16>(&arg0.versions, 0x1::type_name::get<T0>()), 9223372251603140609);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VersionTable{
            id       : 0x2::object::new(arg0),
            versions : 0x2::table::new<0x1::type_name::TypeName, u16>(arg0),
        };
        0x2::transfer::share_object<VersionTable>(v1);
    }

    entry fun init_version<T0: drop>(arg0: &mut VersionTable, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<0x1::type_name::TypeName, u16>(&mut arg0.versions, 0x1::type_name::get<T0>(), 1);
    }

    entry fun update_version<T0: drop>(arg0: &mut VersionTable, arg1: u16, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        *0x2::table::borrow_mut<0x1::type_name::TypeName, u16>(&mut arg0.versions, 0x1::type_name::get<T0>()) = arg1;
    }

    // decompiled from Move bytecode v6
}

