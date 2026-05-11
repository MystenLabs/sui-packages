module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::position_lock {
    struct LockedPosition has key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        pool_id: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg1: &mut 0x2::tx_context::TxContext) : LockedPosition {
        LockedPosition{
            id       : 0x2::object::new(arg1),
            position : arg0,
            pool_id  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg0),
        }
    }

    public fun liquidity(arg0: &LockedPosition) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg0.position)
    }

    public fun pool_id(arg0: &LockedPosition) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun collect_fees<T0, T1>(arg0: &LockedPosition, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, &arg0.position, true)
    }

    public fun position_id(arg0: &LockedPosition) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    public(friend) fun share(arg0: LockedPosition) {
        0x2::transfer::share_object<LockedPosition>(arg0);
    }

    // decompiled from Move bytecode v6
}

