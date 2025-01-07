module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::dynamic_vector {
    struct DynVec<T0> has store {
        vec_0: vector<T0>,
        vecs: 0x2::object::UID,
        current_chunk: u64,
        tip_length: u64,
        total_length: u64,
        limit: u64,
    }

    public fun empty<T0: store>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : DynVec<T0> {
        DynVec<T0>{
            vec_0         : 0x1::vector::empty<T0>(),
            vecs          : 0x2::object::new(arg1),
            current_chunk : 0,
            tip_length    : 0,
            total_length  : 0,
            limit         : arg0,
        }
    }

    public fun push_back<T0: store>(arg0: &mut DynVec<T0>, arg1: T0) {
        if (arg0.tip_length == arg0.limit) {
            insert_chunk<T0>(arg0, arg1);
        } else {
            push_element_to_chunk<T0>(arg0, arg1);
        };
    }

    public fun pop_back<T0: store>(arg0: &mut DynVec<T0>) : T0 {
        assert!(arg0.tip_length != 0, 0);
        if (arg0.tip_length == 1) {
            remove_chunk<T0>(arg0)
        } else {
            pop_element_from_chunk<T0>(arg0)
        }
    }

    public fun singleton<T0: store>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : DynVec<T0> {
        let v0 = empty<T0>(arg1, arg2);
        let v1 = &mut v0;
        push_back<T0>(v1, arg0);
        v0
    }

    public fun delete<T0: store>(arg0: DynVec<T0>) {
        let DynVec {
            vec_0         : v0,
            vecs          : v1,
            current_chunk : _,
            tip_length    : _,
            total_length  : _,
            limit         : _,
        } = arg0;
        0x1::vector::destroy_empty<T0>(v0);
        0x2::object::delete(v1);
    }

    public fun borrow_at_index<T0: store>(arg0: &mut DynVec<T0>, arg1: u64) : &T0 {
        assert!(arg0.total_length > 0, 1);
        assert!(arg1 < arg0.total_length, 3);
        let (v0, v1) = chunk_index<T0>(arg0, arg1);
        0x1::vector::borrow<T0>(borrow_chunk<T0>(arg0, v0), v1)
    }

    public fun borrow_chunk<T0: store>(arg0: &DynVec<T0>, arg1: u64) : &vector<T0> {
        if (arg1 == 0) {
            &arg0.vec_0
        } else {
            0x2::dynamic_field::borrow<u64, vector<T0>>(&arg0.vecs, arg1)
        }
    }

    fun borrow_chunk_mut<T0: store>(arg0: &mut DynVec<T0>, arg1: u64) : &mut vector<T0> {
        if (arg1 == 0) {
            &mut arg0.vec_0
        } else {
            0x2::dynamic_field::borrow_mut<u64, vector<T0>>(&mut arg0.vecs, arg1)
        }
    }

    public fun chunk_index<T0: store>(arg0: &DynVec<T0>, arg1: u64) : (u64, u64) {
        (arg1 / arg0.limit, arg1 % arg0.limit)
    }

    public fun current_chunk<T0: store>(arg0: &DynVec<T0>) : u64 {
        arg0.current_chunk
    }

    public fun has_chunk<T0: store>(arg0: &DynVec<T0>, arg1: u64) : bool {
        arg1 == 0 || 0x2::dynamic_field::exists_<u64>(&arg0.vecs, arg1)
    }

    fun how_many_chunks(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / arg1;
        let v1 = v0;
        if (arg0 % arg1 > 0) {
            v1 = v0 + 1;
        };
        v1
    }

    fun insert_chunk<T0: store>(arg0: &mut DynVec<T0>, arg1: T0) {
        0x2::dynamic_field::add<u64, vector<T0>>(&mut arg0.vecs, arg0.current_chunk + 1, 0x1::vector::singleton<T0>(arg1));
        arg0.current_chunk = arg0.current_chunk + 1;
        arg0.tip_length = 1;
        arg0.total_length = arg0.total_length + 1;
    }

    public fun pop_at_index<T0: store>(arg0: &mut DynVec<T0>, arg1: u64) : T0 {
        assert!(arg0.total_length > 0, 1);
        assert!(arg1 < arg0.total_length, 3);
        let (v0, v1) = chunk_index<T0>(arg0, arg1);
        let v2 = arg0.current_chunk;
        if (v0 == v2) {
            if (arg0.tip_length > 1) {
                arg0.total_length = arg0.total_length - 1;
                arg0.tip_length = arg0.tip_length - 1;
                0x1::vector::swap_remove<T0>(borrow_chunk_mut<T0>(arg0, v2), v1)
            } else {
                remove_chunk<T0>(arg0)
            }
        } else {
            let v4 = pop_last_element<T0>(arg0);
            let v5 = borrow_chunk_mut<T0>(arg0, v0);
            0x1::vector::push_back<T0>(v5, v4);
            0x1::vector::swap_remove<T0>(v5, v1)
        }
    }

    fun pop_element_from_chunk<T0: store>(arg0: &mut DynVec<T0>) : T0 {
        let v0 = arg0.current_chunk;
        let v1 = borrow_chunk_mut<T0>(arg0, v0);
        arg0.tip_length = arg0.tip_length - 1;
        arg0.total_length = arg0.total_length - 1;
        0x1::vector::pop_back<T0>(v1)
    }

    fun pop_last_element<T0: store>(arg0: &mut DynVec<T0>) : T0 {
        if (arg0.tip_length > 1) {
            pop_element_from_chunk<T0>(arg0)
        } else {
            remove_chunk<T0>(arg0)
        }
    }

    fun push_element_to_chunk<T0: store>(arg0: &mut DynVec<T0>, arg1: T0) {
        let v0 = arg0.current_chunk;
        let v1 = borrow_chunk_mut<T0>(arg0, v0);
        0x1::vector::push_back<T0>(v1, arg1);
        arg0.tip_length = arg0.tip_length + 1;
        arg0.total_length = arg0.total_length + 1;
    }

    fun remove_chunk<T0: store>(arg0: &mut DynVec<T0>) : T0 {
        let v0 = arg0.current_chunk;
        let v1 = if (v0 == 0) {
            0x1::vector::pop_back<T0>(&mut arg0.vec_0)
        } else {
            let v2 = 0x2::dynamic_field::remove<u64, vector<T0>>(&mut arg0.vecs, v0);
            0x1::vector::destroy_empty<T0>(v2);
            0x1::vector::pop_back<T0>(&mut v2)
        };
        arg0.total_length = arg0.total_length - 1;
        if (arg0.current_chunk > 0) {
            arg0.current_chunk = arg0.current_chunk - 1;
            arg0.tip_length = arg0.limit;
        } else {
            arg0.tip_length = 0;
        };
        v1
    }

    public fun tip_length<T0: store>(arg0: &DynVec<T0>) : u64 {
        arg0.tip_length
    }

    public fun total_length<T0: store>(arg0: &DynVec<T0>) : u64 {
        arg0.total_length
    }

    // decompiled from Move bytecode v6
}

