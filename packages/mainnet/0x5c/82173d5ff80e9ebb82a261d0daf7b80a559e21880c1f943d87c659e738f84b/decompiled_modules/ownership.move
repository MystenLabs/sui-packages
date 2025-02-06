module 0x5c82173d5ff80e9ebb82a261d0daf7b80a559e21880c1f943d87c659e738f84b::ownership {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct OwnerCapTransferred has copy, drop {
        from: address,
        to: address,
    }

    struct OperatorCapTransferred has copy, drop {
        from: address,
        to: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun transfer_operator(arg0: OperatorCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OperatorCap>(arg0, arg1);
        let v0 = OperatorCapTransferred{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<OperatorCapTransferred>(v0);
    }

    public entry fun transfer_owner(arg0: OwnerCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
        let v0 = OwnerCapTransferred{
            from : 0x2::tx_context::sender(arg2),
            to   : arg1,
        };
        0x2::event::emit<OwnerCapTransferred>(v0);
    }

    // decompiled from Move bytecode v6
}

