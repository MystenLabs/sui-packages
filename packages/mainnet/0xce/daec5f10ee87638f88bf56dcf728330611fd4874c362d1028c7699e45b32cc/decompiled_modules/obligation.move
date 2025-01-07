module 0xcedaec5f10ee87638f88bf56dcf728330611fd4874c362d1028c7699e45b32cc::obligation {
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

