module 0xac55259d62fd8c30dd638f46afab109bc6a1066c4e92093b791d60e6bad266e7::ll {
    struct LL<T0> {
        r: T0,
        a: u64,
    }

    public fun is_some<T0>(arg0: &0x1::option::Option<LL<T0>>) : bool {
        0x1::option::is_some<LL<T0>>(arg0)
    }

    public fun none<T0>() : 0x1::option::Option<LL<T0>> {
        0x1::option::none<LL<T0>>()
    }

    public fun some<T0>(arg0: T0, arg1: u64) : 0x1::option::Option<LL<T0>> {
        0x1::option::some<LL<T0>>(wrap<T0>(arg0, arg1))
    }

    public fun amount<T0>(arg0: &LL<T0>) : u64 {
        arg0.a
    }

    public fun close<T0>(arg0: 0x1::option::Option<LL<T0>>) {
        assert!(0x1::option::is_none<LL<T0>>(&arg0), 202);
        0x1::option::destroy_none<LL<T0>>(arg0);
    }

    public fun open<T0>(arg0: 0x1::option::Option<LL<T0>>) : (T0, u64) {
        assert!(0x1::option::is_some<LL<T0>>(&arg0), 201);
        unwrap<T0>(0x1::option::destroy_some<LL<T0>>(arg0))
    }

    public fun unwrap<T0>(arg0: LL<T0>) : (T0, u64) {
        let LL {
            r : v0,
            a : v1,
        } = arg0;
        (v0, v1)
    }

    public fun wrap<T0>(arg0: T0, arg1: u64) : LL<T0> {
        LL<T0>{
            r : arg0,
            a : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

