module 0x684d8698c41d65efc590fedfdd0f080b4e833ae2aea279cff005f6089d3f8599::fins_access {
    struct AccessRegistry has key {
        id: 0x2::object::UID,
        min_wal_balance: u64,
    }

    public fun get_min_balance(arg0: &AccessRegistry) : u64 {
        arg0.min_wal_balance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessRegistry{
            id              : 0x2::object::new(arg0),
            min_wal_balance : 1000000000,
        };
        0x2::transfer::share_object<AccessRegistry>(v0);
    }

    public entry fun seal_approve_access(arg0: vector<u8>, arg1: &AccessRegistry, arg2: u64) {
        assert!(arg2 >= arg1.min_wal_balance, 0);
    }

    public entry fun update_min_balance(arg0: &mut AccessRegistry, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.min_wal_balance = arg1;
    }

    // decompiled from Move bytecode v6
}

