module 0xdfca5a7e82c3995bd7b8464178438069892ffe7f7220020db74fbe78519df4df::credit {
    struct Credit<T0: copy + drop + store> has copy, drop, store {
        display_name: 0x1::string::String,
        roles: vector<T0>,
    }

    public fun display_name<T0: copy + drop + store>(arg0: &Credit<T0>) : &0x1::string::String {
        &arg0.display_name
    }

    public fun new<T0: copy + drop + store>(arg0: 0x1::string::String, arg1: vector<T0>) : Credit<T0> {
        assert!(!0x1::string::is_empty(&arg0), 31);
        assert!(0x1::string::length(&arg0) <= 200, 30);
        assert!(0x1::vector::length<T0>(&arg1) >= 1, 32);
        assert!(0x1::vector::length<T0>(&arg1) <= 50, 33);
        let v0 = 0x1::vector::length<T0>(&arg1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<T0>(&arg1, v1) != 0x1::vector::borrow<T0>(&arg1, v2), 40);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
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

