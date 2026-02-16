module 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state {
    struct StateCreated has copy, drop {
        state: 0x2::object::ID,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        emitter_cap: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        locked_orders: 0x2::table::Table<address, bool>,
        refunded_orders: 0x2::table::Table<address, bool>,
    }

    public(friend) fun add_locked_order(arg0: &mut State, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.refunded_orders, arg1) == false, 1);
        0x2::table::add<address, bool>(&mut arg0.locked_orders, arg1, true);
    }

    public(friend) fun add_refunded_order(arg0: &mut State, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.locked_orders, arg1) == false, 0);
        0x2::table::add<address, bool>(&mut arg0.refunded_orders, arg1, true);
    }

    public(friend) fun borrow_mut_emitter_cap(arg0: &mut State) : &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap {
        &mut arg0.emitter_cap
    }

    public fun new_state(arg0: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg1: &mut 0x2::tx_context::TxContext) : State {
        let v0 = State{
            id              : 0x2::object::new(arg1),
            emitter_cap     : arg0,
            locked_orders   : 0x2::table::new<address, bool>(arg1),
            refunded_orders : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = StateCreated{state: 0x2::object::id<State>(&v0)};
        0x2::event::emit<StateCreated>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

