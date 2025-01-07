module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::on_demand {
    struct ON_DEMAND has drop {
        dummy_field: bool,
    }

    struct State has key {
        id: 0x2::object::UID,
        oracle_queue: 0x2::object::ID,
        guardian_queue: 0x2::object::ID,
        on_demand_package_id: 0x2::object::ID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun guardian_queue(arg0: &State) : 0x2::object::ID {
        arg0.guardian_queue
    }

    fun init(arg0: ON_DEMAND, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ON_DEMAND>(arg0, arg1);
        let v0 = 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::new(x"963fead0d455c024345ec1c3726843693bbe6426825862a6d38ba9ccd8e5bd7c", 0x2::tx_context::sender(arg1), 0x1::string::utf8(b"Mainnet Guardian Queue"), 0, 0x2::tx_context::sender(arg1), 3, 157680000000, 0x2::object::id_from_address(@0x963fead0d455c024345ec1c3726843693bbe6426825862a6d38ba9ccd8e5bd7c), true, arg1);
        let v1 = State{
            id                   : 0x2::object::new(arg1),
            oracle_queue         : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::queue::new(x"86807068432f186a147cf0b13a30067d386204ea9d6c8b04743ac2ef010b0752", 0x2::tx_context::sender(arg1), 0x1::string::utf8(b"Mainnet Oracle Queue"), 0, 0x2::tx_context::sender(arg1), 3, 604800000, v0, false, arg1),
            guardian_queue       : v0,
            on_demand_package_id : 0x2::object::id_from_address(0x2::tx_context::sender(arg1)),
        };
        0x2::transfer::share_object<State>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<AdminCap>(v2);
    }

    public fun on_demand_package_id(arg0: &State) : 0x2::object::ID {
        arg0.on_demand_package_id
    }

    public fun oracle_queue(arg0: &State) : 0x2::object::ID {
        arg0.oracle_queue
    }

    public(friend) fun set_on_demand_package_id(arg0: &mut State, arg1: 0x2::object::ID) {
        arg0.on_demand_package_id = arg1;
    }

    // decompiled from Move bytecode v6
}

