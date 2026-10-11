module 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lpfees {
    struct FeesCollected has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        to: address,
    }

    struct RewardCollected has copy, drop {
        lock_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    public fun collect_fee<T0, T1>(arg0: &0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLockCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg2, arg3, v0, true);
        let v3 = v2;
        let v4 = v1;
        let v5 = FeesCollected{
            lock_id     : 0x2::object::id<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0),
            amount_a    : 0x2::balance::value<T0>(&v4),
            amount_b    : 0x2::balance::value<T1>(&v3),
            to          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<FeesCollected>(v5);
        (0x2::coin::from_balance<T0>(v4, arg4), 0x2::coin::from_balance<T1>(v3, arg4))
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, arg1: &0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLockCap, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg2, arg3, v0, arg4, true, arg5);
        let v2 = RewardCollected{
            lock_id     : 0x2::object::id<0x6827c30e3cde4f1cd4775a8fedb0c442a97d55b7adc5f82a202434c907efce1::lplock::LpLock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>>(arg0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0),
            amount      : 0x2::balance::value<T2>(&v1),
            to          : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardCollected>(v2);
        0x2::coin::from_balance<T2>(v1, arg6)
    }

    // decompiled from Move bytecode v7
}

