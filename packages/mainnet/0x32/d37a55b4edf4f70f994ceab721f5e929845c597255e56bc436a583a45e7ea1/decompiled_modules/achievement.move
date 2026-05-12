module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::achievement {
    struct AchievementRegistry has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct AchievementTypeKey has copy, drop, store {
        type_id: 0x1::string::String,
    }

    struct AchievementCriterion has copy, drop, store {
        counter: 0x1::string::String,
        op: 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::condition::Operator,
        threshold: u64,
    }

    struct AchievementTypeMeta has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        criterion: 0x1::option::Option<AchievementCriterion>,
        active: bool,
        created_at: u64,
    }

    struct Achievement has store, key {
        id: 0x2::object::UID,
        type_id: 0x1::string::String,
        earned_at: u64,
        evidence: vector<u8>,
        recipient_account: 0x2::object::ID,
    }

    struct AchievementTypeRegistered has copy, drop {
        type_id: 0x1::string::String,
        name: 0x1::string::String,
        has_criterion: bool,
        registered_by: address,
        timestamp: u64,
    }

    struct AchievementMinted has copy, drop {
        achievement_id: 0x2::object::ID,
        type_id: 0x1::string::String,
        recipient_account: 0x2::object::ID,
        earned_at: u64,
        oracle_pubkey: vector<u8>,
        timestamp: u64,
    }

    struct AchievementBurned has copy, drop {
        achievement_id: 0x2::object::ID,
        type_id: 0x1::string::String,
        recipient_account: 0x2::object::ID,
        burned_by: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun admin_burn_achievement(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg1: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg2: 0x2::transfer::Receiving<Achievement>, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_super_admin(arg0, arg5);
        let v0 = 0x2::transfer::public_receive<Achievement>(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::uid_mut(arg1), arg2);
        assert!(v0.recipient_account == 0x2::object::id<0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account>(arg1), 11);
        let Achievement {
            id                : v1,
            type_id           : v2,
            earned_at         : _,
            evidence          : _,
            recipient_account : v5,
        } = v0;
        let v6 = v1;
        let v7 = AchievementBurned{
            achievement_id    : 0x2::object::uid_to_inner(&v6),
            type_id           : v2,
            recipient_account : v5,
            burned_by         : 0x2::tx_context::sender(arg5),
            reason            : arg3,
            timestamp         : 0x2::clock::timestamp_ms(arg4),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<AchievementBurned>(v7);
        0x2::object::delete(v6);
    }

    fun build_mint_message(arg0: &0x2::object::ID, arg1: &0x1::string::String, arg2: &0x1::option::Option<u64>, arg3: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<u64>>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    public fun delete_type(arg0: &mut AchievementRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg1, arg3);
        let v0 = AchievementTypeKey{type_id: arg2};
        assert!(0x2::dynamic_field::exists<AchievementTypeKey>(&arg0.id, v0), 0);
        0x2::dynamic_field::remove<AchievementTypeKey, AchievementTypeMeta>(&mut arg0.id, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AchievementRegistry{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::share_object<AchievementRegistry>(v0);
    }

    public fun mint_achievement(arg0: &AchievementRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg2: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: 0x1::option::Option<u64>, arg6: vector<u8>, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg2, arg11);
        assert!(0x1::vector::length<u8>(&arg8) == 64, 6);
        assert!(0x1::vector::length<u8>(&arg9) == 33, 7);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::is_oracle_authorized(arg1, arg9), 10);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        assert!(arg7 <= v0, 9);
        assert!(v0 - arg7 <= 600000, 8);
        let v1 = build_mint_message(&arg3, &arg4, &arg5, arg7);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg8, &arg9, &v1, 1), 5);
        let v2 = AchievementTypeKey{type_id: arg4};
        assert!(0x2::dynamic_field::exists<AchievementTypeKey>(&arg0.id, v2), 0);
        let v3 = 0x2::dynamic_field::borrow<AchievementTypeKey, AchievementTypeMeta>(&arg0.id, v2);
        assert!(v3.active, 2);
        if (0x1::option::is_some<AchievementCriterion>(&v3.criterion)) {
            assert!(0x1::option::is_some<u64>(&arg5), 4);
            let v4 = 0x1::option::borrow<AchievementCriterion>(&v3.criterion);
            let v5 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::condition::new(v4.counter, v4.op, v4.threshold, false);
            assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::condition::passes(&v5, *0x1::option::borrow<u64>(&arg5)), 3);
        };
        let v6 = Achievement{
            id                : 0x2::object::new(arg11),
            type_id           : v2.type_id,
            earned_at         : v0,
            evidence          : arg6,
            recipient_account : arg3,
        };
        let v7 = AchievementMinted{
            achievement_id    : 0x2::object::id<Achievement>(&v6),
            type_id           : v2.type_id,
            recipient_account : arg3,
            earned_at         : v0,
            oracle_pubkey     : arg9,
            timestamp         : v0,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<AchievementMinted>(v7);
        0x2::transfer::public_transfer<Achievement>(v6, 0x2::object::id_to_address(&arg3));
    }

    public fun new_criterion(arg0: 0x1::string::String, arg1: 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::condition::Operator, arg2: u64) : AchievementCriterion {
        AchievementCriterion{
            counter   : arg0,
            op        : arg1,
            threshold : arg2,
        }
    }

    public fun register_type(arg0: &mut AchievementRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::option::Option<AchievementCriterion>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg1, arg8);
        let v0 = AchievementTypeKey{type_id: arg2};
        assert!(!0x2::dynamic_field::exists<AchievementTypeKey>(&arg0.id, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = AchievementTypeMeta{
            name        : arg3,
            description : arg4,
            image_url   : 0x2::url::new_unsafe_from_bytes(arg5),
            criterion   : arg6,
            active      : true,
            created_at  : v1,
        };
        0x2::dynamic_field::add<AchievementTypeKey, AchievementTypeMeta>(&mut arg0.id, v0, v2);
        let v3 = AchievementTypeRegistered{
            type_id       : v0.type_id,
            name          : arg3,
            has_criterion : 0x1::option::is_some<AchievementCriterion>(&arg6),
            registered_by : 0x2::tx_context::sender(arg8),
            timestamp     : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<AchievementTypeRegistered>(v3);
    }

    public fun set_type_active(arg0: &mut AchievementRegistry, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: 0x1::string::String, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg1, arg4);
        let v0 = AchievementTypeKey{type_id: arg2};
        assert!(0x2::dynamic_field::exists<AchievementTypeKey>(&arg0.id, v0), 0);
        0x2::dynamic_field::borrow_mut<AchievementTypeKey, AchievementTypeMeta>(&mut arg0.id, v0).active = arg3;
    }

    // decompiled from Move bytecode v7
}

