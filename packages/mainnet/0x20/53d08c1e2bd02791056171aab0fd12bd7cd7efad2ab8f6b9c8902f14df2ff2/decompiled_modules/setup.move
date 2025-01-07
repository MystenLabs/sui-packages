module 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::setup {
    public(friend) fun setup<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::ManagedTreasury<T0> {
        let v0 = 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::new<T0>(arg0, arg1, arg2);
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::admin::setup<T0>(&mut v0, arg2);
        0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::authorize<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole, 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::admin::AdminConfig>(0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::treasury::roles_mut<T0>(&mut v0), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::new_role<0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::roles::AdminRole>(0x2::tx_context::sender(arg2)), 0x2053d08c1e2bd02791056171aab0fd12bd7cd7efad2ab8f6b9c8902f14df2ff2::admin::new_config(false));
        v0
    }

    // decompiled from Move bytecode v6
}

