module 0x9539d4ad25f6ca8e316cb5e97dac6fd9a73d33a0b93db4b1a5071cd629abd55::set {
    struct Unit has copy, drop, store {
        dummy_field: bool,
    }

    struct Set<T0: copy + drop + store> has store {
        keys: vector<T0>,
        elems: 0x2::table::Table<T0, Unit>,
    }

    public fun empty<T0: copy + drop + store>(arg0: &mut Set<T0>) {
        while (!0x1::vector::is_empty<T0>(&arg0.keys)) {
            0x2::table::remove<T0, Unit>(&mut arg0.elems, 0x1::vector::pop_back<T0>(&mut arg0.keys));
        };
    }

    public fun add<T0: copy + drop + store>(arg0: &mut Set<T0>, arg1: T0) {
        let v0 = Unit{dummy_field: false};
        0x2::table::add<T0, Unit>(&mut arg0.elems, arg1, v0);
        0x1::vector::push_back<T0>(&mut arg0.keys, arg1);
    }

    public fun contains<T0: copy + drop + store>(arg0: &Set<T0>, arg1: T0) : bool {
        0x2::table::contains<T0, Unit>(&arg0.elems, arg1)
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Set<T0> {
        Set<T0>{
            keys  : 0x1::vector::empty<T0>(),
            elems : 0x2::table::new<T0, Unit>(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

