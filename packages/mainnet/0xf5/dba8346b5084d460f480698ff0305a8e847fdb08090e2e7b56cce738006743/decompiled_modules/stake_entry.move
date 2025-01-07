module 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake_entry {
    public entry fun stake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::GlobalStorage, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::stake<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::GlobalStorage, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::claim<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::GlobalStorage, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun early_end<T0, T1>(arg0: &0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::AdminCap, arg1: &mut 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::GlobalStorage, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::early_end<T0, T1>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun unstake<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::GlobalStorage, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf5dba8346b5084d460f480698ff0305a8e847fdb08090e2e7b56cce738006743::stake::unstake<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

