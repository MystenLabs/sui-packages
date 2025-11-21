module 0xaf2f8ad6382c0706e0ed17ce4d68bec8ccd858ec3741bcfd2b5d38234409df07::model_registry {
    struct ModelRegistration has store, key {
        id: 0x2::object::UID,
        version: 0x1::string::String,
        model_hash: vector<u8>,
        fairness_score: u64,
        bias_audit_passed: bool,
        excluded_features: vector<0x1::string::String>,
        features_used: vector<0x1::string::String>,
        registered_at: u64,
        registered_by: address,
        is_active: bool,
        model_type: 0x1::string::String,
    }

    struct ModelRegistry has key {
        id: 0x2::object::UID,
        active_version: 0x1::string::String,
        total_models: u64,
    }

    struct ModelRegistered has copy, drop {
        model_id: address,
        version: 0x1::string::String,
        model_hash: vector<u8>,
        fairness_score: u64,
        bias_audit_passed: bool,
        timestamp: u64,
    }

    struct ModelActivated has copy, drop {
        model_id: address,
        version: 0x1::string::String,
        timestamp: u64,
    }

    struct ModelDeprecated has copy, drop {
        model_id: address,
        version: 0x1::string::String,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public entry fun activate_model(arg0: &mut ModelRegistry, arg1: &mut ModelRegistration, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fairness_score >= 9000, 1);
        assert!(arg1.bias_audit_passed == true, 2);
        arg1.is_active = true;
        arg0.active_version = arg1.version;
        let v0 = ModelActivated{
            model_id  : 0x2::object::uid_to_address(&arg1.id),
            version   : arg1.version,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ModelActivated>(v0);
    }

    public fun bias_audit_passed(arg0: &ModelRegistration) : bool {
        arg0.bias_audit_passed
    }

    public entry fun deprecate_model(arg0: &mut ModelRegistration, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.registered_by == 0x2::tx_context::sender(arg2), 3);
        arg0.is_active = false;
        let v0 = ModelDeprecated{
            model_id  : 0x2::object::uid_to_address(&arg0.id),
            version   : arg0.version,
            reason    : 0x1::string::utf8(arg1),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ModelDeprecated>(v0);
    }

    public fun get_excluded_features(arg0: &ModelRegistration) : vector<0x1::string::String> {
        arg0.excluded_features
    }

    public fun get_fairness_score(arg0: &ModelRegistration) : u64 {
        arg0.fairness_score
    }

    public fun get_features_used(arg0: &ModelRegistration) : vector<0x1::string::String> {
        arg0.features_used
    }

    public fun get_model_hash(arg0: &ModelRegistration) : vector<u8> {
        arg0.model_hash
    }

    public fun get_version(arg0: &ModelRegistration) : 0x1::string::String {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ModelRegistry{
            id             : 0x2::object::new(arg0),
            active_version : 0x1::string::utf8(b"none"),
            total_models   : 0,
        };
        0x2::transfer::share_object<ModelRegistry>(v0);
    }

    public fun is_active(arg0: &ModelRegistration) : bool {
        arg0.is_active
    }

    public entry fun register_model(arg0: &mut ModelRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: bool, arg5: vector<vector<u8>>, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 9000, 1);
        assert!(arg4 == true, 2);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg5)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg5, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg6)) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg6, v3)));
            v3 = v3 + 1;
        };
        let v4 = ModelRegistration{
            id                : 0x2::object::new(arg8),
            version           : 0x1::string::utf8(arg1),
            model_hash        : arg2,
            fairness_score    : arg3,
            bias_audit_passed : arg4,
            excluded_features : v0,
            features_used     : v2,
            registered_at     : 0x2::tx_context::epoch_timestamp_ms(arg8),
            registered_by     : 0x2::tx_context::sender(arg8),
            is_active         : false,
            model_type        : 0x1::string::utf8(arg7),
        };
        arg0.total_models = arg0.total_models + 1;
        let v5 = ModelRegistered{
            model_id          : 0x2::object::uid_to_address(&v4.id),
            version           : 0x1::string::utf8(arg1),
            model_hash        : arg2,
            fairness_score    : arg3,
            bias_audit_passed : arg4,
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<ModelRegistered>(v5);
        0x2::transfer::public_share_object<ModelRegistration>(v4);
    }

    // decompiled from Move bytecode v6
}

