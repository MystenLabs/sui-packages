module 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::operate {
    public entry fun add_pool<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::add_pool<T0>(arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun after_set_boost<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg4: &0x2::clock::Clock) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::after_set_boost<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun extract_bank<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Bank<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::extract_bank<T0, T1>(arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun flip_boost<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: &0x2::clock::Clock) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::flip_boost<T0, T1>(arg2, arg3);
    }

    public entry fun funding_bank<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::funding_bank<T0, T1>(arg2, arg3);
    }

    public entry fun set_boost(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: address, arg3: u64) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::set_boost(arg1, arg2, arg3);
    }

    public entry fun set_pool<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: bool) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::set_pool<T0>(arg2, arg3);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::manage::OperatorCap, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg1);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

