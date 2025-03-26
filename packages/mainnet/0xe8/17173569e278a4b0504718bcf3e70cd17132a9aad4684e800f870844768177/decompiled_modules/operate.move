module 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::operate {
    public entry fun add_pool<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::add_pool<T0>(arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun extract_bank<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Bank<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::extract_bank<T0, T1>(arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun funding_bank<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::funding_bank<T0, T1>(arg2, arg3);
    }

    public entry fun set_pool<T0>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg3: bool) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::set_pool<T0>(arg2, arg3);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::manage::OperatorCap, arg1: &0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Setting, arg2: &mut 0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::assert_version(arg1);
        0x350fc249898202ccb858546fcbee2031f20372ba2dc7d17a858b8f1a9ac31f66::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

