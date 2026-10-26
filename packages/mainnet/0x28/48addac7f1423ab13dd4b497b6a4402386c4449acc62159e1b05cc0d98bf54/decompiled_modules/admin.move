module 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::admin {
    struct PredictAdminRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        active_cap_id: 0x2::object::ID,
    }

    struct PredictAdminRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        active_cap_id: 0x2::object::ID,
        by: address,
        ts: u64,
    }

    struct PredictAdminCapRotated has copy, drop {
        registry_id: 0x2::object::ID,
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
        recipient: address,
        by: address,
        ts: u64,
    }

    public fun bootstrap_admin_registry(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::version(arg0) == 2, 13891353454351286274);
        let (v0, _, _) = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::admin_pin(arg0);
        assert!(!v0, 13891634937918062596);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::amm::record_admin_user(arg0, 0x2::tx_context::sender(arg3), v3);
        let v4 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap>(arg1);
        let v5 = PredictAdminRegistry{
            id            : 0x2::object::new(arg3),
            version       : 2,
            config_id     : 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config>(arg0),
            active_cap_id : v4,
        };
        let v6 = 0x2::object::id<PredictAdminRegistry>(&v5);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::pin_admin(arg0, v6, v4);
        let v7 = PredictAdminRegistryCreated{
            registry_id   : v6,
            config_id     : 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config>(arg0),
            active_cap_id : v4,
            by            : 0x2::tx_context::sender(arg3),
            ts            : v3,
        };
        0x2::event::emit<PredictAdminRegistryCreated>(v7);
        0x2::transfer::share_object<PredictAdminRegistry>(v5);
    }

    public fun registry_active_cap_id(arg0: &PredictAdminRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun registry_config_id(arg0: &PredictAdminRegistry) : 0x2::object::ID {
        arg0.config_id
    }

    public fun registry_version(arg0: &PredictAdminRegistry) : u64 {
        arg0.version
    }

    public fun rotate_predict_admin_cap(arg0: &mut PredictAdminRegistry, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::version(arg2) == 2, 13891353621855010818);
        assert!(arg0.version == 2, 13893042476011028494);
        assert!(arg0.config_id == 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config>(arg2), 13892198055375470600);
        let (v0, v1, _) = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::admin_pin(arg2);
        assert!(v0, 13892761013919088652);
        assert!(v1 == 0x2::object::id<PredictAdminRegistry>(arg0), 13891916593283530758);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::assert_admin(arg2, arg1);
        assert!(arg3 != @0x0, 13892479551827148810);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::amm::record_admin_user(arg2, 0x2::tx_context::sender(arg5), v3);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::amm::record_admin_user(arg2, arg3, v3);
        let v4 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::new_admin_cap(arg5);
        let v5 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap>(&v4);
        arg0.active_cap_id = v5;
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::pin_admin(arg2, v1, v5);
        let v6 = PredictAdminCapRotated{
            registry_id : v1,
            old_cap_id  : arg0.active_cap_id,
            new_cap_id  : v5,
            recipient   : arg3,
            by          : 0x2::tx_context::sender(arg5),
            ts          : v3,
        };
        0x2::event::emit<PredictAdminCapRotated>(v6);
        0x2::transfer::public_transfer<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap>(v4, arg3);
    }

    // decompiled from Move bytecode v7
}

