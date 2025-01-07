module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::freezer {
    struct FreezerRole has drop {
        dummy_field: bool,
    }

    struct FreezeEvent<phantom T0> has copy, drop {
        addr: address,
        frozen: bool,
    }

    public fun freeze_address<T0>(arg0: &mut 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_authorized<FreezerRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_not_paused<FreezerRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0));
        0x2::coin::deny_list_add<T0>(arg1, 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::denylist_cap_mut<T0>(arg0), arg2, arg3);
        let v0 = FreezeEvent<T0>{
            addr   : arg2,
            frozen : true,
        };
        0x2::event::emit<FreezeEvent<T0>>(v0);
    }

    public fun unfreeze_address<T0>(arg0: &mut 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_authorized<FreezerRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_not_paused<FreezerRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0));
        0x2::coin::deny_list_remove<T0>(arg1, 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::denylist_cap_mut<T0>(arg0), arg2, arg3);
        let v0 = FreezeEvent<T0>{
            addr   : arg2,
            frozen : false,
        };
        0x2::event::emit<FreezeEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

