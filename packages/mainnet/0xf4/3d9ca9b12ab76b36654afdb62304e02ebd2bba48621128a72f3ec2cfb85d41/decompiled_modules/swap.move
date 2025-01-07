module 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::swap {
    struct Escrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        exchange_key: 0x2::object::ID,
        escrowed: 0x1::option::Option<T0>,
    }

    public fun swap<T0: store + key, T1: store + key>(arg0: &mut Escrow<T0>, arg1: 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Key, arg2: 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Locked<T1>, arg3: &0x2::tx_context::TxContext) : T0 {
        assert!(0x1::option::is_some<T0>(&arg0.escrowed), 2);
        assert!(arg0.recipient == 0x2::tx_context::sender(arg3), 0);
        assert!(arg0.exchange_key == 0x2::object::id<0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Key>(&arg1), 1);
        0x2::transfer::public_transfer<T1>(0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::unlock<T1>(arg2, arg1), arg0.sender);
        0x1::option::extract<T0>(&mut arg0.escrowed)
    }

    public fun create<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id           : 0x2::object::new(arg3),
            sender       : 0x2::tx_context::sender(arg3),
            recipient    : arg2,
            exchange_key : arg1,
            escrowed     : 0x1::option::some<T0>(arg0),
        };
        0x2::transfer::public_share_object<Escrow<T0>>(v0);
    }

    public fun create_escrow<T0: store + key>(arg0: T0, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        create<T0>(arg0, arg1, arg2, arg3);
        0x2::object::id<T0>(&arg0)
    }

    public fun end_swap<T0: store + key, T1: store + key>(arg0: &mut Escrow<T0>, arg1: 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Key, arg2: 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Locked<T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(swap<T0, T1>(arg0, arg1, arg2, arg4), arg3);
    }

    public fun return_to_sender<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &0x2::tx_context::TxContext) : T0 {
        assert!(arg0.sender == 0x2::tx_context::sender(arg1), 0);
        assert!(0x1::option::is_some<T0>(&arg0.escrowed), 2);
        0x1::option::extract<T0>(&mut arg0.escrowed)
    }

    public fun start_swap<T0: store + key>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::lock<T0>(arg0, arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Locked<T0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Key>(v2, 0x2::tx_context::sender(arg1));
        (0x2::object::id<T0>(&arg0), 0x2::object::id<0xf43d9ca9b12ab76b36654afdb62304e02ebd2bba48621128a72f3ec2cfb85d41::lock::Key>(&v2))
    }

    // decompiled from Move bytecode v6
}

