module 0x60d4b5e03dd44d0727aa683afa4325fa33d5d6a4baba8e169e4751d000ee9f85::linked_list {
    struct LinkedList<T0: copy + drop + store, phantom T1: store> has drop, store {
        id: 0x2::object::ID,
        first: 0x1::option::Option<T0>,
        last: 0x1::option::Option<T0>,
        length: u64,
    }

    struct Node<T0: copy + drop + store, T1: store> has copy, drop, store {
        value: T1,
        prev: 0x1::option::Option<T0>,
        next: 0x1::option::Option<T0>,
        exists: bool,
    }

    public fun length<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : u64 {
        arg0.length
    }

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : &T1 {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        let v0 = 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = &v0.value;
        if (!v0.exists) {
            abort 1
        };
        v1
    }

    public fun push_back<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length + 1;
        if (0x1::option::is_none<T0>(&arg1.first)) {
            arg1.first = 0x1::option::some<T0>(arg2);
        };
        if (0x1::option::is_some<T0>(&arg1.last)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&arg1.last)).next = 0x1::option::some<T0>(arg2);
        };
        push_node<T0, T1>(arg0, arg2, new_node<T0, T1>(arg3, arg1.last, 0x1::option::none<T0>()));
        arg1.last = 0x1::option::some<T0>(arg2);
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : &mut T1 {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        let v0 = 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = &mut v0.value;
        if (!v0.exists) {
            abort 1
        };
        v1
    }

    public fun pop_back<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = *0x1::option::borrow<T0>(&arg1.last);
        let v1 = prev<T0, T1>(arg0, arg1, v0);
        arg1.last = v1;
        if (0x1::option::is_some<T0>(&v1)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).next = 0x1::option::none<T0>();
        } else {
            arg1.first = 0x1::option::none<T0>();
        };
        (v0, pop_node<T0, T1>(arg0, v0))
    }

    public fun remove<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0) : T1 {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = v0.prev;
        let v2 = v0.next;
        if (0x1::option::is_none<T0>(&v1)) {
            arg1.first = v2;
        } else {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).next = v2;
        };
        if (0x1::option::is_none<T0>(&v2)) {
            arg1.last = v1;
        } else {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v2)).prev = v1;
        };
        pop_node<T0, T1>(arg0, arg2)
    }

    public fun chain<T0: copy + drop + store, T1: store>(arg0: &mut LinkedList<T0, T1>, arg1: &mut LinkedList<T0, T1>) {
        assert!(arg0.id == arg1.id, 0);
        if (length<T0, T1>(arg1) != 0) {
            if (length<T0, T1>(arg0) == 0) {
                arg0.first = arg1.first;
                arg0.last = arg1.last;
                arg0.length = arg1.length;
            } else {
                arg0.last = arg1.first;
                arg0.length = arg0.length + arg1.length;
            };
            arg1.first = 0x1::option::none<T0>();
            arg1.last = 0x1::option::none<T0>();
            arg1.length = 0;
        };
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : bool {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        0x2::dynamic_field::exists_<T0>(arg0, arg2) && 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2).exists
    }

    public fun delete<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0) : T1 {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = v0.prev;
        let v2 = v0.next;
        if (0x1::option::is_none<T0>(&v1)) {
            arg1.first = v2;
        } else {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).next = v2;
        };
        if (0x1::option::is_none<T0>(&v2)) {
            arg1.last = v1;
        } else {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v2)).prev = v1;
        };
        take_node<T0, T1>(arg0, arg2)
    }

    public fun first<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : 0x1::option::Option<T0> {
        arg0.first
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : bool {
        arg0.length == 0
    }

    public fun last<T0: copy + drop + store, T1: store>(arg0: &LinkedList<T0, T1>) : 0x1::option::Option<T0> {
        arg0.last
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: 0x2::object::ID) : LinkedList<T0, T1> {
        LinkedList<T0, T1>{
            id     : arg0,
            first  : 0x1::option::none<T0>(),
            last   : 0x1::option::none<T0>(),
            length : 0,
        }
    }

    public fun new_node<T0: copy + drop + store, T1: store>(arg0: T1, arg1: 0x1::option::Option<T0>, arg2: 0x1::option::Option<T0>) : Node<T0, T1> {
        Node<T0, T1>{
            value  : arg0,
            prev   : arg1,
            next   : arg2,
            exists : true,
        }
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : 0x1::option::Option<T0> {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        let v0 = 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = &v0.next;
        if (!v0.exists) {
            abort 1
        };
        *v1
    }

    public fun node_exists<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : bool {
        arg0.exists
    }

    public fun node_value<T0: copy + drop + store, T1: store>(arg0: &Node<T0, T1>) : &T1 {
        &arg0.value
    }

    public fun pop_front<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = *0x1::option::borrow<T0>(&arg1.first);
        let v1 = next<T0, T1>(arg0, arg1, v0);
        arg1.first = v1;
        if (0x1::option::is_some<T0>(&v1)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).prev = 0x1::option::none<T0>();
        } else {
            arg1.last = 0x1::option::none<T0>();
        };
        (v0, pop_node<T0, T1>(arg0, v0))
    }

    public fun pop_node<T0: copy + drop + store, T1: copy + store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let v0 = 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, arg1);
        let v1 = &mut v0.value;
        let v2 = &mut v0.prev;
        let v3 = &mut v0.next;
        let v4 = &mut v0.exists;
        if (!*v4) {
            abort 1
        };
        *v2 = 0x1::option::none<T0>();
        *v3 = 0x1::option::none<T0>();
        *v4 = false;
        *v1
    }

    public fun prepare_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: T1) {
        if (!0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            let v0 = Node<T0, T1>{
                value  : arg2,
                prev   : 0x1::option::none<T0>(),
                next   : 0x1::option::none<T0>(),
                exists : false,
            };
            0x2::dynamic_field::add<T0, Node<T0, T1>>(arg0, arg1, v0);
        };
    }

    public fun prev<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedList<T0, T1>, arg2: T0) : 0x1::option::Option<T0> {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        let v0 = 0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2);
        let v1 = &v0.prev;
        if (!v0.exists) {
            abort 1
        };
        *v1
    }

    public fun push_front<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length + 1;
        if (0x1::option::is_none<T0>(&arg1.last)) {
            arg1.last = 0x1::option::some<T0>(arg2);
        };
        if (0x1::option::is_some<T0>(&arg1.first)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&arg1.first)).prev = 0x1::option::some<T0>(arg2);
        };
        push_node<T0, T1>(arg0, arg2, new_node<T0, T1>(arg3, 0x1::option::none<T0>(), arg1.first));
        arg1.first = 0x1::option::some<T0>(arg2);
    }

    public fun push_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: Node<T0, T1>) {
        if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, arg1);
            if (v0.exists) {
                abort 2
            };
            let Node {
                value  : v1,
                prev   : v2,
                next   : v3,
                exists : v4,
            } = arg2;
            v0.value = v1;
            v0.prev = v2;
            v0.next = v3;
            v0.exists = v4;
        } else {
            0x2::dynamic_field::add<T0, Node<T0, T1>>(arg0, arg1, arg2);
        };
    }

    public fun put_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) : 0x1::option::Option<T1> {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length + 1;
        if (0x1::option::is_none<T0>(&arg1.first)) {
            arg1.first = 0x1::option::some<T0>(arg2);
        };
        if (0x1::option::is_some<T0>(&arg1.last)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&arg1.last)).next = 0x1::option::some<T0>(arg2);
        };
        arg1.last = 0x1::option::some<T0>(arg2);
        put_node<T0, T1>(arg0, arg2, new_node<T0, T1>(arg3, arg1.last, 0x1::option::none<T0>()))
    }

    public fun put_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>, arg2: T0, arg3: T1) : 0x1::option::Option<T1> {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length + 1;
        if (0x1::option::is_none<T0>(&arg1.last)) {
            arg1.last = 0x1::option::some<T0>(arg2);
        };
        if (0x1::option::is_some<T0>(&arg1.first)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&arg1.first)).prev = 0x1::option::some<T0>(arg2);
        };
        arg1.first = 0x1::option::some<T0>(arg2);
        put_node<T0, T1>(arg0, arg2, new_node<T0, T1>(arg3, 0x1::option::none<T0>(), arg1.first))
    }

    public fun put_node<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: Node<T0, T1>) : 0x1::option::Option<T1> {
        let v0 = if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            let Node {
                value  : v1,
                prev   : _,
                next   : _,
                exists : v4,
            } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(arg0, arg1);
            if (v4) {
                abort 2
            };
            0x1::option::some<T1>(v1)
        } else {
            0x1::option::none<T1>()
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(arg0, arg1, arg2);
        v0
    }

    public fun remove_node<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::object::UID, arg1: T0) {
        if (0x2::dynamic_field::exists_<T0>(arg0, arg1)) {
            let Node {
                value  : _,
                prev   : _,
                next   : _,
                exists : v3,
            } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(arg0, arg1);
            if (v3) {
                abort 3
            };
        };
    }

    public fun take_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = *0x1::option::borrow<T0>(&arg1.last);
        let v1 = prev<T0, T1>(arg0, arg1, v0);
        arg1.last = v1;
        if (0x1::option::is_some<T0>(&v1)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).next = 0x1::option::none<T0>();
        } else {
            arg1.first = 0x1::option::none<T0>();
        };
        (v0, take_node<T0, T1>(arg0, v0))
    }

    public fun take_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedList<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_inner(arg0) == arg1.id, 0);
        arg1.length = arg1.length - 1;
        let v0 = *0x1::option::borrow<T0>(&arg1.first);
        let v1 = next<T0, T1>(arg0, arg1, v0);
        arg1.first = v1;
        if (0x1::option::is_some<T0>(&v1)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v1)).prev = 0x1::option::none<T0>();
        } else {
            arg1.last = 0x1::option::none<T0>();
        };
        (v0, take_node<T0, T1>(arg0, v0))
    }

    public fun take_node<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: T0) : T1 {
        let Node {
            value  : v0,
            prev   : _,
            next   : _,
            exists : v3,
        } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(arg0, arg1);
        if (!v3) {
            abort 1
        };
        v0
    }

    // decompiled from Move bytecode v6
}

