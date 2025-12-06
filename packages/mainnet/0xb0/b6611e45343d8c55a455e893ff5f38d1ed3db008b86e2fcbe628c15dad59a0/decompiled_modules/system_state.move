module 0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::system_state {
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

    entry fun migrate(arg0: &0xb0b6611e45343d8c55a455e893ff5f38d1ed3db008b86e2fcbe628c15dad59a0::admin::AdminCap, arg1: &mut SystemState) {
        assert!(arg1.version <= 1 - 1, 1);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

