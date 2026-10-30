module 0xf6c09b6b20a514c9494b6b31443642841441d2965c8c49968315b54f27bc2222::credit {
    struct Credit<T0: copy + drop + store> has copy, drop, store {
        display_name: 0x1::string::String,
        roles: vector<T0>,
    }

    public fun display_name<T0: copy + drop + store>(arg0: &Credit<T0>) : &0x1::string::String {
        &arg0.display_name
    }

    public fun new<T0: copy + drop + store>(arg0: 0x1::string::String, arg1: vector<T0>) : Credit<T0> {
        assert!(!0x1::string::is_empty(&arg0), 1);
        assert!(0x1::string::length(&arg0) <= 200, 0);
        assert!(0x1::vector::length<T0>(&arg1) >= 1, 2);
        assert!(0x1::vector::length<T0>(&arg1) <= 50, 3);
        let v0 = 0x2::vec_set::empty<T0>();
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<T0>(v1)) {
            let v3 = 0x1::vector::borrow<T0>(v1, v2);
            assert!(!0x2::vec_set::contains<T0>(&v0, v3), 4);
            0x2::vec_set::insert<T0>(&mut v0, *v3);
            v2 = v2 + 1;
        };
        Credit<T0>{
            display_name : arg0,
            roles        : arg1,
        }
    }

    public fun roles<T0: copy + drop + store>(arg0: &Credit<T0>) : &vector<T0> {
        &arg0.roles
    }

    // decompiled from Move bytecode v7
}

