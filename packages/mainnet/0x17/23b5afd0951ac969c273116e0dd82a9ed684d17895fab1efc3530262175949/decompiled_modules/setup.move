module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::setup {
    public(friend) fun setup<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0> {
        let v0 = 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::new<T0>(arg0, arg1, arg2);
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::admin::setup<T0>(&mut v0, arg2);
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::authorize<0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::AdminRole, 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::admin::AdminConfig>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles_mut<T0>(&mut v0), 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::new_role<0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::AdminRole>(0x2::tx_context::sender(arg2)), 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::admin::new_config(false));
        v0
    }

    // decompiled from Move bytecode v6
}

