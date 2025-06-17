module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::config {
    struct BridgeConfig has store {
        role: 0x2::table::Table<address, u8>,
        pair_id: u64,
        pair_ids: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>,
        pairs: 0x2::table::Table<u64, BridgePair>,
    }

    struct BridgePair has copy, drop, store {
        id: u64,
        token: 0x1::type_name::TypeName,
        to_token: 0x1::ascii::String,
        fee_type: u8,
        fee: u64,
        min_limit: u64,
        max_limit: u64,
        enable: bool,
    }

    public fun cal_fee<T0>(arg0: &mut BridgeConfig, arg1: address, arg2: u64, arg3: 0x1::ascii::String) : u64 {
        let v0 = arg2;
        let v1 = user_role(arg0, arg1);
        if (v1 == 0) {
            let v2 = find_pair<T0>(arg0, arg3);
            if (v2.fee_type == 0) {
                v0 = arg2 * v2.fee / 10000;
            } else {
                v0 = v2.fee;
            };
        } else if (v1 == 2) {
            v0 = 0;
        };
        v0
    }

    public fun can_bridge<T0>(arg0: &BridgeConfig, arg1: 0x1::ascii::String, arg2: address, arg3: u64) : bool {
        if (is_black_user(arg0, arg2) || arg3 == 0) {
            false
        } else {
            let v1 = find_pair<T0>(arg0, arg1);
            v1.enable && (v1.max_limit == 0 && arg3 >= v1.min_limit || arg3 >= v1.min_limit && arg3 <= v1.max_limit)
        }
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : BridgeConfig {
        BridgeConfig{
            role     : 0x2::table::new<address, u8>(arg0),
            pair_id  : 0,
            pair_ids : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(arg0),
            pairs    : 0x2::table::new<u64, BridgePair>(arg0),
        }
    }

    public(friend) fun create_bridge_pair<T0>(arg0: &mut BridgeConfig, arg1: vector<0x1::ascii::String>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1)) {
            new_bridge_pair<T0>(arg0, *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0), 0, arg2);
            v0 = v0 + 1;
        };
    }

    public(friend) fun create_special_bridge_pair<T0>(arg0: &mut BridgeConfig, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        new_bridge_pair<T0>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun delete_bridge_pair(arg0: &mut BridgeConfig, arg1: u64) {
        assert!(is_pair_id_exist(arg0, arg1), 1);
        let v0 = 0x2::table::borrow<u64, BridgePair>(&arg0.pairs, arg1);
        0x2::table::remove<0x1::ascii::String, u64>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.pair_ids, v0.token), v0.to_token);
        0x2::table::remove<u64, BridgePair>(&mut arg0.pairs, arg1);
    }

    fun find_pair<T0>(arg0: &BridgeConfig, arg1: 0x1::ascii::String) : &BridgePair {
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.pair_ids, 0x1::type_name::get<T0>()), 1);
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.pair_ids, 0x1::type_name::get<T0>());
        assert!(0x2::table::contains<0x1::ascii::String, u64>(v0, arg1), 1);
        0x2::table::borrow<u64, BridgePair>(&arg0.pairs, *0x2::table::borrow<0x1::ascii::String, u64>(v0, arg1))
    }

    public(friend) fun find_pair_by_id(arg0: &BridgeConfig, arg1: u64) : &BridgePair {
        assert!(0x2::table::contains<u64, BridgePair>(&arg0.pairs, arg1), 1);
        0x2::table::borrow<u64, BridgePair>(&arg0.pairs, arg1)
    }

    public(friend) fun find_pair_mut_by_id(arg0: &mut BridgeConfig, arg1: u64) : &mut BridgePair {
        assert!(0x2::table::contains<u64, BridgePair>(&arg0.pairs, arg1), 1);
        0x2::table::borrow_mut<u64, BridgePair>(&mut arg0.pairs, arg1)
    }

    fun is_black_user(arg0: &BridgeConfig, arg1: address) : bool {
        user_role(arg0, arg1) == 1
    }

    fun is_pair_exist<T0>(arg0: &BridgeConfig, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.pair_ids, 0x1::type_name::get<T0>()) && 0x2::table::contains<0x1::ascii::String, u64>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.pair_ids, 0x1::type_name::get<T0>()), arg1)
    }

    fun is_pair_id_exist(arg0: &BridgeConfig, arg1: u64) : bool {
        0x2::table::contains<u64, BridgePair>(&arg0.pairs, arg1)
    }

    public(friend) fun modify_pair_enable(arg0: &mut BridgeConfig, arg1: u64, arg2: bool) {
        find_pair_mut_by_id(arg0, arg1).enable = arg2;
    }

    public(friend) fun modify_pair_fee(arg0: &mut BridgeConfig, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = find_pair_mut_by_id(arg0, arg1);
        v0.fee = arg2;
        v0.fee_type = arg3;
    }

    public(friend) fun modify_pair_limit(arg0: &mut BridgeConfig, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = find_pair_mut_by_id(arg0, arg1);
        v0.min_limit = arg2;
        v0.max_limit = arg3;
    }

    fun new_bridge_pair<T0>(arg0: &mut BridgeConfig, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!is_pair_exist<T0>(arg0, arg1), 2);
        assert!(arg2 == 0 || arg2 > 0 && !is_pair_id_exist(arg0, arg2), 3);
        if (arg2 == 0) {
            arg0.pair_id = arg0.pair_id + 1;
            arg2 = arg0.pair_id;
        };
        let v0 = BridgePair{
            id        : arg2,
            token     : 0x1::type_name::get<T0>(),
            to_token  : arg1,
            fee_type  : 0,
            fee       : 0,
            min_limit : 0,
            max_limit : 0,
            enable    : false,
        };
        0x2::table::add<u64, BridgePair>(&mut arg0.pairs, arg2, v0);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&arg0.pair_ids, 0x1::type_name::get<T0>())) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.pair_ids, 0x1::type_name::get<T0>(), 0x2::table::new<0x1::ascii::String, u64>(arg3));
        };
        0x2::table::add<0x1::ascii::String, u64>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<0x1::ascii::String, u64>>(&mut arg0.pair_ids, 0x1::type_name::get<T0>()), arg1, arg2);
        arg2
    }

    public(friend) fun op_white_black(arg0: &mut BridgeConfig, arg1: vector<address>, arg2: u8) {
        let v0 = if (arg2 == 0) {
            true
        } else if (arg2 == 1) {
            true
        } else {
            arg2 == 2
        };
        assert!(v0, 4);
        let v1 = &mut arg0.role;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (0x2::table::contains<address, u8>(v1, v3)) {
                0x2::table::remove<address, u8>(v1, v3);
            };
            if (arg2 > 0) {
                0x2::table::add<address, u8>(v1, v3, arg2);
            };
            v2 = v2 + 1;
        };
    }

    public fun pair_fee_info(arg0: &BridgePair) : (u64, u8, u64, u64) {
        (arg0.fee, arg0.fee_type, arg0.min_limit, arg0.max_limit)
    }

    public(friend) fun pair_list(arg0: &BridgeConfig) : vector<BridgePair> {
        let v0 = 0x1::vector::empty<BridgePair>();
        let v1 = 1;
        while (v1 <= arg0.pair_id) {
            if (0x2::table::contains<u64, BridgePair>(&arg0.pairs, v1)) {
                0x1::vector::push_back<BridgePair>(&mut v0, *0x2::table::borrow<u64, BridgePair>(&arg0.pairs, v1));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun pair_token_info(arg0: &BridgePair) : (0x1::type_name::TypeName, 0x1::ascii::String) {
        (arg0.token, arg0.to_token)
    }

    public fun user_role(arg0: &BridgeConfig, arg1: address) : u8 {
        let v0 = 0;
        if (0x2::table::contains<address, u8>(&arg0.role, arg1)) {
            v0 = *0x2::table::borrow<address, u8>(&arg0.role, arg1);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

