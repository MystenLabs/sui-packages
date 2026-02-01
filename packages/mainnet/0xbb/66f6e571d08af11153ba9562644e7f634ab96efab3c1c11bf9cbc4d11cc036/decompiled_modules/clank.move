module 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::clank {
    struct PackageInitialized has copy, drop {
        treasury_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        initialized_at: u64,
    }

    struct CLANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLANK, arg1: &mut 0x2::tx_context::TxContext) {
        let CLANK {  } = arg0;
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::admin::create(arg1);
        0x2::transfer::public_transfer<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::admin::AdminCap>(v1, v0);
        0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::admin::create_protocol_state(arg1);
        let v2 = PackageInitialized{
            treasury_id    : 0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::treasury::create(v0, arg1),
            admin_cap_id   : 0x2::object::id<0xbb66f6e571d08af11153ba9562644e7f634ab96efab3c1c11bf9cbc4d11cc036::admin::AdminCap>(&v1),
            initialized_at : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<PackageInitialized>(v2);
    }

    // decompiled from Move bytecode v6
}

