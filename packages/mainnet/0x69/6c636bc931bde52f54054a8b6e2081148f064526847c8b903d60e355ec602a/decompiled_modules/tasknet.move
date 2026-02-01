module 0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::tasknet {
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
        let v1 = 0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::admin::create(arg1);
        0x2::transfer::public_transfer<0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::admin::AdminCap>(v1, v0);
        0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::admin::create_protocol_state(arg1);
        0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::claim::create_registry(v0, arg1);
        let v2 = PackageInitialized{
            treasury_id    : 0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::treasury::create(v0, arg1),
            admin_cap_id   : 0x2::object::id<0x696c636bc931bde52f54054a8b6e2081148f064526847c8b903d60e355ec602a::admin::AdminCap>(&v1),
            initialized_at : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PackageInitialized>(v2);
    }

    // decompiled from Move bytecode v6
}

