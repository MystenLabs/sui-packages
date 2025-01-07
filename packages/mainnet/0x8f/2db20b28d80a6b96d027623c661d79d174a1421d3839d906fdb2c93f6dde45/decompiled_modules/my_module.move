module 0x8f2db20b28d80a6b96d027623c661d79d174a1421d3839d906fdb2c93f6dde45::my_module {
    struct EscrowedObj<T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_for: 0x2::object::ID,
        escrowed: T0,
    }

    public entry fun swap<T0: store + key, T1: store + key>(arg0: EscrowedObj<T0, T1>, arg1: EscrowedObj<T1, T0>) {
        let EscrowedObj {
            id           : v0,
            sender       : v1,
            recipient    : v2,
            exchange_for : v3,
            escrowed     : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v2;
        let v7 = v1;
        let EscrowedObj {
            id           : v8,
            sender       : v9,
            recipient    : v10,
            exchange_for : v11,
            escrowed     : v12,
        } = arg1;
        let v13 = v12;
        let v14 = v10;
        let v15 = v9;
        0x2::object::delete(v0);
        0x2::object::delete(v8);
        assert!(&v7 == &v14, 0);
        assert!(&v15 == &v6, 0);
        assert!(0x2::object::id<T0>(&v5) == v11, 1);
        assert!(0x2::object::id<T1>(&v13) == v3, 1);
        0x2::transfer::public_transfer<T0>(v5, v15);
        0x2::transfer::public_transfer<T1>(v13, v7);
    }

    public fun create<T0: store + key, T1: store + key>(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowedObj<T0, T1>{
            id           : 0x2::object::new(arg4),
            sender       : 0x2::tx_context::sender(arg4),
            recipient    : arg0,
            exchange_for : arg2,
            escrowed     : arg3,
        };
        0x2::transfer::public_transfer<EscrowedObj<T0, T1>>(v0, arg1);
    }

    public entry fun return_to_sender<T0: store + key, T1: store + key>(arg0: EscrowedObj<T0, T1>) {
        let EscrowedObj {
            id           : v0,
            sender       : v1,
            recipient    : _,
            exchange_for : _,
            escrowed     : v4,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v4, v1);
    }

    // decompiled from Move bytecode v6
}

