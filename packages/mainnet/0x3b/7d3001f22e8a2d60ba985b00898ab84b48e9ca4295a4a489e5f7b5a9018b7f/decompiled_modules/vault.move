module 0x3b7d3001f22e8a2d60ba985b00898ab84b48e9ca4295a4a489e5f7b5a9018b7f::vault {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        admin: address,
        sweep_count: u64,
    }

    public entry fun admin_sweep(arg0: &mut Treasury, arg1: address) {
        arg0.admin = arg1;
        arg0.sweep_count = arg0.sweep_count + 1;
    }

    public entry fun init_treasury(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            admin       : 0x2::tx_context::sender(arg0),
            sweep_count : 0,
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun withdraw_all(arg0: &mut Treasury) {
        arg0.sweep_count = arg0.sweep_count + 1;
    }

    // decompiled from Move bytecode v7
}

