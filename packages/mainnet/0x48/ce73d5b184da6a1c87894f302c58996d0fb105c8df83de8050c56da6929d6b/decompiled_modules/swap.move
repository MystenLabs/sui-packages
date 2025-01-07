module 0x48ce73d5b184da6a1c87894f302c58996d0fb105c8df83de8050c56da6929d6b::swap {
    struct EscrowedObj<T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        creator: address,
        recipient: address,
        exchange_for: 0x2::object::ID,
        escrowed: 0x1::option::Option<T0>,
    }

    public entry fun cancel<T0: store + key, T1: store + key>(arg0: &mut EscrowedObj<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(&v0 == &arg0.creator, 0);
        assert!(0x1::option::is_some<T0>(&arg0.escrowed), 4);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.escrowed), arg0.creator);
    }

    public fun create<T0: store + key, T1: store + key>(arg0: address, arg1: 0x2::object::ID, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowedObj<T0, T1>{
            id           : 0x2::object::new(arg3),
            creator      : 0x2::tx_context::sender(arg3),
            recipient    : arg0,
            exchange_for : arg1,
            escrowed     : 0x1::option::some<T0>(arg2),
        };
        0x2::transfer::public_share_object<EscrowedObj<T0, T1>>(v0);
    }

    public entry fun exchange<T0: store + key, T1: store + key>(arg0: T1, arg1: &mut EscrowedObj<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<T0>(&arg1.escrowed), 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(&v0 == &arg1.recipient, 1);
        assert!(0x2::object::borrow_id<T1>(&arg0) == &arg1.exchange_for, 2);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg1.escrowed), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<T1>(arg0, arg1.creator);
    }

    // decompiled from Move bytecode v6
}

