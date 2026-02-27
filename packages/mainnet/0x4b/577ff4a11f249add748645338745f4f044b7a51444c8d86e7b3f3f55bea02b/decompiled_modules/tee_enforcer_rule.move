module 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::tee_enforcer_rule {
    struct Pcrs has copy, drop, store {
        pos0: vector<u8>,
        pos1: vector<u8>,
        pos2: vector<u8>,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct EnclaveAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EnclaveConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        pcrs: Pcrs,
        admin_cap_id: 0x2::object::ID,
        version: u64,
    }

    struct Enclave has key {
        id: 0x2::object::UID,
        pk: vector<u8>,
        config_version: u64,
        owner: address,
    }

    struct Config has drop, store {
        enclave_id: 0x2::object::ID,
        version: u64,
    }

    struct IntentMessage<T0: drop> has copy, drop {
        intent: u8,
        timestamp_ms: u64,
        payload: T0,
    }

    struct AttestationPayload has copy, drop {
        intent_hash: vector<u8>,
        chain_id: vector<u8>,
        amount_usd_cents: u64,
        recipient: vector<u8>,
    }

    struct UserConfigKey has copy, drop, store {
        user: address,
    }

    struct UserConfig has drop, store {
        limit_usd_cents: 0x1::option::Option<u64>,
        limit_window_minutes: u64,
        per_tx_limit_usd_cents: 0x1::option::Option<u64>,
        allowed_recipients_count: u64,
        blocked_recipients_count: u64,
        enabled: bool,
    }

    struct AllowedRecipientKey has copy, drop, store {
        user: address,
        recipient: vector<u8>,
    }

    struct BlockedRecipientKey has copy, drop, store {
        user: address,
        recipient: vector<u8>,
    }

    struct SpendKey has copy, drop, store {
        user: address,
    }

    struct SpendWindow has drop, store {
        window_start_ms: u64,
        total_usd_cents: u64,
    }

    public fun add(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: &Enclave) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            enclave_id : 0x2::object::id<Enclave>(arg2),
            version    : 1,
        };
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::set_requires_message_binding(arg0, arg1, true);
    }

    public fun remove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap) : Config {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg0));
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::set_requires_message_binding(arg0, arg1, false);
        let v1 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v1)
    }

    public fun add_user_allowed_recipient(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        0x2::dynamic_field::borrow<UserConfigKey, UserConfig>(v1, v2);
        let v3 = AllowedRecipientKey{
            user      : arg2,
            recipient : arg3,
        };
        if (!0x2::dynamic_field::exists_<AllowedRecipientKey>(v1, v3)) {
            0x2::dynamic_field::add<AllowedRecipientKey, bool>(v1, v3, true);
            let v4 = 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2);
            v4.allowed_recipients_count = v4.allowed_recipients_count + 1;
        };
    }

    public fun add_user_blocked_recipient(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        0x2::dynamic_field::borrow<UserConfigKey, UserConfig>(v1, v2);
        let v3 = BlockedRecipientKey{
            user      : arg2,
            recipient : arg3,
        };
        if (!0x2::dynamic_field::exists_<BlockedRecipientKey>(v1, v3)) {
            0x2::dynamic_field::add<BlockedRecipientKey, bool>(v1, v3, true);
            let v4 = 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2);
            v4.blocked_recipients_count = v4.blocked_recipients_count + 1;
        };
    }

    fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 14);
    }

    public fun create_enclave_config(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : EnclaveAdminCap {
        let v0 = EnclaveAdminCap{id: 0x2::object::new(arg4)};
        let v1 = Pcrs{
            pos0 : arg1,
            pos1 : arg2,
            pos2 : arg3,
        };
        let v2 = EnclaveConfig{
            id           : 0x2::object::new(arg4),
            name         : arg0,
            pcrs         : v1,
            admin_cap_id : 0x2::object::id<EnclaveAdminCap>(&v0),
            version      : 0,
        };
        0x2::transfer::share_object<EnclaveConfig>(v2);
        v0
    }

    public fun create_intent_message<T0: drop>(arg0: u8, arg1: u64, arg2: T0) : IntentMessage<T0> {
        IntentMessage<T0>{
            intent       : arg0,
            timestamp_ms : arg1,
            payload      : arg2,
        }
    }

    public fun destroy_old_enclave(arg0: Enclave, arg1: &EnclaveConfig) {
        assert!(arg0.config_version < arg1.version, 11);
        let Enclave {
            id             : v0,
            pk             : _,
            config_version : _,
            owner          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun disable_user(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2).enabled = false;
        };
    }

    public fun enable_user(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2).enabled = true;
        };
    }

    public fun enclave_id(arg0: &Config) : 0x2::object::ID {
        assert_version(arg0);
        arg0.enclave_id
    }

    public fun enclave_pk(arg0: &Enclave) : &vector<u8> {
        &arg0.pk
    }

    public fun get_spending(arg0: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = SpendKey{user: arg1};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::uid(arg0);
        if (0x2::dynamic_field::exists_<SpendKey>(v1, v0)) {
            let v3 = 0x2::dynamic_field::borrow<SpendKey, SpendWindow>(v1, v0);
            if (0x2::clock::timestamp_ms(arg3) - v3.window_start_ms >= arg2 * 60000) {
                0
            } else {
                v3.total_usd_cents
            }
        } else {
            0
        }
    }

    public fun intent_scope() : u8 {
        1
    }

    fun load_pk_from_attestation(arg0: &EnclaveConfig, arg1: &0x2::nitro_attestation::NitroAttestationDocument) : vector<u8> {
        let v0 = 0x2::nitro_attestation::pcrs(arg1);
        let v1 = &arg0.pcrs;
        let v2 = if (*0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 0)) == v1.pos0) {
            if (*0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 1)) == v1.pos1) {
                *0x2::nitro_attestation::value(0x1::vector::borrow<0x2::nitro_attestation::PCREntry>(v0, 2)) == v1.pos2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 3);
        0x1::option::destroy_some<vector<u8>>(*0x2::nitro_attestation::public_key(arg1))
    }

    public fun migrate(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut_for_migration<Rule, Config>(v0, arg0);
        if (v1.version < 1) {
            v1.version = 1;
        };
    }

    public fun prove(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningRequest, arg1: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg2: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy>(arg1) == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::policy_id(arg2), 12);
        assert!(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::signer_id(arg0) == 0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner>(arg2), 12);
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg1));
        let v1 = UserConfigKey{user: 0x2::tx_context::sender(arg3)};
        assert!(!0x2::dynamic_field::exists_<UserConfigKey>(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg1), v1), 9);
        let v2 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v2, arg0);
    }

    public fun prove_with_attestation(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningRequest, arg1: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg2: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner, arg3: &Enclave, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy>(arg1) == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::policy_id(arg2), 12);
        assert!(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::signer_id(arg0) == 0x2::object::id<0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::UmiSigner>(arg2), 12);
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule<Rule, Config>(v0, arg1);
        assert_version(v1);
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = 0x2::clock::timestamp_ms(arg10);
        assert!(0x2::object::id<Enclave>(arg3) == v1.enclave_id, 0);
        assert!(arg4 == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::intent_hash(arg0), 2);
        assert!(arg6 == 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::chain_id(arg0), 2);
        assert!(v3 <= arg5 + 300000, 1);
        let v4 = AttestationPayload{
            intent_hash      : arg4,
            chain_id         : arg6,
            amount_usd_cents : arg8,
            recipient        : arg9,
        };
        let v5 = IntentMessage<AttestationPayload>{
            intent       : 1,
            timestamp_ms : arg5,
            payload      : v4,
        };
        let v6 = 0x2::bcs::to_bytes<IntentMessage<AttestationPayload>>(&v5);
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg3.pk, &v6), 0);
        let v7 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg1);
        let v8 = UserConfigKey{user: v2};
        if (!0x2::dynamic_field::exists_<UserConfigKey>(v7, v8)) {
            let v9 = Rule{dummy_field: false};
            0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v9, arg0);
            return
        };
        let v10 = 0x2::dynamic_field::borrow<UserConfigKey, UserConfig>(v7, v8);
        assert!(v10.enabled, 8);
        let v11 = v10.limit_usd_cents;
        let v12 = v10.per_tx_limit_usd_cents;
        if (v10.blocked_recipients_count > 0) {
            let v13 = BlockedRecipientKey{
                user      : v2,
                recipient : arg9,
            };
            assert!(!0x2::dynamic_field::exists_<BlockedRecipientKey>(v7, v13), 6);
        };
        if (v10.allowed_recipients_count > 0) {
            let v14 = AllowedRecipientKey{
                user      : v2,
                recipient : arg9,
            };
            assert!(0x2::dynamic_field::exists_<AllowedRecipientKey>(v7, v14), 7);
        };
        if (0x1::option::is_some<u64>(&v12)) {
            assert!(arg8 <= *0x1::option::borrow<u64>(&v12), 5);
        };
        if (0x1::option::is_some<u64>(&v11)) {
            let v15 = SpendKey{user: v2};
            let v16 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::umi_signer::uid_mut(arg2);
            if (0x2::dynamic_field::exists_<SpendKey>(v16, v15)) {
                let v17 = 0x2::dynamic_field::borrow_mut<SpendKey, SpendWindow>(v16, v15);
                if (v3 - v17.window_start_ms >= v10.limit_window_minutes * 60000) {
                    v17.window_start_ms = v3;
                    v17.total_usd_cents = arg8;
                } else {
                    v17.total_usd_cents = v17.total_usd_cents + arg8;
                };
                assert!(v17.total_usd_cents <= *0x1::option::borrow<u64>(&v11), 4);
            } else {
                assert!(arg8 <= *0x1::option::borrow<u64>(&v11), 4);
                let v18 = SpendWindow{
                    window_start_ms : v3,
                    total_usd_cents : arg8,
                };
                0x2::dynamic_field::add<SpendKey, SpendWindow>(v16, v15, v18);
            };
        };
        let v19 = Rule{dummy_field: false};
        0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::add_receipt<Rule>(v19, arg0);
    }

    public fun register_enclave(arg0: &EnclaveConfig, arg1: 0x2::nitro_attestation::NitroAttestationDocument, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Enclave{
            id             : 0x2::object::new(arg2),
            pk             : load_pk_from_attestation(arg0, &arg1),
            config_version : arg0.version,
            owner          : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Enclave>(v0);
    }

    public fun remove_user_allowed_recipient(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        let v3 = AllowedRecipientKey{
            user      : arg2,
            recipient : arg3,
        };
        if (0x2::dynamic_field::exists_<AllowedRecipientKey>(v1, v3)) {
            0x2::dynamic_field::remove<AllowedRecipientKey, bool>(v1, v3);
            let v4 = 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2);
            v4.allowed_recipients_count = v4.allowed_recipients_count - 1;
        };
    }

    public fun remove_user_blocked_recipient(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        let v3 = BlockedRecipientKey{
            user      : arg2,
            recipient : arg3,
        };
        if (0x2::dynamic_field::exists_<BlockedRecipientKey>(v1, v3)) {
            0x2::dynamic_field::remove<BlockedRecipientKey, bool>(v1, v3);
            let v4 = 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2);
            v4.blocked_recipients_count = v4.blocked_recipients_count - 1;
        };
    }

    public fun remove_user_config(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address) : UserConfig {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        let v3 = 0x2::dynamic_field::borrow<UserConfigKey, UserConfig>(v1, v2);
        assert!(v3.allowed_recipients_count == 0 && v3.blocked_recipients_count == 0, 13);
        0x2::dynamic_field::remove<UserConfigKey, UserConfig>(v1, v2)
    }

    public fun set_user_config(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: address, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: 0x1::option::Option<u64>) {
        let v0 = Rule{dummy_field: false};
        assert_version(0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1));
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        let v3 = UserConfig{
            limit_usd_cents          : arg3,
            limit_window_minutes     : arg4,
            per_tx_limit_usd_cents   : arg5,
            allowed_recipients_count : 0,
            blocked_recipients_count : 0,
            enabled                  : true,
        };
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            let v4 = 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2);
            v4.limit_usd_cents = v3.limit_usd_cents;
            v4.limit_window_minutes = v3.limit_window_minutes;
            v4.per_tx_limit_usd_cents = v3.per_tx_limit_usd_cents;
            v4.enabled = v3.enabled;
        } else {
            0x2::dynamic_field::add<UserConfigKey, UserConfig>(v1, v2, v3);
        };
    }

    public fun update_enclave(arg0: &mut 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicy, arg1: &0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::SigningPolicyCap, arg2: &Enclave) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x4b577ff4a11f249add748645338745f4f044b7a51444c8d86e7b3f3f55bea02b::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        assert_version(v1);
        v1.enclave_id = 0x2::object::id<Enclave>(arg2);
    }

    public fun update_pcrs(arg0: &mut EnclaveConfig, arg1: &EnclaveAdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(0x2::object::id<EnclaveAdminCap>(arg1) == arg0.admin_cap_id, 10);
        let v0 = Pcrs{
            pos0 : arg2,
            pos1 : arg3,
            pos2 : arg4,
        };
        arg0.pcrs = v0;
        arg0.version = arg0.version + 1;
    }

    // decompiled from Move bytecode v6
}

