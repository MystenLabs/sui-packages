module 0xc9aa1e3ae7eaf0913727bab7eb0d6bdbd1ad865f2a0a0326e667dfdcbc655f5f::state {
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

    public(friend) fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State<T0>{
            id            : 0x2::object::new(arg0),
            current_epoch : 0,
        };
        0x2::transfer::share_object<State<T0>>(v0);
    }

    public(friend) fun contain<T0, T1: copy + drop + store, T2: store + key>(arg0: &State<T0>, arg1: T1) : bool {
        0x2::dynamic_object_field::exists_with_type<T1, T2>(&arg0.id, arg1)
    }

    public fun get_current_epoch<T0>(arg0: &State<T0>) : u64 {
        arg0.current_epoch
    }

    public(friend) fun update_current_epoch<T0>(arg0: &mut State<T0>, arg1: u64) {
        arg0.current_epoch = arg1;
    }

    // decompiled from Move bytecode v6
}

