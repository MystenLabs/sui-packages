module 0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::unstake {
    struct UnstakeEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        unstake_amount: u64,
        total_staked: u64,
        tx_sender: address,
    }

    public fun unstake<T0>(arg0: &mut 0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::Farm<T0>, arg1: &mut 0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::StakeReceipt, arg2: u64, arg3: &0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::version::assert_supported_version(arg3);
        let v0 = UnstakeEvent{
            farm_id        : 0x2::object::id<0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::Farm<T0>>(arg0),
            receipt_id     : 0x2::object::id<0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::StakeReceipt>(arg1),
            unstake_amount : arg2,
            total_staked   : 0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::total_staked<T0>(arg0),
            tx_sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UnstakeEvent>(v0);
        0x1f1c306ae99ff9574eda4106b230f94923b4f9b2f6eda244474506a3df126e8d::farm::unstake<T0>(arg0, arg1, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

