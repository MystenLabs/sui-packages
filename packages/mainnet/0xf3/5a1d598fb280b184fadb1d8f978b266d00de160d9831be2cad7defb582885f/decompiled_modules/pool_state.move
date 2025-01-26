module 0xf35a1d598fb280b184fadb1d8f978b266d00de160d9831be2cad7defb582885f::pool_state {
    struct PoolState has copy, drop, store {
        pool_id: 0x2::object::ID,
        unit: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float,
    }

    public(friend) fun add_unit(arg0: &mut PoolState, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float) {
        arg0.unit = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::add(unit(arg0), arg1);
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float) : PoolState {
        PoolState{
            pool_id : arg0,
            unit    : arg1,
        }
    }

    public fun pool_id(arg0: &PoolState) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun unit(arg0: &PoolState) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::double::Float {
        arg0.unit
    }

    // decompiled from Move bytecode v6
}

