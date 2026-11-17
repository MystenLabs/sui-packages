module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        interface_version: u64,
        entries: 0x2::table::Table<0x1::type_name::TypeName, Entry>,
    }

    struct AuditorCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
    }

    struct Entry has copy, drop, store {
        kind: u8,
        family: 0x1::ascii::String,
        version: u64,
        auditor: 0x1::ascii::String,
        report: vector<u8>,
        listed_ms: u64,
        live: bool,
    }

    struct Listed has copy, drop {
        adapter: 0x1::type_name::TypeName,
        family: 0x1::ascii::String,
        version: u64,
        auditor: 0x1::ascii::String,
        report: vector<u8>,
    }

    struct Revoked has copy, drop {
        adapter: 0x1::type_name::TypeName,
        auditor: 0x1::ascii::String,
    }

    struct InterfaceMigrated has copy, drop {
        version: u64,
    }

    public(friend) fun new(arg0: 0x1::ascii::String, arg1: &mut 0x2::tx_context::TxContext) : (Registry, AuditorCap) {
        let v0 = Registry{
            id                : 0x2::object::new(arg1),
            interface_version : 1,
            entries           : 0x2::table::new<0x1::type_name::TypeName, Entry>(arg1),
        };
        let v1 = AuditorCap{
            id   : 0x2::object::new(arg1),
            name : arg0,
        };
        (v0, v1)
    }

    public(friend) fun assert_interface(arg0: &Registry) {
        assert!(arg0.interface_version == 1, 3);
    }

    public fun exchange_version<T0: drop>(arg0: &Registry) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, v0), 0);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, Entry>(&arg0.entries, v0);
        assert!(v1.live, 1);
        assert!(v1.kind == 0, 2);
        v1.version
    }

    public fun interface_version(arg0: &Registry) : u64 {
        arg0.interface_version
    }

    public(friend) fun is_listed<T0: drop>(arg0: &Registry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun list_exchange<T0: drop>(arg0: &mut Registry, arg1: &AuditorCap, arg2: 0x1::ascii::String, arg3: u64, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Entry>(&mut arg0.entries, v0);
        };
        let v1 = Listed{
            adapter : v0,
            family  : arg2,
            version : arg3,
            auditor : arg1.name,
            report  : arg4,
        };
        0x2::event::emit<Listed>(v1);
        let v2 = Entry{
            kind      : 0,
            family    : arg2,
            version   : arg3,
            auditor   : arg1.name,
            report    : arg4,
            listed_ms : 0x2::tx_context::epoch_timestamp_ms(arg5),
            live      : true,
        };
        0x2::table::add<0x1::type_name::TypeName, Entry>(&mut arg0.entries, v0, v2);
    }

    public(friend) fun migrate_interface(arg0: &mut Registry) {
        assert!(arg0.interface_version < 1, 3);
        arg0.interface_version = 1;
        let v0 = InterfaceMigrated{version: 1};
        0x2::event::emit<InterfaceMigrated>(v0);
    }

    public fun revoke<T0: drop>(arg0: &mut Registry, arg1: &AuditorCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, Entry>(&arg0.entries, v0), 0);
        0x2::table::borrow_mut<0x1::type_name::TypeName, Entry>(&mut arg0.entries, v0).live = false;
        let v1 = Revoked{
            adapter : v0,
            auditor : arg1.name,
        };
        0x2::event::emit<Revoked>(v1);
    }

    public(friend) fun share(arg0: Registry) {
        0x2::transfer::share_object<Registry>(arg0);
    }

    // decompiled from Move bytecode v7
}

