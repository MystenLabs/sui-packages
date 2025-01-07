module 0xb05aca43307f8dea7c866254fca5910f67cb63394b2b2f8d83995ad699631365::control {
    struct Permits has key {
        id: 0x2::object::UID,
        permits: 0x2::table::Table<address, bool>,
    }

    struct Master has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add(arg0: &Master, arg1: &mut Permits, arg2: address) {
        0x2::table::add<address, bool>(&mut arg1.permits, arg2, true);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Permits{
            id      : 0x2::object::new(arg0),
            permits : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = Master{id: 0x2::object::new(arg0)};
        0x2::table::add<address, bool>(&mut v0.permits, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::transfer<Master>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Permits>(v0);
    }

    public fun valid(arg0: &Permits, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.permits, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

