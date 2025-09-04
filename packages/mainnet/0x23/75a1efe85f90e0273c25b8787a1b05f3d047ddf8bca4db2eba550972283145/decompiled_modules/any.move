module 0x2375a1efe85f90e0273c25b8787a1b05f3d047ddf8bca4db2eba550972283145::any {
    struct Any has store, key {
        id: 0x2::object::UID,
    }

    struct TEST_BTC has drop {
        dummy_field: bool,
    }

    public fun new<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Any {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<vector<u8>, T0>(&mut v0, b"inner_type", arg0);
        Any{id: v0}
    }

    public(friend) fun cast<T0: store>(arg0: Any) : T0 {
        let Any { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<vector<u8>, T0>(&mut arg0.id, b"inner_type")
    }

    fun test_any<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = new<0x2::coin::Coin<T0>>(arg0, arg1);
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            test_specialize_sui(cast<0x2::coin::Coin<0x2::sui::SUI>>(v0), arg1)
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(cast<0x2::coin::Coin<T0>>(v0), 0x2::tx_context::sender(arg1));
            false
        }
    }

    fun test_specialize_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
        true
    }

    // decompiled from Move bytecode v6
}

