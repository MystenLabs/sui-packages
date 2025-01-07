module 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::follow_list {
    struct FollowList<T0: store> has store, key {
        id: 0x2::object::UID,
        inline_vec: vector<T0>,
        big_vec: 0x1::option::Option<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>,
        inline_capacity: 0x1::option::Option<u64>,
        bucket_size: 0x1::option::Option<u64>,
    }

    public fun length<T0: store>(arg0: &FollowList<T0>) : u64 {
        let v0 = if (0x1::option::is_none<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)) {
            0
        } else {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::length<T0>(0x1::option::borrow<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec))
        };
        0x1::vector::length<T0>(&arg0.inline_vec) + v0
    }

    public fun borrow<T0: store>(arg0: &FollowList<T0>, arg1: u64) : &T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        let v0 = 0x1::vector::length<T0>(&arg0.inline_vec);
        if (arg1 < v0) {
            0x1::vector::borrow<T0>(&arg0.inline_vec, arg1)
        } else {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::borrow<T0>(0x1::option::borrow<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec), arg1 - v0)
        }
    }

    public fun push_back<T0: store>(arg0: &mut FollowList<T0>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = length<T0>(arg0);
        if (v0 == 0x1::vector::length<T0>(&arg0.inline_vec)) {
            if (v0 < *0x1::option::borrow<u64>(&arg0.inline_capacity)) {
                0x1::vector::push_back<T0>(&mut arg0.inline_vec, arg1);
                return
            };
            0x1::option::fill<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec, 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::new<T0>(*0x1::option::borrow<u64>(&arg0.bucket_size), arg2));
        };
        0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::push_back<T0>(0x1::option::borrow_mut<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec), arg1);
    }

    public fun borrow_mut<T0: store>(arg0: &mut FollowList<T0>, arg1: u64) : &mut T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        let v0 = 0x1::vector::length<T0>(&arg0.inline_vec);
        if (arg1 < v0) {
            0x1::vector::borrow_mut<T0>(&mut arg0.inline_vec, arg1)
        } else {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::borrow_mut<T0>(0x1::option::borrow_mut<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec), arg1 - v0)
        }
    }

    public fun pop_back<T0: store>(arg0: &mut FollowList<T0>) : T0 {
        assert!(!is_empty<T0>(arg0), 2);
        let v0 = &mut arg0.big_vec;
        if (0x1::option::is_some<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v0)) {
            let v2 = 0x1::option::extract<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v0);
            if (0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::is_empty<T0>(&v2)) {
                0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::destroy_empty<T0>(v2);
            } else {
                0x1::option::fill<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v0, v2);
            };
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::pop_back<T0>(&mut v2)
        } else {
            0x1::vector::pop_back<T0>(&mut arg0.inline_vec)
        }
    }

    public fun destroy_empty<T0: store>(arg0: FollowList<T0>) {
        assert!(is_empty<T0>(&arg0), 3);
        let FollowList {
            id              : v0,
            inline_vec      : v1,
            big_vec         : v2,
            inline_capacity : _,
            bucket_size     : _,
        } = arg0;
        0x1::vector::destroy_empty<T0>(v1);
        0x1::option::destroy_none<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2);
        0x2::object::delete(v0);
    }

    public fun swap<T0: store>(arg0: &mut FollowList<T0>, arg1: u64, arg2: u64) {
        if (arg1 > arg2) {
            swap<T0>(arg0, arg2, arg1);
            return
        };
        let v0 = length<T0>(arg0);
        assert!(arg2 < v0, 1);
        let v1 = 0x1::vector::length<T0>(&arg0.inline_vec);
        if (arg1 >= v1) {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::swap<T0>(0x1::option::borrow_mut<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec), arg1 - v1, arg2 - v1);
        } else if (arg2 < v1) {
            0x1::vector::swap<T0>(&mut arg0.inline_vec, arg1, arg2);
        } else {
            let v2 = 0x1::option::borrow_mut<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec);
            let v3 = &mut arg0.inline_vec;
            0x1::vector::push_back<T0>(v3, 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::swap_remove<T0>(v2, arg2 - v1));
            0x1::vector::swap<T0>(v3, arg1, v1 - 1);
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::push_back<T0>(v2, 0x1::vector::swap_remove<T0>(v3, arg1));
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::swap<T0>(v2, arg2 - v1, v0 - v1 - 1);
        };
    }

    public fun append<T0: store>(arg0: &mut FollowList<T0>, arg1: FollowList<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = length<T0>(&arg1);
        let v1 = 0;
        while (v1 < v0 / 2) {
            let v2 = &mut arg1;
            push_back<T0>(arg0, swap_remove<T0>(v2, v1), arg2);
            v1 = v1 + 1;
        };
        while (v1 < v0) {
            let v3 = &mut arg1;
            push_back<T0>(arg0, pop_back<T0>(v3), arg2);
            v1 = v1 + 1;
        };
        destroy_empty<T0>(arg1);
    }

    public fun index_of<T0: store>(arg0: &FollowList<T0>, arg1: &T0) : (bool, u64) {
        let (v0, v1) = 0x1::vector::index_of<T0>(&arg0.inline_vec, arg1);
        if (v0) {
            (true, v1)
        } else if (0x1::option::is_some<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)) {
            let (v4, v5) = 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::index_of<T0>(0x1::option::borrow<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec), arg1);
            (v4, v5 + 0x1::vector::length<T0>(&arg0.inline_vec))
        } else {
            (false, 0)
        }
    }

    public fun is_empty<T0: store>(arg0: &FollowList<T0>) : bool {
        length<T0>(arg0) == 0
    }

    public fun remove<T0: store>(arg0: &mut FollowList<T0>, arg1: u64) : T0 {
        assert!(arg1 < length<T0>(arg0), 1);
        let v0 = 0x1::vector::length<T0>(&arg0.inline_vec);
        if (arg1 < v0) {
            0x1::vector::remove<T0>(&mut arg0.inline_vec, arg1)
        } else {
            let v2 = &mut arg0.big_vec;
            let v3 = 0x1::option::extract<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2);
            if (0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::is_empty<T0>(&v3)) {
                0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::destroy_empty<T0>(v3);
            } else {
                0x1::option::fill<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2, v3);
            };
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::remove<T0>(&mut v3, arg1 - v0)
        }
    }

    public fun reverse<T0: store>(arg0: &mut FollowList<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<T0>();
        while (v0 < 0x1::vector::length<T0>(&arg0.inline_vec)) {
            let v2 = pop_back<T0>(arg0);
            0x1::vector::push_back<T0>(&mut v1, v2);
            v0 = v0 + 1;
        };
        0x1::vector::reverse<T0>(&mut v1);
        if (0x1::option::is_some<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)) {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::reverse<T0>(0x1::option::borrow_mut<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec));
        };
        let v3 = 0x1::vector::empty<T0>();
        while (!0x1::vector::is_empty<T0>(&mut arg0.inline_vec)) {
            0x1::vector::push_back<T0>(&mut v3, 0x1::vector::pop_back<T0>(&mut arg0.inline_vec));
        };
        0x1::vector::reverse<T0>(&mut v3);
        while (!0x1::vector::is_empty<T0>(&mut v1)) {
            0x1::vector::push_back<T0>(&mut arg0.inline_vec, 0x1::vector::pop_back<T0>(&mut v1));
        };
        0x1::vector::destroy_empty<T0>(v1);
        while (!0x1::vector::is_empty<T0>(&mut v3)) {
            push_back<T0>(arg0, 0x1::vector::pop_back<T0>(&mut v3), arg1);
        };
        0x1::vector::destroy_empty<T0>(v3);
    }

    public fun swap_remove<T0: store>(arg0: &mut FollowList<T0>, arg1: u64) : T0 {
        let v0 = length<T0>(arg0);
        assert!(arg1 < v0, 1);
        let v1 = 0x1::vector::length<T0>(&arg0.inline_vec);
        let v2 = &mut arg0.big_vec;
        let v3 = &mut arg0.inline_vec;
        if (arg1 >= v1) {
            let v5 = 0x1::option::extract<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2);
            if (0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::is_empty<T0>(&v5)) {
                0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::destroy_empty<T0>(v5);
            } else {
                0x1::option::fill<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2, v5);
            };
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::swap_remove<T0>(&mut v5, arg1 - v1)
        } else {
            if (v1 < v0) {
                let v6 = 0x1::option::extract<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2);
                if (0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::is_empty<T0>(&v6)) {
                    0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::destroy_empty<T0>(v6);
                } else {
                    0x1::option::fill<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(v2, v6);
                };
                0x1::vector::push_back<T0>(v3, 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::pop_back<T0>(&mut v6));
            };
            0x1::vector::swap_remove<T0>(v3, arg1)
        }
    }

    public fun new<T0: store>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FollowList<T0> {
        assert!(arg1 > 0, 4);
        FollowList<T0>{
            id              : 0x2::object::new(arg2),
            inline_vec      : 0x1::vector::empty<T0>(),
            big_vec         : 0x1::option::none<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(),
            inline_capacity : 0x1::option::some<u64>(arg0),
            bucket_size     : 0x1::option::some<u64>(arg1),
        }
    }

    public fun destroy<T0: drop + store>(arg0: FollowList<T0>) {
        let v0 = &mut arg0;
        clear<T0>(v0);
        destroy_empty<T0>(arg0);
    }

    public fun to_vector<T0: copy + store>(arg0: &FollowList<T0>) : vector<T0> {
        let v0 = arg0.inline_vec;
        if (0x1::option::is_some<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)) {
            0x1::vector::append<T0>(&mut v0, 0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::to_vector<T0>(0x1::option::borrow<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)));
        };
        v0
    }

    public fun add_all<T0: store>(arg0: &mut FollowList<T0>, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg1)) {
            push_back<T0>(arg0, 0x1::vector::remove<T0>(&mut arg1, 0), arg2);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun clear<T0: drop + store>(arg0: &mut FollowList<T0>) {
        arg0.inline_vec = 0x1::vector::empty<T0>();
        if (0x1::option::is_some<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&arg0.big_vec)) {
            0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::destroy<T0>(0x1::option::extract<0xb0e202c408578c876919b66ebff1879c6cffe71a072734ae61b1bb4414e5a892::big_vector::BigVector<T0>>(&mut arg0.big_vec));
        };
    }

    public fun contains<T0: store>(arg0: &FollowList<T0>, arg1: &T0) : bool {
        if (is_empty<T0>(arg0)) {
            return false
        };
        let (v0, _) = index_of<T0>(arg0, arg1);
        v0
    }

    public fun singleton<T0: store>(arg0: u64, arg1: u64, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : FollowList<T0> {
        let v0 = new<T0>(arg0, arg1, arg3);
        let v1 = &mut v0;
        push_back<T0>(v1, arg2, arg3);
        v0
    }

    // decompiled from Move bytecode v6
}

