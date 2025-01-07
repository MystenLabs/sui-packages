module 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::state {
    struct State has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow<T0: copy + drop + store, T1: store + key>(arg0: &State, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut State, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0: copy + drop + store, T1: store + key>(arg0: &mut State, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<State>(v0);
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store + key>(arg0: &State, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

