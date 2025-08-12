module 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::collect {
    struct FeeCollectedEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct CollectPoolRewardEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        reward_coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun fee<T0, T1>(arg0: &mut 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1>, arg1: &mut 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::Position, arg2: &0x2::clock::Clock, arg3: &0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::assert_supported_version(arg3);
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::assert_not_pause<T0, T1>(arg0);
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::verify_pool<T0, T1>(arg0, 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::pool_id(arg1));
        if (0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::liquidity(arg1) > 0) {
            let (_, _) = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::update_data_for_delta_l<T0, T1>(arg0, arg1, 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::i128::zero(), arg2);
        };
        let (v2, v3) = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::collect_fee<T0, T1>(arg0, arg1);
        let v4 = v3;
        let v5 = v2;
        let v6 = FeeCollectedEvent{
            sender      : 0x2::tx_context::sender(arg4),
            pool_id     : 0x2::object::id<0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1>>(arg0),
            position_id : 0x2::object::id<0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::Position>(arg1),
            amount_x    : 0x2::balance::value<T0>(&v5),
            amount_y    : 0x2::balance::value<T1>(&v4),
        };
        0x2::event::emit<FeeCollectedEvent>(v6);
        (0x2::coin::from_balance<T0>(v5, arg4), 0x2::coin::from_balance<T1>(v4, arg4))
    }

    public fun reward<T0, T1, T2>(arg0: &mut 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1>, arg1: &mut 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::Position, arg2: &0x2::clock::Clock, arg3: &0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::version::assert_supported_version(arg3);
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::assert_not_pause<T0, T1>(arg0);
        0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::verify_pool<T0, T1>(arg0, 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::pool_id(arg1));
        if (0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::liquidity(arg1) > 0) {
            let (_, _) = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::update_data_for_delta_l<T0, T1>(arg0, arg1, 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::i128::zero(), arg2);
        };
        let v2 = 0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::collect_reward<T0, T1, T2>(arg0, arg1);
        let v3 = CollectPoolRewardEvent{
            sender           : 0x2::tx_context::sender(arg4),
            pool_id          : 0x2::object::id<0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::pool::Pool<T0, T1>>(arg0),
            position_id      : 0x2::object::id<0xbd64d178c50ed0f87c829a47af28b94f95f6462e519d1a39995be026106a0f6a::position::Position>(arg1),
            reward_coin_type : 0x1::type_name::get<T2>(),
            amount           : 0x2::balance::value<T2>(&v2),
        };
        0x2::event::emit<CollectPoolRewardEvent>(v3);
        0x2::coin::from_balance<T2>(v2, arg4)
    }

    // decompiled from Move bytecode v6
}

