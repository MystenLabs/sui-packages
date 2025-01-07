module 0xe1b425ed0a1dce7a89b8c3aae330fb9a9e8ec8fb6f221a501f4b34cfb0041b4e::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has store, key {
        id: 0x2::object::UID,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
        size: u64,
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
        let v0 = Node<T0, T1>{
            prev  : arg0.tail,
            next  : 0x1::option::none<T0>(),
            value : arg2,
        };
        0x1::option::swap_or_fill<T0>(&mut arg0.tail, arg1);
        if (0x1::option::is_none<T0>(&arg0.head)) {
            0x1::option::swap_or_fill<T0>(&mut arg0.head, arg1);
        };
        if (0x1::option::is_some<T0>(&v0.prev)) {
            let v1 = borrow_mut_node<T0, T1>(arg0, *0x1::option::borrow<T0>(&v0.prev));
            0x1::option::swap_or_fill<T0>(&mut v1.next, arg1);
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v0);
        arg0.size = arg0.size + 1;
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0) : &mut T1 {
        &mut 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, arg1).value
    }

    public fun destroy_empty<T0: copy + drop + store, T1: drop + store>(arg0: LinkedTable<T0, T1>) {
        let LinkedTable {
            id   : v0,
            head : _,
            tail : _,
            size : v3,
        } = arg0;
        assert!(v3 == 0, 0);
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
            head : 0x1::option::none<T0>(),
            tail : 0x1::option::none<T0>(),
            size : 0,
        }
    }

    public fun borrow_mut_node<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0) : &mut Node<T0, T1> {
        0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, arg1)
    }

    public fun borrow_mut_value<T0: copy + drop + store, T1: store>(arg0: &mut Node<T0, T1>) : &mut T1 {
        &mut arg0.value
    }

    public fun borrow_node<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : &Node<T0, T1> {
        0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1)
    }

    public fun borrow_value<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : &T1 {
        &arg0.value
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, Node<T0, T1>>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store, T1: store>(arg0: LinkedTable<T0, T1>) {
        let LinkedTable {
            id   : v0,
            head : _,
            tail : _,
            size : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun head<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : 0x1::option::Option<T0> {
        arg0.head
    }

    public fun insert_after<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0, arg2: T0, arg3: T1) {
        let v0 = borrow_mut_node<T0, T1>(arg0, arg1);
        let v1 = Node<T0, T1>{
            prev  : 0x1::option::some<T0>(arg1),
            next  : v0.next,
            value : arg3,
        };
        0x1::option::swap_or_fill<T0>(&mut v0.next, arg2);
        if (0x1::option::is_some<T0>(&v1.next)) {
            let v2 = borrow_mut_node<T0, T1>(arg0, *0x1::option::borrow<T0>(&v1.next));
            0x1::option::swap_or_fill<T0>(&mut v2.prev, arg2);
        } else {
            0x1::option::swap_or_fill<T0>(&mut arg0.tail, arg2);
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg2, v1);
        arg0.size = arg0.size + 1;
    }

    public fun insert_before<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0, arg2: T0, arg3: T1) {
        let v0 = borrow_mut_node<T0, T1>(arg0, arg1);
        let v1 = Node<T0, T1>{
            prev  : v0.prev,
            next  : 0x1::option::some<T0>(arg1),
            value : arg3,
        };
        0x1::option::swap_or_fill<T0>(&mut v0.prev, arg2);
        if (0x1::option::is_some<T0>(&v1.prev)) {
            let v2 = borrow_mut_node<T0, T1>(arg0, *0x1::option::borrow<T0>(&v1.prev));
            0x1::option::swap_or_fill<T0>(&mut v2.next, arg2);
        } else {
            0x1::option::swap_or_fill<T0>(&mut arg0.head, arg2);
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg2, v1);
        arg0.size = arg0.size + 1;
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : 0x1::option::Option<T0> {
        arg0.next
    }

    public fun prev<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : 0x1::option::Option<T0> {
        arg0.prev
    }

    public fun push_front<T0: copy + drop + store, T1: store>(arg0: &mut LinkedTable<T0, T1>, arg1: T0, arg2: T1) {
        let v0 = Node<T0, T1>{
            prev  : 0x1::option::none<T0>(),
            next  : arg0.head,
            value : arg2,
        };
        0x1::option::swap_or_fill<T0>(&mut arg0.head, arg1);
        if (0x1::option::is_none<T0>(&arg0.tail)) {
            0x1::option::swap_or_fill<T0>(&mut arg0.tail, arg1);
        };
        if (0x1::option::is_some<T0>(&v0.next)) {
            let v1 = borrow_mut_node<T0, T1>(arg0, *0x1::option::borrow<T0>(&v0.next));
            0x1::option::swap_or_fill<T0>(&mut v1.prev, arg1);
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v0);
        arg0.size = arg0.size + 1;
    }

    public fun tail<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : 0x1::option::Option<T0> {
        arg0.tail
    }

    // decompiled from Move bytecode v6
}

