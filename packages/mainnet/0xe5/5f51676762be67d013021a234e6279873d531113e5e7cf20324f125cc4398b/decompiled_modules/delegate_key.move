module 0x3b2fffcd5c06f34aab0370b45593551b59604976713608da57f94f87bbb04745::delegate_key {
    struct DelegateRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
    }

    public fun assert_delegate_sender(arg0: &DelegateRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.delegate != @0x0, 52);
        assert!(0x2::tx_context::sender(arg1) == arg0.delegate, 53);
    }

    public fun delegate(arg0: &DelegateRegistry) : address {
        arg0.delegate
    }

    public fun is_active(arg0: &DelegateRegistry, arg1: address) : bool {
        arg0.delegate == arg1 && arg0.owner != @0x0
    }

    public fun owner(arg0: &DelegateRegistry) : address {
        arg0.owner
    }

    public fun register(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DelegateRegistry{
            id       : 0x2::object::new(arg2),
            owner    : arg0,
            delegate : arg1,
        };
        0x2::transfer::transfer<DelegateRegistry>(v0, arg0);
    }

    public fun replace(arg0: &mut DelegateRegistry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 50);
        arg0.delegate = arg1;
    }

    public fun revoke(arg0: &mut DelegateRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 50);
        arg0.delegate = @0x0;
    }

    // decompiled from Move bytecode v7
}

