module 0x9a8fed88dd6ff322d4627e3ef8ac122c7cf32f8a7c9d9b632dbb6d13e3381d7e::seal_object_id_capability {
    struct ObjectIdDecryptionCapability has store, key {
        id: 0x2::object::UID,
        for_id: vector<u8>,
    }

    struct CapabilityCreated has copy, drop {
        for_id: vector<u8>,
    }

    struct CapabilityBurned has copy, drop {
        for_id: vector<u8>,
    }

    public fun burn_capability(arg0: ObjectIdDecryptionCapability) {
        let v0 = CapabilityBurned{for_id: arg0.for_id};
        0x2::event::emit<CapabilityBurned>(v0);
        let ObjectIdDecryptionCapability {
            id     : v1,
            for_id : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun create_capability(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : ObjectIdDecryptionCapability {
        let v0 = 0x2::object::uid_to_inner(arg0);
        let v1 = ObjectIdDecryptionCapability{
            id     : 0x2::object::new(arg1),
            for_id : 0x2::object::id_to_bytes(&v0),
        };
        let v2 = CapabilityCreated{for_id: v1.for_id};
        0x2::event::emit<CapabilityCreated>(v2);
        v1
    }

    public fun get_seal_id(arg0: &ObjectIdDecryptionCapability) : vector<u8> {
        arg0.for_id
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &ObjectIdDecryptionCapability, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 == arg1.for_id, 0);
    }

    // decompiled from Move bytecode v6
}

