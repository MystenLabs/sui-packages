module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::on_demand {
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
        let v0 = State{
            id                   : 0x2::object::new(arg1),
            oracle_queue         : 0x2::object::id_from_address(@0x0),
            guardian_queue       : 0x2::object::id_from_address(@0x0),
            on_demand_package_id : 0x2::object::id_from_address(@0x0),
        };
        0x2::transfer::share_object<State>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun on_demand_package_id(arg0: &State) : 0x2::object::ID {
        arg0.on_demand_package_id
    }

    public fun oracle_queue(arg0: &State) : 0x2::object::ID {
        arg0.oracle_queue
    }

    public(friend) fun set_guardian_queue_id(arg0: &mut State, arg1: 0x2::object::ID) {
        arg0.guardian_queue = arg1;
    }

    public(friend) fun set_on_demand_package_id(arg0: &mut State, arg1: 0x2::object::ID) {
        arg0.on_demand_package_id = arg1;
    }

    public(friend) fun set_oracle_queue_id(arg0: &mut State, arg1: 0x2::object::ID) {
        arg0.oracle_queue = arg1;
    }

    // decompiled from Move bytecode v6
}

