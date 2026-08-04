module 0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::state {
    struct State has key {
        id: 0x2::object::UID,
        state: u8,
    }

    struct StateChanged has copy, drop {
        state_id: address,
        old_state: u8,
        new_state: u8,
    }

    entry fun change_state(arg0: &mut State, arg1: &0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::OwnerCap, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::is_owned(&arg0.id, arg1);
        arg0.state = arg2;
        let v0 = StateChanged{
            state_id  : 0x2::object::uid_to_address(&arg0.id),
            old_state : arg0.state,
            new_state : arg2,
        };
        0x2::event::emit<StateChanged>(v0);
    }

    entry fun create_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id    : 0x2::object::new(arg0),
            state : 0,
        };
        0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::create_owner_cap(&v0.id, 0x2::tx_context::sender(arg0), arg0);
        0x2::transfer::share_object<State>(v0);
    }

    entry fun destroy_state(arg0: State, arg1: 0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::OwnerCap, arg2: &0x2::tx_context::TxContext) {
        0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::is_owned(&arg0.id, &arg1);
        let State {
            id    : v0,
            state : _,
        } = arg0;
        0x2::object::delete(v0);
        0xdb6e1c754da93997b3cf57f7a67f7be501282436f3e63e80be6a294c2cc055dd::owner_cap::destroy_cap(arg1);
    }

    public(friend) fun get_state(arg0: &State) : u8 {
        arg0.state
    }

    // decompiled from Move bytecode v7
}

