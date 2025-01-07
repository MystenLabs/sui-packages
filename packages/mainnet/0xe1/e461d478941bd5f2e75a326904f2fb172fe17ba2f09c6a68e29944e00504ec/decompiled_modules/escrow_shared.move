module 0xed6c6fe0732be937f4379bc0b471f0f6bfbe0e8741968009e0f01e6de3d59f32::escrow_shared {
    struct Escrow<T0: store + key> has key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        arbitrator: 0x1::option::Option<address>,
        obj: 0x1::option::Option<T0>,
    }

    public entry fun transfer<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sender, 65536);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.obj), arg0.recipient);
    }

    public entry fun escrow<T0: store + key>(arg0: address, arg1: address, arg2: 0x1::option::Option<address>, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow<T0>{
            id         : 0x2::object::new(arg4),
            sender     : arg0,
            recipient  : arg1,
            arbitrator : arg2,
            obj        : 0x1::option::some<T0>(arg3),
        };
        0x2::transfer::share_object<Escrow<T0>>(v0);
    }

    public entry fun refund<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.recipient, 65537);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.obj), arg0.sender);
    }

    public entry fun refund_arbitrated<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.arbitrator) && 0x2::tx_context::sender(arg1) == *0x1::option::borrow<address>(&arg0.arbitrator), 65538);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.obj), arg0.sender);
    }

    public entry fun transfer_arbitrated<T0: store + key>(arg0: &mut Escrow<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.arbitrator) && 0x2::tx_context::sender(arg1) == *0x1::option::borrow<address>(&arg0.arbitrator), 65538);
        0x2::transfer::public_transfer<T0>(0x1::option::extract<T0>(&mut arg0.obj), arg0.recipient);
    }

    // decompiled from Move bytecode v6
}

