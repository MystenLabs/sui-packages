module 0xdb89864a5dd7166474d3cda1cfc633881a5074b97d6ac615326975e47697d9c9::simple {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
        counter: 0x2::table::Table<address, u64>,
    }

    struct Inc has copy, drop {
        sender: address,
        value: u64,
    }

    public fun create_account(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xdb89864a5dd7166474d3cda1cfc633881a5074b97d6ac615326975e47697d9c9::account::AccountCap>(0xdb89864a5dd7166474d3cda1cfc633881a5074b97d6ac615326975e47697d9c9::account::create_account_cap(arg0), 0x2::tx_context::sender(arg0));
    }

    public entry fun increment_account(arg0: &mut Counter, arg1: &0xdb89864a5dd7166474d3cda1cfc633881a5074b97d6ac615326975e47697d9c9::account::AccountCap) {
        internal_increment(0xdb89864a5dd7166474d3cda1cfc633881a5074b97d6ac615326975e47697d9c9::account::account_owner(arg1), arg0);
    }

    public entry fun increment_ctx(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        internal_increment(0x2::tx_context::sender(arg1), arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Counter{
            id      : 0x2::object::new(arg0),
            value   : 0,
            counter : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Counter>(v1);
    }

    fun internal_increment(arg0: address, arg1: &mut Counter) {
        arg1.value = arg1.value + 1;
        if (!0x2::table::contains<address, u64>(&arg1.counter, arg0)) {
            0x2::table::add<address, u64>(&mut arg1.counter, arg0, 1);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg1.counter, arg0);
            *v0 = *v0 + 1;
        };
        let v1 = Inc{
            sender : arg0,
            value  : arg1.value,
        };
        0x2::event::emit<Inc>(v1);
    }

    // decompiled from Move bytecode v6
}

