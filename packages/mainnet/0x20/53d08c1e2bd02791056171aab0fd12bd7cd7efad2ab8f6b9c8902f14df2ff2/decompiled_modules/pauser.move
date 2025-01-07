module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::pauser {
    struct PauserRole has drop {
        dummy_field: bool,
    }

    struct PauseEvent<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        paused: bool,
    }

    public fun pause<T0, T1: drop>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<PauserRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg1));
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::pause<T1>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0));
        let v0 = PauseEvent<T0>{
            role   : 0x1::type_name::get<T1>(),
            paused : true,
        };
        0x2::event::emit<PauseEvent<T0>>(v0);
    }

    public fun resume<T0, T1: drop>(arg0: &mut 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::assert_is_authorized<PauserRole>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg1));
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::unpause<T1>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(arg0));
        let v0 = PauseEvent<T0>{
            role   : 0x1::type_name::get<T1>(),
            paused : false,
        };
        0x2::event::emit<PauseEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

