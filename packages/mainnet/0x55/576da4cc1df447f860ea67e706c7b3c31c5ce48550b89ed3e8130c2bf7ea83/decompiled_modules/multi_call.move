module 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::multi_call {
    struct MultiCall<T0, T1> {
        caller: address,
        calls: vector<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>,
    }

    public fun length<T0, T1>(arg0: &MultiCall<T0, T1>) : u64 {
        0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(&arg0.calls)
    }

    public fun borrow<T0, T1>(arg0: &MultiCall<T0, T1>, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap) : &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1> {
        let v0 = &arg0.calls;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0)) {
            if (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::callee<T0, T1>(0x1::vector::borrow<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0, v1)) == 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg1)) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                let v3 = &arg0.calls;
                if (0x1::option::is_some<u64>(&v2)) {
                    return 0x1::vector::borrow<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v3, 0x1::option::destroy_some<u64>(v2))
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    abort 1
                };
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun borrow_mut<T0, T1>(arg0: &mut MultiCall<T0, T1>, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap) : &mut 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1> {
        let v0 = &arg0.calls;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0)) {
            if (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::callee<T0, T1>(0x1::vector::borrow<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0, v1)) == 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg1)) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                let v3 = &mut arg0.calls;
                if (0x1::option::is_some<u64>(&v2)) {
                    return 0x1::vector::borrow_mut<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v3, 0x1::option::destroy_some<u64>(v2))
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    abort 1
                };
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun caller<T0, T1>(arg0: &MultiCall<T0, T1>) : address {
        arg0.caller
    }

    public fun contains<T0, T1>(arg0: &MultiCall<T0, T1>, arg1: address) : bool {
        let v0 = &arg0.calls;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0)) {
            if (0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::callee<T0, T1>(0x1::vector::borrow<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>(v0, v1)) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                return 0x1::option::is_some<u64>(&v2)
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun create<T0, T1>(arg0: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg1: vector<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>>) : MultiCall<T0, T1> {
        MultiCall<T0, T1>{
            caller : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg0),
            calls  : arg1,
        }
    }

    public fun destroy<T0, T1>(arg0: MultiCall<T0, T1>, arg1: &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap) : vector<0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<T0, T1>> {
        assert!(0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(arg1) == arg0.caller, 2);
        let MultiCall {
            caller : _,
            calls  : v1,
        } = arg0;
        v1
    }

    // decompiled from Move bytecode v6
}

