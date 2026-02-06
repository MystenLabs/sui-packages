module 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::tee_enforcer_rule {
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
        allowed_recipients: vector<vector<u8>>,
        blocked_recipients: vector<vector<u8>>,
        enabled: bool,
    }

    struct SpendKey has copy, drop, store {
        user: address,
        window_start_ms: u64,
    }

    struct SpendWindow has drop, store {
        total_usd_cents: u64,
    }

    public fun add(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: &Enclave) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{enclave_id: 0x2::object::id<Enclave>(arg2)};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_stackable_rule<Rule, Config>(v0, arg0, arg1, v1);
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::set_requires_message_binding(arg0, arg1, true);
    }

    public fun remove(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap) : Config {
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::set_requires_message_binding(arg0, arg1, false);
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::remove_rule<Rule, Config>(arg0, arg1, v0)
    }

    public fun add_user_allowed_recipient(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = UserConfigKey{user: arg2};
        0x1::vector::push_back<vector<u8>>(&mut 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0), v1).allowed_recipients, arg3);
    }

    public fun add_user_blocked_recipient(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address, arg3: vector<u8>) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = UserConfigKey{user: arg2};
        0x1::vector::push_back<vector<u8>>(&mut 0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0), v1).blocked_recipients, arg3);
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

    public fun disable_user(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2).enabled = false;
        };
    }

    public fun enable_user(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2).enabled = true;
        };
    }

    public fun enclave_id(arg0: &Config) : 0x2::object::ID {
        arg0.enclave_id
    }

    public fun enclave_pk(arg0: &Enclave) : &vector<u8> {
        &arg0.pk
    }

    public fun get_spending(arg0: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::UmiSigner, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = arg2 * 60000;
        let v1 = SpendKey{
            user            : arg1,
            window_start_ms : 0x2::clock::timestamp_ms(arg3) / v0 * v0,
        };
        let v2 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::uid(arg0);
        if (0x2::dynamic_field::exists_<SpendKey>(v2, v1)) {
            0x2::dynamic_field::borrow<SpendKey, SpendWindow>(v2, v1).total_usd_cents
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

    public fun prove(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningRequest, arg1: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = UserConfigKey{user: 0x2::tx_context::sender(arg2)};
        assert!(!0x2::dynamic_field::exists_<UserConfigKey>(0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg1), v0), 9);
        let v1 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_receipt<Rule>(v1, arg0);
    }

    public fun prove_with_attestation(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningRequest, arg1: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg2: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::UmiSigner, arg3: &Enclave, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = 0x2::clock::timestamp_ms(arg10);
        assert!(0x2::object::id<Enclave>(arg3) == 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule<Rule, Config>(v0, arg1).enclave_id, 0);
        assert!(arg4 == 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::intent_hash(arg0), 2);
        assert!(arg6 == 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::chain_id(arg0), 2);
        assert!(v2 <= arg5 + 300000, 1);
        let v3 = AttestationPayload{
            intent_hash      : arg4,
            chain_id         : arg6,
            amount_usd_cents : arg8,
            recipient        : arg9,
        };
        let v4 = IntentMessage<AttestationPayload>{
            intent       : 1,
            timestamp_ms : arg5,
            payload      : v3,
        };
        let v5 = 0x2::bcs::to_bytes<IntentMessage<AttestationPayload>>(&v4);
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg3.pk, &v5), 0);
        let v6 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg1);
        let v7 = UserConfigKey{user: v1};
        if (!0x2::dynamic_field::exists_<UserConfigKey>(v6, v7)) {
            let v8 = Rule{dummy_field: false};
            0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_receipt<Rule>(v8, arg0);
            return
        };
        let v9 = 0x2::dynamic_field::borrow<UserConfigKey, UserConfig>(v6, v7);
        assert!(v9.enabled, 8);
        let v10 = v9.limit_usd_cents;
        let v11 = v9.per_tx_limit_usd_cents;
        let v12 = v9.allowed_recipients;
        let v13 = v9.blocked_recipients;
        let v14 = 0;
        while (v14 < 0x1::vector::length<vector<u8>>(&v13)) {
            assert!(*0x1::vector::borrow<vector<u8>>(&v13, v14) != arg9, 6);
            v14 = v14 + 1;
        };
        if (0x1::vector::length<vector<u8>>(&v12) > 0) {
            let v15 = false;
            let v16 = 0;
            while (v16 < 0x1::vector::length<vector<u8>>(&v12)) {
                if (*0x1::vector::borrow<vector<u8>>(&v12, v16) == arg9) {
                    v15 = true;
                    break
                };
                v16 = v16 + 1;
            };
            assert!(v15, 7);
        };
        if (0x1::option::is_some<u64>(&v11)) {
            assert!(arg8 <= *0x1::option::borrow<u64>(&v11), 5);
        };
        if (0x1::option::is_some<u64>(&v10)) {
            let v17 = v9.limit_window_minutes * 60000;
            let v18 = SpendKey{
                user            : v1,
                window_start_ms : v2 / v17 * v17,
            };
            let v19 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::umi_signer::uid_mut(arg2);
            let v20 = if (0x2::dynamic_field::exists_<SpendKey>(v19, v18)) {
                0x2::dynamic_field::borrow<SpendKey, SpendWindow>(v19, v18).total_usd_cents
            } else {
                0
            };
            let v21 = v20 + arg8;
            assert!(v21 <= *0x1::option::borrow<u64>(&v10), 4);
            if (0x2::dynamic_field::exists_<SpendKey>(v19, v18)) {
                0x2::dynamic_field::borrow_mut<SpendKey, SpendWindow>(v19, v18).total_usd_cents = v21;
            } else {
                let v22 = SpendWindow{total_usd_cents: v21};
                0x2::dynamic_field::add<SpendKey, SpendWindow>(v19, v18, v22);
            };
        };
        let v23 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::add_receipt<Rule>(v23, arg0);
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

    public fun remove_user_config(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address) : UserConfig {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = UserConfigKey{user: arg2};
        0x2::dynamic_field::remove<UserConfigKey, UserConfig>(0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0), v1)
    }

    public fun set_user_config(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: address, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: 0x1::option::Option<u64>) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1);
        let v1 = 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::policy_uid_mut(arg0);
        let v2 = UserConfigKey{user: arg2};
        let v3 = UserConfig{
            limit_usd_cents        : arg3,
            limit_window_minutes   : arg4,
            per_tx_limit_usd_cents : arg5,
            allowed_recipients     : 0x1::vector::empty<vector<u8>>(),
            blocked_recipients     : 0x1::vector::empty<vector<u8>>(),
            enabled                : true,
        };
        if (0x2::dynamic_field::exists_<UserConfigKey>(v1, v2)) {
            *0x2::dynamic_field::borrow_mut<UserConfigKey, UserConfig>(v1, v2) = v3;
        } else {
            0x2::dynamic_field::add<UserConfigKey, UserConfig>(v1, v2, v3);
        };
    }

    public fun update_enclave(arg0: &mut 0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicy, arg1: &0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::SigningPolicyCap, arg2: &Enclave) {
        let v0 = Rule{dummy_field: false};
        0x94a61f4a002de2fe641e95711a030f3d6386ea88876b10186773ab828a3dcfe::signing_policy::get_rule_mut<Rule, Config>(v0, arg0, arg1).enclave_id = 0x2::object::id<Enclave>(arg2);
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

