module 0x8bba3d8e3449349116c569543b5ded374615e9f11cbd2ba97b7a6bc5f45b12fe::linked_set {
    struct LinkedSet<T0: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        size: u64,
        head: 0x1::option::Option<T0>,
        tail: 0x1::option::Option<T0>,
    }

    struct Node<T0: copy + drop + store> has store {
        prev: 0x1::option::Option<T0>,
        next: 0x1::option::Option<T0>,
    }

    public fun length<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : u64 {
        arg0.size
    }

    public fun push_back<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        if (0x1::option::is_none<T0>(&arg0.head)) {
            0x1::option::fill<T0>(&mut arg0.head, arg1);
        };
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg0.tail, arg1);
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0>>(&mut arg0.id, v2).next = 0x1::option::some<T0>(arg1);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0>{
            prev : v1,
            next : 0x1::option::none<T0>(),
        };
        0x2::dynamic_field::add<T0, Node<T0>>(&mut arg0.id, arg1, v3);
        arg0.size = arg0.size + 1;
    }

    public fun pop_back<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0.tail), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.tail);
        remove<T0>(arg0, v0);
        v0
    }

    public fun destroy_empty<T0: copy + drop + store>(arg0: LinkedSet<T0>) {
        let LinkedSet {
            id   : v0,
            size : v1,
            head : _,
            tail : _,
        } = arg0;
        assert!(v1 == 0, 0);
        0x2::object::delete(v0);
    }

    public fun remove<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        let Node {
            prev : v0,
            next : v1,
        } = 0x2::dynamic_field::remove<T0, Node<T0>>(&mut arg0.id, arg1);
        let v2 = v1;
        let v3 = v0;
        arg0.size = arg0.size - 1;
        if (0x1::option::is_some<T0>(&v3)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0>>(&mut arg0.id, *0x1::option::borrow<T0>(&v3)).next = v2;
        };
        if (0x1::option::is_some<T0>(&v2)) {
            0x2::dynamic_field::borrow_mut<T0, Node<T0>>(&mut arg0.id, *0x1::option::borrow<T0>(&v2)).prev = v3;
        };
        if (0x1::option::borrow<T0>(&arg0.head) == &arg1) {
            arg0.head = v2;
        };
        if (0x1::option::borrow<T0>(&arg0.tail) == &arg1) {
            arg0.tail = v3;
        };
    }

    public fun new<T0: copy + drop + store>(arg0: &mut 0x2::tx_context::TxContext) : LinkedSet<T0> {
        LinkedSet<T0>{
            id   : 0x2::object::new(arg0),
            size : 0,
            head : 0x1::option::none<T0>(),
            tail : 0x1::option::none<T0>(),
        }
    }

    public fun back<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : &0x1::option::Option<T0> {
        &arg0.tail
    }

    public fun contains<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : bool {
        0x2::dynamic_field::exists_with_type<T0, Node<T0>>(&arg0.id, arg1)
    }

    public fun drop<T0: copy + drop + store>(arg0: LinkedSet<T0>) {
        let LinkedSet {
            id   : v0,
            size : _,
            head : _,
            tail : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun front<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : &0x1::option::Option<T0> {
        &arg0.head
    }

    public fun is_empty<T0: copy + drop + store>(arg0: &LinkedSet<T0>) : bool {
        arg0.size == 0
    }

    public fun next<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0>>(&arg0.id, arg1).next
    }

    public fun pop_front<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0.head), 1);
        let v0 = *0x1::option::borrow<T0>(&arg0.head);
        remove<T0>(arg0, v0);
        v0
    }

    public fun prev<T0: copy + drop + store>(arg0: &LinkedSet<T0>, arg1: T0) : &0x1::option::Option<T0> {
        &0x2::dynamic_field::borrow<T0, Node<T0>>(&arg0.id, arg1).prev
    }

    public fun push_front<T0: copy + drop + store>(arg0: &mut LinkedSet<T0>, arg1: T0) {
        let v0 = 0x1::option::swap_or_fill<T0>(&mut arg0.head, arg1);
        if (0x1::option::is_none<T0>(&arg0.tail)) {
            0x1::option::fill<T0>(&mut arg0.tail, arg1);
        };
        let v1 = if (0x1::option::is_some<T0>(&v0)) {
            let v2 = 0x1::option::destroy_some<T0>(v0);
            0x2::dynamic_field::borrow_mut<T0, Node<T0>>(&mut arg0.id, v2).prev = 0x1::option::some<T0>(arg1);
            0x1::option::some<T0>(v2)
        } else {
            0x1::option::none<T0>()
        };
        let v3 = Node<T0>{
            prev : 0x1::option::none<T0>(),
            next : v1,
        };
        0x2::dynamic_field::add<T0, Node<T0>>(&mut arg0.id, arg1, v3);
        arg0.size = arg0.size + 1;
    }

    // decompiled from Move bytecode v6
}

