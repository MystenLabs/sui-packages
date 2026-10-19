module 0xcb85a942317994b3f7ee03a7944098bcfc6a585af5b2cbb651884d9afea5dfa5::position_book {
    struct Book<T0: store> has store {
        entries: 0x2::table::Table<u64, Entry<T0>>,
        longs: vector<u64>,
        shorts: vector<u64>,
    }

    struct Entry<T0: store> has store {
        value: T0,
        long: bool,
        trigger: u64,
        index: u64,
    }

    public fun length<T0: store>(arg0: &Book<T0>) : u64 {
        0x2::table::length<u64, Entry<T0>>(&arg0.entries)
    }

    public fun borrow<T0: store>(arg0: &Book<T0>, arg1: u64) : &T0 {
        &0x2::table::borrow<u64, Entry<T0>>(&arg0.entries, arg1).value
    }

    public fun destroy_empty<T0: store>(arg0: Book<T0>) {
        let Book {
            entries : v0,
            longs   : v1,
            shorts  : v2,
        } = arg0;
        0x2::table::destroy_empty<u64, Entry<T0>>(v0);
        0x1::vector::destroy_empty<u64>(v1);
        0x1::vector::destroy_empty<u64>(v2);
    }

    fun swap<T0: store>(arg0: &mut Book<T0>, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), arg2);
        let v1 = *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), arg3);
        let v2 = heap_mut<T0>(arg0, arg1);
        0x1::vector::swap<u64>(v2, arg2, arg3);
        0x2::table::borrow_mut<u64, Entry<T0>>(&mut arg0.entries, v0).index = arg3;
        0x2::table::borrow_mut<u64, Entry<T0>>(&mut arg0.entries, v1).index = arg2;
    }

    public fun contains<T0: store>(arg0: &Book<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, Entry<T0>>(&arg0.entries, arg1)
    }

    public fun new<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : Book<T0> {
        Book<T0>{
            entries : 0x2::table::new<u64, Entry<T0>>(arg0),
            longs   : vector[],
            shorts  : vector[],
        }
    }

    public fun remove<T0: store>(arg0: &mut Book<T0>, arg1: u64) : T0 {
        assert!(0x2::table::contains<u64, Entry<T0>>(&arg0.entries, arg1), 1);
        let Entry {
            value   : v0,
            long    : v1,
            trigger : _,
            index   : v3,
        } = 0x2::table::remove<u64, Entry<T0>>(&mut arg0.entries, arg1);
        let v4 = heap_mut<T0>(arg0, v1);
        assert!(0x1::vector::swap_remove<u64>(v4, v3) == arg1, 1);
        if (v3 < 0x1::vector::length<u64>(heap<T0>(arg0, v1))) {
            0x2::table::borrow_mut<u64, Entry<T0>>(&mut arg0.entries, *0x1::vector::borrow<u64>(heap<T0>(arg0, v1), v3)).index = v3;
            let v5 = up<T0>(arg0, v1, v3);
            down<T0>(arg0, v1, v5);
        };
        v0
    }

    fun before<T0: store>(arg0: &Book<T0>, arg1: u64, arg2: u64, arg3: bool) : bool {
        let v0 = 0x2::table::borrow<u64, Entry<T0>>(&arg0.entries, arg1).trigger;
        let v1 = 0x2::table::borrow<u64, Entry<T0>>(&arg0.entries, arg2).trigger;
        v0 == v1 && arg1 < arg2 || arg3 && v0 > v1 || v0 < v1
    }

    fun down<T0: store>(arg0: &mut Book<T0>, arg1: bool, arg2: u64) {
        let v0 = 0x1::vector::length<u64>(heap<T0>(arg0, arg1));
        while (2 * arg2 + 1 < v0) {
            let v1 = 2 * arg2 + 1;
            let v2 = v1;
            if (v1 + 1 < v0 && before<T0>(arg0, *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), v1 + 1), *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), v1), arg1)) {
                v2 = v1 + 1;
            };
            if (!before<T0>(arg0, *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), v2), *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), arg2), arg1)) {
                break
            };
            swap<T0>(arg0, arg1, arg2, v2);
            arg2 = v2;
        };
    }

    fun heap<T0: store>(arg0: &Book<T0>, arg1: bool) : &vector<u64> {
        if (arg1) {
            &arg0.longs
        } else {
            &arg0.shorts
        }
    }

    fun heap_mut<T0: store>(arg0: &mut Book<T0>, arg1: bool) : &mut vector<u64> {
        if (arg1) {
            &mut arg0.longs
        } else {
            &mut arg0.shorts
        }
    }

    public fun insert<T0: store>(arg0: &mut Book<T0>, arg1: u64, arg2: T0, arg3: bool, arg4: u64) {
        assert!(length<T0>(arg0) < 10000, 0);
        let v0 = 0x1::vector::length<u64>(heap<T0>(arg0, arg3));
        let v1 = Entry<T0>{
            value   : arg2,
            long    : arg3,
            trigger : arg4,
            index   : v0,
        };
        0x2::table::add<u64, Entry<T0>>(&mut arg0.entries, arg1, v1);
        let v2 = heap_mut<T0>(arg0, arg3);
        0x1::vector::push_back<u64>(v2, arg1);
        up<T0>(arg0, arg3, v0);
    }

    public fun next_liquidatable<T0: store>(arg0: &Book<T0>, arg1: u64, arg2: bool) : 0x1::option::Option<u64> {
        let v0 = heap<T0>(arg0, arg2);
        if (0x1::vector::is_empty<u64>(v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = *0x1::vector::borrow<u64>(v0, 0);
        if (arg2 && arg1 <= 0x2::table::borrow<u64, Entry<T0>>(&arg0.entries, v1).trigger || arg1 >= 0x2::table::borrow<u64, Entry<T0>>(&arg0.entries, v1).trigger) {
            0x1::option::some<u64>(v1)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun up<T0: store>(arg0: &mut Book<T0>, arg1: bool, arg2: u64) : u64 {
        let v0 = arg2;
        while (v0 > 0) {
            let v1 = (v0 - 1) / 2;
            if (!before<T0>(arg0, *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), arg2), *0x1::vector::borrow<u64>(heap<T0>(arg0, arg1), v1), arg1)) {
                break
            };
            swap<T0>(arg0, arg1, arg2, v1);
            v0 = v1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

