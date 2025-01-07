module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator {
    struct Operator has key {
        id: 0x2::object::UID,
        addr: address,
        public_key: vector<u8>,
    }

    struct SuperRootCap has store, key {
        id: 0x2::object::UID,
        initialized_operator: bool,
    }

    public(friend) fun get_address(arg0: &Operator) : address {
        arg0.addr
    }

    public(friend) fun get_public_key(arg0: &Operator) : vector<u8> {
        arg0.public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperRootCap{
            id                   : 0x2::object::new(arg0),
            initialized_operator : false,
        };
        0x2::transfer::transfer<SuperRootCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_operator(arg0: &mut SuperRootCap, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized_operator == false, 1);
        let v0 = Operator{
            id         : 0x2::object::new(arg3),
            addr       : arg1,
            public_key : arg2,
        };
        0x2::transfer::share_object<Operator>(v0);
        arg0.initialized_operator = true;
    }

    public fun set_operator(arg0: &SuperRootCap, arg1: &mut Operator, arg2: address, arg3: vector<u8>) {
        arg1.addr = arg2;
        arg1.public_key = arg3;
    }

    // decompiled from Move bytecode v6
}

