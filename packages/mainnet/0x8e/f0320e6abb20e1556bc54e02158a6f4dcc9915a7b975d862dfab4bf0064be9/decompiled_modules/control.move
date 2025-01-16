module 0x4b61b1d8585f99e641e9459e80a132239cb7902bcf3f66bffb3bc973ef9f153f::control {
    struct Permits has key {
        id: 0x2::object::UID,
        permits: 0x2::table::Table<address, bool>,
        mates: 0x2::table::Table<address, bool>,
    }

    struct Master has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add(arg0: &Master, arg1: &mut Permits, arg2: address, arg3: bool) {
        0x2::table::add<address, bool>(&mut arg1.permits, arg2, true);
        if (arg3) {
            0x2::table::add<address, bool>(&mut arg1.mates, arg2, true);
        };
    }

    public entry fun remove(arg0: &Master, arg1: &mut Permits, arg2: address) {
        0x2::table::remove<address, bool>(&mut arg1.permits, arg2);
        if (0x2::table::contains<address, bool>(&arg1.mates, arg2)) {
            0x2::table::remove<address, bool>(&mut arg1.mates, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Permits{
            id      : 0x2::object::new(arg0),
            permits : 0x2::table::new<address, bool>(arg0),
            mates   : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = Master{id: 0x2::object::new(arg0)};
        0x2::table::add<address, bool>(&mut v0.permits, 0x2::tx_context::sender(arg0), true);
        0x2::transfer::transfer<Master>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Permits>(v0);
    }

    public fun is_mate(arg0: &Permits, arg1: address) : bool {
        if (!0x2::table::contains<address, bool>(&arg0.mates, arg1)) {
            return false
        };
        *0x2::table::borrow<address, bool>(&arg0.mates, arg1)
    }

    public fun valid(arg0: &Permits, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.permits, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

