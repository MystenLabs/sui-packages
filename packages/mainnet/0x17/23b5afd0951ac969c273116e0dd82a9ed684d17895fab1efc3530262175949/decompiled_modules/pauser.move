module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::pauser {
    struct PauserRole has drop {
        dummy_field: bool,
    }

    struct PauseEvent<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        paused: bool,
    }

    public fun pause<T0, T1: drop>(arg0: &mut 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_authorized<PauserRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg1));
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::pause<T1>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles_mut<T0>(arg0));
        let v0 = PauseEvent<T0>{
            role   : 0x1::type_name::get<T1>(),
            paused : true,
        };
        0x2::event::emit<PauseEvent<T0>>(v0);
    }

    public fun resume<T0, T1: drop>(arg0: &mut 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_authorized<PauserRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg1));
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::unpause<T1>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles_mut<T0>(arg0));
        let v0 = PauseEvent<T0>{
            role   : 0x1::type_name::get<T1>(),
            paused : false,
        };
        0x2::event::emit<PauseEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

