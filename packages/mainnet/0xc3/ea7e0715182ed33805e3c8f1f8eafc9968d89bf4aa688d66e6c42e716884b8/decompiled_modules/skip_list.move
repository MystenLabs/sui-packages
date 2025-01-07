module 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::skip_list {
    struct SkipList<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        head: vector<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>,
        tail: 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64,
        level: u64,
        max_level: u64,
        list_p: u64,
        size: u64,
        random: 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::random::Random,
    }

    struct Node<T0: store> has store {
        score: u64,
        nexts: vector<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>,
        prev: 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64,
        value: T0,
    }

    struct Item has drop, store {
        n: u64,
        score: u64,
        finded: 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64,
    }

    public fun length<T0: store>(arg0: &SkipList<T0>) : u64 {
        arg0.size
    }

    public fun borrow<T0: store>(arg0: &SkipList<T0>, arg1: u64) : &T0 {
        &0x2::dynamic_field::borrow<u64, Node<T0>>(&arg0.id, arg1).value
    }

    public fun borrow_mut<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : &mut T0 {
        &mut 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, arg1).value
    }

    public fun destroy_empty<T0: drop + store>(arg0: SkipList<T0>) {
        let SkipList {
            id        : v0,
            head      : _,
            tail      : _,
            level     : _,
            max_level : _,
            list_p    : _,
            size      : v6,
            random    : _,
        } = arg0;
        assert!(v6 == 0, 3);
        0x2::object::delete(v0);
    }

    public fun remove<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : T0 {
        assert!(contains<T0>(arg0, arg1), 1);
        let v0 = &mut arg0.head;
        let v1 = arg0.level;
        let v2 = 0x2::dynamic_field::remove<u64, Node<T0>>(&mut arg0.id, arg1);
        while (v1 > 0) {
            let v3 = 0x1::vector::borrow_mut<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v0, v1 - 1);
            while (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some_and_lte(v3, arg1)) {
                let v4 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(v3);
                if (v4 == arg1) {
                    *v3 = *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&v2.nexts, v1 - 1);
                    continue
                };
                let v5 = borrow_mut_node<T0>(arg0, v4);
                let v6 = &mut v5.nexts;
                v3 = 0x1::vector::borrow_mut<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v6, v1 - 1);
                v0 = v6;
            };
            v1 = v1 - 1;
        };
        if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(&arg0.tail) == arg1) {
            arg0.tail = v2.prev;
        };
        let v7 = 0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&v2.nexts, 0);
        if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some(v7)) {
            let v8 = borrow_mut_node<T0>(arg0, 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(v7));
            v8.prev = v2.prev;
        };
        arg0.size = arg0.size - 1;
        drop_node<T0>(v2)
    }

    public fun new<T0: store>(arg0: u64, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SkipList<T0> {
        SkipList<T0>{
            id        : 0x2::object::new(arg3),
            head      : 0x1::vector::empty<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(),
            tail      : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none(),
            level     : 0,
            max_level : arg0,
            list_p    : arg1,
            size      : 0,
            random    : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::random::new(arg2),
        }
    }

    public fun borrow_mut_node<T0: store>(arg0: &mut SkipList<T0>, arg1: u64) : &mut Node<T0> {
        0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, arg1)
    }

    public fun borrow_mut_value<T0: store>(arg0: &mut Node<T0>) : &mut T0 {
        &mut arg0.value
    }

    public fun borrow_node<T0: store>(arg0: &SkipList<T0>, arg1: u64) : &Node<T0> {
        0x2::dynamic_field::borrow<u64, Node<T0>>(&arg0.id, arg1)
    }

    public fun borrow_value<T0: store>(arg0: &Node<T0>) : &T0 {
        &arg0.value
    }

    public fun contains<T0: store>(arg0: &SkipList<T0>, arg1: u64) : bool {
        0x2::dynamic_field::exists_with_type<u64, Node<T0>>(&arg0.id, arg1)
    }

    fun create_node<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: T0) : (u64, Node<T0>) {
        let v0 = rand_level<T0>(0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::random::rand(&mut arg0.random), arg0);
        if (v0 > arg0.level) {
            arg0.level = v0;
            0x1::vector::push_back<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&mut arg0.head, 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none());
        };
        let v1 = Node<T0>{
            score : arg1,
            nexts : 0x1::vector::empty<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(),
            prev  : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none(),
            value : arg2,
        };
        (v0, v1)
    }

    fun drop_node<T0: store>(arg0: Node<T0>) : T0 {
        let Node {
            score : _,
            nexts : _,
            prev  : _,
            value : v3,
        } = arg0;
        v3
    }

    fun find<T0: store>(arg0: &SkipList<T0>, arg1: u64) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        let v0 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none();
        let v1 = &arg0.head;
        let v2 = arg0.level;
        while (v2 > 0) {
            let v3 = *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v1, v2 - 1);
            while (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some_and_lte(&v3, arg1)) {
                let v4 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(&v3);
                if (v4 == arg1) {
                    return 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::some(v4)
                };
                v0 = v3;
                v1 = &borrow_node<T0>(arg0, v4).nexts;
                v3 = *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v1, v2 - 1);
            };
            if (v2 == 1 && 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some(&v0)) {
                return v0
            };
            v2 = v2 - 1;
        };
        *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&arg0.head, 0)
    }

    public fun find_next<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        let v0 = find<T0>(arg0, arg1);
        if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_none(&v0)) {
            return v0
        };
        let v1 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(&v0);
        if (arg2 && v1 == arg1 || v1 > arg1) {
            return v0
        };
        *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&borrow_node<T0>(arg0, v1).nexts, 0)
    }

    public fun find_prev<T0: store>(arg0: &SkipList<T0>, arg1: u64, arg2: bool) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        let v0 = find<T0>(arg0, arg1);
        if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_none(&v0)) {
            return v0
        };
        let v1 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(&v0);
        if (arg2 && v1 == arg1 || v1 < arg1) {
            return v0
        };
        borrow_node<T0>(arg0, v1).prev
    }

    public fun head<T0: store>(arg0: &SkipList<T0>) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        if (is_empty<T0>(arg0)) {
            return 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none()
        };
        *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&arg0.head, 0)
    }

    public fun insert<T0: store>(arg0: &mut SkipList<T0>, arg1: u64, arg2: T0) {
        assert!(!contains<T0>(arg0, arg1), 0);
        let (v0, v1) = create_node<T0>(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none();
        let v4 = &mut arg0.head;
        let v5 = arg0.level;
        let v6 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::none();
        while (v5 > 0) {
            let v7 = 0x1::vector::borrow_mut<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v4, v5 - 1);
            while (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some_and_lte(v7, arg1)) {
                let v8 = 0x2::dynamic_field::borrow_mut<u64, Node<T0>>(&mut arg0.id, 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(v7));
                v3 = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::some(v8.score);
                let v9 = &mut v8.nexts;
                v7 = 0x1::vector::borrow_mut<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(v9, v5 - 1);
                v4 = v9;
            };
            if (v0 >= v5) {
                0x1::vector::push_back<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&mut v2.nexts, *v7);
                if (v5 == 1) {
                    v2.prev = v3;
                    if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some(v7)) {
                        v6 = *v7;
                    } else {
                        arg0.tail = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::some(arg1);
                    };
                };
                0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::swap_or_fill(v7, arg1);
            };
            v5 = v5 - 1;
        };
        if (0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::is_some(&v6)) {
            let v10 = borrow_mut_node<T0>(arg0, 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::borrow(&v6));
            v10.prev = 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::some(arg1);
        };
        0x1::vector::reverse<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&mut v2.nexts);
        0x2::dynamic_field::add<u64, Node<T0>>(&mut arg0.id, arg1, v2);
        arg0.size = arg0.size + 1;
    }

    public fun is_empty<T0: store>(arg0: &SkipList<T0>) : bool {
        arg0.size == 0
    }

    public fun metadata<T0: store>(arg0: &SkipList<T0>) : (vector<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>, 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64, u64, u64, u64, u64) {
        (arg0.head, arg0.tail, arg0.level, arg0.max_level, arg0.list_p, arg0.size)
    }

    public fun next_score<T0: store>(arg0: &Node<T0>) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        *0x1::vector::borrow<0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64>(&arg0.nexts, 0)
    }

    public fun prev_score<T0: store>(arg0: &Node<T0>) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        arg0.prev
    }

    fun rand_level<T0: store>(arg0: u64, arg1: &SkipList<T0>) : u64 {
        let v0 = 1;
        let v1 = arg1.list_p;
        while (arg0 % v1 == 0) {
            v1 = v1 * arg1.list_p;
            let v2 = v0 + 1;
            v0 = v2;
            if (v2 > arg1.level) {
                if (v2 >= arg1.max_level) {
                    v0 = arg1.max_level;
                    break
                } else {
                    v0 = arg1.level + 1;
                    break
                };
            };
        };
        v0
    }

    public fun tail<T0: store>(arg0: &SkipList<T0>) : 0xc3ea7e0715182ed33805e3c8f1f8eafc9968d89bf4aa688d66e6c42e716884b8::option_u64::OptionU64 {
        arg0.tail
    }

    // decompiled from Move bytecode v6
}

