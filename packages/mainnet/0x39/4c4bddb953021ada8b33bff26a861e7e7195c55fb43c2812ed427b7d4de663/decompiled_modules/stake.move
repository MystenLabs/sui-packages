module 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::stake {
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

    public fun increase_stake<T0>(arg0: &mut 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>, arg1: &mut 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::assert_supported_version(arg3);
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::increase_stake<T0>(arg0, arg1, arg2, arg4);
        let v0 = IncreaseStakeEvent{
            farm_id      : 0x2::object::id<0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>>(arg0),
            receipt_id   : 0x2::object::id<0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt>(arg1),
            stake_amount : 0x2::balance::value<T0>(&arg2),
            total_staked : 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::total_staked<T0>(arg0),
            tx_sender    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<IncreaseStakeEvent>(v0);
    }

    public fun stake<T0>(arg0: &mut 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt {
        0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::version::assert_supported_version(arg3);
        let v0 = 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::stake<T0>(arg0, arg1, arg2, arg4);
        let v1 = StakeEvent{
            farm_id      : 0x2::object::id<0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::Farm<T0>>(arg0),
            receipt_id   : 0x2::object::id<0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::StakeReceipt>(&v0),
            stake_amount : 0x2::balance::value<T0>(&arg1),
            total_staked : 0x394c4bddb953021ada8b33bff26a861e7e7195c55fb43c2812ed427b7d4de663::farm::total_staked<T0>(arg0),
            tx_sender    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<StakeEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

