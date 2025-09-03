module 0x10d255d8912135c9cfdae85e37ab12c5a4d50ab52f0f822492da9fdf8b420006::tx_status {
    struct TxStatus has key {
        id: 0x2::object::UID,
        tx_status_map: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun create_tx_status(arg0: &0x10d255d8912135c9cfdae85e37ab12c5a4d50ab52f0f822492da9fdf8b420006::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TxStatus{
            id            : 0x2::object::new(arg1),
            tx_status_map : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<TxStatus>(v0);
    }

    public fun get_status(arg0: &TxStatus, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tx_status_map, arg1)
    }

    public fun set_status(arg0: &0x10d255d8912135c9cfdae85e37ab12c5a4d50ab52f0f822492da9fdf8b420006::admin_cap::AdminCap, arg1: &mut TxStatus, arg2: vector<u8>) {
        0x2::table::add<vector<u8>, bool>(&mut arg1.tx_status_map, arg2, true);
    }

    // decompiled from Move bytecode v6
}

