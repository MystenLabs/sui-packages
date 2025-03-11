module 0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::switchboard_registry {
    struct SwitchboardRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct SwitchboardRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_switchboard_aggregator<T0>(arg0: &SwitchboardRegistry, arg1: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) {
        assert!(0x2::object::id<0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 70661);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwitchboardRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        let v1 = SwitchboardRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<SwitchboardRegistry>(&v0),
        };
        0x2::transfer::share_object<SwitchboardRegistry>(v0);
        0x2::transfer::transfer<SwitchboardRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_switchboard_aggregator<T0>(arg0: &mut SwitchboardRegistry, arg1: &SwitchboardRegistryCap, arg2: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator) {
        assert!(0x2::object::id<SwitchboardRegistry>(arg0) == arg1.for, 70662);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator>(arg2));
    }

    // decompiled from Move bytecode v6
}

