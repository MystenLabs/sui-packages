module 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::operate {
    public entry fun add_pool<T0>(arg0: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage::OperatorCap, arg1: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::assert_version(arg1);
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::add_pool<T0>(arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage::OperatorCap, arg1: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting, arg2: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::assert_version(arg1);
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun funding_bank<T0, T1>(arg0: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage::OperatorCap, arg1: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting, arg2: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::assert_version(arg1);
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::funding_bank<T0, T1>(arg2, arg3);
    }

    public entry fun set_pool<T0>(arg0: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage::OperatorCap, arg1: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting, arg2: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Pool<T0>, arg3: bool) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::assert_version(arg1);
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::set_pool<T0>(arg2, arg3);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::manage::OperatorCap, arg1: &0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Setting, arg2: &mut 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::assert_version(arg1);
        0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

