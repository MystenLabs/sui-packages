module 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::tasknet {
    struct PackageInitialized has copy, drop {
        treasury_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        initialized_at: u64,
    }

    struct TASKNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASKNET, arg1: &mut 0x2::tx_context::TxContext) {
        let TASKNET {  } = arg0;
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::admin::create(arg1);
        0x2::transfer::public_transfer<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::admin::AdminCap>(v1, v0);
        0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::admin::create_protocol_state(arg1);
        0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::claim::create_registry(v0, arg1);
        let v2 = PackageInitialized{
            treasury_id    : 0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::treasury::create(v0, arg1),
            admin_cap_id   : 0x2::object::id<0x2ad5fa7c2c9184b7406955fbbb9e279076a69b2c9b25d92e6c1528a9d2b1af92::admin::AdminCap>(&v1),
            initialized_at : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PackageInitialized>(v2);
    }

    // decompiled from Move bytecode v6
}

