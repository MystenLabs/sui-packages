module 0x51b58964d35455e6c6821f7f6219d085a25e5acb5d4482f10c6d95d7715eb611::access_control {
    struct BlobRegistry has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlobRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BlobRegistry>(v0);
    }

    public fun register_blob(arg0: &mut BlobRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, arg1), 3);
        0x2::dynamic_field::add<vector<u8>, address>(&mut arg0.id, arg1, 0x2::tx_context::sender(arg2));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BlobRegistry) {
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg1.id, arg0), 2);
    }

    public fun transfer_blob(arg0: &mut BlobRegistry, arg1: vector<u8>, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg0.id, arg1), 2);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, address>(&mut arg0.id, arg1);
        assert!(*v0 == 0x2::tx_context::sender(arg3), 1);
        *v0 = arg2;
    }

    public fun unregister_blob(arg0: &mut BlobRegistry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg0.id, arg1), 2);
        assert!(0x2::dynamic_field::remove<vector<u8>, address>(&mut arg0.id, arg1) == 0x2::tx_context::sender(arg2), 1);
    }

    // decompiled from Move bytecode v7
}

