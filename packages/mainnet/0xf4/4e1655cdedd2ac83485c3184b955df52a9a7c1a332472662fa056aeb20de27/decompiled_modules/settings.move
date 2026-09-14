module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::settings {
    struct Settings has copy, drop, store {
        synth_bps: u64,
        hot_bps: u64,
        lending_bps: u64,
        margin_bps: u64,
        engine_lending_bps: u64,
        max_trade_bps: u64,
        hibernation_floor: u64,
        hibernation_enabled: bool,
        pause_on_market_close: bool,
    }

    public fun allocations(arg0: &Settings) : (u64, u64, u64, u64) {
        (arg0.synth_bps, arg0.hot_bps, arg0.lending_bps, arg0.margin_bps)
    }

    public fun defaults() : Settings {
        new(8000, 1000, 1000, 0, 4500, 500, 2000000000, true, true)
    }

    public fun engine_lending_bps(arg0: &Settings) : u64 {
        arg0.engine_lending_bps
    }

    public fun hibernation_enabled(arg0: &Settings) : bool {
        arg0.hibernation_enabled
    }

    public fun hibernation_floor(arg0: &Settings) : u64 {
        arg0.hibernation_floor
    }

    public fun max_trade(arg0: &Settings) : u64 {
        arg0.max_trade_bps
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool) : Settings {
        let v0 = Settings{
            synth_bps             : arg0,
            hot_bps               : arg1,
            lending_bps           : arg2,
            margin_bps            : arg3,
            engine_lending_bps    : arg4,
            max_trade_bps         : arg5,
            hibernation_floor     : arg6,
            hibernation_enabled   : arg7,
            pause_on_market_close : arg8,
        };
        validate(&v0);
        v0
    }

    public fun session_guard(arg0: &Settings) : bool {
        arg0.pause_on_market_close
    }

    public fun spot(arg0: u64, arg1: bool) : Settings {
        new(0, 10000, 0, 0, 0, arg0, 0, arg1, false)
    }

    public fun validate(arg0: &Settings) {
        let v0 = if (arg0.synth_bps == 0) {
            if (arg0.hot_bps == 10000) {
                if (arg0.lending_bps == 0) {
                    if (arg0.margin_bps == 0) {
                        if (arg0.engine_lending_bps == 0) {
                            !arg0.pause_on_market_close
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg0.synth_bps <= 9500) {
            if (arg0.synth_bps >= 5000) {
                arg0.hot_bps >= 500
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        assert!(arg0.synth_bps + arg0.hot_bps + arg0.lending_bps + arg0.margin_bps == 10000, 1);
        assert!(arg0.lending_bps <= 6000 && arg0.engine_lending_bps <= 4500, 1);
        assert!(arg0.max_trade_bps > 0 && arg0.max_trade_bps <= 1000, 1);
    }

    // decompiled from Move bytecode v7
}

