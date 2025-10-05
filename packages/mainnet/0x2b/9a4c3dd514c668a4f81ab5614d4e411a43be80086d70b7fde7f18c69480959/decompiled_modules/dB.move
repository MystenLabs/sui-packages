module 0x2b9a4c3dd514c668a4f81ab5614d4e411a43be80086d70b7fde7f18c69480959::dB {
    struct AP has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    public fun BBhA(arg0: &mut AP, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 914);
        arg0.version = arg1;
    }

    public fun gJ(arg0: &AP) {
        assert!(arg0.version == 0, 512);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AP{
            id      : 0x2::object::new(arg0),
            version : 0,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AP>(v0);
    }

    // decompiled from Move bytecode v6
}

