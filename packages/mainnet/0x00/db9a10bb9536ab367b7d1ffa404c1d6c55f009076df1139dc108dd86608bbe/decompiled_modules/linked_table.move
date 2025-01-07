module 0xdb9a10bb9536ab367b7d1ffa404c1d6c55f009076df1139dc108dd86608bbe::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        size: u64,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
    }

    struct Node<T0: copy + drop + store, T1: store> has store {
        prev: 0x1::option::Option<T0>,
        next: 0x1::option::Option<T0>,
        value: T1,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : &T1 {
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1).value
    }

    public fun push_back<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0, arg2: T1) {
        if (0x1::option::is_none<T0>(&arg0.head)) {
            0x1::option::fill<T0>(&mut arg0.head, arg1);
        };
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg0.tail, arg1);
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v2).next = 0x1::option::some<T0>(arg1);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0, T1>{
            prev  : v1,
            next  : 0x1::option::none<T0>(),
            value : arg2,
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v3);
        arg0.size = arg0.size + 1;
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0) : &mut T1 {
        &mut 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, arg1).value
    }

    public fun pop_back<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>) : (T0, T1) {
        assert!(0x1::option::is_some<T0>(&arg0.tail), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.tail);
        (v0, remove<T0, T1>(arg0, v0))
    }

    public fun destroy_empty<T0: copy + drop + store, T1: store>(arg0: LinkedTable<T0, T1>) {
        let LinkedTable {
            id   : v0,
            size : v1,
            head : _,
            tail : _,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0) : T1 {
        let Node {
            prev  : v0,
            next  : v1,
            value : v2,
        } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(&mut arg0.id, arg1);
        let v3 = v1;
        let v4 = v0;
        arg0.size = arg0.size - 1;
        if (0x1::option::is_some<T0>(&v4)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, *0x1::option::borrow<T0>(&v4)).next = v3;
        };
        if (0x1::option::is_some<T0>(&v3)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, *0x1::option::borrow<T0>(&v3)).prev = v4;
        };
        if (0x1::option::borrow<T0>(&arg0.head) == &arg1) {
            arg0.head = v3;
        };
        if (0x1::option::borrow<T0>(&arg0.tail) == &arg1) {
            arg0.tail = v4;
        };
        v2
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::tx_context::TxContext) : LinkedTable<T0, T1> {
        LinkedTable<T0, T1>{
            id   : 0x2::object::new(arg0),
            size : 0,
            head : 0x1::option::none<T0>(),
            tail : 0x1::option::none<T0>(),
        }
    }

    public fun back<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.tail
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, Node<T0, T1>>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: drop + store>(arg0: LinkedTable<T0, T1>) {
        let LinkedTable {
            id   : v0,
            size : _,
            head : _,
            tail : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun front<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.head
    }

    public fun insert_back<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: 0x1::option::Option<T0>, arg2: T0, arg3: T1) {
        if (0x1::option::is_none<T0>(&arg1)) {
            push_front<T0, T1>(arg0, arg2, arg3);
        } else {
            let v0 = 0x1::option::destroy_some<T0>(arg1);
            let v1 = *next<T0, T1>(arg0, v0);
            if (0x1::option::is_none<T0>(&v1)) {
                push_back<T0, T1>(arg0, arg2, arg3);
            } else {
                let v2 = 0x1::option::destroy_some<T0>(v1);
                0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v2).prev = 0x1::option::some<T0>(arg2);
                0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v0).next = 0x1::option::some<T0>(arg2);
                let v3 = Node<T0, T1>{
                    prev  : 0x1::option::some<T0>(v0),
                    next  : 0x1::option::some<T0>(v2),
                    value : arg3,
                };
                0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg2, v3);
                arg0.size = arg0.size + 1;
            };
        };
    }

    public fun insert_front<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: 0x1::option::Option<T0>, arg2: T0, arg3: T1) {
        if (0x1::option::is_none<T0>(&arg1)) {
            push_back<T0, T1>(arg0, arg2, arg3);
        } else {
            let v0 = 0x1::option::destroy_some<T0>(arg1);
            let v1 = *prev<T0, T1>(arg0, v0);
            if (0x1::option::is_none<T0>(&v1)) {
                push_front<T0, T1>(arg0, arg2, arg3);
            } else {
                let v2 = 0x1::option::destroy_some<T0>(v1);
                0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v0).prev = 0x1::option::some<T0>(arg2);
                0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v2).next = 0x1::option::some<T0>(arg2);
                let v3 = Node<T0, T1>{
                    prev  : 0x1::option::some<T0>(v2),
                    next  : 0x1::option::some<T0>(v0),
                    value : arg3,
                };
                0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg2, v3);
                arg0.size = arg0.size + 1;
            };
        };
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1).next
    }

    public fun pop_front<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>) : (T0, T1) {
        assert!(0x1::option::is_some<T0>(&arg0.head), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.head);
        (v0, remove<T0, T1>(arg0, v0))
    }

    public fun prev<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1).prev
    }

    public fun push_front<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0, arg2: T1) {
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg0.head, arg1);
        if (0x1::option::is_none<T0>(&arg0.tail)) {
            0x1::option::fill<T0>(&mut arg0.tail, arg1);
        };
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, v2).prev = 0x1::option::some<T0>(arg1);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0, T1>{
            prev  : 0x1::option::none<T0>(),
            next  : v1,
            value : arg2,
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v3);
        arg0.size = arg0.size + 1;
    }

    // decompiled from Move bytecode v6
}

