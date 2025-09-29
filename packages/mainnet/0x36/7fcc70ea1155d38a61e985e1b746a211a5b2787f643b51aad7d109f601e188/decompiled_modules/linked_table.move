module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::linked_table {
    struct LinkedTable<T0: copy + drop + store, phantom T1: store> has copy, drop, store {
        id: address,
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

    public fun borrow<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedTable<T0, T1>, arg2: T0) : &T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2).value
    }

    public fun push_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>, arg2: T0, arg3: T1) {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        if (0x1::option::is_none<T0>(&arg1.head)) {
            0x1::option::fill<T0>(&mut arg1.head, arg2);
        };
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg1.tail, arg2);
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, v2).next = 0x1::option::some<T0>(arg2);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0, T1>{
            prev  : v1,
            next  : 0x1::option::none<T0>(),
            value : arg3,
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(arg0, arg2, v3);
        arg1.size = arg1.size + 1;
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>, arg2: T0) : &mut T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        &mut 0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, arg2).value
    }

    public fun pop_back<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        assert!(0x1::option::is_some<T0>(&arg1.tail), (401 as u64));
        let v0 = *0x1::option::borrow<T0>(&arg1.tail);
        (v0, remove<T0, T1>(arg0, arg1, v0))
    }

    public fun remove<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>, arg2: T0) : T1 {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        let Node {
            prev  : v0,
            next  : v1,
            value : v2,
        } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(arg0, arg2);
        let v3 = v1;
        let v4 = v0;
        arg1.size = arg1.size - 1;
        if (0x1::option::is_some<T0>(&v4)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v4)).next = v3;
        };
        if (0x1::option::is_some<T0>(&v3)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, *0x1::option::borrow<T0>(&v3)).prev = v4;
        };
        if (0x1::option::borrow<T0>(&arg1.head) == &arg2) {
            arg1.head = v3;
        };
        if (0x1::option::borrow<T0>(&arg1.tail) == &arg2) {
            arg1.tail = v4;
        };
        v2
    }

    public fun back<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.tail
    }

    public fun contains<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedTable<T0, T1>, arg2: T0) : bool {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        0x2::dynamic_field::exists_with_type<T0, Node<T0, T1>>(arg0, arg2)
    }

    public fun front<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.head
    }

    public fun is_empty<T0: copy + drop + store, T1: store>(arg0: &LinkedTable<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun new<T0: copy + drop + store, T1: store>(arg0: &address) : LinkedTable<T0, T1> {
        LinkedTable<T0, T1>{
            id   : *arg0,
            size : 0,
            head : 0x1::option::none<T0>(),
            tail : 0x1::option::none<T0>(),
        }
    }

    public fun next<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedTable<T0, T1>, arg2: T0) : &0x1::option::Option<T0> {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2).next
    }

    public fun pop_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>) : (T0, T1) {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        assert!(0x1::option::is_some<T0>(&arg1.head), (401 as u64));
        let v0 = *0x1::option::borrow<T0>(&arg1.head);
        (v0, remove<T0, T1>(arg0, arg1, v0))
    }

    public fun prev<T0: copy + drop + store, T1: store>(arg0: &0x2::object::UID, arg1: &LinkedTable<T0, T1>, arg2: T0) : &0x1::option::Option<T0> {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(arg0, arg2).prev
    }

    public fun push_front<T0: copy + drop + store, T1: store>(arg0: &mut 0x2::object::UID, arg1: &mut LinkedTable<T0, T1>, arg2: T0, arg3: T1) {
        assert!(0x2::object::uid_to_address(arg0) == arg1.id, (400 as u64));
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg1.head, arg2);
        if (0x1::option::is_none<T0>(&arg1.tail)) {
            0x1::option::fill<T0>(&mut arg1.tail, arg2);
        };
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(arg0, v2).prev = 0x1::option::some<T0>(arg2);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0, T1>{
            prev  : 0x1::option::none<T0>(),
            next  : v1,
            value : arg3,
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(arg0, arg2, v3);
        arg1.size = arg1.size + 1;
    }

    // decompiled from Move bytecode v6
}

