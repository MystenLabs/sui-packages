module 0x571f78ffddd02cafd1eb8ee38985f1b1f6828794fef268acb2a673ffdd66621e::demo {
    struct Counter has store, key {
        id: 0x2::object::UID,
        value: u64,
        admin: address,
    }

    struct Increased has copy, drop {
        counter_id: 0x2::object::ID,
        old_value: u64,
        new_value: u64,
        sender: address,
    }

    public entry fun increase(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.value + 1;
        arg0.value = v0;
        let v1 = Increased{
            counter_id : 0x2::object::id<Counter>(arg0),
            old_value  : arg0.value,
            new_value  : v0,
            sender     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Increased>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    public entry fun reset(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834852948213759);
        arg0.value = 0;
    }

    // decompiled from Move bytecode v7
}

