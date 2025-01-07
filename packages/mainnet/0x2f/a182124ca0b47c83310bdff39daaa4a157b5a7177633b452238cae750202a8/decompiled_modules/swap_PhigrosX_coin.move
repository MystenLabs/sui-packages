module 0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::swap_PhigrosX_coin {
    struct Escrow<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
    }

    struct DYEscrow has copy, drop, store {
        dummy_field: bool,
    }

    public entry fun swap<T0: store + key, T1: store + key>(arg0: Escrow<T0>, arg1: 0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::lock::Locked<T1>, arg2: 0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::lock::Key, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DYEscrow{dummy_field: false};
        let Escrow {
            id           : v1,
            sender       : v2,
            recipient    : v3,
            exchange_key : v4,
        } = arg0;
        assert!(v3 == 0x2::tx_context::sender(arg3), 0);
        assert!(v4 == 0x2::object::id<0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::lock::Key>(&arg2), 1);
        0x2fa182124ca0b47c83310bdff39daaa4a157b5a7177633b452238cae750202a8::lock::unlockAndTransfer<T1>(arg1, arg2, v2);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<DYEscrow, T0>(&mut arg0.id, v0), 0x2::tx_context::sender(arg3));
        0x2::object::delete(v1);
    }

    public entry fun create<T0: store + key>(arg0: address, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg3),
            sender       : 0x2::tx_context::sender(arg3),
            recipient    : arg0,
            exchange_key : arg1,
        };
        let v1 = DYEscrow{dummy_field: false};
        0x2::dynamic_object_field::add<DYEscrow, T0>(&mut v0.id, v1, arg2);
        0x2::transfer::public_share_object<Escrow<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

