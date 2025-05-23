module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::freezer {
    struct FreezerRole has drop {
        dummy_field: bool,
    }

    struct FreezeEvent<phantom T0> has copy, drop {
        addr: address,
        frozen: bool,
    }

    public fun freeze_address<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<FreezerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_not_paused<FreezerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0));
        0x2::coin::deny_list_add<T0>(arg1, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::denylist_cap_mut<T0>(arg0), arg2, arg3);
        let v0 = FreezeEvent<T0>{
            addr   : arg2,
            frozen : true,
        };
        0x2::event::emit<FreezeEvent<T0>>(v0);
    }

    public fun unfreeze_address<T0>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<FreezerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg3));
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_not_paused<FreezerRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0));
        0x2::coin::deny_list_remove<T0>(arg1, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::denylist_cap_mut<T0>(arg0), arg2, arg3);
        let v0 = FreezeEvent<T0>{
            addr   : arg2,
            frozen : false,
        };
        0x2::event::emit<FreezeEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

