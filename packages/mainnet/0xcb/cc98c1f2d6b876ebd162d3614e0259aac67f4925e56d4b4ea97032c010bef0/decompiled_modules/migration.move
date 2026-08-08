module 0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::migration {
    struct Receipts<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        seen: 0x2::table::Table<vector<u8>, bool>,
    }

    fun assert_version<T0>(arg0: &Receipts<T0>) {
        assert!(arg0.version == 1, 13906834393386844163);
    }

    public fun create_and_share_receipts<T0>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Receipts<T0>{
            id      : 0x2::object::new(arg1),
            version : 1,
            seen    : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<Receipts<T0>>(v0);
    }

    public fun is_migrated<T0>(arg0: &Receipts<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.seen, arg1)
    }

    public fun migrate<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::AdminCap<T0>, arg1: &mut Receipts<T0>) {
        assert!(arg1.version < 1, 13906834419156779013);
        arg1.version = 1;
    }

    public fun record<T0>(arg0: &0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::access::MinterCap<T0>, arg1: &mut Receipts<T0>, arg2: vector<u8>) {
        assert_version<T0>(arg1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg1.seen, arg2), 13906834453516255233);
        0x2::table::add<vector<u8>, bool>(&mut arg1.seen, arg2, true);
        0xcbcc98c1f2d6b876ebd162d3614e0259aac67f4925e56d4b4ea97032c010bef0::events::migrated<T0>(arg2);
    }

    public fun version<T0>(arg0: &Receipts<T0>) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

