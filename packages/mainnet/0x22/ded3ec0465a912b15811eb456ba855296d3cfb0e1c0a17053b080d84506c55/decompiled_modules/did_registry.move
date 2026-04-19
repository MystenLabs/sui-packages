module 0x22ded3ec0465a912b15811eb456ba855296d3cfb0e1c0a17053b080d84506c55::did_registry {
    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DIDState has store, key {
        id: 0x2::object::UID,
        did: 0x1::string::String,
        merchant_id: 0x1::string::String,
        business_name: 0x1::string::String,
        registered_at: u64,
        mote_version: u8,
    }

    struct DIDRegistered has copy, drop {
        did: 0x1::string::String,
        merchant_id: 0x1::string::String,
        sui_address: address,
        registered_at: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_did(arg0: &RegistryAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DIDState{
            id            : 0x2::object::new(arg6),
            did           : arg1,
            merchant_id   : arg2,
            business_name : arg3,
            registered_at : arg4,
            mote_version  : 1,
        };
        let v1 = DIDRegistered{
            did           : v0.did,
            merchant_id   : v0.merchant_id,
            sui_address   : arg5,
            registered_at : v0.registered_at,
        };
        0x2::event::emit<DIDRegistered>(v1);
        0x2::transfer::transfer<DIDState>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

