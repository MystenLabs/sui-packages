module 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::owned {
    struct Escrow<T0: store + key> has key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
        escrowed_key: 0x2::object::ID,
        escrowed: T0,
    }

    public fun swap<T0: store + key, T1: store + key>(arg0: Escrow<T0>, arg1: Escrow<T1>) {
        let Escrow {
            id           : v0,
            sender       : v1,
            recipient    : v2,
            exchange_key : v3,
            escrowed_key : v4,
            escrowed     : v5,
        } = arg0;
        let Escrow {
            id           : v6,
            sender       : v7,
            recipient    : v8,
            exchange_key : v9,
            escrowed_key : v10,
            escrowed     : v11,
        } = arg1;
        0x2::object::delete(v0);
        0x2::object::delete(v6);
        assert!(v1 == v8, 0);
        assert!(v7 == v2, 0);
        assert!(v4 == v9, 1);
        assert!(v10 == v3, 1);
        0x2::transfer::public_transfer<T0>(v5, v2);
        0x2::transfer::public_transfer<T1>(v11, v8);
    }

    public fun create<T0: store + key>(arg0: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key, arg1: 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Locked<T0>, arg2: 0x2::object::ID, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg5),
            sender       : 0x2::tx_context::sender(arg5),
            recipient    : arg3,
            exchange_key : arg2,
            escrowed_key : 0x2::object::id<0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::Key>(&arg0),
            escrowed     : 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::lock::unlock<T0>(arg1, arg0),
        };
        0x2::transfer::transfer<Escrow<T0>>(v0, arg4);
    }

    public fun return_to_sender<T0: store + key>(arg0: Escrow<T0>) {
        let Escrow {
            id           : v0,
            sender       : v1,
            recipient    : _,
            exchange_key : _,
            escrowed_key : _,
            escrowed     : v5,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v5, v1);
    }

    // decompiled from Move bytecode v6
}

