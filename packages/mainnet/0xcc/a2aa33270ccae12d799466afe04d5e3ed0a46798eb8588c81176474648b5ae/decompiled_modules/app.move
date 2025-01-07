module 0xcca2aa33270ccae12d799466afe04d5e3ed0a46798eb8588c81176474648b5ae::app {
    struct DelegatePermission has store, key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
    }

    public entry fun set_delegate(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0, 1);
        let v0 = DelegatePermission{
            id       : 0x2::object::new(arg2),
            owner    : arg0,
            delegate : arg1,
        };
        0x2::transfer::share_object<DelegatePermission>(v0);
    }

    public entry fun transfer_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

