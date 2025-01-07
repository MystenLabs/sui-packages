module 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::linked_object_table {
    struct LinkedObjectTable<T0: copy + drop + store, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        vid: 0x2::object::UID,
        size: u64,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
    }

    struct Node<T0: copy + drop + store, phantom T1: store + key> has store {
        prev: 0x1::option::Option<T0>,
        next: 0x1::option::Option<T0>,
    }

    public fun length<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>) : u64 {
        arg0.size
    }

    public fun borrow<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.vid, arg1)
    }

    public fun push_back<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>, arg1: T0, arg2: T1) {
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
            prev : v1,
            next : 0x1::option::none<T0>(),
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v3);
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.vid, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    public fun borrow_mut<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>, arg1: T0) : &mut T1 {
        0x2::dynamic_object_field::borrow_mut<T0, T1>(&mut arg0.vid, arg1)
    }

    public fun pop_back<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>) : (T0, T1) {
        assert!(0x1::option::is_some<T0>(&arg0.tail), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.tail);
        (v0, remove<T0, T1>(arg0, v0))
    }

    public fun destroy_empty<T0: copy + drop + store, T1: store + key>(arg0: LinkedObjectTable<T0, T1>) {
        let LinkedObjectTable {
            id   : v0,
            vid  : v1,
            size : v2,
            head : _,
            tail : _,
        } = arg0;
        assert!(v2 == 0, 0);
        0x2::object::delete(v0);
        0x2::object::delete(v1);
    }

    public fun remove<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>, arg1: T0) : T1 {
        let Node {
            prev : v0,
            next : v1,
        } = 0x2::dynamic_field::remove<T0, Node<T0, T1>>(&mut arg0.id, arg1);
        let v2 = v1;
        let v3 = v0;
        arg0.size = arg0.size - 1;
        if (0x1::option::is_some<T0>(&v3)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, *0x1::option::borrow<T0>(&v3)).next = v2;
        };
        if (0x1::option::is_some<T0>(&v2)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0, T1>>(&mut arg0.id, *0x1::option::borrow<T0>(&v2)).prev = v3;
        };
        if (0x1::option::borrow<T0>(&arg0.head) == &arg1) {
            arg0.head = v2;
        };
        if (0x1::option::borrow<T0>(&arg0.tail) == &arg1) {
            arg0.tail = v3;
        };
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.vid, arg1)
    }

    public fun new<T0: copy + drop + store, T1: store + key>(arg0: &mut 0x2::tx_context::TxContext) : LinkedObjectTable<T0, T1> {
        LinkedObjectTable<T0, T1>{
            id   : 0x2::object::new(arg0),
            vid  : 0x2::object::new(arg0),
            size : 0,
            head : 0x1::option::none<T0>(),
            tail : 0x1::option::none<T0>(),
        }
    }

    public fun back<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.tail
    }

    public fun contains<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, Node<T0, T1>>(&arg0.id, arg1)
    }

    public fun front<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>) : &0x1::option::Option<T0> {
        &arg0.head
    }

    public fun is_empty<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>) : bool {
        arg0.size == 0
    }

    public fun next<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1).next
    }

    public fun pop_front<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>) : (T0, T1) {
        assert!(0x1::option::is_some<T0>(&arg0.head), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.head);
        (v0, remove<T0, T1>(arg0, v0))
    }

    public fun prev<T0: copy + drop + store, T1: store + key>(arg0: &LinkedObjectTable<T0, T1>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0, T1>>(&arg0.id, arg1).prev
    }

    public fun push_front<T0: copy + drop + store, T1: store + key>(arg0: &mut LinkedObjectTable<T0, T1>, arg1: T0, arg2: T1) {
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
            prev : 0x1::option::none<T0>(),
            next : v1,
        };
        0x2::dynamic_field::add<T0, Node<T0, T1>>(&mut arg0.id, arg1, v3);
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.vid, arg1, arg2);
        arg0.size = arg0.size + 1;
    }

    // decompiled from Move bytecode v6
}

