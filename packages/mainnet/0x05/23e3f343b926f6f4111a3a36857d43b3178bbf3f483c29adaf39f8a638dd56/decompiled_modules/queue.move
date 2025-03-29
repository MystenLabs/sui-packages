module 0x523e3f343b926f6f4111a3a36857d43b3178bbf3f483c29adaf39f8a638dd56::queue {
    struct Queue<T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        items: vector<T0>,
    }

    public fun length<T0: copy + drop + store>(arg0: &Queue<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.items)
    }

    public fun borrow<T0: copy + drop + store>(arg0: &Queue<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(&arg0.items, arg1)
    }

    public fun push_back<T0: copy + drop + store>(arg0: &mut Queue<T0>, arg1: T0) {
        0x1::vector::push_back<T0>(&mut arg0.items, arg1);
    }

    public fun contains<T0: copy + drop + store>(arg0: &Queue<T0>, arg1: &T0) : bool {
        0x1::vector::contains<T0>(&arg0.items, arg1)
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &Queue<T0>) : bool {
        0x1::vector::is_empty<T0>(&arg0.items)
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : Queue<T0> {
        Queue<T0>{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<T0>(),
        }
    }

    public fun clear<T0: copy + drop + store>(arg0: &mut Queue<T0>) {
        arg0.items = 0x1::vector::empty<T0>();
    }

    public fun dequeue<T0: copy + drop + store>(arg0: &mut Queue<T0>) : T0 {
        assert!(!is_empty<T0>(arg0), 100);
        0x1::vector::remove<T0>(&mut arg0.items, 0)
    }

    public fun front<T0: copy + drop + store>(arg0: &Queue<T0>) : T0 {
        assert!(!is_empty<T0>(arg0), 100);
        *0x1::vector::borrow<T0>(&arg0.items, 0)
    }

    public fun front_mut<T0: copy + drop + store>(arg0: &mut Queue<T0>) : &mut T0 {
        assert!(!is_empty<T0>(arg0), 100);
        0x1::vector::borrow_mut<T0>(&mut arg0.items, 0)
    }

    public fun pop_front<T0: copy + drop + store>(arg0: &mut Queue<T0>) : 0x1::option::Option<T0> {
        if (0x1::vector::is_empty<T0>(&arg0.items)) {
            0x1::option::none<T0>()
        } else {
            0x1::option::some<T0>(0x1::vector::remove<T0>(&mut arg0.items, 0))
        }
    }

    // decompiled from Move bytecode v6
}

