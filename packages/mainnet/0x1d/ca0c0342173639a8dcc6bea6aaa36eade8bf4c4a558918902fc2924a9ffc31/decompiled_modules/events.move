module 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::events {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
        fee_amount_x: u64,
        fee_amount_y: u64,
    }

    struct Compounded has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_amount_x: u64,
        new_amount_y: u64,
        fee_amount_x: u64,
        fee_amount_y: u64,
    }

    struct Zapped has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        new_amount_x: u64,
        new_amount_y: u64,
        fee_amount_x: u64,
        fee_amount_y: u64,
        is_zapped_in: bool,
    }

    public fun emit_compounded<T0>(arg0: &0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::assert_witness<T0>(arg0);
        let v0 = Compounded{
            pool_id      : arg2,
            position_id  : arg3,
            new_amount_x : arg4,
            new_amount_y : arg5,
            fee_amount_x : arg6,
            fee_amount_y : arg7,
        };
        0x2::event::emit<Compounded>(v0);
    }

    public fun emit_rebalanced<T0>(arg0: &0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::assert_witness<T0>(arg0);
        let v0 = Rebalanced{
            pool_id         : arg2,
            old_position_id : arg3,
            new_position_id : arg4,
            old_amount_x    : arg5,
            old_amount_y    : arg6,
            new_amount_x    : arg7,
            new_amount_y    : arg8,
            fee_amount_x    : arg9,
            fee_amount_y    : arg10,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped<T0>(arg0: &0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::assert_witness<T0>(arg0);
        let v0 = Zapped{
            pool_id      : arg2,
            position_id  : arg3,
            new_amount_x : arg4,
            new_amount_y : arg5,
            fee_amount_x : arg6,
            fee_amount_y : arg7,
            is_zapped_in : arg8,
        };
        0x2::event::emit<Zapped>(v0);
    }

    // decompiled from Move bytecode v6
}

