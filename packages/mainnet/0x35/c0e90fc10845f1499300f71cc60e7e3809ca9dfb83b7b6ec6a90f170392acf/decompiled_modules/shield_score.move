module 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::shield_score {
    public fun compute_score(arg0: u8, arg1: u8, arg2: u8) : u8 {
        let v0 = ((arg0 as u64) * 40 + (arg1 as u64) * 35 + (arg2 as u64) * 25) / 100;
        if (v0 > 100) {
            100
        } else {
            (v0 as u8)
        }
    }

    public fun deposits_allowed(arg0: u8) : bool {
        arg0 != 2
    }

    public fun health_component_from_bps(arg0: u64) : u8 {
        let v0 = arg0 / 100;
        if (v0 >= 100) {
            100
        } else {
            (v0 as u8)
        }
    }

    public fun status_caution() : u8 {
        1
    }

    public fun status_from_score(arg0: u8) : u8 {
        if (arg0 < 30) {
            2
        } else if (arg0 < 60) {
            1
        } else {
            0
        }
    }

    public fun status_paused() : u8 {
        2
    }

    public fun status_safe() : u8 {
        0
    }

    public fun util_component_from_bps(arg0: u64) : u8 {
        let v0 = arg0 / 100;
        if (v0 >= 100) {
            0
        } else {
            100 - (v0 as u8)
        }
    }

    public fun vol_component_from_bps(arg0: u64) : u8 {
        let v0 = arg0 / 50;
        if (v0 >= 100) {
            0
        } else {
            100 - (v0 as u8)
        }
    }

    // decompiled from Move bytecode v7
}

