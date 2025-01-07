module 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::unstake {
    struct UnstakeEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        unstake_amount: u64,
        total_staked: u64,
        tx_sender: address,
    }

    public fun unstake<T0>(arg0: &mut 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>, arg1: &mut 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt, arg2: u64, arg3: &0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::assert_supported_version(arg3);
        assert!(arg2 > 0, 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::error::zero_amount());
        let v0 = UnstakeEvent{
            farm_id        : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>>(arg0),
            receipt_id     : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt>(arg1),
            unstake_amount : arg2,
            total_staked   : 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::total_staked<T0>(arg0),
            tx_sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<UnstakeEvent>(v0);
        0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::unstake<T0>(arg0, arg1, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

