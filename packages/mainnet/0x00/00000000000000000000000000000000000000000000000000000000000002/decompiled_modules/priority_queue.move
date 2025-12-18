module 0x2::priority_queue {
    struct PriorityQueue<T0: drop> has drop, store {
        entries: vector<Entry<T0>>,
    }

    struct Entry<T0: drop> has drop, store {
        priority: u64,
        value: T0,
    }

    public fun create_entries<T0: drop>(arg0: vector<u64>, arg1: vector<T0>) : vector<Entry<T0>> {
        assert!(0x1::vector::length<T0>(&arg1) == 0x1::vector::length<u64>(&arg0), 1);
        let v0 = 0x1::vector::empty<Entry<T0>>();
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<T0>(&arg1), 13906834470696124415);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = Entry<T0>{
                priority : 0x1::vector::pop_back<u64>(&mut arg0),
                value    : 0x1::vector::pop_back<T0>(&mut arg1),
            };
            0x1::vector::push_back<Entry<T0>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        0x1::vector::reverse<Entry<T0>>(&mut v0);
        v0
    }

    public fun insert<T0: drop>(arg0: &mut PriorityQueue<T0>, arg1: u64, arg2: T0) {
        let v0 = Entry<T0>{
            priority : arg1,
            value    : arg2,
        };
        0x1::vector::push_back<Entry<T0>>(&mut arg0.entries, v0);
        let v1 = &mut arg0.entries;
        restore_heap_recursive<T0>(v1, 0x1::vector::length<Entry<T0>>(&arg0.entries) - 1);
    }

    fun max_heapify_recursive<T0: drop>(arg0: &mut vector<Entry<T0>>, arg1: u64, arg2: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg2 < arg1, 2);
        let v0 = arg2 * 2 + 1;
        let v1 = v0 + 1;
        let v2 = arg2;
        if (v0 < arg1 && 0x1::vector::borrow<Entry<T0>>(arg0, v0).priority > 0x1::vector::borrow<Entry<T0>>(arg0, arg2).priority) {
            v2 = v0;
        };
        if (v1 < arg1 && 0x1::vector::borrow<Entry<T0>>(arg0, v1).priority > 0x1::vector::borrow<Entry<T0>>(arg0, v2).priority) {
            v2 = v1;
        };
        if (v2 != arg2) {
            0x1::vector::swap<Entry<T0>>(arg0, v2, arg2);
            max_heapify_recursive<T0>(arg0, arg1, v2);
        };
    }

    public fun new<T0: drop>(arg0: vector<Entry<T0>>) : PriorityQueue<T0> {
        let v0 = 0x1::vector::length<Entry<T0>>(&arg0);
        let v1 = v0 / 2;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = &mut arg0;
            max_heapify_recursive<T0>(v2, v0, v1);
        };
        PriorityQueue<T0>{entries: arg0}
    }

    public fun new_entry<T0: drop>(arg0: u64, arg1: T0) : Entry<T0> {
        Entry<T0>{
            priority : arg0,
            value    : arg1,
        }
    }

    public fun pop_max<T0: drop>(arg0: &mut PriorityQueue<T0>) : (u64, T0) {
        let v0 = 0x1::vector::length<Entry<T0>>(&arg0.entries);
        assert!(v0 > 0, 0);
        let Entry {
            priority : v1,
            value    : v2,
        } = 0x1::vector::swap_remove<Entry<T0>>(&mut arg0.entries, 0);
        let v3 = &mut arg0.entries;
        max_heapify_recursive<T0>(v3, v0 - 1, 0);
        (v1, v2)
    }

    public fun priorities<T0: drop>(arg0: &PriorityQueue<T0>) : vector<u64> {
        let v0 = &arg0.entries;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Entry<T0>>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<Entry<T0>>(v0, v2).priority);
            v2 = v2 + 1;
        };
        v1
    }

    fun restore_heap_recursive<T0: drop>(arg0: &mut vector<Entry<T0>>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = (arg1 - 1) / 2;
        if (0x1::vector::borrow<Entry<T0>>(arg0, arg1).priority > 0x1::vector::borrow<Entry<T0>>(arg0, v0).priority) {
            0x1::vector::swap<Entry<T0>>(arg0, arg1, v0);
            restore_heap_recursive<T0>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v6
}

