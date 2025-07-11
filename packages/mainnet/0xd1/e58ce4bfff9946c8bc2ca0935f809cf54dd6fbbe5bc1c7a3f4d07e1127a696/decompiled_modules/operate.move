module 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::operate {
    public entry fun add_pool<T0>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::add_pool<T0>(arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun after_set_boost<T0>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg4: &0x2::clock::Clock) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun extract_bank<T0, T1>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Bank<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::extract_bank<T0, T1>(arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun flip_boost<T0, T1>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: &0x2::clock::Clock) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::flip_boost<T0, T1>(arg2, arg3);
    }

    public entry fun funding_bank<T0, T1>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::funding_bank<T0, T1>(arg2, arg3);
    }

    public entry fun set_boost(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: vector<address>, arg3: vector<u64>) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::set_boost(arg1, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_pool<T0>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: bool) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::set_pool<T0>(arg2, arg3);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    public entry fun after_set_boost_batch<T0>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::manage::OperatorCap, arg1: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg3: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg4: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg5: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg6: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg7: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg8: &0x2::clock::Clock) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg1);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg3, arg8);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg4, arg8);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg5, arg8);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg6, arg8);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::after_set_boost<T0>(arg1, arg2, arg7, arg8);
    }

    public entry fun settle_batch<T0>(arg0: &0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Setting, arg1: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Pool<T0>, arg2: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg3: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg4: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg5: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg6: &mut 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::Deposit<T0>, arg7: &0x2::clock::Clock) {
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::assert_version(arg0);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::settle<T0>(arg0, arg1, arg2, arg7);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::settle<T0>(arg0, arg1, arg3, arg7);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::settle<T0>(arg0, arg1, arg4, arg7);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::settle<T0>(arg0, arg1, arg5, arg7);
        0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core::settle<T0>(arg0, arg1, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

