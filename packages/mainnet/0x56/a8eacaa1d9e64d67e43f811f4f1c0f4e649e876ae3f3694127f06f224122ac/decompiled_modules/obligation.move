module 0x56a8eacaa1d9e64d67e43f811f4f1c0f4e649e876ae3f3694127f06f224122ac::obligation {
    struct GeneralKeyStore<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        obligation_key_id: 0x2::object::ID,
    }

    public fun new<T0: key, T1: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : GeneralKeyStore<T1> {
        GeneralKeyStore<T1>{
            id                : 0x2::object::new(arg1),
            obligation_key_id : 0x2::object::id<T0>(arg0),
        }
    }

    public fun key_id<T0: drop>(arg0: &GeneralKeyStore<T0>) : 0x2::object::ID {
        arg0.obligation_key_id
    }

    // decompiled from Move bytecode v6
}

