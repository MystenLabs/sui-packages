module 0x3747b7881396ae0812029689ede9d3e5a539e85766dff94f8e5dbc04cd030873::oracle {
    struct Oracle<T0: copy + store> has store, key {
        id: 0x2::object::UID,
        writer: 0x2::object::ID,
        latest: u64,
        history: vector<T0>,
    }

    struct WriterCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0: copy + drop + store>(arg0: &WriterCap, arg1: u64, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) : Oracle<T0> {
        assert!(arg1 > 0, 0);
        let v0 = 0;
        let v1 = 0x1::vector::empty<T0>();
        while (v0 < arg1) {
            0x1::vector::push_back<T0>(&mut v1, arg2);
            v0 = v0 + 1;
        };
        Oracle<T0>{
            id      : 0x2::object::new(arg3),
            writer  : 0x2::object::id<WriterCap>(arg0),
            latest  : arg1 - 1,
            history : v1,
        }
    }

    public fun borrow_latest<T0: copy + store>(arg0: &Oracle<T0>) : &T0 {
        0x1::vector::borrow<T0>(&arg0.history, arg0.latest)
    }

    public fun history<T0: copy + store>(arg0: &Oracle<T0>, arg1: u64) : vector<T0> {
        let v0 = 0x1::vector::length<T0>(&arg0.history);
        assert!(arg1 <= v0, 2);
        let v1 = arg0.latest;
        let v2 = 0;
        let v3 = 0x1::vector::empty<T0>();
        while (v2 < arg1) {
            0x1::vector::push_back<T0>(&mut v3, *0x1::vector::borrow<T0>(&arg0.history, v1));
            let v4 = if (v1 == 0) {
                v0 - 1
            } else {
                v1 - 1
            };
            v1 = v4;
            v2 = v2 + 1;
        };
        0x1::vector::reverse<T0>(&mut v3);
        v3
    }

    public fun latest<T0: copy + store>(arg0: &Oracle<T0>) : T0 {
        *borrow_latest<T0>(arg0)
    }

    public fun update<T0: copy + drop + store>(arg0: &WriterCap, arg1: &mut Oracle<T0>, arg2: T0) : bool {
        assert!(arg1.writer == 0x2::object::id<WriterCap>(arg0), 1);
        if (arg1.latest == 0x1::vector::length<T0>(&arg1.history) - 1) {
            arg1.latest = 0;
            *0x1::vector::borrow_mut<T0>(&mut arg1.history, arg1.latest) = arg2;
            true
        } else {
            arg1.latest = arg1.latest + 1;
            *0x1::vector::borrow_mut<T0>(&mut arg1.history, arg1.latest) = arg2;
            false
        }
    }

    public fun window<T0: copy + store>(arg0: &Oracle<T0>) : u64 {
        0x1::vector::length<T0>(&arg0.history)
    }

    public fun writer(arg0: &mut 0x2::tx_context::TxContext) : WriterCap {
        WriterCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

