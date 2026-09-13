module 0xc3f6f683a5da0d555a303f9fa5a43e86a6dcfcd399760426428963bdacc242fc::locker {
    struct Locker<phantom T0> has store, key {
        id: 0x2::object::UID,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
    }

    struct Locked has copy, drop {
        locker_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        liquidity: u128,
    }

    public fun position<T0: drop>(arg0: T0, arg1: &Locker<T0>) : &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        &arg1.position
    }

    public fun liquidity<T0>(arg0: &Locker<T0>) : u128 {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg0.position)
    }

    public fun pool_id<T0>(arg0: &Locker<T0>) : 0x2::object::ID {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg0.position)
    }

    public fun lock<T0: drop>(arg0: T0, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &mut 0x2::tx_context::TxContext) : Locker<T0> {
        let v0 = Locker<T0>{
            id       : 0x2::object::new(arg2),
            position : arg1,
        };
        let v1 = Locked{
            locker_id   : 0x2::object::id<Locker<T0>>(&v0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0.position),
            pool_id     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v0.position),
            liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0.position),
        };
        0x2::event::emit<Locked>(v1);
        v0
    }

    public fun position_id<T0>(arg0: &Locker<T0>) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    // decompiled from Move bytecode v7
}

