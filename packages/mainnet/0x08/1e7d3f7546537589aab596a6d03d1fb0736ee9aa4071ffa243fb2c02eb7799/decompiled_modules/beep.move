module 0x81e7d3f7546537589aab596a6d03d1fb0736ee9aa4071ffa243fb2c02eb7799::beep {
    struct Beeper has store, key {
        id: 0x2::object::UID,
        beep_count: u64,
    }

    struct BeepEvent has copy, drop {
        beeper_id: address,
        beep_count: u64,
        message: vector<u8>,
    }

    public fun beep(arg0: &mut Beeper) {
        arg0.beep_count = arg0.beep_count + 1;
        let v0 = BeepEvent{
            beeper_id  : 0x2::object::uid_to_address(&arg0.id),
            beep_count : arg0.beep_count,
            message    : b"BEEP!",
        };
        0x2::event::emit<BeepEvent>(v0);
    }

    public fun create_beeper(arg0: &mut 0x2::tx_context::TxContext) : Beeper {
        Beeper{
            id         : 0x2::object::new(arg0),
            beep_count : 0,
        }
    }

    public fun get_beep_count(arg0: &Beeper) : u64 {
        arg0.beep_count
    }

    // decompiled from Move bytecode v6
}

