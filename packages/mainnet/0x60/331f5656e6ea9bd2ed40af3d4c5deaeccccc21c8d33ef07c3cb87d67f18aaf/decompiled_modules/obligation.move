module 0x60331f5656e6ea9bd2ed40af3d4c5deaeccccc21c8d33ef07c3cb87d67f18aaf::obligation {
    struct GeneralKeyStore<T0: key> has store, key {
        id: 0x2::object::UID,
        obligation_key_id: 0x2::object::ID,
    }

    public fun new<T0: key>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : GeneralKeyStore<T0> {
        GeneralKeyStore<T0>{
            id                : 0x2::object::new(arg1),
            obligation_key_id : 0x2::object::id<T0>(arg0),
        }
    }

    public fun key_id<T0: key>(arg0: &GeneralKeyStore<T0>) : 0x2::object::ID {
        arg0.obligation_key_id
    }

    // decompiled from Move bytecode v6
}

