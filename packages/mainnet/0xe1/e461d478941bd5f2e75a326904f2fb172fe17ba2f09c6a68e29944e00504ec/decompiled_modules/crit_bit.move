module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::crit_bit {
    struct CB<T0> has store {
        r: u64,
        i: vector<I>,
        o: vector<O<T0>>,
    }

    struct I has store {
        c: u8,
        p: u64,
        l: u64,
        r: u64,
    }

    struct O<T0> has store {
        k: u128,
        v: T0,
        p: u64,
    }

    public fun empty<T0>() : CB<T0> {
        CB<T0>{
            r : 0,
            i : 0x1::vector::empty<I>(),
            o : 0x1::vector::empty<O<T0>>(),
        }
    }

    public fun length<T0>(arg0: &CB<T0>) : u64 {
        0x1::vector::length<O<T0>>(&arg0.o)
    }

    public fun borrow<T0>(arg0: &CB<T0>, arg1: u128) : &T0 {
        assert!(!is_empty<T0>(arg0), 3);
        let v0 = b_s_o<T0>(arg0, arg1);
        assert!(v0.k == arg1, 4);
        &v0.v
    }

    public fun borrow_mut<T0>(arg0: &mut CB<T0>, arg1: u128) : &mut T0 {
        assert!(!is_empty<T0>(arg0), 3);
        let v0 = b_s_o_m<T0>(arg0, arg1);
        assert!(v0.k == arg1, 4);
        &mut v0.v
    }

    public fun destroy_empty<T0>(arg0: CB<T0>) {
        assert!(is_empty<T0>(&arg0), 1);
        let CB {
            r : _,
            i : v1,
            o : v2,
        } = arg0;
        0x1::vector::destroy_empty<I>(v1);
        0x1::vector::destroy_empty<O<T0>>(v2);
    }

    public fun is_empty<T0>(arg0: &CB<T0>) : bool {
        0x1::vector::is_empty<O<T0>>(&arg0.o)
    }

    fun crit_bit(arg0: u128, arg1: u128) : u8 {
        let v0 = 0;
        let v1 = 127;
        let v2;
        loop {
            v2 = (v0 + v1) / 2;
            let v3 = (arg0 ^ arg1) >> v2;
            if (v3 == 1) {
                break
            };
            if (v3 > 1) {
                v0 = v2 + 1;
                continue
            };
            v1 = v2 - 1;
        };
        v2
    }

    fun b_s_o<T0>(arg0: &CB<T0>, arg1: u128) : &O<T0> {
        if (is_out(arg0.r)) {
            return 0x1::vector::borrow<O<T0>>(&arg0.o, o_v(arg0.r))
        };
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg0.r);
        let v1;
        loop {
            if (is_set(arg1, v0.c)) {
                v1 = v0.r;
            } else {
                v1 = v0.l;
            };
            if (is_out(v1)) {
                break
            };
            v0 = 0x1::vector::borrow<I>(&arg0.i, v1);
        };
        0x1::vector::borrow<O<T0>>(&arg0.o, o_v(v1))
    }

    fun b_s_o_m<T0>(arg0: &mut CB<T0>, arg1: u128) : &mut O<T0> {
        if (is_out(arg0.r)) {
            return 0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(arg0.r))
        };
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg0.r);
        let v1;
        loop {
            if (is_set(arg1, v0.c)) {
                v1 = v0.r;
            } else {
                v1 = v0.l;
            };
            if (is_out(v1)) {
                break
            };
            v0 = 0x1::vector::borrow<I>(&arg0.i, v1);
        };
        0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(v1))
    }

    fun check_len(arg0: u64) {
        assert!(arg0 < 18446744073709551615 ^ 1 << 63, 5);
    }

    public fun has_key<T0>(arg0: &CB<T0>, arg1: u128) : bool {
        if (is_empty<T0>(arg0)) {
            return false
        };
        b_s_o<T0>(arg0, arg1).k == arg1
    }

    public fun insert<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0) {
        let v0 = length<T0>(arg0);
        check_len(v0);
        if (v0 == 0) {
            insert_empty<T0>(arg0, arg1, arg2);
        } else if (v0 == 1) {
            insert_singleton<T0>(arg0, arg1, arg2);
        } else {
            insert_general<T0>(arg0, arg1, arg2, v0);
        };
    }

    fun insert_above<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64, arg4: u64, arg5: u64, arg6: u8) {
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg5).p;
        loop {
            if (v0 == 18446744073709551615) {
                break
            };
            let v1 = 0x1::vector::borrow_mut<I>(&mut arg0.i, v0);
            if (arg6 < v1.c) {
                insert_below_walk<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg6);
                return
            };
            v0 = v1.p;
        };
        insert_above_root<T0>(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    fun insert_above_root<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = arg0.r;
        0x1::vector::borrow_mut<I>(&mut arg0.i, v0).p = arg4;
        arg0.r = arg4;
        push_back_insert_nodes<T0>(arg0, arg1, arg2, arg4, arg5, 18446744073709551615, is_set(arg1, arg5), v0, o_c(arg3));
    }

    fun insert_below<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u128, arg8: u64, arg9: u8) {
        if (arg6 == true) {
            0x1::vector::borrow_mut<I>(&mut arg0.i, arg8).l = arg4;
        } else {
            0x1::vector::borrow_mut<I>(&mut arg0.i, arg8).r = arg4;
        };
        0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(arg5)).p = arg4;
        push_back_insert_nodes<T0>(arg0, arg1, arg2, arg4, arg9, arg8, arg1 < arg7, o_c(arg3), arg5);
    }

    fun insert_below_walk<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64, arg4: u64, arg5: u64, arg6: u8) {
        let v0 = 0x1::vector::borrow_mut<I>(&mut arg0.i, arg5);
        let (v1, v2) = if (is_set(arg1, v0.c)) {
            (false, v0.r)
        } else {
            (true, v0.l)
        };
        if (v1 == true) {
            v0.l = arg4;
        } else {
            v0.r = arg4;
        };
        0x1::vector::borrow_mut<I>(&mut arg0.i, v2).p = arg4;
        push_back_insert_nodes<T0>(arg0, arg1, arg2, arg4, arg6, arg5, is_set(arg1, arg6), v2, o_c(arg3));
    }

    fun insert_empty<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0) {
        let v0 = O<T0>{
            k : arg1,
            v : arg2,
            p : 18446744073709551615,
        };
        0x1::vector::push_back<O<T0>>(&mut arg0.o, v0);
        arg0.r = 1 << 63;
    }

    fun insert_general<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64) {
        let v0 = 0x1::vector::length<I>(&arg0.i);
        let (v1, v2, v3, v4, v5) = search_outer<T0>(arg0, arg1);
        assert!(v3 != arg1, 2);
        let v6 = crit_bit(v3, arg1);
        if (v6 < v5) {
            insert_below<T0>(arg0, arg1, arg2, arg3, v0, v1, v2, v3, v4, v6);
        } else {
            insert_above<T0>(arg0, arg1, arg2, arg3, v0, v4, v6);
        };
    }

    fun insert_singleton<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0) {
        let v0 = 0x1::vector::borrow<O<T0>>(&arg0.o, 0);
        assert!(arg1 != v0.k, 2);
        push_back_insert_nodes<T0>(arg0, arg1, arg2, 0, crit_bit(v0.k, arg1), 18446744073709551615, arg1 > v0.k, o_c(0), o_c(1));
        arg0.r = 0;
        0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, 0).p = 0;
    }

    fun is_out(arg0: u64) : bool {
        arg0 >> 63 & 1 == 1
    }

    fun is_set(arg0: u128, arg1: u8) : bool {
        arg0 >> arg1 & 1 == 1
    }

    public fun max_key<T0>(arg0: &CB<T0>) : u128 {
        assert!(!is_empty<T0>(arg0), 7);
        0x1::vector::borrow<O<T0>>(&arg0.o, o_v(max_node_c_i<T0>(arg0))).k
    }

    fun max_node_c_i<T0>(arg0: &CB<T0>) : u64 {
        let v0 = arg0.r;
        loop {
            if (is_out(v0)) {
                break
            };
            let v1 = &0x1::vector::borrow<I>(&arg0.i, v0).r;
            v0 = *v1;
        };
        v0
    }

    public fun min_key<T0>(arg0: &CB<T0>) : u128 {
        assert!(!is_empty<T0>(arg0), 7);
        0x1::vector::borrow<O<T0>>(&arg0.o, o_v(min_node_c_i<T0>(arg0))).k
    }

    fun min_node_c_i<T0>(arg0: &CB<T0>) : u64 {
        let v0 = arg0.r;
        loop {
            if (is_out(v0)) {
                break
            };
            let v1 = &0x1::vector::borrow<I>(&arg0.i, v0).l;
            v0 = *v1;
        };
        v0
    }

    fun o_c(arg0: u64) : u64 {
        arg0 | 1 << 63
    }

    fun o_v(arg0: u64) : u64 {
        arg0 & 18446744073709551615 ^ 1 << 63
    }

    public fun pop<T0>(arg0: &mut CB<T0>, arg1: u128) : T0 {
        assert!(!is_empty<T0>(arg0), 6);
        let v0 = length<T0>(arg0);
        if (v0 == 1) {
            pop_singleton<T0>(arg0, arg1)
        } else {
            pop_general<T0>(arg0, arg1, v0)
        }
    }

    fun pop_destroy_nodes<T0>(arg0: &mut CB<T0>, arg1: u64, arg2: u64, arg3: u64) : T0 {
        let v0 = 0x1::vector::length<I>(&arg0.i);
        let I {
            c : _,
            p : _,
            l : _,
            r : _,
        } = 0x1::vector::swap_remove<I>(&mut arg0.i, arg1);
        if (arg1 < v0 - 1) {
            stitch_swap_remove<T0>(arg0, arg1, v0);
        };
        let O {
            k : _,
            v : v6,
            p : _,
        } = 0x1::vector::swap_remove<O<T0>>(&mut arg0.o, o_v(arg2));
        if (o_v(arg2) < arg3 - 1) {
            stitch_swap_remove<T0>(arg0, arg2, arg3);
        };
        v6
    }

    fun pop_general<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64) : T0 {
        let (v0, v1, v2, v3, _) = search_outer<T0>(arg0, arg1);
        assert!(v2 == arg1, 4);
        pop_update_relationships<T0>(arg0, v1, v3);
        pop_destroy_nodes<T0>(arg0, v3, v0, arg2)
    }

    fun pop_singleton<T0>(arg0: &mut CB<T0>, arg1: u128) : T0 {
        assert!(0x1::vector::borrow<O<T0>>(&arg0.o, 0).k == arg1, 4);
        arg0.r = 0;
        let O {
            k : _,
            v : v1,
            p : _,
        } = 0x1::vector::pop_back<O<T0>>(&mut arg0.o);
        v1
    }

    fun pop_update_relationships<T0>(arg0: &mut CB<T0>, arg1: bool, arg2: u64) {
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg2);
        let v1 = if (arg1 == true) {
            v0.r
        } else {
            v0.l
        };
        let v2 = v0.p;
        if (is_out(v1)) {
            0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(v1)).p = v2;
        } else {
            0x1::vector::borrow_mut<I>(&mut arg0.i, v1).p = v2;
        };
        if (v2 == 18446744073709551615) {
            arg0.r = v1;
        } else {
            let v3 = 0x1::vector::borrow_mut<I>(&mut arg0.i, v2);
            if (v3.l == arg2) {
                v3.l = v1;
            } else {
                v3.r = v1;
            };
        };
    }

    fun push_back_insert_nodes<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: T0, arg3: u64, arg4: u8, arg5: u64, arg6: bool, arg7: u64, arg8: u64) {
        let (v0, v1) = if (arg6) {
            (arg7, arg8)
        } else {
            (arg8, arg7)
        };
        let v2 = O<T0>{
            k : arg1,
            v : arg2,
            p : arg3,
        };
        0x1::vector::push_back<O<T0>>(&mut arg0.o, v2);
        let v3 = I{
            c : arg4,
            p : arg5,
            l : v0,
            r : v1,
        };
        0x1::vector::push_back<I>(&mut arg0.i, v3);
    }

    fun search_outer<T0>(arg0: &CB<T0>, arg1: u128) : (u64, bool, u128, u64, u8) {
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg0.r);
        let v1;
        let v2;
        loop {
            if (is_set(arg1, v0.c)) {
                v1 = false;
                v2 = v0.r;
            } else {
                v1 = true;
                v2 = v0.l;
            };
            if (is_out(v2)) {
                break
            };
            v0 = 0x1::vector::borrow<I>(&arg0.i, v2);
        };
        let v3 = 0x1::vector::borrow<O<T0>>(&arg0.o, o_v(v2));
        (v2, v1, v3.k, v3.p, v0.c)
    }

    public fun singleton<T0>(arg0: u128, arg1: T0) : CB<T0> {
        let v0 = CB<T0>{
            r : 0,
            i : 0x1::vector::empty<I>(),
            o : 0x1::vector::empty<O<T0>>(),
        };
        let v1 = &mut v0;
        insert_empty<T0>(v1, arg0, arg1);
        v0
    }

    fun stitch_child_of_parent<T0>(arg0: &mut CB<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::borrow_mut<I>(&mut arg0.i, arg2);
        if (v0.l == arg3) {
            v0.l = arg1;
        } else {
            v0.r = arg1;
        };
    }

    fun stitch_parent_of_child<T0>(arg0: &mut CB<T0>, arg1: u64, arg2: u64) {
        if (is_out(arg2)) {
            0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(arg2)).p = arg1;
        } else {
            0x1::vector::borrow_mut<I>(&mut arg0.i, arg2).p = arg1;
        };
    }

    fun stitch_swap_remove<T0>(arg0: &mut CB<T0>, arg1: u64, arg2: u64) {
        if (is_out(arg1)) {
            let v0 = 0x1::vector::borrow<O<T0>>(&arg0.o, o_v(arg1)).p;
            if (v0 == 18446744073709551615) {
                arg0.r = arg1;
                return
            };
            stitch_child_of_parent<T0>(arg0, arg1, v0, o_c(arg2 - 1));
        } else {
            let v1 = 0x1::vector::borrow<I>(&arg0.i, arg1);
            let v2 = v1.p;
            stitch_parent_of_child<T0>(arg0, arg1, v1.l);
            stitch_parent_of_child<T0>(arg0, arg1, v1.r);
            if (v2 == 18446744073709551615) {
                arg0.r = arg1;
                return
            };
            stitch_child_of_parent<T0>(arg0, arg1, v2, arg2 - 1);
        };
    }

    fun traverse_c_i<T0>(arg0: &CB<T0>, arg1: u128, arg2: u64, arg3: bool) : u64 {
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg2);
        while (arg3 != is_set(arg1, v0.c)) {
            let v1 = v0.p;
            v0 = 0x1::vector::borrow<I>(&arg0.i, v1);
        };
        let v2 = if (arg3 == true) {
            v0.l
        } else {
            v0.r
        };
        let v3 = v2;
        while (!is_out(v3)) {
            let v4 = if (arg3 == true) {
                0x1::vector::borrow<I>(&arg0.i, v3).r
            } else {
                0x1::vector::borrow<I>(&arg0.i, v3).l
            };
            v3 = v4;
        };
        v3
    }

    public fun traverse_end_pop<T0>(arg0: &mut CB<T0>, arg1: u64, arg2: u64, arg3: u64) : T0 {
        if (arg3 == 1) {
            arg0.r = 0;
            let O {
                k : _,
                v : v2,
                p : _,
            } = 0x1::vector::pop_back<O<T0>>(&mut arg0.o);
            v2
        } else {
            let v4 = 0x1::vector::borrow<I>(&arg0.i, arg1).l == arg2;
            pop_update_relationships<T0>(arg0, v4, arg1);
            pop_destroy_nodes<T0>(arg0, arg1, arg2, arg3)
        }
    }

    public fun traverse_init_mut<T0>(arg0: &mut CB<T0>, arg1: bool) : (u128, &mut T0, u64, u64) {
        let v0 = if (arg1 == true) {
            max_node_c_i<T0>(arg0)
        } else {
            min_node_c_i<T0>(arg0)
        };
        let v1 = 0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(v0));
        (v1.k, &mut v1.v, v1.p, v0)
    }

    public fun traverse_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64, arg3: bool) : (u128, &mut T0, u64, u64) {
        let v0 = traverse_c_i<T0>(arg0, arg1, arg2, arg3);
        let v1 = 0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(v0));
        (v1.k, &mut v1.v, v1.p, v0)
    }

    public fun traverse_p_init_mut<T0>(arg0: &mut CB<T0>) : (u128, &mut T0, u64, u64) {
        traverse_init_mut<T0>(arg0, true)
    }

    public fun traverse_p_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64) : (u128, &mut T0, u64, u64) {
        traverse_mut<T0>(arg0, arg1, arg2, true)
    }

    public fun traverse_p_pop_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : (u128, &mut T0, u64, u64, T0) {
        traverse_pop_mut<T0>(arg0, arg1, arg2, arg3, arg4, true)
    }

    public fun traverse_pop_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: bool) : (u128, &mut T0, u64, u64, T0) {
        let v0 = 0x1::vector::borrow<I>(&arg0.i, arg2).l == arg3;
        let v1 = traverse_c_i<T0>(arg0, arg1, arg2, arg5);
        let v2 = v1;
        pop_update_relationships<T0>(arg0, v0, arg2);
        let v3 = pop_destroy_nodes<T0>(arg0, arg2, arg3, arg4);
        if (o_v(v1) == arg4 - 1) {
            v2 = arg3;
        };
        let v4 = 0x1::vector::borrow_mut<O<T0>>(&mut arg0.o, o_v(v2));
        (v4.k, &mut v4.v, v4.p, v2, v3)
    }

    public fun traverse_s_init_mut<T0>(arg0: &mut CB<T0>) : (u128, &mut T0, u64, u64) {
        traverse_init_mut<T0>(arg0, false)
    }

    public fun traverse_s_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64) : (u128, &mut T0, u64, u64) {
        traverse_mut<T0>(arg0, arg1, arg2, false)
    }

    public fun traverse_s_pop_mut<T0>(arg0: &mut CB<T0>, arg1: u128, arg2: u64, arg3: u64, arg4: u64) : (u128, &mut T0, u64, u64, T0) {
        traverse_pop_mut<T0>(arg0, arg1, arg2, arg3, arg4, false)
    }

    // decompiled from Move bytecode v6
}

