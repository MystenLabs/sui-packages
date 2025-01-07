module 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::claim {
    struct RewardsClaimedEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        reward_amount: u64,
        tx_sender: address,
    }

    public fun claim_reward<T0, T1>(arg0: &mut 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm::Farm<T0>, arg1: &mut 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm::StakeReceipt, arg2: &0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::version::assert_supported_version(arg2);
        let v0 = 0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm::claim_reward<T0, T1>(arg0, arg1, arg3);
        let v1 = RewardsClaimedEvent{
            farm_id       : 0x2::object::id<0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm::Farm<T0>>(arg0),
            receipt_id    : 0x2::object::id<0x24296c2e3ab5a69cef549694fbff1a36fb601f12ac7904b8d86d7593146caeee::farm::StakeReceipt>(arg1),
            reward_type   : 0x1::type_name::get<T1>(),
            reward_amount : 0x2::balance::value<T1>(&v0),
            tx_sender     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<RewardsClaimedEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

