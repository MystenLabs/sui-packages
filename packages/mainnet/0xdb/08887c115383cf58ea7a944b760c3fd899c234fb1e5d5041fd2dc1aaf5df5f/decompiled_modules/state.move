module 0x4b1feb4e2eeec04800670eea1398ddf5eb3472a20f02acf6fb89da556499afff::state {
    struct State has store, key {
        id: 0x2::object::UID,
        offers: 0x2::table::Table<address, 0x2::table::Table<u64, 0x2::object::ID>>,
        loans: 0x2::table::Table<address, 0x2::table::Table<u64, 0x2::object::ID>>,
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

    public(friend) fun remove<T0: copy + drop + store, T1: store + key>(arg0: &mut State, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id     : 0x2::object::new(arg0),
            offers : 0x2::table::new<address, 0x2::table::Table<u64, 0x2::object::ID>>(arg0),
            loans  : 0x2::table::new<address, 0x2::table::Table<u64, 0x2::object::ID>>(arg0),
        };
        0x2::transfer::public_share_object<State>(v0);
    }

    public(friend) fun add_loan(arg0: &mut State, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, 0x2::object::ID>>(&arg0.loans, arg2)) {
            0x2::table::add<address, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg0.loans, arg2, 0x2::table::new<u64, 0x2::object::ID>(arg3));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg0.loans, arg2);
        0x2::table::add<u64, 0x2::object::ID>(v0, 0x2::table::length<u64, 0x2::object::ID>(v0) + 1, arg1);
    }

    public(friend) fun add_offer(arg0: &mut State, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::table::Table<u64, 0x2::object::ID>>(&arg0.offers, arg2)) {
            0x2::table::add<address, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg0.offers, arg2, 0x2::table::new<u64, 0x2::object::ID>(arg3));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg0.offers, arg2);
        0x2::table::add<u64, 0x2::object::ID>(v0, 0x2::table::length<u64, 0x2::object::ID>(v0) + 1, arg1);
    }

    public(friend) fun contain<T0: copy + drop + store, T1: store + key>(arg0: &State, arg1: T0) : bool {
        0x2::dynamic_object_field::exists_with_type<T0, T1>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

