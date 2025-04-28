module 0xcb8b8a5c39e8718d40740caf3119164cdbbd37c8b502da674073dfa7677c970a::test {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        nonce: u64,
        version: u8,
        addr: address,
    }

    struct Result has copy, drop {
        latest_nonce: u64,
    }

    public fun get_nonce(arg0: &Config) : u64 {
        3
    }

    public entry fun increase_nonce(arg0: &AdminCap, arg1: &mut Config, arg2: vector<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (Result, u64) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = *0x1::vector::borrow<u64>(&arg2, v3);
            if (v4 > v1) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        arg1.nonce = v2 + 20;
        arg1.addr = arg3;
        let v5 = Result{latest_nonce: v2};
        (v5, arg1.nonce)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            nonce   : 0,
            version : 2,
            addr    : @0x3d1ef1901720aedec86cae5c41d4f9faca0f6714d61060c866043bddac26d042,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun update_nonce(arg0: &mut Config, arg1: Result, arg2: u64) {
        if (arg2 > arg1.latest_nonce) {
            arg0.nonce = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

