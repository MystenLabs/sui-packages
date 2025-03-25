module 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::interface {
    public entry fun add_deposit<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg3: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg4: &0x2::clock::Clock) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg0);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::add_deposit<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun deposit<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg0);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::deposit<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun harvest<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg3: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Bank<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = raw_harvest<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun remaining<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::remaining<T0>(arg0, arg1, arg2)
    }

    public entry fun withdraw<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = raw_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun raw_harvest<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg3: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Bank<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg0);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::harvest<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun raw_withdraw<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg1: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg0);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::withdraw<T0>(arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

