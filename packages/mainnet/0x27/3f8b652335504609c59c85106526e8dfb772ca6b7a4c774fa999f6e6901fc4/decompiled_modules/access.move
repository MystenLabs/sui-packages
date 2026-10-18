module 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::access {
    struct Auth has drop {
        dummy_field: bool,
    }

    struct ExtensionRegistryEventV1 has copy, drop {
        registry_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        registered: bool,
    }

    struct WitnessKey has copy, drop, store {
        name: 0x1::type_name::TypeName,
    }

    public fun is_registered<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        0x2::dynamic_field::exists<WitnessKey>(arg0, v0)
    }

    public fun issue<T0: drop>(arg0: T0, arg1: &0x2::object::UID) : Auth {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        assert!(0x2::dynamic_field::exists<WitnessKey>(arg1, v0), 13835058175541248001);
        new()
    }

    public(friend) fun new() : Auth {
        Auth{dummy_field: false}
    }

    public(friend) fun register_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (!0x2::dynamic_field::exists<WitnessKey>(arg0, v0)) {
            0x2::dynamic_field::add<WitnessKey, bool>(arg0, v0, true);
            let v1 = ExtensionRegistryEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v0.name,
                registered  : true,
            };
            0x2::event::emit<ExtensionRegistryEventV1>(v1);
        };
    }

    public(friend) fun unregister_uid<T0>(arg0: &mut 0x2::object::UID) {
        let v0 = WitnessKey{name: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<WitnessKey>(arg0, v0)) {
            0x2::dynamic_field::remove<WitnessKey, bool>(arg0, v0);
            let v1 = ExtensionRegistryEventV1{
                registry_id : 0x2::object::uid_to_inner(arg0),
                witness     : v0.name,
                registered  : false,
            };
            0x2::event::emit<ExtensionRegistryEventV1>(v1);
        };
    }

    // decompiled from Move bytecode v7
}

