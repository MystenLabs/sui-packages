module 0x916414526d6881f5296f433a77bdb8366ae33f694a9cce2e2b4ebd2bec7e9a36::test {
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

    public entry fun increase_nonce(arg0: &AdminCap, arg1: &mut Config, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (Result, u64) {
        arg1.nonce = arg3;
        arg1.addr = arg2;
        let v0 = Result{latest_nonce: arg3};
        (v0, arg1.nonce)
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

