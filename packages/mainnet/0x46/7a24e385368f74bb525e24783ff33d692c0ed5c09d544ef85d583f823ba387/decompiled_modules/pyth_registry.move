module 0x467a24e385368f74bb525e24783ff33d692c0ed5c09d544ef85d583f823ba387::pyth_registry {
    struct PythRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PythRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun assert_pyth_price_info_object<T0>(arg0: &PythRegistry, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, 0x1::type_name::get<T0>()), 70149);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PythRegistry{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        let v1 = PythRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<PythRegistry>(&v0),
        };
        0x2::transfer::share_object<PythRegistry>(v0);
        0x2::transfer::transfer<PythRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_pyth_price_info_object<T0>(arg0: &mut PythRegistry, arg1: &PythRegistryCap, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) {
        assert!(0x2::object::id<PythRegistry>(arg0) == arg1.for, 70150);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg2));
    }

    // decompiled from Move bytecode v6
}

