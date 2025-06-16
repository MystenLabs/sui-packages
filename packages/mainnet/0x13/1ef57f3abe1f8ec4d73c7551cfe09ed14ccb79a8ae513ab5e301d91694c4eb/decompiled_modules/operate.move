module 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::operate {
    public entry fun add_pool<T0>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x2::tx_context::TxContext) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::add_pool<T0>(arg1, arg2);
    }

    public entry fun add_reward_config<T0, T1>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Pool<T0>, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::add_reward_config<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun after_set_boost<T0>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Pool<T0>, arg3: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Deposit<T0>, arg4: &0x2::clock::Clock) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::after_set_boost<T0>(arg1, arg2, arg3, arg4);
    }

    public entry fun extract_bank<T0, T1>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Bank<T0, T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::extract_bank<T0, T1>(arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun flip_boost<T0, T1>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Pool<T0>, arg3: &0x2::clock::Clock) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::flip_boost<T0, T1>(arg2, arg3);
    }

    public entry fun funding_bank<T0, T1>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Bank<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::funding_bank<T0, T1>(arg2, arg3);
    }

    public entry fun set_boost(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: vector<address>, arg3: vector<u64>) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::set_boost(arg1, *0x1::vector::borrow<address>(&arg2, v0), *0x1::vector::borrow<u64>(&arg3, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun set_pool<T0>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Pool<T0>, arg3: bool) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::set_pool<T0>(arg2, arg3);
    }

    public entry fun set_reward_config<T0, T1>(arg0: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::manage::OperatorCap, arg1: &0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Setting, arg2: &mut 0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::Pool<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::assert_version(arg1);
        0x131ef57f3abe1f8ec4d73c7551cfe09ed14ccb79a8ae513ab5e301d91694c4eb::core::set_reward_config<T0, T1>(arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

