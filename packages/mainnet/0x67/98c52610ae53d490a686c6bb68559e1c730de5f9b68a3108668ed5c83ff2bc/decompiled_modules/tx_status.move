module 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::tx_status {
    struct TxStatus has key {
        id: 0x2::object::UID,
        used_hashes: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun has_been_used(arg0: &TxStatus, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_hashes, *arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TxStatus{
            id          : 0x2::object::new(arg0),
            used_hashes : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<TxStatus>(v0);
    }

    public(friend) fun record_hash(arg0: &mut TxStatus, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_hashes, arg1), 100);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_hashes, arg1, true);
    }

    // decompiled from Move bytecode v6
}

