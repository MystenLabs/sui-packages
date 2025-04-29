module 0x4da0870ec5e9d6a27091d8574f5e771096603b148df7703507c1dd7c9cf5329b::test {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        nonce: u64,
        version: u8,
        addr: address,
        state: bool,
    }

    struct Result has copy, drop {
        latest_nonce: u64,
    }

    public fun get_nonce(arg0: &Config) : u64 {
        3
    }

    public entry fun increase_nonce(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u8, arg4: bool, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : (Result, u64) {
        let v0 = arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg5)) {
            let v2 = *0x1::vector::borrow<u8>(&arg5, v1);
            if (v2 > arg3) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        arg1.nonce = (v0 as u64);
        arg1.addr = arg2;
        arg1.state = arg4;
        let v3 = Result{latest_nonce: (v0 as u64)};
        (v3, arg1.nonce)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            nonce   : 0,
            version : 2,
            addr    : @0x3d1ef1901720aedec86cae5c41d4f9faca0f6714d61060c866043bddac26d042,
            state   : false,
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

