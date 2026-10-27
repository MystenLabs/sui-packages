module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position {
    struct Position has copy, drop, store {
        owner: address,
        is_long: bool,
        entry_tick: u64,
        day: u64,
        entry_price: u64,
        margin: u64,
        leverage: u64,
        notional: u64,
        bust_price: u64,
    }

    public fun bust_line(arg0: &Position) : u64 {
        arg0.bust_price
    }

    public fun bust_price(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = 1000000000000000000 / (arg2 as u128);
        assert!(v0 > (arg3 as u128), 1);
        let v1 = if (arg0) {
            0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg1 as u128), 1000000000000000000 - v0 - (arg3 as u128), 1000000000000000000, true)
        } else {
            0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg1 as u128), 1000000000000000000 + v0 - (arg3 as u128), 1000000000000000000, false)
        };
        assert!(v1 <= 18446744073709551615, 0);
        (v1 as u64)
    }

    public fun busts_at(arg0: &Position, arg1: u64) : bool {
        arg0.is_long && arg1 <= arg0.bust_price || arg1 >= arg0.bust_price
    }

    public fun busts_within(arg0: &Position, arg1: u64, arg2: u64) : bool {
        arg0.is_long && arg1 <= arg0.bust_price || arg2 >= arg0.bust_price
    }

    public fun day(arg0: &Position) : u64 {
        arg0.day
    }

    public fun entry_price(arg0: &Position) : u64 {
        arg0.entry_price
    }

    public fun entry_tick(arg0: &Position) : u64 {
        arg0.entry_tick
    }

    public fun is_long(arg0: &Position) : bool {
        arg0.is_long
    }

    public fun kept_win(arg0: u64, arg1: u64, arg2: u64, arg3: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = (arg0 as u256) * (1000000000000000000 as u256) / (arg1 as u256);
        let v1 = (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::deadband_wad(arg3) as u256);
        if (v0 <= v1) {
            return 0
        };
        let v2 = v0 - v1;
        let v3 = ((1000000000000000000 - (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::haircut_b_wad(arg3) as u128)) as u256);
        let v4 = (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::haircut_h_wad(arg3) as u256);
        let v5 = v3 * v4;
        let v6 = v2 + v4;
        let v7 = if (v5 % v6 != 0) {
            1
        } else {
            0
        };
        let v8 = v5 / v6 + v7;
        let v9 = if (v8 >= v3) {
            0
        } else {
            v3 - v8
        };
        let v10 = (arg2 as u256) * v2 * v9 / (1000000000000000000 as u256) / (1000000000000000000 as u256);
        if (v10 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v10 as u64)
        }
    }

    public fun leverage(arg0: &Position) : u64 {
        arg0.leverage
    }

    public fun liquidated() : u8 {
        2
    }

    public fun loss() : u8 {
        1
    }

    public fun margin(arg0: &Position) : u64 {
        arg0.margin
    }

    public fun notional(arg0: &Position) : u64 {
        arg0.notional
    }

    public(friend) fun open(arg0: address, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : Position {
        assert!(arg4 > 0, 0);
        assert!(arg6 > 0 && arg6 <= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::max_leverage(arg7), 0);
        assert!(arg5 >= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::min_margin(arg7), 0);
        let v0 = (arg5 as u128) * (arg6 as u128);
        assert!(v0 <= (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::max_position_notional(arg7) as u128), 0);
        Position{
            owner       : arg0,
            is_long     : arg1,
            entry_tick  : arg2,
            day         : arg3,
            entry_price : arg4,
            margin      : arg5,
            leverage    : arg6,
            notional    : (v0 as u64),
            bust_price  : bust_price(arg1, arg4, arg6, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::buffer_wad(arg7)),
        }
    }

    public fun owner(arg0: &Position) : address {
        arg0.owner
    }

    public(friend) fun settle(arg0: &Position, arg1: u64, arg2: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) : (u8, u64) {
        if (busts_at(arg0, arg1)) {
            return (2, arg0.margin)
        };
        let v0 = if (arg1 > arg0.entry_price) {
            arg1 - arg0.entry_price
        } else {
            arg0.entry_price - arg1
        };
        if (arg0.is_long && arg1 > arg0.entry_price || arg1 < arg0.entry_price) {
            (0, kept_win(v0, arg0.entry_price, arg0.notional, arg2))
        } else {
            let v3 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg0.notional as u128), (v0 as u128), (arg0.entry_price as u128), true);
            let v4 = if (v3 > (arg0.margin as u128)) {
                arg0.margin
            } else {
                (v3 as u64)
            };
            (1, v4)
        }
    }

    public(friend) fun settle_plain(arg0: &Position, arg1: u64) : (u8, u64) {
        if (busts_at(arg0, arg1)) {
            return (2, arg0.margin)
        };
        let v0 = if (arg1 > arg0.entry_price) {
            arg1 - arg0.entry_price
        } else {
            arg0.entry_price - arg1
        };
        if (arg0.is_long && arg1 > arg0.entry_price || arg1 < arg0.entry_price) {
            let v3 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg0.notional as u128), (v0 as u128), (arg0.entry_price as u128), false);
            let v4 = if (v3 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v3 as u64)
            };
            (0, v4)
        } else {
            let v5 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::mul_div((arg0.notional as u128), (v0 as u128), (arg0.entry_price as u128), true);
            let v6 = if (v5 > (arg0.margin as u128)) {
                arg0.margin
            } else {
                (v5 as u64)
            };
            (1, v6)
        }
    }

    public fun win() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

