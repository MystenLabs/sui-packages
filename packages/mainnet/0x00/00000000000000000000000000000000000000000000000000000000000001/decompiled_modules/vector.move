module 0x1::vector {
    native public fun empty<T0>() : vector<T0>;
    native public fun length<T0>(arg0: &vector<T0>) : u64;
    native public fun borrow<T0>(arg0: &vector<T0>, arg1: u64) : &T0;
    native public fun push_back<T0>(arg0: &mut vector<T0>, arg1: T0);
    native public fun borrow_mut<T0>(arg0: &mut vector<T0>, arg1: u64) : &mut T0;
    native public fun pop_back<T0>(arg0: &mut vector<T0>) : T0;
    native public fun destroy_empty<T0>(arg0: vector<T0>);
    native public fun swap<T0>(arg0: &mut vector<T0>, arg1: u64, arg2: u64);
    public fun append<T0>(arg0: &mut vector<T0>, arg1: vector<T0>) {
        let v0 = length<T0>(arg0);
        destroy_empty<T0>(replace_range<T0>(arg0, v0, v0, arg1));
    }

    public fun contains<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let v0 = 0;
        while (v0 < length<T0>(arg0)) {
            if (borrow<T0>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    native public fun copy_range<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: u64) : vector<T0>;
    public fun flatten<T0>(arg0: vector<vector<T0>>) : vector<T0> {
        let v0 = empty<T0>();
        let v1 = &mut arg0;
        reverse<vector<T0>>(v1);
        let v2 = 0;
        while (v2 < length<vector<T0>>(&arg0)) {
            let v3 = &mut arg0;
            let v4 = &mut v0;
            append<T0>(v4, pop_back<vector<T0>>(v3));
            v2 = v2 + 1;
        };
        destroy_empty<vector<T0>>(arg0);
        v0
    }

    public fun index_of<T0>(arg0: &vector<T0>, arg1: &T0) : (bool, u64) {
        let v0 = 0;
        while (v0 < length<T0>(arg0)) {
            if (borrow<T0>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun insert<T0>(arg0: &mut vector<T0>, arg1: T0, arg2: u64) {
        if (arg2 > length<T0>(arg0)) {
            abort 131072
        };
        let v0 = empty<T0>();
        let v1 = &mut v0;
        push_back<T0>(v1, arg1);
        destroy_empty<T0>(replace_range<T0>(arg0, arg2, arg2, v0));
    }

    public fun is_empty<T0>(arg0: &vector<T0>) : bool {
        length<T0>(arg0) == 0
    }

    native public fun keep_range<T0: drop>(arg0: &mut vector<T0>, arg1: u64, arg2: u64);
    public fun remove<T0>(arg0: &mut vector<T0>, arg1: u64) : T0 {
        if (arg1 >= length<T0>(arg0)) {
            abort 131072
        };
        let v0 = remove_range<T0>(arg0, arg1, arg1 + 1);
        let v1 = &mut v0;
        destroy_empty<T0>(v0);
        pop_back<T0>(v1)
    }

    public fun remove_range<T0>(arg0: &mut vector<T0>, arg1: u64, arg2: u64) : vector<T0> {
        replace_range<T0>(arg0, arg1, arg2, empty<T0>())
    }

    native public fun replace_range<T0>(arg0: &mut vector<T0>, arg1: u64, arg2: u64, arg3: vector<T0>) : vector<T0>;
    native public fun reverse<T0>(arg0: &mut vector<T0>);
    public fun singleton<T0>(arg0: T0) : vector<T0> {
        let v0 = empty<T0>();
        let v1 = &mut v0;
        push_back<T0>(v1, arg0);
        v0
    }

    public fun skip<T0: drop>(arg0: vector<T0>, arg1: u64) : vector<T0> {
        let v0 = length<T0>(&arg0);
        if (arg1 >= v0) {
            return empty<T0>()
        };
        let v1 = &mut arg0;
        keep_range<T0>(v1, arg1, v0);
        arg0
    }

    public fun swap_remove<T0>(arg0: &mut vector<T0>, arg1: u64) : T0 {
        assert!(length<T0>(arg0) != 0, 131072);
        let v0 = length<T0>(arg0) - 1;
        swap<T0>(arg0, arg1, v0);
        pop_back<T0>(arg0)
    }

    public fun take<T0: drop>(arg0: vector<T0>, arg1: u64) : vector<T0> {
        assert!(arg1 <= length<T0>(&arg0), 13906834805703573503);
        let v0 = &mut arg0;
        truncate<T0>(v0, arg1);
        arg0
    }

    public fun truncate<T0: drop>(arg0: &mut vector<T0>, arg1: u64) {
        if (arg1 < length<T0>(arg0)) {
            keep_range<T0>(arg0, 0, arg1);
        };
    }

    // decompiled from Move bytecode v7
}

