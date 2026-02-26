module 0x292cfd9140707f3e6d2ff21ff11aa5b18e17096e73fab3e67f667754188f5827::obligation_indexer {
    struct ObligationIndexer has key {
        id: 0x2::object::UID,
        obligations: 0x2::table::Table<0x2::object::ID, bool>,
        size: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationIndexer{
            id          : 0x2::object::new(arg0),
            obligations : 0x2::table::new<0x2::object::ID, bool>(arg0),
            size        : 0,
        };
        0x2::transfer::share_object<ObligationIndexer>(v0);
    }

    public fun is_registered(arg0: &ObligationIndexer, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.obligations, arg1)
    }

    public fun register_obligation(arg0: &mut ObligationIndexer, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.obligations, v0), 0);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.obligations, v0, true);
        arg0.size = arg0.size + 1;
    }

    public fun size(arg0: &ObligationIndexer) : u64 {
        arg0.size
    }

    // decompiled from Move bytecode v6
}

