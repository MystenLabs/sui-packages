module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::platform {
    struct PlatformRegistry has key {
        id: 0x2::object::UID,
        active_claims: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct PlatformBinding has key {
        id: 0x2::object::UID,
        account_id: 0x1::option::Option<0x2::object::ID>,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
        username: 0x1::string::String,
        tagline: 0x1::string::String,
        region: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
    }

    struct PlatformAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlatformBound has copy, drop {
        binding_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
        username: 0x1::string::String,
        is_rebind: bool,
        timestamp: u64,
    }

    struct PlatformReleased has copy, drop {
        binding_id: 0x2::object::ID,
        former_account_id: 0x2::object::ID,
        platform: 0x1::string::String,
        platform_uid: 0x1::string::String,
        timestamp: u64,
    }

    struct PlatformDisplayUpdated has copy, drop {
        binding_id: 0x2::object::ID,
        username: 0x1::string::String,
        timestamp: u64,
    }

    public fun platform(arg0: &PlatformBinding) : &0x1::string::String {
        &arg0.platform
    }

    public fun account_id(arg0: &PlatformBinding) : 0x1::option::Option<0x2::object::ID> {
        arg0.account_id
    }

    public fun bind_platform(arg0: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg0, arg1);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x1::vector::length<u8>(&arg11) == 64, 5);
        assert!(0x1::vector::length<u8>(&arg12) == 33, 6);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::is_oracle_authorized(arg3, arg12), 4);
        assert!(arg10 <= v1, 8);
        assert!(v1 - arg10 <= 600000, 7);
        let v2 = build_binding_verification_message(&v0, &arg5, &arg6, arg10);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg11, &arg12, &v2, 1), 3);
        let v3 = build_claim_key(&arg5, &arg6);
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg13);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.active_claims, v3), 0);
        let v5 = PlatformBinding{
            id           : 0x2::derived_object::claim<0x1::string::String>(&mut arg2.id, v3),
            account_id   : 0x1::option::some<0x2::object::ID>(v0),
            platform     : arg5,
            platform_uid : arg6,
            username     : arg7,
            tagline      : arg8,
            region       : arg9,
            created_at   : v4,
            updated_at   : v4,
        };
        let v6 = 0x2::object::id<PlatformBinding>(&v5);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg2.active_claims, build_claim_key(&v5.platform, &v5.platform_uid), v0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_platform_binding(arg0, v6, arg13);
        let v7 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_connect_gaming();
        if (v7 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg0, v7, true, 0x1::string::utf8(b"connect_gaming"), arg13);
        };
        let v8 = PlatformBound{
            binding_id   : v6,
            account_id   : v0,
            platform     : v5.platform,
            platform_uid : v5.platform_uid,
            username     : v5.username,
            is_rebind    : false,
            timestamp    : v4,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformBound>(v8);
        0x2::transfer::share_object<PlatformBinding>(v5);
        v6
    }

    public fun binding_exists(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        0x2::derived_object::exists<0x1::string::String>(&arg0.id, build_claim_key(arg1, arg2))
    }

    public fun binding_id(arg0: &PlatformBinding) : 0x2::object::ID {
        0x2::object::id<PlatformBinding>(arg0)
    }

    fun build_binding_verification_message(arg0: &0x2::object::ID, arg1: &0x1::string::String, arg2: &0x1::string::String, arg3: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(arg0));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg1));
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg3));
        v0
    }

    fun build_claim_key(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append_utf8(&mut v0, b":");
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public fun claim_released(arg0: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::ZenkoRegistry, arg4: &0x2::clock::Clock, arg5: &mut PlatformBinding, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: vector<u8>, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg0, arg1);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x1::vector::length<u8>(&arg10) == 64, 5);
        assert!(0x1::vector::length<u8>(&arg11) == 33, 6);
        assert!(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::zenko::is_oracle_authorized(arg3, arg11), 4);
        assert!(arg9 <= v1, 8);
        assert!(v1 - arg9 <= 600000, 7);
        let v2 = build_binding_verification_message(&v0, &arg5.platform, &arg5.platform_uid, arg9);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg10, &arg11, &v2, 1), 3);
        let v3 = 0x2::tx_context::epoch_timestamp_ms(arg12);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg2.active_claims, build_claim_key(&arg5.platform, &arg5.platform_uid)), 0);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg5.account_id), 2);
        arg5.account_id = 0x1::option::some<0x2::object::ID>(v0);
        arg5.username = arg6;
        arg5.tagline = arg7;
        arg5.region = arg8;
        arg5.updated_at = v3;
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg2.active_claims, build_claim_key(&arg5.platform, &arg5.platform_uid), v0);
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::add_platform_binding(arg0, 0x2::object::id<PlatformBinding>(arg5), arg12);
        let v4 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config::rep_connect_gaming();
        if (v4 > 0) {
            0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::adjust_reputation_(arg0, v4, true, 0x1::string::utf8(b"connect_gaming"), arg12);
        };
        let v5 = PlatformBound{
            binding_id   : 0x2::object::id<PlatformBinding>(arg5),
            account_id   : v0,
            platform     : arg5.platform,
            platform_uid : arg5.platform_uid,
            username     : arg5.username,
            is_rebind    : true,
            timestamp    : v3,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformBound>(v5);
    }

    public fun created_at(arg0: &PlatformBinding) : u64 {
        arg0.created_at
    }

    public fun derive_binding_address(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : address {
        0x2::derived_object::derive_address<0x1::string::String>(0x2::object::id<PlatformRegistry>(arg0), build_claim_key(arg1, arg2))
    }

    public fun force_release_binding(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg1: &mut PlatformRegistry, arg2: &mut PlatformBinding, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_operations(arg0, arg3);
        arg2.account_id = 0x1::option::none<0x2::object::ID>();
        arg2.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid))) {
            0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.active_claims, build_claim_key(&arg2.platform, &arg2.platform_uid));
        };
    }

    public fun get_active_owner(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.active_claims, build_claim_key(arg1, arg2))) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.active_claims, build_claim_key(arg1, arg2)))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformRegistry{
            id            : 0x2::object::new(arg0),
            active_claims : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<PlatformRegistry>(v0);
        let v1 = PlatformAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PlatformAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &PlatformBinding) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.account_id)
    }

    public fun is_actively_claimed(arg0: &PlatformRegistry, arg1: &0x1::string::String, arg2: &0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.active_claims, build_claim_key(arg1, arg2))
    }

    public fun is_released(arg0: &PlatformBinding) : bool {
        0x1::option::is_none<0x2::object::ID>(&arg0.account_id)
    }

    public fun platform_uid(arg0: &PlatformBinding) : &0x1::string::String {
        &arg0.platform_uid
    }

    public fun region(arg0: &PlatformBinding) : &0x1::string::String {
        &arg0.region
    }

    public fun release_platform(arg0: &mut 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg2: &mut PlatformRegistry, arg3: &mut PlatformBinding, arg4: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg0, arg1);
        let v0 = 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0);
        assert!(arg3.account_id == 0x1::option::some<0x2::object::ID>(v0), 1);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v2 = 0x2::object::id<PlatformBinding>(arg3);
        arg3.account_id = 0x1::option::none<0x2::object::ID>();
        arg3.updated_at = v1;
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg2.active_claims, build_claim_key(&arg3.platform, &arg3.platform_uid));
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::remove_platform_binding(arg0, v2, arg4);
        let v3 = PlatformReleased{
            binding_id        : v2,
            former_account_id : v0,
            platform          : arg3.platform,
            platform_uid      : arg3.platform_uid,
            timestamp         : v1,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformReleased>(v3);
    }

    public fun tagline(arg0: &PlatformBinding) : &0x1::string::String {
        &arg0.tagline
    }

    public fun update_display_info(arg0: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::Account, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::AccountAuth, arg2: &mut PlatformBinding, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::verify_auth(arg0, arg1);
        assert!(arg2.account_id == 0x1::option::some<0x2::object::ID>(0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::account::id(arg0)), 1);
        arg2.username = arg3;
        arg2.tagline = arg4;
        arg2.region = arg5;
        arg2.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v0 = PlatformDisplayUpdated{
            binding_id : 0x2::object::id<PlatformBinding>(arg2),
            username   : arg3,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg6),
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<PlatformDisplayUpdated>(v0);
    }

    public fun updated_at(arg0: &PlatformBinding) : u64 {
        arg0.updated_at
    }

    public fun username(arg0: &PlatformBinding) : &0x1::string::String {
        &arg0.username
    }

    // decompiled from Move bytecode v7
}

