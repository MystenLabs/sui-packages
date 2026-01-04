module 0xf87e715624ddec186d8b5360907db94f7d0928111b655244739a98d6004b2fce::multisig_config {
    struct MultisigConfig has key {
        id: 0x2::object::UID,
        public_keys: vector<vector<u8>>,
        weights: vector<u8>,
        threshold: u16,
        initialized: bool,
    }

    struct MultisigAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MultisigConfigInitialized has copy, drop {
        config_id: 0x2::object::ID,
        public_keys: vector<vector<u8>>,
        weights: vector<u8>,
        threshold: u16,
        multisig_address: address,
    }

    struct MultisigConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_public_keys: vector<vector<u8>>,
        new_public_keys: vector<vector<u8>>,
        old_weights: vector<u8>,
        new_weights: vector<u8>,
        old_threshold: u16,
        new_threshold: u16,
        old_address: address,
        new_address: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MultisigConfig{
            id          : 0x2::object::new(arg0),
            public_keys : 0x1::vector::empty<vector<u8>>(),
            weights     : 0x1::vector::empty<u8>(),
            threshold   : 0,
            initialized : false,
        };
        let v1 = MultisigAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<MultisigConfig>(v0);
        0x2::transfer::transfer<MultisigAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_multisig_config(arg0: &mut MultisigConfig, arg1: &MultisigAdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16) {
        assert!(!arg0.initialized, 3);
        assert!(0x1::vector::length<vector<u8>>(&arg2) >= 2, 5);
        arg0.public_keys = arg2;
        arg0.weights = arg3;
        arg0.threshold = arg4;
        arg0.initialized = true;
        let v0 = MultisigConfigInitialized{
            config_id        : 0x2::object::uid_to_inner(&arg0.id),
            public_keys      : arg2,
            weights          : arg3,
            threshold        : arg4,
            multisig_address : 0x8438f6d7b1efa6eb1fb7aa2cfa82667de6eaa8c6c1934a11e25b7aa0392417ab::multisig::derive_multisig_address_quiet(arg2, arg3, arg4),
        };
        0x2::event::emit<MultisigConfigInitialized>(v0);
    }

    public fun update_multisig_config(arg0: &mut MultisigConfig, arg1: &MultisigAdminCap, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16) {
        assert!(arg0.initialized, 4);
        assert!(0x1::vector::length<vector<u8>>(&arg2) >= 2, 5);
        let v0 = arg0.public_keys;
        let v1 = arg0.weights;
        let v2 = arg0.threshold;
        let v3 = 0x8438f6d7b1efa6eb1fb7aa2cfa82667de6eaa8c6c1934a11e25b7aa0392417ab::multisig::derive_multisig_address_quiet(v0, v1, v2);
        let v4 = 0x8438f6d7b1efa6eb1fb7aa2cfa82667de6eaa8c6c1934a11e25b7aa0392417ab::multisig::derive_multisig_address_quiet(arg2, arg3, arg4);
        assert!(v3 != v4, 1);
        arg0.public_keys = arg2;
        arg0.weights = arg3;
        arg0.threshold = arg4;
        let v5 = MultisigConfigUpdated{
            config_id       : 0x2::object::uid_to_inner(&arg0.id),
            old_public_keys : v0,
            new_public_keys : arg2,
            old_weights     : v1,
            new_weights     : arg3,
            old_threshold   : v2,
            new_threshold   : arg4,
            old_address     : v3,
            new_address     : v4,
        };
        0x2::event::emit<MultisigConfigUpdated>(v5);
    }

    public(friend) fun validate_sender_is_admin_multisig(arg0: &MultisigConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialized, 4);
        assert!(0x8438f6d7b1efa6eb1fb7aa2cfa82667de6eaa8c6c1934a11e25b7aa0392417ab::multisig::check_if_sender_is_multisig_address(arg0.public_keys, arg0.weights, arg0.threshold, arg1), 2);
    }

    // decompiled from Move bytecode v6
}

