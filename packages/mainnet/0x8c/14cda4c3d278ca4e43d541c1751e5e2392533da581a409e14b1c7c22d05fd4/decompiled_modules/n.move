module 0x8c14cda4c3d278ca4e43d541c1751e5e2392533da581a409e14b1c7c22d05fd4::n {
    struct N has key {
        id: 0x2::object::UID,
        admin: address,
        c: u64,
    }

    public fun admin(arg0: &N) : address {
        arg0.admin
    }

    public fun alloc(arg0: &mut N, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        let v0 = 0;
        while (v0 < arg1) {
            arg0.c = arg0.c + 1;
            let v1 = N{
                id    : 0x2::object::new(arg3),
                admin : arg0.admin,
                c     : 0,
            };
            0x2::transfer::transfer<N>(v1, arg2);
            v0 = v0 + 1;
        };
    }

    public fun bump(arg0: &mut N) {
        arg0.c = arg0.c + 1;
    }

    public fun counter(arg0: &N) : u64 {
        arg0.c
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        n_new(v0, arg0);
    }

    public fun n_new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = N{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
            c     : 0,
        };
        0x2::transfer::transfer<N>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

