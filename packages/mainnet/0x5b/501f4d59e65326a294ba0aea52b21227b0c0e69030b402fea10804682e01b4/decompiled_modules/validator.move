module 0x5b501f4d59e65326a294ba0aea52b21227b0c0e69030b402fea10804682e01b4::validator {
    struct Validator has store {
        id: 0x2::object::UID,
        data: vector<u8>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: vector<u8>) : Validator {
        Validator{
            id   : 0x2::object::new(arg0),
            data : arg1,
        }
    }

    public fun clean(arg0: Validator) {
        let Validator {
            id   : v0,
            data : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun do_validate(arg0: &Validator, arg1: &vector<u8>) : bool {
        0x2::hash::blake2b256(arg1) == arg0.data
    }

    // decompiled from Move bytecode v6
}

