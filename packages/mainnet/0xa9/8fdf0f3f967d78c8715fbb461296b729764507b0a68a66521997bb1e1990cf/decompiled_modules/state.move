module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state {
    struct State<phantom T0> has store, key {
        id: 0x2::object::UID,
        current_epoch: u64,
    }

    public(friend) fun borrow<T0, T1: copy + drop + store, T2: store + key>(arg0: &State<T0>, arg1: T1) : &T2 {
        0x2::dynamic_object_field::borrow<T1, T2>(&arg0.id, arg1)
    }

    public(friend) fun borrow_mut<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut State<T0>, arg1: T1) : &mut T2 {
        0x2::dynamic_object_field::borrow_mut<T1, T2>(&mut arg0.id, arg1)
    }

    public(friend) fun add<T0, T1: copy + drop + store, T2: store + key>(arg0: &mut State<T0>, arg1: T1, arg2: T2) {
        0x2::dynamic_object_field::add<T1, T2>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : State<T0> {
        State<T0>{
            id            : 0x2::object::new(arg0),
            current_epoch : 0,
        }
    }

    public(friend) fun contains<T0, T1: copy + drop + store, T2: store + key>(arg0: &State<T0>, arg1: T1) : bool {
        0x2::dynamic_object_field::exists_with_type<T1, T2>(&arg0.id, arg1)
    }

    public fun current_epoch<T0>(arg0: &State<T0>) : u64 {
        arg0.current_epoch
    }

    public(friend) fun share<T0>(arg0: State<T0>) {
        0x2::transfer::public_share_object<State<T0>>(arg0);
    }

    public(friend) fun update_state<T0>(arg0: &mut State<T0>, arg1: u64) {
        arg0.current_epoch = arg1;
    }

    // decompiled from Move bytecode v6
}

