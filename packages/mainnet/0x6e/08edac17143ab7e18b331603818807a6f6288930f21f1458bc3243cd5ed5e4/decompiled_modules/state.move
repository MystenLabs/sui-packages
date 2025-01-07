module 0x6e08edac17143ab7e18b331603818807a6f6288930f21f1458bc3243cd5ed5e4::state {
    struct State has store, key {
        id: 0x2::object::UID,
        admin: address,
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
        let v0 = State{
            id    : 0x2::object::new(arg0),
            admin : @0x0,
        };
        0x2::transfer::share_object<State>(v0);
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store + key>(arg0: &State, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun set_admin(arg0: &mut State, arg1: address) {
        arg0.admin = arg1;
    }

    public(friend) fun transfer_fee(arg0: &State, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.admin);
    }

    // decompiled from Move bytecode v6
}

