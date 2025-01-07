module 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2 {
    public fun borrow_mut_fill<T0: copy + drop + store, T1: drop + store>(arg0: &mut 0x2::linked_table::LinkedTable<T0, T1>, arg1: T0, arg2: T1) : &mut T1 {
        if (!0x2::linked_table::contains<T0, T1>(arg0, arg1)) {
            0x2::linked_table::push_back<T0, T1>(arg0, arg1, arg2);
        };
        0x2::linked_table::borrow_mut<T0, T1>(arg0, arg1)
    }

    public fun collapse_balance<T0: copy + drop + store, T1>(arg0: 0x2::linked_table::LinkedTable<T0, 0x2::balance::Balance<T1>>) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::balance::zero<T1>();
        while (!0x2::linked_table::is_empty<T0, 0x2::balance::Balance<T1>>(&arg0)) {
            let (_, v2) = 0x2::linked_table::pop_front<T0, 0x2::balance::Balance<T1>>(&mut arg0);
            0x2::balance::join<T1>(&mut v0, v2);
        };
        0x2::linked_table::destroy_empty<T0, 0x2::balance::Balance<T1>>(arg0);
        v0
    }

    public fun keys<T0: copy + drop + store, T1: store>(arg0: &0x2::linked_table::LinkedTable<T0, T1>) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        let v1 = 0x2::linked_table::front<T0, T1>(arg0);
        while (0x1::option::is_some<T0>(v1)) {
            let v2 = *0x1::option::borrow<T0>(v1);
            0x1::vector::push_back<T0>(&mut v0, v2);
            v1 = 0x2::linked_table::next<T0, T1>(arg0, v2);
        };
        v0
    }

    public fun merge_balance<T0: copy + drop + store, T1>(arg0: &mut 0x2::linked_table::LinkedTable<T0, 0x2::balance::Balance<T1>>, arg1: T0, arg2: 0x2::balance::Balance<T1>) {
        if (0x2::linked_table::contains<T0, 0x2::balance::Balance<T1>>(arg0, arg1)) {
            0x2::balance::join<T1>(0x2::linked_table::borrow_mut<T0, 0x2::balance::Balance<T1>>(arg0, arg1), arg2);
        } else {
            0x2::linked_table::push_back<T0, 0x2::balance::Balance<T1>>(arg0, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

