module 0x3c89fb57737a49b87b6488ad528f7828282dcf47c4298c1a5ec6fc0b988e2190::tx_status {
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

