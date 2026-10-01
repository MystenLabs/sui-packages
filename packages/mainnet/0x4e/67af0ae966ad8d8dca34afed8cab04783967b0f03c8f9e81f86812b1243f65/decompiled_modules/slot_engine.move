module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_engine {
    struct SpinOutcome has copy, drop {
        base_grid: vector<u8>,
        base_units: u64,
        base_scatters: u64,
        fs_units: u64,
        total_units: u64,
        free_spins_awarded: u64,
        free_spins_played: u64,
        retriggers: u64,
        final_multiplier: u64,
    }

    public fun base_grid(arg0: &SpinOutcome) : vector<u8> {
        arg0.base_grid
    }

    public fun base_scatters(arg0: &SpinOutcome) : u64 {
        arg0.base_scatters
    }

    public fun base_units(arg0: &SpinOutcome) : u64 {
        arg0.base_units
    }

    public fun build_grid(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = &mut v0;
        fill_grid(arg0, arg1, arg2, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0), 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rows(arg0), v1);
        v0
    }

    fun eval_cells(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>, arg2: &vector<u64>) : (u64, u64) {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::wild(arg0);
        let v1 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::paytable(arg0);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(arg2)) {
            let v4 = *0x1::vector::borrow<u8>(arg1, *0x1::vector::borrow<u64>(arg2, v3));
            let v5 = false;
            let v6 = true;
            let v7 = 0;
            let v8 = true;
            let v9 = 0;
            let v10 = 0;
            while (v10 < 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0)) {
                let v11 = *0x1::vector::borrow<u8>(arg1, *0x1::vector::borrow<u64>(arg2, v3));
                v3 = v3 + 1;
                v10 = v10 + 1;
                let v12 = v11 == v0;
                let v13 = !v12 && !v5;
                let v14 = if (v13) {
                    v11
                } else {
                    v4
                };
                v4 = v14;
                let v15 = v5 || v13;
                v5 = v15;
                let v16 = v12 || v11 == v11;
                let v17 = v6 && v16;
                v6 = v17;
                let v18 = if (v17) {
                    v10
                } else {
                    v7
                };
                v7 = v18;
                let v19 = v8 && v12;
                v8 = v19;
                let v20 = if (v19) {
                    v10
                } else {
                    v9
                };
                v9 = v20;
            };
            let v21 = if (v0 != 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::none()) {
                v0
            } else {
                v4
            };
            let v22 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(v1, (v4 as u64)), v7);
            let v23 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(v1, (v21 as u64)), v9);
            let v24 = if (v22 > v23) {
                v22
            } else {
                v23
            };
            v2 = v2 + v24;
        };
        let v25 = 0;
        let v26 = 0;
        while (v26 < 0x1::vector::length<u8>(arg1)) {
            let v27 = if (*0x1::vector::borrow<u8>(arg1, v26) == 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::scatter(arg0)) {
                1
            } else {
                0
            };
            v25 = v25 + v27;
            v26 = v26 + 1;
        };
        (v2, v25)
    }

    public fun eval_grid(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>) : (u64, u64) {
        let v0 = line_cells(arg0);
        eval_cells(arg0, arg1, &v0)
    }

    public fun evaluate(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>) : SpinOutcome {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0);
        let v1 = line_cells(arg0);
        let v2 = b"";
        let v3 = b"";
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::mult_start(arg0);
        let v11 = 0;
        while (v11 == 0 || v11 <= v7) {
            let v12 = &mut v2;
            fill_grid(arg0, arg1, v11 * v0, v0, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rows(arg0), v12);
            let (v13, v14) = eval_cells(arg0, &v2, &v1);
            let v15 = v13 + 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::scatter_pay(arg0, v14);
            let v16 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::has_free_spins(arg0) && v14 >= 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::fs_trigger(arg0);
            if (v11 == 0) {
                v3 = v2;
                v4 = v15;
                v5 = v14;
                let v17 = if (v16) {
                    0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::fs_award(arg0)
                } else {
                    0
                };
                v7 = v17;
            } else {
                v6 = v6 + v15 * v10;
                v8 = v8 + 1;
                if (v15 > 0) {
                    let v18 = v10 + 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::mult_step(arg0);
                    v10 = min(v18, 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::mult_max(arg0));
                };
                if (v16) {
                    let v19 = min(v7 + 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::fs_retrigger(arg0), 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::fs_max_total(arg0));
                    if (v19 > v7) {
                        v9 = v9 + 1;
                    };
                    v7 = v19;
                };
            };
            v11 = v11 + 1;
        };
        SpinOutcome{
            base_grid          : v3,
            base_units         : v4,
            base_scatters      : v5,
            fs_units           : v6,
            total_units        : v4 + v6,
            free_spins_awarded : v7,
            free_spins_played  : v8,
            retriggers         : v9,
            final_multiplier   : v10,
        }
    }

    fun fill_grid(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut vector<u8>) {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::strips(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg3) {
            let v3 = 0x1::vector::borrow<vector<u8>>(v0, v2);
            let v4 = 0;
            while (v4 < arg4) {
                if (0x1::vector::length<u8>(arg5) == 0) {
                    0x1::vector::push_back<u8>(arg5, *0x1::vector::borrow<u8>(v3, ((*0x1::vector::borrow<u8>(arg1, arg2 + v2) as u64) + v4) % 0x1::vector::length<u8>(v3)));
                } else {
                    *0x1::vector::borrow_mut<u8>(arg5, v1) = *0x1::vector::borrow<u8>(v3, ((*0x1::vector::borrow<u8>(arg1, arg2 + v2) as u64) + v4) % 0x1::vector::length<u8>(v3));
                };
                v1 = v1 + 1;
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
    }

    public fun final_multiplier(arg0: &SpinOutcome) : u64 {
        arg0.final_multiplier
    }

    public fun free_spins_awarded(arg0: &SpinOutcome) : u64 {
        arg0.free_spins_awarded
    }

    public fun free_spins_played(arg0: &SpinOutcome) : u64 {
        arg0.free_spins_played
    }

    public fun fs_units(arg0: &SpinOutcome) : u64 {
        arg0.fs_units
    }

    public fun line_cells(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig) : vector<u64> {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::paylines(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v0)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(v0, v2);
            let v4 = 0;
            while (v4 < 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0)) {
                0x1::vector::push_back<u64>(&mut v1, v4 * 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rows(arg0) + (*0x1::vector::borrow<u8>(v3, v4) as u64));
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun line_pay(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>, arg2: &vector<u8>) : u64 {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, v1 * 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::rows(arg0) + (*0x1::vector::borrow<u8>(arg2, v1) as u64));
            v1 = v1 + 1;
        };
        let (v2, _) = eval_cells(arg0, arg1, &v0);
        v2
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun payout(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: u64, arg2: u64, arg3: u64) : (u64, bool) {
        let v0 = (arg1 as u128) * (arg2 as u128) / (0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::payline_count(arg0) as u128);
        let v1 = v0 > (arg3 as u128);
        let v2 = if (v1) {
            arg3
        } else {
            (v0 as u64)
        };
        (v2, v1)
    }

    public fun random_bytes_per_spin(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig) : u64 {
        4 * 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::draws_per_spin(arg0)
    }

    public fun retriggers(arg0: &SpinOutcome) : u64 {
        arg0.retriggers
    }

    public fun stops_from_bytes(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::SlotConfig, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::strips(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::draws_per_spin(arg0)) {
            let v3 = 4 * v2;
            0x1::vector::push_back<u8>(&mut v1, ((((*0x1::vector::borrow<u8>(arg1, v3) as u64) | (*0x1::vector::borrow<u8>(arg1, v3 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg1, v3 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg1, v3 + 3) as u64) << 24) % 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(v0, v2 % 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::slot_config::reels(arg0)))) as u8));
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_units(arg0: &SpinOutcome) : u64 {
        arg0.total_units
    }

    // decompiled from Move bytecode v7
}

