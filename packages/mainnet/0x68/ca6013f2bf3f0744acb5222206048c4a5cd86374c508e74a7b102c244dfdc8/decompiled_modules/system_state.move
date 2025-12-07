module 0x68ca6013f2bf3f0744acb5222206048c4a5cd86374c508e74a7b102c244dfdc8::system_state {
    struct SystemState has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun check_version(arg0: &SystemState) {
        assert!(arg0.version == 1, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SystemState{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<SystemState>(v0);
    }

    entry fun migrate(arg0: &0x68ca6013f2bf3f0744acb5222206048c4a5cd86374c508e74a7b102c244dfdc8::admin::AdminCap, arg1: &mut SystemState) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

