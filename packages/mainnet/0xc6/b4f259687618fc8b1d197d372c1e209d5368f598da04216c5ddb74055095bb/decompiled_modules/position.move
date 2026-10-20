module 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::position {
    struct Pnl has copy, drop {
        loss: u64,
        raw: u64,
        adjusted: u64,
        win_fee: u64,
        close_toll: u64,
        net: u64,
    }

    fun abs_diff(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun bust_long(arg0: u128, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 <= 1000000000000000, 13835058227080855553);
        assert!(arg1 >= 1, 13835339706352664579);
        assert!(arg0 > 0, 13835621185624473605);
        let v0 = (arg1 as u256);
        ((ceil_div((arg0 as u256) * (v0 - 1), v0) * (1000000000000000000 + (arg2 as u256)) / 1000000000000000000) as u128)
    }

    public fun bust_short(arg0: u128, arg1: u64, arg2: u128) : u128 {
        assert!(arg2 <= 1000000000000000, 13835058278620463105);
        assert!(arg1 >= 1, 13835339757892272131);
        assert!(arg0 > 0, 13835621237164081157);
        let v0 = (arg1 as u256);
        let v1 = 1000000000000000000;
        (ceil_div((arg0 as u256) * (v0 + 1) / v0 * (v1 - (arg2 as u256)), v1) as u128)
    }

    public fun c_wad(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * 1000000000000000000 / (arg1 as u256)) as u128)
    }

    fun ceil_div(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 + arg1 - 1) / arg1
        }
    }

    public fun charged_spread(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let v0 = (arg0 as u256) * (arg2 as u256) / 10000;
        let v1 = (arg1 as u256);
        let v2 = if (v1 > v0) {
            v1
        } else {
            v0
        };
        (v2 as u128)
    }

    public fun crossed_bust(arg0: bool, arg1: u128, arg2: u128) : bool {
        arg0 && arg1 <= arg2 || arg1 >= arg2
    }

    public fun pnl_adjusted(arg0: &Pnl) : u64 {
        arg0.adjusted
    }

    public fun pnl_close_toll(arg0: &Pnl) : u64 {
        arg0.close_toll
    }

    public fun pnl_loss(arg0: &Pnl) : u64 {
        arg0.loss
    }

    public fun pnl_net(arg0: &Pnl) : u64 {
        arg0.net
    }

    public fun pnl_raw(arg0: &Pnl) : u64 {
        arg0.raw
    }

    public fun pnl_win_fee(arg0: &Pnl) : u64 {
        arg0.win_fee
    }

    public fun settle(arg0: bool, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : Pnl {
        assert!(arg7 >= 1 && arg7 <= 1000, 13835902840989941767);
        assert!(arg3 > 0 && arg4 > 0, 13835621370308067333);
        assert!(arg2 <= arg1, 13836184324556718089);
        let v0 = arg0 && arg4 > arg3 || arg3 > arg4;
        if (!v0) {
            return Pnl{
                loss       : (((arg1 as u256) * (abs_diff(arg3, arg4) as u256) / (arg3 as u256)) as u64),
                raw        : 0,
                adjusted   : 0,
                win_fee    : 0,
                close_toll : (((arg1 as u128) * (arg6 as u128) / 1000000) as u64),
                net        : 0,
            }
        };
        let v1 = abs_diff(arg3, arg4);
        let v2 = (arg3 as u256) * (arg5 as u256) / 1000000;
        if ((v1 as u256) <= v2) {
            return Pnl{
                loss       : 0,
                raw        : 0,
                adjusted   : 0,
                win_fee    : 0,
                close_toll : (((arg1 as u128) * (arg6 as u128) / 1000000) as u64),
                net        : 0,
            }
        };
        let v3 = (v1 as u256) - v2;
        let v4 = (((arg2 as u256) * v3 / (arg3 as u256)) as u64);
        let v5 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::trim_profit(v4, (v3 as u128), arg3, arg8, arg9);
        let v6 = (((v5 as u128) * (arg7 as u128) / 10000) as u64);
        Pnl{
            loss       : 0,
            raw        : v4,
            adjusted   : v5,
            win_fee    : v6,
            close_toll : (((arg1 as u128) * (arg6 as u128) / 1000000) as u64),
            net        : v5 - v6,
        }
    }

    // decompiled from Move bytecode v7
}

