module 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::priority_queue {
    struct PriorityQueue<T0: store> has store {
        entries: 0x2::table_vec::TableVec<Entry<T0>>,
    }

    struct Entry<T0: store> has drop, store {
        priority: u64,
        value: T0,
    }

    public fun length<T0: store>(arg0: &PriorityQueue<T0>) : u64 {
        0x2::table_vec::length<Entry<T0>>(&arg0.entries)
    }

    public fun insert<T0: store>(arg0: &mut PriorityQueue<T0>, arg1: u64, arg2: T0) {
        let v0 = Entry<T0>{
            priority : arg1,
            value    : arg2,
        };
        0x2::table_vec::push_back<Entry<T0>>(&mut arg0.entries, v0);
        let v1 = &mut arg0.entries;
        restore_heap_recursive<T0>(v1, 0x2::table_vec::length<Entry<T0>>(&arg0.entries) - 1);
    }

    fun max_heapify_recursive<T0: store>(arg0: &mut 0x2::table_vec::TableVec<Entry<T0>>, arg1: u64, arg2: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg2 < arg1, 1);
        let v0 = arg2 * 2 + 1;
        let v1 = v0 + 1;
        let v2 = arg2;
        if (v0 < arg1 && 0x2::table_vec::borrow<Entry<T0>>(arg0, v0).priority > 0x2::table_vec::borrow<Entry<T0>>(arg0, arg2).priority) {
            v2 = v0;
        };
        if (v1 < arg1 && 0x2::table_vec::borrow<Entry<T0>>(arg0, v1).priority > 0x2::table_vec::borrow<Entry<T0>>(arg0, v2).priority) {
            v2 = v1;
        };
        if (v2 != arg2) {
            0x2::table_vec::swap<Entry<T0>>(arg0, v2, arg2);
            max_heapify_recursive<T0>(arg0, arg1, v2);
        };
    }

    public fun new<T0: store>(arg0: 0x2::table_vec::TableVec<Entry<T0>>) : PriorityQueue<T0> {
        let v0 = 0x2::table_vec::length<Entry<T0>>(&arg0);
        let v1 = v0 / 2;
        while (v1 > 0) {
            v1 = v1 - 1;
            let v2 = &mut arg0;
            max_heapify_recursive<T0>(v2, v0, v1);
        };
        PriorityQueue<T0>{entries: arg0}
    }

    public fun new_entry<T0: store>(arg0: u64, arg1: T0) : Entry<T0> {
        Entry<T0>{
            priority : arg0,
            value    : arg1,
        }
    }

    public fun pop_max<T0: store>(arg0: &mut PriorityQueue<T0>) : (u64, T0) {
        let v0 = 0x2::table_vec::length<Entry<T0>>(&arg0.entries);
        assert!(v0 > 0, 0);
        let Entry {
            priority : v1,
            value    : v2,
        } = 0x2::table_vec::swap_remove<Entry<T0>>(&mut arg0.entries, 0);
        let v3 = &mut arg0.entries;
        max_heapify_recursive<T0>(v3, v0 - 1, 0);
        (v1, v2)
    }

    public fun priorities<T0: store>(arg0: &PriorityQueue<T0>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<Entry<T0>>(&arg0.entries)) {
            0x1::vector::push_back<u64>(&mut v0, 0x2::table_vec::borrow<Entry<T0>>(&arg0.entries, v1).priority);
            v1 = v1 + 1;
        };
        v0
    }

    fun restore_heap_recursive<T0: store>(arg0: &mut 0x2::table_vec::TableVec<Entry<T0>>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = (arg1 - 1) / 2;
        if (0x2::table_vec::borrow<Entry<T0>>(arg0, arg1).priority > 0x2::table_vec::borrow<Entry<T0>>(arg0, v0).priority) {
            0x2::table_vec::swap<Entry<T0>>(arg0, arg1, v0);
            restore_heap_recursive<T0>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v6
}

