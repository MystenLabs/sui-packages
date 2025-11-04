module 0x1a9020278f01cf03d5523f19ca63dcd976235883530db0a2de96360046ef8a41::sui_action_box {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct ActionBoxConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        chain_id: u64,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        action_counter: u64,
        version: u64,
    }

    struct ActionCreated has copy, drop {
        master: address,
        user: vector<u8>,
        kernel_app_address: vector<u8>,
        kernel_app_calldata: vector<u8>,
        action_id: vector<u8>,
        amounts: vector<u64>,
        tokens: vector<vector<u8>>,
        config_id: 0x2::object::ID,
        chain_id: u64,
        action_counter: u64,
        version: u64,
    }

    struct VersionBumped has copy, drop {
        config_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun add_to_whitelist(arg0: &mut ActionBoxConfig, arg1: &ManagerCap, arg2: 0x2::object::ID) {
        assert_manager(arg1, arg0);
        assert_latest(arg0);
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg2)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.whitelist, arg2, true);
        };
    }

    fun assert_latest(arg0: &ActionBoxConfig) {
        assert!(arg0.version == 1, 1004);
    }

    fun assert_manager(arg0: &ManagerCap, arg1: &ActionBoxConfig) {
        assert!(arg0.config_id == 0x2::object::id<ActionBoxConfig>(arg1), 1006);
    }

    public fun bump_version(arg0: &mut ActionBoxConfig, arg1: &ManagerCap, arg2: u64) {
        assert_manager(arg1, arg0);
        let v0 = arg0.version;
        assert!(arg2 != v0, 1005);
        arg0.version = arg2;
        let v1 = VersionBumped{
            config_id : 0x2::object::id<ActionBoxConfig>(arg0),
            from      : v0,
            to        : arg2,
        };
        0x2::event::emit<VersionBumped>(v1);
    }

    public fun create_action<T0: store + key>(arg0: &mut ActionBoxConfig, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u64>, arg5: vector<vector<u8>>, arg6: &T0, arg7: &mut 0x2::tx_context::TxContext) {
        assert_latest(arg0);
        let v0 = 0x2::object::id<T0>(arg6);
        assert!(is_whitelisted_id(arg0, &v0), 1003);
        let v1 = arg0.action_counter;
        arg0.action_counter = v1 + 1;
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u64>(&v1));
        let v3 = ActionCreated{
            master              : arg0.owner,
            user                : arg1,
            kernel_app_address  : arg2,
            kernel_app_calldata : arg3,
            action_id           : 0x2::hash::keccak256(&v2),
            amounts             : arg4,
            tokens              : arg5,
            config_id           : 0x2::object::id<ActionBoxConfig>(arg0),
            chain_id            : arg0.chain_id,
            action_counter      : v1,
            version             : arg0.version,
        };
        0x2::event::emit<ActionCreated>(v3);
    }

    public fun get_next_action_id(arg0: &ActionBoxConfig) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.action_counter));
        0x2::hash::keccak256(&v0)
    }

    public fun handover_manager(arg0: ManagerCap, arg1: address) {
        0x2::transfer::transfer<ManagerCap>(arg0, arg1);
    }

    public fun init_action_box(arg0: u64, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) : ManagerCap {
        let v0 = 0x2::table::new<0x2::object::ID, bool>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v1);
            if (!0x2::table::contains<0x2::object::ID, bool>(&v0, v2)) {
                0x2::table::add<0x2::object::ID, bool>(&mut v0, v2, true);
            };
            v1 = v1 + 1;
        };
        let v3 = ActionBoxConfig{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            chain_id       : arg0,
            whitelist      : v0,
            action_counter : 0,
            version        : 1,
        };
        let v4 = ManagerCap{
            id        : 0x2::object::new(arg2),
            config_id : 0x2::object::id<ActionBoxConfig>(&v3),
        };
        0x2::transfer::share_object<ActionBoxConfig>(v3);
        v4
    }

    public fun is_whitelisted(arg0: &ActionBoxConfig, arg1: 0x2::object::ID) : bool {
        is_whitelisted_id(arg0, &arg1)
    }

    fun is_whitelisted_id(arg0: &ActionBoxConfig, arg1: &0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, *arg1)
    }

    public fun remove_from_whitelist(arg0: &mut ActionBoxConfig, arg1: &ManagerCap, arg2: 0x2::object::ID) {
        assert_manager(arg1, arg0);
        assert_latest(arg0);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg2)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg0.whitelist, arg2);
        };
    }

    public fun set_chain_id(arg0: &mut ActionBoxConfig, arg1: &ManagerCap, arg2: u64) {
        assert_manager(arg1, arg0);
        assert_latest(arg0);
        arg0.chain_id = arg2;
    }

    public fun set_owner(arg0: &mut ActionBoxConfig, arg1: &ManagerCap, arg2: address) {
        assert_manager(arg1, arg0);
        assert_latest(arg0);
        arg0.owner = arg2;
    }

    // decompiled from Move bytecode v6
}

