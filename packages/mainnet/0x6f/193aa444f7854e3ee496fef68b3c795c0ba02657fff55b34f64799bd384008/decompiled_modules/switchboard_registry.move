module 0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_registry {
    struct SwitchboardRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct SwitchboardRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_switchboard_aggregator<T0>(arg0: &SwitchboardRegistry, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        assert!(0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 70661);
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

    public entry fun register_switchboard_aggregator<T0>(arg0: &mut SwitchboardRegistry, arg1: &SwitchboardRegistryCap, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        assert!(0x2::object::id<SwitchboardRegistry>(arg0) == arg1.for, 70662);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg2));
    }

    // decompiled from Move bytecode v6
}

