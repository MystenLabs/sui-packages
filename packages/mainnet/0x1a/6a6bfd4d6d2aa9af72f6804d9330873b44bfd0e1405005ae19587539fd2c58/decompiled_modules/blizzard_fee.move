module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_fee {
    struct BlizzardFee has copy, drop, store {
        mint: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS,
        burn: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS,
        transmute: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS,
        protocol: 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS,
    }

    public(friend) fun new() : BlizzardFee {
        BlizzardFee{
            mint      : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(0),
            burn      : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(0),
            transmute : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(0),
            protocol  : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(0),
        }
    }

    public fun burn(arg0: &BlizzardFee) : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS {
        arg0.burn
    }

    public fun mint(arg0: &BlizzardFee) : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS {
        arg0.mint
    }

    public fun protocol(arg0: &BlizzardFee) : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS {
        arg0.protocol
    }

    public(friend) fun set_burn(arg0: &mut BlizzardFee, arg1: u64) {
        assert!(arg1 <= 1000, 18);
        arg0.burn = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(arg1);
    }

    public(friend) fun set_mint(arg0: &mut BlizzardFee, arg1: u64) {
        assert!(arg1 <= 1000, 18);
        arg0.mint = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(arg1);
    }

    public(friend) fun set_protocol(arg0: &mut BlizzardFee, arg1: u64) {
        assert!(arg1 <= 3000, 19);
        arg0.protocol = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(arg1);
    }

    public(friend) fun set_transmute(arg0: &mut BlizzardFee, arg1: u64) {
        assert!(arg1 <= 1000, 18);
        arg0.transmute = 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::new(arg1);
    }

    public fun transmute(arg0: &BlizzardFee) : 0x17264709505b1a94908171fa3ec688c472dd59edd8acb38091d1b10cfb85fc43::bps::BPS {
        arg0.transmute
    }

    // decompiled from Move bytecode v6
}

