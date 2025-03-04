module 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_level {
    struct Level has store {
        current: u32,
        evolution_stage: u8,
    }

    fun calc_evolution_stage(arg0: u32) : u8 {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::evolution_thresholds();
        let v1 = 0;
        loop {
            if ((v1 as u64) >= 0x1::vector::length<u32>(&v0) || *0x1::vector::borrow<u32>(&v0, (v1 as u64)) > arg0) {
                break
            };
            v1 = v1 + 1;
        };
        v1
    }

    public fun current(arg0: &Level) : u32 {
        arg0.current
    }

    public fun evolution_stage(arg0: &Level) : u8 {
        arg0.evolution_stage
    }

    public(friend) fun increase_current_level(arg0: &mut Level, arg1: u32) {
        arg0.current = arg0.current + arg1;
        arg0.evolution_stage = calc_evolution_stage(arg0.current);
    }

    public fun levels_to_next_evolution_stage(arg0: &Level) : u32 {
        let v0 = 0xd2197b1ce2096e96e726c29fa2c138c5c6748da169b81d34927c522b7499f1d7::ika_chan_values::evolution_thresholds();
        if ((arg0.evolution_stage as u64) >= 0x1::vector::length<u32>(&v0)) {
            0
        } else {
            *0x1::vector::borrow<u32>(&v0, (arg0.evolution_stage as u64)) - arg0.current
        }
    }

    public(friend) fun new(arg0: u32) : Level {
        Level{
            current         : arg0,
            evolution_stage : calc_evolution_stage(arg0),
        }
    }

    // decompiled from Move bytecode v6
}

