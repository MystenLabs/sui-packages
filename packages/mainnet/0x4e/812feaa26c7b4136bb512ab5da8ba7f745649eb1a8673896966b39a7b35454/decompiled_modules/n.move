module 0x4e812feaa26c7b4136bb512ab5da8ba7f745649eb1a8673896966b39a7b35454::n {
    struct Nonce has store, key {
        id: 0x2::object::UID,
        m: u64,
        c: u64,
    }

    public fun alloc(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = Nonce{
                id : 0x2::object::new(arg2),
                m  : arg1,
                c  : 0,
            };
            0x2::transfer::public_transfer<Nonce>(v1, 0x2::tx_context::sender(arg2));
            v0 = v0 + 1;
        };
    }

    public fun bump(arg0: &mut Nonce) {
        arg0.c = arg0.c + 1;
    }

    // decompiled from Move bytecode v6
}

