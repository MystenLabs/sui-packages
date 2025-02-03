module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vec_map2 {
    public fun borrow_mut_fill<T0: copy, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: &T0, arg2: T1) : &mut T1 {
        let v0 = 0x2::vec_map::get_idx_opt<T0, T1>(arg0, arg1);
        if (!0x1::option::is_some<u64>(&v0)) {
            0x2::vec_map::insert<T0, T1>(arg0, *arg1, arg2);
        };
        0x2::vec_map::get_mut<T0, T1>(arg0, arg1)
    }

    public fun create<T0: copy, T1>(arg0: vector<T0>, arg1: vector<T1>) : 0x2::vec_map::VecMap<T0, T1> {
        assert!(0x1::vector::length<T0>(&arg0) == 0x1::vector::length<T1>(&arg1), 0);
        0x1::vector::reverse<T0>(&mut arg0);
        0x1::vector::reverse<T1>(&mut arg1);
        let v0 = 0x2::vec_map::empty<T0, T1>();
        while (0x1::vector::length<T1>(&arg1) > 0) {
            0x2::vec_map::insert<T0, T1>(&mut v0, 0x1::vector::pop_back<T0>(&mut arg0), 0x1::vector::pop_back<T1>(&mut arg1));
        };
        0x1::vector::destroy_empty<T0>(arg0);
        0x1::vector::destroy_empty<T1>(arg1);
        v0
    }

    public fun get_many<T0: copy + drop, T1: copy>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &vector<T0>) : vector<T1> {
        let v0 = 0x1::vector::empty<T1>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<T0>(arg1)) {
            0x1::vector::push_back<T1>(&mut v0, *0x2::vec_map::get<T0, T1>(arg0, 0x1::vector::borrow<T0>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_maybe<T0: copy, T1: copy>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &T0) : 0x1::option::Option<T1> {
        let v0 = 0x2::vec_map::get_idx_opt<T0, T1>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<T0, T1>(arg0, 0x1::option::destroy_some<u64>(v0));
            0x1::option::some<T1>(*v3)
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun get_with_default<T0: copy + drop, T1: copy + drop>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &T0, arg2: T1) : T1 {
        let v0 = 0x2::vec_map::get_idx_opt<T0, T1>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<T0, T1>(arg0, 0x1::option::destroy_some<u64>(v0));
            *v3
        } else {
            arg2
        }
    }

    public fun insert_maybe<T0: copy + drop, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: T0, arg2: T1) {
        if (!0x2::vec_map::contains<T0, T1>(arg0, &arg1)) {
            0x2::vec_map::insert<T0, T1>(arg0, arg1, arg2);
        };
    }

    public fun match_struct_tag_maybe<T0: copy>(arg0: &0x2::vec_map::VecMap<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, T0>, arg1: &0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag) : 0x1::option::Option<T0> {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, T0>(arg0)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, T0>(arg0, v0);
            if (0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::match(arg1, v1)) {
                return 0x1::option::some<T0>(*v2)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<T0>()
    }

    public fun merge<T0: copy, T1: copy + drop>(arg0: &mut 0x2::vec_map::VecMap<T0, vector<T1>>, arg1: &0x2::vec_map::VecMap<T0, vector<T1>>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<T0, vector<T1>>(arg1)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<T0, vector<T1>>(arg1, v0);
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge<T1>(borrow_mut_fill<T0, vector<T1>>(arg0, v1, 0x1::vector::empty<T1>()), *v2);
            v0 = v0 + 1;
        };
    }

    public fun merge_value<T0: copy + drop, T1: copy + drop>(arg0: &mut 0x2::vec_map::VecMap<T0, vector<T1>>, arg1: &T0, arg2: T1) {
        let v0 = 0x1::vector::empty<T1>();
        0x1::vector::push_back<T1>(&mut v0, arg2);
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::vector2::merge<T1>(borrow_mut_fill<T0, vector<T1>>(arg0, arg1, 0x1::vector::empty<T1>()), v0);
    }

    public fun new<T0: copy, T1>(arg0: T0, arg1: T1) : 0x2::vec_map::VecMap<T0, T1> {
        let v0 = 0x2::vec_map::empty<T0, T1>();
        0x2::vec_map::insert<T0, T1>(&mut v0, arg0, arg1);
        v0
    }

    public fun remove_entries_with_value<T0: copy + drop, T1: drop>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: &T1) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<T0, T1>(arg0)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx<T0, T1>(arg0, v0);
            if (v2 == arg1) {
                let (_, _) = 0x2::vec_map::remove_entry_by_idx<T0, T1>(arg0, v0);
                continue
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_maybe<T0: copy + drop, T1>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: &T0) : 0x1::option::Option<T1> {
        let v0 = 0x2::vec_map::get_idx_opt<T0, T1>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, v3) = 0x2::vec_map::remove_entry_by_idx<T0, T1>(arg0, 0x1::option::destroy_some<u64>(v0));
            0x1::option::some<T1>(v3)
        } else {
            0x1::option::none<T1>()
        }
    }

    public fun set<T0: copy + drop, T1>(arg0: &mut 0x2::vec_map::VecMap<T0, T1>, arg1: &T0, arg2: T1) : 0x1::option::Option<T1> {
        let v0 = 0x2::vec_map::get_idx_opt<T0, T1>(arg0, arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let (_, v3) = 0x2::vec_map::remove_entry_by_idx<T0, T1>(arg0, 0x1::option::destroy_some<u64>(v0));
            0x1::option::some<T1>(v3)
        } else {
            0x1::option::none<T1>()
        };
        0x2::vec_map::insert<T0, T1>(arg0, *arg1, arg2);
        v1
    }

    // decompiled from Move bytecode v6
}

