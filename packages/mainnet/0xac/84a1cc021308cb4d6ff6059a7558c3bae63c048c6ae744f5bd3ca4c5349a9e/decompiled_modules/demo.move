module 0xac84a1cc021308cb4d6ff6059a7558c3bae63c048c6ae744f5bd3ca4c5349a9e::demo {
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
        arg0.value = arg0.value + 1;
        let v0 = Increased{
            counter_id : 0x2::object::id<Counter>(arg0),
            old_value  : arg0.value - 1,
            new_value  : arg0.value,
            sender     : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Increased>(v0);
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
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 13906834844358279167);
        arg0.value = 0;
    }

    // decompiled from Move bytecode v7
}

