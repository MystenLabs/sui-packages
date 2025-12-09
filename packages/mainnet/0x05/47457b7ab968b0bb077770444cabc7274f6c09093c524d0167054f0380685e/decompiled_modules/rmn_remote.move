module 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::rmn_remote {
    struct RMNRemoteState has store, key {
        id: 0x2::object::UID,
        local_chain_selector: u64,
        config: Config,
        config_count: u32,
        signers: 0x2::vec_map::VecMap<vector<u8>, bool>,
        cursed_subjects: 0x2::vec_map::VecMap<vector<u8>, bool>,
    }

    struct Config has copy, drop, store {
        rmn_home_contract_config_digest: vector<u8>,
        signers: vector<Signer>,
        f_sign: u64,
    }

    struct Signer has copy, drop, store {
        onchain_public_key: vector<u8>,
        node_index: u64,
    }

    struct ConfigSet has copy, drop {
        version: u32,
        config: Config,
    }

    struct Cursed has copy, drop {
        subjects: vector<vector<u8>>,
    }

    struct Uncursed has copy, drop {
        subjects: vector<vector<u8>>,
    }

    public fun curse(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: vector<u8>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg2);
        curse_multiple(arg0, arg1, v0);
    }

    public fun curse_multiple(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: vector<vector<u8>>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse_multiple"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<RMNRemoteState>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(v1, v2);
            assert!(0x1::vector::length<u8>(&v3) == 16, 10);
            assert!(!0x2::vec_map::contains<vector<u8>, bool>(&v0.cursed_subjects, &v3), 2);
            0x2::vec_map::insert<vector<u8>, bool>(&mut v0.cursed_subjects, v3, true);
            v2 = v2 + 1;
        };
        let v4 = Cursed{subjects: arg2};
        0x2::event::emit<Cursed>(v4);
    }

    public fun get_cursed_subjects(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef) : vector<vector<u8>> {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_cursed_subjects"), 1);
        0x2::vec_map::keys<vector<u8>, bool>(&0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects)
    }

    public fun get_local_chain_selector(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef) : u64 {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_local_chain_selector"), 1);
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<RMNRemoteState>(arg0).local_chain_selector
    }

    public fun get_report_digest_header() : vector<u8> {
        let v0 = b"RMN_V1_6_ANY2SUI_REPORT";
        0x2::hash::keccak256(&v0)
    }

    public fun get_versioned_config(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef) : (u32, Config) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_versioned_config"), 1);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<RMNRemoteState>(arg0);
        (v0.config_count, v0.config)
    }

    public fun initialize(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        assert!(!0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::contains<RMNRemoteState>(arg0), 1);
        assert!(arg2 != 0, 7);
        let v0 = Config{
            rmn_home_contract_config_digest : b"",
            signers                         : 0x1::vector::empty<Signer>(),
            f_sign                          : 0,
        };
        let v1 = RMNRemoteState{
            id                   : 0x2::object::new(arg3),
            local_chain_selector : arg2,
            config               : v0,
            config_count         : 0,
            signers              : 0x2::vec_map::empty<vector<u8>, bool>(),
            cursed_subjects      : 0x2::vec_map::empty<vector<u8>, bool>(),
        };
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::add<RMNRemoteState>(arg0, arg1, v1, arg3);
    }

    public fun is_cursed(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: vector<u8>) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed"), 1);
        0x2::vec_map::contains<vector<u8>, bool>(&0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects, &arg1) || is_cursed_global(arg0)
    }

    public fun is_cursed_global(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed_global"), 1);
        let v0 = x"01000000000000000000000000000001";
        0x2::vec_map::contains<vector<u8>, bool>(&0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects, &v0)
    }

    public fun is_cursed_u128(arg0: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: u128) : bool {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed_u128"), 1);
        let v0 = 0x1::bcs::to_bytes<u128>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        is_cursed(arg0, v0)
    }

    public fun mcms_curse(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse"), 12);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        curse(arg0, v0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3));
    }

    public fun mcms_curse_multiple(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse_multiple"), 12);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        curse_multiple(arg0, v0, v6);
    }

    public fun mcms_set_config(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"set_config"), 12);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u64>(&mut v8, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v3));
            v9 = v9 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        set_config(arg0, v0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3), v6, v8, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_u64(&mut v3));
    }

    public fun mcms_uncurse(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"uncurse"), 12);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        uncurse(arg0, v0, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3));
    }

    public fun mcms_uncurse_multiple(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &mut 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::Registry, arg2: 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::mcms_registry::get_callback_params_with_caps<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::McmsCallback, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1, 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"uncurse_multiple"), 12);
        let v3 = 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(v0));
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        0xe1f64e7b6a475e6d834ec83f44927910d54d524a868c40afa8e1407a6f3b551::bcs_stream::assert_is_consumed(&v3);
        uncurse_multiple(arg0, v0, v6);
    }

    public fun set_config(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: u64) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"set_config"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<RMNRemoteState>(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        assert!(0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::eth_abi::decode_u256_value(arg2) != 0, 7);
        let v1 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v1 == 0x1::vector::length<u64>(&arg4), 9);
        let v2 = 1;
        while (v2 < v1) {
            assert!(*0x1::vector::borrow<u64>(&arg4, v2 - 1) < *0x1::vector::borrow<u64>(&arg4, v2), 4);
            v2 = v2 + 1;
        };
        assert!(v1 >= 2 * arg5 + 1, 5);
        let v3 = 0x2::vec_map::keys<vector<u8>, bool>(&v0.signers);
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u8>>(&v3)) {
            let v5 = *0x1::vector::borrow<vector<u8>>(&v3, v4);
            let (_, _) = 0x2::vec_map::remove<vector<u8>, bool>(&mut v0.signers, &v5);
            v4 = v4 + 1;
        };
        let v8 = &arg3;
        let v9 = 0x1::vector::empty<Signer>();
        let v10 = &arg4;
        let v11 = 0x1::vector::length<vector<u8>>(v8);
        assert!(v11 == 0x1::vector::length<u64>(v10), 13906834788523704319);
        let v12 = 0;
        while (v12 < v11) {
            let v13 = &mut v9;
            let v14 = *0x1::vector::borrow<vector<u8>>(v8, v12);
            assert!(0x1::vector::length<u8>(&v14) == 20, 11);
            assert!(!0x2::vec_map::contains<vector<u8>, bool>(&v0.signers, &v14), 3);
            0x2::vec_map::insert<vector<u8>, bool>(&mut v0.signers, v14, true);
            let v15 = Signer{
                onchain_public_key : v14,
                node_index         : *0x1::vector::borrow<u64>(v10, v12),
            };
            0x1::vector::push_back<Signer>(v13, v15);
            v12 = v12 + 1;
        };
        let v16 = Config{
            rmn_home_contract_config_digest : arg2,
            signers                         : v9,
            f_sign                          : arg5,
        };
        v0.config = v16;
        let v17 = v0.config_count + 1;
        v0.config_count = v17;
        let v18 = ConfigSet{
            version : v17,
            config  : v16,
        };
        0x2::event::emit<ConfigSet>(v18);
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"RMNRemote 1.6.0")
    }

    public fun uncurse(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: vector<u8>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"uncurse"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg2);
        uncurse_multiple(arg0, arg1, v0);
    }

    public fun uncurse_multiple(arg0: &mut 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::CCIPObjectRef, arg1: &0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap, arg2: vector<vector<u8>>) {
        0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"uncurse_multiple"), 1);
        assert!(0x2::object::id<0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::ownable::OwnerCap>(arg1) == 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x547457b7ab968b0bb077770444cabc7274f6c09093c524d0167054f0380685e::state_object::borrow_mut<RMNRemoteState>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(v1, v2);
            assert!(0x2::vec_map::contains<vector<u8>, bool>(&v0.cursed_subjects, &v3), 6);
            let (_, _) = 0x2::vec_map::remove<vector<u8>, bool>(&mut v0.cursed_subjects, &v3);
            v2 = v2 + 1;
        };
        let v6 = Uncursed{subjects: arg2};
        0x2::event::emit<Uncursed>(v6);
    }

    // decompiled from Move bytecode v6
}

