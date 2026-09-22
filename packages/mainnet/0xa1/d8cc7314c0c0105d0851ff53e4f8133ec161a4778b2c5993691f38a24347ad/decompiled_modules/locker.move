module 0xa1d8cc7314c0c0105d0851ff53e4f8133ec161a4778b2c5993691f38a24347ad::locker {
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
        let v0 = 0x2::object::new(arg2);
        let v1 = Locked{
            locker_id   : 0x2::object::uid_to_inner(&v0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1),
            pool_id     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1),
            liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg1),
        };
        0x2::event::emit<Locked>(v1);
        Locker<T0>{
            id       : v0,
            position : arg1,
        }
    }

    public fun position_id<T0>(arg0: &Locker<T0>) : 0x2::object::ID {
        0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)
    }

    // decompiled from Move bytecode v7
}

