module 0xeddc1be51ffea32e24426f26a2630dc44e296fb47e6e5a2be23765543640929d::router {
    struct Validator has store {
        id: 0x2::object::UID,
        data: vector<u8>,
        address: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: vector<u8>) : Validator {
        Validator{
            id      : 0x2::object::new(arg0),
            data    : arg1,
            address : 0x2::tx_context::sender(arg0),
        }
    }

    public fun clean(arg0: Validator) {
        let Validator {
            id      : v0,
            data    : _,
            address : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun do_validate(arg0: &Validator, arg1: &vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : bool {
        0x2::hash::blake2b256(arg1) == arg0.data && 0x2::tx_context::sender(arg2) == arg0.address
    }

    // decompiled from Move bytecode v6
}

