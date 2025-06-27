module 0xff603cc8fc110532f13385c4d4b17b78187f250dd79a3f7ed7ee0fb1e9597d56::escrow {
    struct EscrowObjectKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Escrow<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
    }

    public fun swap<T0: store + key, T1: store + key>(arg0: Escrow<T0>, arg1: 0xff603cc8fc110532f13385c4d4b17b78187f250dd79a3f7ed7ee0fb1e9597d56::lock::Key, arg2: 0xff603cc8fc110532f13385c4d4b17b78187f250dd79a3f7ed7ee0fb1e9597d56::lock::Locked<T1>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(arg0.exchange_key == 0x2::object::id<0xff603cc8fc110532f13385c4d4b17b78187f250dd79a3f7ed7ee0fb1e9597d56::lock::Key>(&arg1), 0);
        assert!(arg0.recipient == 0x2::tx_context::sender(arg3), 0);
        let v0 = EscrowObjectKey{dummy_field: false};
        let Escrow {
            id           : v1,
            sender       : v2,
            recipient    : _,
            exchange_key : _,
        } = arg0;
        0x2::transfer::public_transfer<T1>(0xff603cc8fc110532f13385c4d4b17b78187f250dd79a3f7ed7ee0fb1e9597d56::lock::unlock<T1>(arg2, arg1, arg3), v2);
        0x2::object::delete(v1);
        0x2::dynamic_object_field::remove<EscrowObjectKey, T0>(&mut arg0.id, v0)
    }

    public fun create<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Escrow<T0> {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg3),
            sender       : 0x2::tx_context::sender(arg3),
            recipient    : arg2,
            exchange_key : arg1,
        };
        let v1 = EscrowObjectKey{dummy_field: false};
        0x2::dynamic_object_field::add<EscrowObjectKey, T0>(&mut v0.id, v1, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

