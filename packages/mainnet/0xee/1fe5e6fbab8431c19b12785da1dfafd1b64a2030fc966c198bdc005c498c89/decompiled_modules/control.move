module 0xee1fe5e6fbab8431c19b12785da1dfafd1b64a2030fc966c198bdc005c498c89::control {
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

