module 0x22d289d43332704ec8e697ea7f8ec57c5cd580f55577717b2e1573f8f311ab6::linked_list {
    struct Node<T0: store + key> has store {
        value: T0,
        prev: 0x1::option::Option<0x2::object::ID>,
        next: 0x1::option::Option<0x2::object::ID>,
    }

    struct LinkedList<T0: store + key> has store {
        head: 0x1::option::Option<0x2::object::ID>,
        tail: 0x1::option::Option<0x2::object::ID>,
        nodes: 0x2::table::Table<0x2::object::ID, Node<T0>>,
        length: u64,
    }

    public fun length<T0: store + key>(arg0: &LinkedList<T0>) : u64 {
        arg0.length
    }

    public fun borrow<T0: store + key>(arg0: &LinkedList<T0>, arg1: 0x2::object::ID) : &T0 {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340346302791683);
        &0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1).value
    }

    public fun push_back<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, v0), 13835621920063881221);
        let v1 = Node<T0>{
            value : arg1,
            prev  : arg0.tail,
            next  : 0x1::option::none<0x2::object::ID>(),
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg0.tail)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.tail)).next = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.head = 0x1::option::some<0x2::object::ID>(v0);
        };
        arg0.tail = 0x1::option::some<0x2::object::ID>(v0);
        0x2::table::add<0x2::object::ID, Node<T0>>(&mut arg0.nodes, v0, v1);
        arg0.length = arg0.length + 1;
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: 0x2::object::ID) : &mut T0 {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340389252464643);
        &mut 0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, arg1).value
    }

    public fun pop_back<T0: store + key>(arg0: &mut LinkedList<T0>) : T0 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.tail), 13835059330887450625);
        let Node {
            value : v0,
            prev  : v1,
            next  : _,
        } = 0x2::table::remove<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.tail));
        let v3 = v1;
        arg0.tail = v3;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v3)).next = 0x1::option::none<0x2::object::ID>();
        } else {
            arg0.head = 0x1::option::none<0x2::object::ID>();
        };
        arg0.length = arg0.length - 1;
        v0
    }

    public fun destroy_empty<T0: store + key>(arg0: LinkedList<T0>) {
        assert!(is_empty<T0>(&arg0), 13835902888234582023);
        let LinkedList {
            head   : _,
            tail   : _,
            nodes  : v2,
            length : _,
        } = arg0;
        0x2::table::destroy_empty<0x2::object::ID, Node<T0>>(v2);
    }

    public fun contains<T0: store + key>(arg0: &LinkedList<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1)
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : LinkedList<T0> {
        LinkedList<T0>{
            head   : 0x1::option::none<0x2::object::ID>(),
            tail   : 0x1::option::none<0x2::object::ID>(),
            nodes  : 0x2::table::new<0x2::object::ID, Node<T0>>(arg0),
            length : 0,
        }
    }

    public fun remove<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: 0x2::object::ID) : T0 {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340913238474755);
        let Node {
            value : v0,
            prev  : v1,
            next  : v2,
        } = 0x2::table::remove<0x2::object::ID, Node<T0>>(&mut arg0.nodes, arg1);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v4)).next = v3;
        } else {
            arg0.head = v3;
        };
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v3)).prev = v4;
        } else {
            arg0.tail = v4;
        };
        arg0.length = arg0.length - 1;
        v0
    }

    public fun back<T0: store + key>(arg0: &LinkedList<T0>) : &T0 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.tail), 13835058746771898369);
        &0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.tail)).value
    }

    public fun borrow_mut_node<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: 0x2::object::ID) : &mut Node<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340303353118723);
        0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, arg1)
    }

    public fun borrow_node<T0: store + key>(arg0: &LinkedList<T0>, arg1: 0x2::object::ID) : &Node<T0> {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340264698413059);
        0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1)
    }

    public fun front<T0: store + key>(arg0: &LinkedList<T0>) : &T0 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.head), 13835058703822225409);
        &0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.head)).value
    }

    public fun head_id<T0: store + key>(arg0: &LinkedList<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.head
    }

    public fun insert_after<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: 0x2::object::ID, arg2: T0) {
        let v0 = 0x2::object::id<T0>(&arg2);
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835341080742199299);
        assert!(!0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, v0), 13835622564308975621);
        let v1 = 0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1).next;
        let v2 = Node<T0>{
            value : arg2,
            prev  : 0x1::option::some<0x2::object::ID>(arg1),
            next  : v1,
        };
        0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, arg1).next = 0x1::option::some<0x2::object::ID>(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v1)).prev = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.tail = 0x1::option::some<0x2::object::ID>(v0);
        };
        0x2::table::add<0x2::object::ID, Node<T0>>(&mut arg0.nodes, v0, v2);
        arg0.length = arg0.length + 1;
    }

    public fun insert_before<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: 0x2::object::ID, arg2: T0) {
        let v0 = 0x2::object::id<T0>(&arg2);
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835341256835858435);
        assert!(!0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, v0), 13835622740402634757);
        let v1 = 0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1).prev;
        let v2 = Node<T0>{
            value : arg2,
            prev  : v1,
            next  : 0x1::option::some<0x2::object::ID>(arg1),
        };
        0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, arg1).prev = 0x1::option::some<0x2::object::ID>(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v1)).next = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.head = 0x1::option::some<0x2::object::ID>(v0);
        };
        0x2::table::add<0x2::object::ID, Node<T0>>(&mut arg0.nodes, v0, v2);
        arg0.length = arg0.length + 1;
    }

    public fun is_empty<T0: store + key>(arg0: &LinkedList<T0>) : bool {
        arg0.length == 0
    }

    public fun next<T0: store + key>(arg0: &Node<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.next
    }

    public fun next_id<T0: store + key>(arg0: &LinkedList<T0>, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340101489655811);
        0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1).next
    }

    public fun pop_front<T0: store + key>(arg0: &mut LinkedList<T0>) : T0 {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.head), 13835059223513268225);
        let Node {
            value : v0,
            prev  : _,
            next  : v2,
        } = 0x2::table::remove<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.head));
        let v3 = v2;
        arg0.head = v3;
        if (0x1::option::is_some<0x2::object::ID>(&v3)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&v3)).prev = 0x1::option::none<0x2::object::ID>();
        } else {
            arg0.tail = 0x1::option::none<0x2::object::ID>();
        };
        arg0.length = arg0.length - 1;
        v0
    }

    public fun prev<T0: store + key>(arg0: &Node<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.prev
    }

    public fun prev_id<T0: store + key>(arg0: &LinkedList<T0>, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        assert!(0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1), 13835340140144361475);
        0x2::table::borrow<0x2::object::ID, Node<T0>>(&arg0.nodes, arg1).prev
    }

    public fun push_front<T0: store + key>(arg0: &mut LinkedList<T0>, arg1: T0) {
        let v0 = 0x2::object::id<T0>(&arg1);
        assert!(!0x2::table::contains<0x2::object::ID, Node<T0>>(&arg0.nodes, v0), 13835622048912900101);
        let v1 = Node<T0>{
            value : arg1,
            prev  : 0x1::option::none<0x2::object::ID>(),
            next  : arg0.head,
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg0.head)) {
            0x2::table::borrow_mut<0x2::object::ID, Node<T0>>(&mut arg0.nodes, *0x1::option::borrow<0x2::object::ID>(&arg0.head)).prev = 0x1::option::some<0x2::object::ID>(v0);
        } else {
            arg0.tail = 0x1::option::some<0x2::object::ID>(v0);
        };
        arg0.head = 0x1::option::some<0x2::object::ID>(v0);
        0x2::table::add<0x2::object::ID, Node<T0>>(&mut arg0.nodes, v0, v1);
        arg0.length = arg0.length + 1;
    }

    public fun tail_id<T0: store + key>(arg0: &LinkedList<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.tail
    }

    public fun value<T0: store + key>(arg0: &Node<T0>) : &T0 {
        &arg0.value
    }

    public fun value_mut<T0: store + key>(arg0: &mut Node<T0>) : &mut T0 {
        &mut arg0.value
    }

    // decompiled from Move bytecode v6
}

