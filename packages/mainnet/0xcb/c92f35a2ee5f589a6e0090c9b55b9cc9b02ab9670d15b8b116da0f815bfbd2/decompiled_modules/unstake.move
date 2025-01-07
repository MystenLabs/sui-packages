module 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::unstake {
    struct UnstakeEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        unstake_amount: u64,
        total_staked: u64,
        tx_sender: address,
    }

    public fun unstake<T0>(arg0: &mut 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>, arg1: &mut 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::StakeReceipt, arg2: u64, arg3: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg3);
        let v0 = UnstakeEvent{
            farm_id        : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(arg0),
            receipt_id     : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::StakeReceipt>(arg1),
            unstake_amount : arg2,
            total_staked   : 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::total_staked<T0>(arg0),
            tx_sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UnstakeEvent>(v0);
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::unstake<T0>(arg0, arg1, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

