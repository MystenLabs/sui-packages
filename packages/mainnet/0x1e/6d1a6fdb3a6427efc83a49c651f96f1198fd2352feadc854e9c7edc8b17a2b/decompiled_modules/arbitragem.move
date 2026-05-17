module 0x1e6d1a6fdb3a6427efc83a49c651f96f1198fd2352feadc854e9c7edc8b17a2b::arbitragem {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RoboVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun verificar_e_travar_lucro<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2 + arg3, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v7
}

