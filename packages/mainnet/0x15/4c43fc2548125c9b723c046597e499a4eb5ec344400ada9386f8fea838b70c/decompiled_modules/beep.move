module 0x154c43fc2548125c9b723c046597e499a4eb5ec344400ada9386f8fea838b70c::beep {
    struct Beeper has store, key {
        id: 0x2::object::UID,
        beep_count: u64,
    }

    struct BeepEvent has copy, drop {
        beeper_id: address,
        beep_count: u64,
        message: vector<u8>,
    }

    public entry fun beep(arg0: &mut Beeper) {
        arg0.beep_count = arg0.beep_count + 1;
        let v0 = BeepEvent{
            beeper_id  : 0x2::object::uid_to_address(&arg0.id),
            beep_count : arg0.beep_count,
            message    : b"BEEP!",
        };
        0x2::event::emit<BeepEvent>(v0);
    }

    public entry fun create_beeper(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Beeper{
            id         : 0x2::object::new(arg0),
            beep_count : 0,
        };
        0x2::transfer::transfer<Beeper>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_beep_count(arg0: &Beeper) : u64 {
        arg0.beep_count
    }

    // decompiled from Move bytecode v6
}

