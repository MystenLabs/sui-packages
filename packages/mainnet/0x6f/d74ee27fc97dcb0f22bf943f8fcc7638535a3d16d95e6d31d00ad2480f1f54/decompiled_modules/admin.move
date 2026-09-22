module 0x6fd74ee27fc97dcb0f22bf943f8fcc7638535a3d16d95e6d31d00ad2480f1f54::admin {
    struct ProtocolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolAdminCapCreated has copy, drop {
        admin_cap_id: 0x2::object::ID,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = ProtocolAdminCap{id: v1};
        let v3 = GlobalConfigCap{id: 0x2::object::new(arg0)};
        let v4 = ProtocolAdminCapCreated{
            admin_cap_id : 0x2::object::uid_to_inner(&v1),
            admin        : v0,
        };
        0x2::event::emit<ProtocolAdminCapCreated>(v4);
        0x2::transfer::transfer<ProtocolAdminCap>(v2, v0);
        0x2::transfer::transfer<GlobalConfigCap>(v3, v0);
    }

    // decompiled from Move bytecode v7
}

