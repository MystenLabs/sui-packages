module 0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::events {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
    }

    struct Compounded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_amount_x: u64,
        new_amount_y: u64,
    }

    struct ZappedIn has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_amount_x: u64,
        new_amount_y: u64,
    }

    struct ZappedOut has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        zap_token: 0x1::type_name::TypeName,
        zap_amount: u64,
    }

    public fun emit_compounded<T0>(arg0: &0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::assert_witness<T0>(arg0);
        let v0 = Compounded{
            pool_id      : arg2,
            position_id  : arg3,
            new_amount_x : arg4,
            new_amount_y : arg5,
        };
        0x2::event::emit<Compounded>(v0);
    }

    public fun emit_rebalanced<T0>(arg0: &0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::assert_witness<T0>(arg0);
        let v0 = Rebalanced{
            pool_id         : arg2,
            old_position_id : arg3,
            new_position_id : arg4,
            old_amount_x    : arg5,
            old_amount_y    : arg6,
            new_amount_x    : arg7,
            new_amount_y    : arg8,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in<T0>(arg0: &0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::assert_witness<T0>(arg0);
        let v0 = ZappedIn{
            pool_id      : arg2,
            position_id  : arg3,
            new_amount_x : arg4,
            new_amount_y : arg5,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    public fun emit_zapped_out<T0>(arg0: &0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: u64) {
        0x62ff6e2f57364805c56b18ac4d46fcbb96f65f2089da1a0d08f13458fcf35c8e::registry::assert_witness<T0>(arg0);
        let v0 = ZappedOut{
            pool_id     : arg2,
            position_id : arg3,
            zap_token   : arg4,
            zap_amount  : arg5,
        };
        0x2::event::emit<ZappedOut>(v0);
    }

    // decompiled from Move bytecode v6
}

