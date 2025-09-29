module 0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::tx_status {
    struct TxStatus has key {
        id: 0x2::object::UID,
        tx_status_map: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun get_status(arg0: &TxStatus, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.tx_status_map, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TxStatus{
            id            : 0x2::object::new(arg0),
            tx_status_map : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<TxStatus>(v0);
    }

    public fun set_status(arg0: &0x10847461e9082108a764664f5634377168c841d2daf81c2a3de0baa9a42254bd::operator_cap::OperatorCap, arg1: &mut TxStatus, arg2: vector<u8>) {
        0x2::table::add<vector<u8>, bool>(&mut arg1.tx_status_map, arg2, true);
    }

    // decompiled from Move bytecode v6
}

