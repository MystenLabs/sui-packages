module 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::rmn_remote {
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

    struct CurserCap has store, key {
        id: 0x2::object::UID,
    }

    struct AllowedCurserCaps has store, key {
        id: 0x2::object::UID,
        allowed_cap_ids: 0x2::vec_map::VecMap<address, bool>,
    }

    struct CurserCapRegistered has copy, drop {
        cap_id: address,
    }

    struct CurserCapDeregistered has copy, drop {
        cap_id: address,
    }

    fun assert_curser_cap_allowed(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &CurserCap) {
        assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0), 15);
        let v0 = 0x2::object::id_address<CurserCap>(arg1);
        assert!(0x2::vec_map::contains<address, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<AllowedCurserCaps>(arg0).allowed_cap_ids, &v0), 17);
    }

    public fun create_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : CurserCap {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"create_curser_cap"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        CurserCap{id: 0x2::object::new(arg2)}
    }

    public fun create_curser_cap_and_transfer(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<CurserCap>(create_curser_cap(arg0, arg1, arg3), arg2);
    }

    public fun curse(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<u8>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg2);
        curse_multiple(arg0, arg1, v0);
    }

    public fun curse_multiple(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<vector<u8>>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse_multiple"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<RMNRemoteState>(arg0);
        insert_cursed_subjects(v0, arg2);
    }

    public fun curse_multiple_with_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &CurserCap, arg2: vector<vector<u8>>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse_multiple_with_curser_cap"), 2);
        assert_curser_cap_allowed(arg0, arg1);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<RMNRemoteState>(arg0);
        insert_cursed_subjects(v0, arg2);
    }

    public fun curse_with_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &CurserCap, arg2: vector<u8>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"curse_with_curser_cap"), 2);
        assert_curser_cap_allowed(arg0, arg1);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<RMNRemoteState>(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v1, arg2);
        insert_cursed_subjects(v0, v1);
    }

    public fun deregister_curser_cap_ids(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<address>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"deregister_curser_cap_ids"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0), 15);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<AllowedCurserCaps>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            assert!(0x2::vec_map::contains<address, bool>(&v0.allowed_cap_ids, &v3), 18);
            let (_, _) = 0x2::vec_map::remove<address, bool>(&mut v0.allowed_cap_ids, &v3);
            let v6 = CurserCapDeregistered{cap_id: v3};
            0x2::event::emit<CurserCapDeregistered>(v6);
            v2 = v2 + 1;
        };
    }

    fun ensure_curser_cap_allowlisted(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0)) {
            let v0 = 0x2::vec_map::empty<address, bool>();
            0x2::vec_map::insert<address, bool>(&mut v0, arg2, true);
            let v1 = AllowedCurserCaps{
                id              : 0x2::object::new(arg3),
                allowed_cap_ids : v0,
            };
            0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::add<AllowedCurserCaps>(arg0, arg1, v1, arg3);
            let v2 = CurserCapRegistered{cap_id: arg2};
            0x2::event::emit<CurserCapRegistered>(v2);
            return
        };
        let v3 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<AllowedCurserCaps>(arg0);
        if (!0x2::vec_map::contains<address, bool>(&v3.allowed_cap_ids, &arg2)) {
            0x2::vec_map::insert<address, bool>(&mut v3.allowed_cap_ids, arg2, true);
            let v4 = CurserCapRegistered{cap_id: arg2};
            0x2::event::emit<CurserCapRegistered>(v4);
        };
    }

    public fun get_allowed_curser_cap_ids(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : vector<address> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_allowed_curser_cap_ids"), 2);
        if (!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0)) {
            return vector[]
        };
        0x2::vec_map::keys<address, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<AllowedCurserCaps>(arg0).allowed_cap_ids)
    }

    public fun get_cursed_subjects(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : vector<vector<u8>> {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_cursed_subjects"), 2);
        0x2::vec_map::keys<vector<u8>, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects)
    }

    public fun get_local_chain_selector(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : u64 {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_local_chain_selector"), 2);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<RMNRemoteState>(arg0).local_chain_selector
    }

    public fun get_report_digest_header() : vector<u8> {
        let v0 = b"RMN_V1_6_ANY2SUI_REPORT";
        0x2::hash::keccak256(&v0)
    }

    public fun get_versioned_config(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : (u32, Config) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"get_versioned_config"), 2);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<RMNRemoteState>(arg0);
        (v0.config_count, v0.config)
    }

    public fun initialize(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        assert!(!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<RMNRemoteState>(arg0), 1);
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
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::add<RMNRemoteState>(arg0, arg1, v1, arg3);
    }

    public fun initialize_allowed_curser_caps(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"initialize_allowed_curser_caps"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        assert!(!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0), 14);
        let v0 = 0x2::vec_map::empty<address, bool>();
        let v1 = &arg2;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            0x2::vec_map::insert<address, bool>(&mut v0, *0x1::vector::borrow<address>(v1, v2), true);
            v2 = v2 + 1;
        };
        let v3 = AllowedCurserCaps{
            id              : 0x2::object::new(arg3),
            allowed_cap_ids : v0,
        };
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::add<AllowedCurserCaps>(arg0, arg1, v3, arg3);
        let v4 = &arg2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(v4)) {
            let v6 = CurserCapRegistered{cap_id: *0x1::vector::borrow<address>(v4, v5)};
            0x2::event::emit<CurserCapRegistered>(v6);
            v5 = v5 + 1;
        };
    }

    fun insert_cursed_subjects(arg0: &mut RMNRemoteState, arg1: vector<vector<u8>>) {
        let v0 = &arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            let v2 = *0x1::vector::borrow<vector<u8>>(v0, v1);
            assert!(0x1::vector::length<u8>(&v2) == 16, 10);
            assert!(!0x2::vec_map::contains<vector<u8>, bool>(&arg0.cursed_subjects, &v2), 2);
            0x2::vec_map::insert<vector<u8>, bool>(&mut arg0.cursed_subjects, v2, true);
            v1 = v1 + 1;
        };
        let v3 = Cursed{subjects: arg1};
        0x2::event::emit<Cursed>(v3);
    }

    public fun is_cursed(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: vector<u8>) : bool {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed"), 2);
        0x2::vec_map::contains<vector<u8>, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects, &arg1) || is_cursed_global(arg0)
    }

    public fun is_cursed_global(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef) : bool {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed_global"), 2);
        let v0 = x"01000000000000000000000000000001";
        0x2::vec_map::contains<vector<u8>, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<RMNRemoteState>(arg0).cursed_subjects, &v0)
    }

    public fun is_cursed_u128(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: u128) : bool {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_cursed_u128"), 2);
        let v0 = 0x1::bcs::to_bytes<u128>(&arg1);
        0x1::vector::reverse<u8>(&mut v0);
        is_cursed(arg0, v0)
    }

    public fun is_curser_cap_allowed(arg0: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: address) : bool {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"is_curser_cap_allowed"), 2);
        if (!0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0)) {
            return false
        };
        0x2::vec_map::contains<address, bool>(&0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow<AllowedCurserCaps>(arg0).allowed_cap_ids, &arg1)
    }

    public fun mcms_create_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) : CurserCap {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"create_curser_cap"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        create_curser_cap(arg0, v0, arg3)
    }

    public fun mcms_create_curser_cap_and_transfer(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"create_curser_cap_and_transfer"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"create_curser_cap_and_transfer"), 2);
        create_curser_cap_and_transfer(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3), arg3);
    }

    public fun mcms_curse(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        curse(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
    }

    public fun mcms_curse_multiple(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse_multiple"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        curse_multiple(arg0, v0, v6);
    }

    public fun mcms_curse_multiple_with_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg2: 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, CurserCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse_multiple_with_curser_cap"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<CurserCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        curse_multiple_with_curser_cap(arg0, v0, v6);
    }

    public fun mcms_curse_with_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg2: 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, CurserCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"curse_with_curser_cap"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<CurserCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        curse_with_curser_cap(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
    }

    public fun mcms_deregister_curser_cap_ids(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"deregister_curser_cap_ids"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        deregister_curser_cap_ids(arg0, v0, v6);
    }

    public fun mcms_initialize_allowed_curser_caps(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"initialize_allowed_curser_caps"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        initialize_allowed_curser_caps(arg0, v0, v6, arg3);
    }

    public fun mcms_mint_and_register_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg3);
        assert!(v1 == 0x1::string::utf8(b"mint_and_register_curser_cap"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry>(arg2));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        mint_and_register_curser_cap(arg0, v0, arg2, arg4);
    }

    public fun mcms_register_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: CurserCap, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg3);
        assert!(v1 == 0x1::string::utf8(b"register_curser_cap"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry>(arg2));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<CurserCap>(&arg4));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        register_curser_cap(arg0, v0, arg2, arg4, arg5);
    }

    public fun mcms_register_curser_cap_ids(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"register_curser_cap_ids"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<address>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<address>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        register_curser_cap_ids(arg0, v0, v6);
    }

    public fun mcms_set_config(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"set_config"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<u64>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3));
            v9 = v9 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        set_config(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3), v6, v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(&mut v3));
    }

    public fun mcms_uncurse(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"uncurse"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        uncurse(arg0, v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
    }

    public fun mcms_uncurse_multiple(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams) {
        let (v0, v1, v2) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_with_caps<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1, 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg2);
        assert!(v1 == 0x1::string::utf8(b"uncurse_multiple"), 12);
        let v3 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v4 = 0x1::vector::empty<address>();
        let v5 = &mut v4;
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef>(arg0));
        0x1::vector::push_back<address>(v5, 0x2::object::id_address<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(v0));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v4, &mut v3);
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v3));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v3);
        uncurse_multiple(arg0, v0, v6);
    }

    public fun mint_and_register_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg3: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"mint_and_register_curser_cap"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = CurserCap{id: 0x2::object::new(arg3)};
        0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::register_entrypoint<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, CurserCap>(arg2, 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::create_publisher_wrapper<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback>(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::borrow_publisher(arg1), 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback()), 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), v0, vector[b"rmn_remote"], arg3);
        ensure_curser_cap_allowlisted(arg0, arg1, 0x2::object::id_address<CurserCap>(&v0), arg3);
    }

    public fun register_curser_cap(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: &mut 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::Registry, arg3: CurserCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"register_curser_cap"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::register_entrypoint<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback, CurserCap>(arg2, 0x34f6f114d80f82ac8a8ebd38464ca11e957d60ba46bfe8b134aa9e2284e07b85::mcms_registry::create_publisher_wrapper<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::McmsCallback>(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::borrow_publisher(arg1), 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback()), 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::mcms_callback(), arg3, vector[b"rmn_remote"], arg4);
        ensure_curser_cap_allowlisted(arg0, arg1, 0x2::object::id_address<CurserCap>(&arg3), arg4);
    }

    public fun register_curser_cap_ids(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<address>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"register_curser_cap_ids"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::contains<AllowedCurserCaps>(arg0), 15);
        register_curser_cap_ids_internal(arg0, arg2);
    }

    fun register_curser_cap_ids_internal(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: vector<address>) {
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<AllowedCurserCaps>(arg0);
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = *0x1::vector::borrow<address>(v1, v2);
            assert!(!0x2::vec_map::contains<address, bool>(&v0.allowed_cap_ids, &v3), 16);
            0x2::vec_map::insert<address, bool>(&mut v0.allowed_cap_ids, v3, true);
            let v4 = CurserCapRegistered{cap_id: v3};
            0x2::event::emit<CurserCapRegistered>(v4);
            v2 = v2 + 1;
        };
    }

    public fun set_config(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: u64) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"set_config"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<RMNRemoteState>(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 8);
        assert!(0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::eth_abi::decode_u256_value(arg2) != 0, 7);
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
        assert!(v11 == 0x1::vector::length<u64>(v10), 13906834930257625087);
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
        0x1::string::utf8(b"RMNRemote 1.6.1")
    }

    public fun uncurse(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<u8>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"uncurse"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg2);
        uncurse_multiple(arg0, arg1, v0);
    }

    public fun uncurse_multiple(arg0: &mut 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::CCIPObjectRef, arg1: &0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap, arg2: vector<vector<u8>>) {
        0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::upgrade_registry::verify_function_allowed(arg0, 0x1::string::utf8(b"rmn_remote"), 0x1::string::utf8(b"uncurse_multiple"), 2);
        assert!(0x2::object::id<0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::ownable::OwnerCap>(arg1) == 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::owner_cap_id(arg0), 13);
        let v0 = 0xe70da5ac8e13225f8b4c12b6060dda15c2036612d476b0f76431fdc271d82ae::state_object::borrow_mut<RMNRemoteState>(arg0);
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

    // decompiled from Move bytecode v7
}

