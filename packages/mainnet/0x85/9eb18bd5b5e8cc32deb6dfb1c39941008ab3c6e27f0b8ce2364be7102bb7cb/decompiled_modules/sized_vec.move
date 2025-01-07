module 0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::sized_vec {
    struct SizedVec<T0> has copy, drop, store {
        capacity: u64,
        vec: vector<T0>,
    }

    public fun empty<T0>(arg0: u64) : SizedVec<T0> {
        SizedVec<T0>{
            capacity : arg0,
            vec      : 0x1::vector::empty<T0>(),
        }
    }

    public fun length<T0>(arg0: &SizedVec<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.vec)
    }

    public fun borrow<T0>(arg0: &SizedVec<T0>, arg1: u64) : &T0 {
        0x1::vector::borrow<T0>(&arg0.vec, arg1)
    }

    public fun push_back<T0>(arg0: &mut SizedVec<T0>, arg1: T0) {
        assert!(0x1::vector::length<T0>(&arg0.vec) < arg0.capacity, 2);
        0x1::vector::push_back<T0>(&mut arg0.vec, arg1);
    }

    public fun borrow_mut<T0>(arg0: &mut SizedVec<T0>, arg1: u64) : &mut T0 {
        0x1::vector::borrow_mut<T0>(&mut arg0.vec, arg1)
    }

    public fun pop_back<T0>(arg0: &mut SizedVec<T0>) : T0 {
        0x1::vector::pop_back<T0>(&mut arg0.vec)
    }

    public fun destroy_empty<T0>(arg0: SizedVec<T0>) {
        let SizedVec {
            capacity : _,
            vec      : v1,
        } = arg0;
        0x1::vector::destroy_empty<T0>(v1);
    }

    public fun swap<T0>(arg0: &mut SizedVec<T0>, arg1: u64, arg2: u64) {
        0x1::vector::swap<T0>(&mut arg0.vec, arg1, arg2);
    }

    public fun append<T0>(arg0: &mut SizedVec<T0>, arg1: SizedVec<T0>) {
        let SizedVec {
            capacity : v0,
            vec      : v1,
        } = arg1;
        arg0.capacity = arg0.capacity + v0;
        0x1::vector::append<T0>(&mut arg0.vec, v1);
    }

    public fun contains<T0>(arg0: &SizedVec<T0>, arg1: &T0) : bool {
        0x1::vector::contains<T0>(&arg0.vec, arg1)
    }

    public fun index_of<T0>(arg0: &SizedVec<T0>, arg1: &T0) : (bool, u64) {
        0x1::vector::index_of<T0>(&arg0.vec, arg1)
    }

    public fun insert<T0>(arg0: &mut SizedVec<T0>, arg1: T0, arg2: u64) {
        0x1::vector::insert<T0>(&mut arg0.vec, arg1, arg2);
    }

    public fun remove<T0>(arg0: &mut SizedVec<T0>, arg1: u64) : T0 {
        0x1::vector::remove<T0>(&mut arg0.vec, arg1)
    }

    public fun reverse<T0>(arg0: &mut SizedVec<T0>) {
        0x1::vector::reverse<T0>(&mut arg0.vec);
    }

    public fun swap_remove<T0>(arg0: &mut SizedVec<T0>, arg1: u64) : T0 {
        0x1::vector::swap_remove<T0>(&mut arg0.vec, arg1)
    }

    public fun capacity<T0>(arg0: &SizedVec<T0>) : u64 {
        arg0.capacity
    }

    public fun decrease_capacity<T0>(arg0: &mut SizedVec<T0>, arg1: u64) {
        assert!(arg1 <= length<T0>(arg0), 3);
        arg0.capacity = arg0.capacity - arg1;
    }

    public fun increase_capacity<T0>(arg0: &mut SizedVec<T0>, arg1: u64) {
        arg0.capacity = arg0.capacity + arg1;
    }

    public fun is_empty<T0>(arg0: &SizedVec<T0>) : bool {
        0x1::vector::length<T0>(&arg0.vec) == 0
    }

    public fun singleton<T0>(arg0: u64, arg1: T0) : SizedVec<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v0, arg1);
        SizedVec<T0>{
            capacity : arg0,
            vec      : v0,
        }
    }

    public fun slack<T0>(arg0: &SizedVec<T0>) : u64 {
        arg0.capacity - length<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

