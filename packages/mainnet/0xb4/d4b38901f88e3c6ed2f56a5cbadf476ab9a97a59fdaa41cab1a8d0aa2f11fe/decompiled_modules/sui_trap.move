module 0xb4d4b38901f88e3c6ed2f56a5cbadf476ab9a97a59fdaa41cab1a8d0aa2f11fe::sui_trap {
    struct Container has key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct DofShell has key {
        id: 0x2::object::UID,
    }

    struct OpaqueKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinCage<phantom T0> has key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<T0>,
    }

    public entry fun always_abort() {
        abort 13897264295718158337
    }

    public entry fun park_dof_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DofShell{id: 0x2::object::new(arg2)};
        let v1 = OpaqueKey{dummy_field: false};
        0x2::dynamic_field::add<OpaqueKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        0x2::transfer::transfer<DofShell>(v0, arg1);
    }

    public entry fun wrap_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{
            id   : 0x2::object::new(arg2),
            held : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<Container>(v0, arg1);
    }

    public entry fun wrap_any_and_send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinCage<T0>{
            id   : 0x2::object::new(arg2),
            held : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::transfer<CoinCage<T0>>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

