module 0x1045a02a434933479d8c599b7d9131b7fdbfa810ce22e2120b29947df915bc62::sui_trap {
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

    // decompiled from Move bytecode v7
}

