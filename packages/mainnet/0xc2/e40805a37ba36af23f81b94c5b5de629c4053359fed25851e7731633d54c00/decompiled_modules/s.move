module 0xc2e40805a37ba36af23f81b94c5b5de629c4053359fed25851e7731633d54c00::s {
    struct S has key {
        id: 0x2::object::UID,
        q: u64,
        w: address,
    }

    public entry fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = S{
            id : 0x2::object::new(arg0),
            q  : 0,
            w  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<S>(v0);
    }

    public entry fun give(arg0: &mut S, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.w, 202);
        arg0.w = arg1;
    }

    public entry fun mark(arg0: &mut S, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.w, 202);
        assert!(0x2::clock::timestamp_ms(arg1) < arg3, 201);
        assert!(arg0.q < arg2, 200);
        arg0.q = arg2;
    }

    public fun n(arg0: &S) : u64 {
        arg0.q
    }

    public fun o(arg0: &S) : address {
        arg0.w
    }

    // decompiled from Move bytecode v6
}

