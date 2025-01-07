module 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::cetus {
    public fun collect<T0: drop, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::FeeSettings, arg3: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T1, T2>(arg0, arg1, 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::borrow_position<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3, arg4), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T1>(&v3);
        let v5 = 0x2::balance::value<T2>(&v2);
        let v6 = 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::calculate(arg2, v4);
        let v7 = 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::calculate(arg2, v5);
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_fee_a<T0>(arg3, v4, v6);
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_fee_b<T0>(arg3, v5, v7);
        let v8 = 0x2::coin::from_balance<T1>(v3, arg5);
        let v9 = 0x2::coin::from_balance<T2>(v2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v8, v6, arg5), 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::recipient(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::split<T2>(&mut v9, v7, arg5), 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::fee::recipient(arg2));
        (v8, v9)
    }

    public fun lock_liquidity<T0: drop, T1, T2>(arg0: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T1, T2>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1));
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::add_position<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v0, v1);
    }

    public fun pending_fees<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_fee<T0, T1>(arg0, arg1)
    }

    public fun unlock_liquidity<T0: drop, T1, T2>(arg0: &mut 0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::Lock<T0>, arg1: 0x2::object::ID, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T1, T2>(arg2, arg1);
        0x30c875560619ee5c842b457912973da3ca4681f3d895064d7cd7f0894862fc68::lock::remove_position<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg1, v0, v1, arg3)
    }

    // decompiled from Move bytecode v6
}

