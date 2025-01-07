module 0x4feb1cc1b680fb7ab5fea5bad6595ccd5b53bad6ba7e96f6de7fcdbd21d491c9::big_queue {
    struct BigQueue<T0: store> has store {
        length: u64,
        max_slice_size: u64,
        next_id: u64,
        head: 0x1::option::Option<vector<T0>>,
        tail: 0x1::option::Option<vector<T0>>,
        spill: 0x2::linked_table::LinkedTable<NodeRef, vector<T0>>,
    }

    struct NodeRef has copy, drop, store {
        id: u64,
    }

    public fun length<T0: store>(arg0: &BigQueue<T0>) : u64 {
        arg0.length
    }

    public fun push_back<T0: store>(arg0: &mut BigQueue<T0>, arg1: T0) {
        ensure_tail<T0>(arg0);
        arg0.length = arg0.length + 1;
        0x1::vector::push_back<T0>(0x1::option::borrow_mut<vector<T0>>(&mut arg0.tail), arg1);
    }

    public fun destroy_empty<T0: store>(arg0: BigQueue<T0>) {
        let BigQueue {
            length         : v0,
            max_slice_size : _,
            next_id        : _,
            head           : v3,
            tail           : v4,
            spill          : v5,
        } = arg0;
        assert!(v0 == 0, 0);
        0x1::vector::destroy_empty<T0>(0x1::option::destroy_some<vector<T0>>(v3));
        0x1::vector::destroy_empty<T0>(0x1::option::destroy_some<vector<T0>>(v4));
        0x2::linked_table::destroy_empty<NodeRef, vector<T0>>(v5);
    }

    public fun is_empty<T0: store>(arg0: &BigQueue<T0>) : bool {
        arg0.length == 0
    }

    public fun drop<T0: drop + store>(arg0: BigQueue<T0>) {
        let BigQueue {
            length         : _,
            max_slice_size : _,
            next_id        : _,
            head           : _,
            tail           : _,
            spill          : v5,
        } = arg0;
        0x2::linked_table::drop<NodeRef, vector<T0>>(v5);
    }

    public fun new<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BigQueue<T0> {
        assert!(0 < arg0, 2);
        assert!(arg0 <= 262144, 3);
        BigQueue<T0>{
            length         : 0,
            max_slice_size : arg0,
            next_id        : 0,
            head           : 0x1::option::some<vector<T0>>(0x1::vector::empty<T0>()),
            tail           : 0x1::option::some<vector<T0>>(0x1::vector::empty<T0>()),
            spill          : 0x2::linked_table::new<NodeRef, vector<T0>>(arg1),
        }
    }

    public fun pop_front<T0: store>(arg0: &mut BigQueue<T0>) : T0 {
        assert!(arg0.length > 0, 1);
        ensure_head<T0>(arg0);
        arg0.length = arg0.length - 1;
        0x1::vector::pop_back<T0>(0x1::option::borrow_mut<vector<T0>>(&mut arg0.head))
    }

    fun ensure_head<T0: store>(arg0: &mut BigQueue<T0>) {
        if (!0x1::vector::is_empty<T0>(0x1::option::borrow<vector<T0>>(&arg0.head))) {
            return
        };
        let v0 = if (0x2::linked_table::is_empty<NodeRef, vector<T0>>(&arg0.spill)) {
            take_tail<T0>(arg0)
        } else {
            let (_, v2) = 0x2::linked_table::pop_front<NodeRef, vector<T0>>(&mut arg0.spill);
            v2
        };
        let v3 = v0;
        0x1::vector::reverse<T0>(&mut v3);
        0x1::vector::destroy_empty<T0>(0x1::option::swap<vector<T0>>(&mut arg0.head, v3));
    }

    fun ensure_tail<T0: store>(arg0: &mut BigQueue<T0>) {
        if (0x1::vector::length<T0>(0x1::option::borrow<vector<T0>>(&arg0.tail)) < arg0.max_slice_size) {
            return
        };
        let v0 = take_tail<T0>(arg0);
        arg0.next_id = arg0.next_id + 1;
        let v1 = NodeRef{id: arg0.next_id};
        0x2::linked_table::push_back<NodeRef, vector<T0>>(&mut arg0.spill, v1, v0);
    }

    public fun nth<T0: store>(arg0: &BigQueue<T0>, arg1: u64) : &T0 {
        assert!(arg1 < arg0.length, 1);
        let v0 = 0x1::option::borrow<vector<T0>>(&arg0.head);
        let v1 = 0x1::vector::length<T0>(v0);
        if (arg1 < v1) {
            return 0x1::vector::borrow<T0>(v0, v1 - 1 - arg1)
        };
        let v2 = arg1 - v1;
        let v3 = 0x2::linked_table::length<NodeRef, vector<T0>>(&arg0.spill) * arg0.max_slice_size;
        if (v2 < v3) {
            let v4 = NodeRef{id: 0x1::option::borrow<NodeRef>(0x2::linked_table::front<NodeRef, vector<T0>>(&arg0.spill)).id + v2 / arg0.max_slice_size};
            return 0x1::vector::borrow<T0>(0x2::linked_table::borrow<NodeRef, vector<T0>>(&arg0.spill, v4), v2 % arg0.max_slice_size)
        };
        0x1::vector::borrow<T0>(0x1::option::borrow<vector<T0>>(&arg0.tail), v2 - v3)
    }

    public fun nth_mut<T0: store>(arg0: &mut BigQueue<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < arg0.length, 1);
        let v0 = 0x1::option::borrow_mut<vector<T0>>(&mut arg0.head);
        let v1 = 0x1::vector::length<T0>(v0);
        if (arg1 < v1) {
            return 0x1::vector::borrow_mut<T0>(v0, v1 - 1 - arg1)
        };
        let v2 = arg1 - v1;
        let v3 = 0x2::linked_table::length<NodeRef, vector<T0>>(&arg0.spill) * arg0.max_slice_size;
        if (v2 < v3) {
            let v4 = NodeRef{id: 0x1::option::borrow<NodeRef>(0x2::linked_table::front<NodeRef, vector<T0>>(&arg0.spill)).id + v2 / arg0.max_slice_size};
            return 0x1::vector::borrow_mut<T0>(0x2::linked_table::borrow_mut<NodeRef, vector<T0>>(&mut arg0.spill, v4), v2 % arg0.max_slice_size)
        };
        0x1::vector::borrow_mut<T0>(0x1::option::borrow_mut<vector<T0>>(&mut arg0.tail), v2 - v3)
    }

    public fun peek_front<T0: store>(arg0: &BigQueue<T0>) : &T0 {
        nth<T0>(arg0, 0)
    }

    public fun peek_front_mut<T0: store>(arg0: &mut BigQueue<T0>) : &mut T0 {
        nth_mut<T0>(arg0, 0)
    }

    fun take_tail<T0: store>(arg0: &mut BigQueue<T0>) : vector<T0> {
        let v0 = 0x1::option::swap<vector<T0>>(&mut arg0.tail, 0x1::vector::empty<T0>());
        assert!(!0x1::vector::is_empty<T0>(&v0), 4);
        v0
    }

    // decompiled from Move bytecode v6
}

