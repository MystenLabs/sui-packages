module 0xfd59dfaf3bbd9c5cff3a764ee2aecf836468b06bddbd215a0488ada28f897190::capability {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Account has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Ping has copy, drop {
        by: 0x2::object::ID,
        time: u64,
    }

    struct App has drop {
        subscribers: 0x2::vec_set::VecSet<address>,
    }

    public entry fun new(arg0: &AdminCap, arg1: 0x1::string::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Account{
            id   : 0x2::object::new(arg3),
            name : arg1,
        };
        0x2::transfer::transfer<Account>(v0, arg2);
    }

    public entry fun give_admin_cap_permissionless(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
    }

    public entry fun send_ping(arg0: &Account, arg1: &0x2::clock::Clock) {
        let v0 = Ping{
            by   : 0x2::object::uid_to_inner(&arg0.id),
            time : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<Ping>(v0);
    }

    public entry fun update(arg0: &mut Account, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    // decompiled from Move bytecode v6
}

