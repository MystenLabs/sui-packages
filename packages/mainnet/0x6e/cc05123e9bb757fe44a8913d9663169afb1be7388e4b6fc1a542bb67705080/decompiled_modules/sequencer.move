module 0x6ecc05123e9bb757fe44a8913d9663169afb1be7388e4b6fc1a542bb67705080::sequencer {
    struct Sequencer has key {
        id: 0x2::object::UID,
        is_locked: bool,
        timestamp: u64,
        highest: u8,
    }

    struct Indexer {
        is_valid: bool,
        highest: u8,
    }

    public fun bos(arg0: &mut Sequencer, arg1: u64, arg2: u8) : Indexer {
        let v0 = 0;
        let v1 = false;
        if (arg0.is_locked && arg0.timestamp == arg1) {
            let v2 = arg0.highest + 1;
            v0 = v2;
            if (v2 <= arg2) {
                arg0.highest = v2;
                v1 = true;
            };
        } else if (!arg0.is_locked || arg0.timestamp <= arg1 + 3000) {
            arg0.highest = 0;
            arg0.is_locked = true;
            v1 = true;
        } else {
            v1 = false;
        };
        if (v0 >= arg2) {
            arg0.is_locked = false;
        };
        Indexer{
            is_valid : v1,
            highest  : v0,
        }
    }

    public fun check(arg0: &Indexer, arg1: u8) : bool {
        arg0.is_valid && arg0.highest == arg1
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : Sequencer {
        Sequencer{
            id        : 0x2::object::new(arg0),
            is_locked : false,
            timestamp : 0,
            highest   : 0,
        }
    }

    public fun eos(arg0: Indexer) {
        let Indexer {
            is_valid : _,
            highest  : _,
        } = arg0;
    }

    public entry fun public_create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Sequencer{
            id        : 0x2::object::new(arg0),
            is_locked : false,
            timestamp : 0,
            highest   : 0,
        };
        0x2::transfer::share_object<Sequencer>(v0);
    }

    // decompiled from Move bytecode v6
}

