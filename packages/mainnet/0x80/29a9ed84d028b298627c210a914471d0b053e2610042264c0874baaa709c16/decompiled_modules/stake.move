module 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::stake {
    struct StakeEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        stake_amount: u64,
        total_staked: u64,
        tx_sender: address,
    }

    struct IncreaseStakeEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        stake_amount: u64,
        total_staked: u64,
        tx_sender: address,
    }

    public fun increase_stake<T0>(arg0: &mut 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>, arg1: &mut 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::assert_supported_version(arg3);
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 > 0, 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::error::zero_amount());
        0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::increase_stake<T0>(arg0, arg1, arg2, arg4);
        let v1 = IncreaseStakeEvent{
            farm_id      : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>>(arg0),
            receipt_id   : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt>(arg1),
            stake_amount : v0,
            total_staked : 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::total_staked<T0>(arg0),
            tx_sender    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<IncreaseStakeEvent>(v1);
    }

    public fun stake<T0>(arg0: &mut 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt {
        0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::version::assert_supported_version(arg3);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::error::zero_amount());
        let v1 = 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::stake<T0>(arg0, arg1, arg2, arg4);
        let v2 = StakeEvent{
            farm_id      : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::Farm<T0>>(arg0),
            receipt_id   : 0x2::object::id<0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::StakeReceipt>(&v1),
            stake_amount : v0,
            total_staked : 0xba0dd78bdd5d1b5f02a689444522ea9a79e1bc4cd4d8e6a57b59f3fbcae5e978::farm::total_staked<T0>(arg0),
            tx_sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StakeEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

