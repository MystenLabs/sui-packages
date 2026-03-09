module 0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::tx_status {
    struct TxStatus has key {
        id: 0x2::object::UID,
        used_hashes: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun create(arg0: &0xc2e36feeac1389ae54a20d941c4d67219d6ff9eef48f6b13dfceff435cc48346::config::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TxStatus{
            id          : 0x2::object::new(arg1),
            used_hashes : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<TxStatus>(v0);
    }

    public fun has_been_used(arg0: &TxStatus, arg1: &vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.used_hashes, *arg1)
    }

    public(friend) fun record_hash(arg0: &mut TxStatus, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used_hashes, arg1), 100);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used_hashes, arg1, true);
    }

    // decompiled from Move bytecode v6
}

