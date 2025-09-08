module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_factory {
    struct PoolFactoryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolSimpleInfo has copy, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        fee_type: 0x1::type_name::TypeName,
        fee: u32,
        tick_spacing: u32,
    }

    struct PoolConfig has store, key {
        id: 0x2::object::UID,
        fee_map: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
        fee_protocol: u32,
        pools: 0x2::table::Table<0x2::object::ID, PoolSimpleInfo>,
    }

    struct AclConfig has store, key {
        id: 0x2::object::UID,
        acl: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::ACL,
    }

    struct PoolCreatedEvent has copy, drop {
        account: address,
        pool: 0x2::object::ID,
        fee: u32,
        tick_spacing: u32,
        fee_protocol: u32,
        sqrt_price: u128,
    }

    struct FeeAmountEnabledEvent has copy, drop {
        fee: u32,
        tick_spacing: u32,
    }

    struct SetFeeProtocolEvent has copy, drop {
        fee_protocol: u32,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    public fun acl(arg0: &AclConfig) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::ACL {
        &arg0.acl
    }

    public fun add_role(arg0: &PoolFactoryAdminCap, arg1: &mut AclConfig, arg2: address, arg3: u8, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &AclConfig) : vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::Member> {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &PoolFactoryAdminCap, arg1: &mut AclConfig, arg2: address, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &PoolFactoryAdminCap, arg1: &mut AclConfig, arg2: address, arg3: u8, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &PoolFactoryAdminCap, arg1: &mut AclConfig, arg2: address, arg3: u128, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg4);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public entry fun init_partners(arg0: &PoolFactoryAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::partner::init_partners(arg1);
    }

    public fun collect_protocol_fee_with_return_<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: address, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public entry fun deploy_pool<T0, T1, T2>(arg0: &mut PoolConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T2>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg4);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 4);
        let v2 = 0x1::type_name::get<T2>();
        let v3 = 0x1::string::from_ascii(0x1::type_name::into_string(v2));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.fee_map, &v3), 0);
        let v4 = pool_key<T0, T1, T2>(v0, v1, v2);
        assert!(!0x2::table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, v4), 5);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_fee<T2>(arg1);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_tick_spacing<T2>(arg1);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::deploy_pool<T0, T1, T2>(v5, v6, arg2, arg0.fee_protocol, arg3, arg5);
        let v8 = PoolSimpleInfo{
            pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7),
            pool_key     : v4,
            coin_type_a  : v0,
            coin_type_b  : v1,
            fee_type     : v2,
            fee          : v5,
            tick_spacing : v6,
        };
        0x2::table::add<0x2::object::ID, PoolSimpleInfo>(&mut arg0.pools, v4, v8);
        let v9 = PoolCreatedEvent{
            account      : 0x2::tx_context::sender(arg5),
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7),
            fee          : v5,
            tick_spacing : v6,
            fee_protocol : arg0.fee_protocol,
            sqrt_price   : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v9);
        0x2::transfer::public_share_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(v7);
    }

    public entry fun toggle_pool_status<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_pool_fee_protocol<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u32, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun upgrade(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::upgrade(arg1);
    }

    public fun check_claim_protocol_fee_manager_role(arg0: &AclConfig, arg1: address) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::has_role(&arg0.acl, arg1, 2), 8);
    }

    public fun check_clmm_manager_role(arg0: &AclConfig, arg1: address) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::has_role(&arg0.acl, arg1, 0), 6);
    }

    public fun check_pause_pool_manager_role(arg0: &AclConfig, arg1: address) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::has_role(&arg0.acl, arg1, 3), 9);
    }

    public fun check_reward_manager_role(arg0: &AclConfig, arg1: address) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::has_role(&arg0.acl, arg1, 1), 7);
    }

    public entry fun collect_protocol_fee<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: address, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun collect_protocol_fee_v2<T0, T1, T2>(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: address, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg5);
        check_claim_protocol_fee_manager_role(arg0, 0x2::tx_context::sender(arg6));
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::collect_protocol_fee_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, arg4);
    }

    public fun collect_protocol_fee_with_return_v2<T0, T1, T2>(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: address, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg5);
        check_claim_protocol_fee_manager_role(arg0, 0x2::tx_context::sender(arg6));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::collect_protocol_fee_with_return_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6)
    }

    fun compare_types(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        while (v2 < v0 && v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v3 < v4) {
                return false
            };
            if (v3 > v4) {
                return true
            };
            v2 = v2 + 1;
        };
        v0 < v1 && false || true
    }

    public entry fun decrease_liquidity_admin<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: address, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: address, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun deploy_pool_and_mint<T0, T1, T2>(arg0: &mut PoolConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u32, arg7: bool, arg8: u32, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: address, arg15: u64, arg16: &0x2::clock::Clock, arg17: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg18: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg17);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 4);
        let v2 = 0x1::type_name::get<T2>();
        let v3 = 0x1::string::from_ascii(0x1::type_name::into_string(v2));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.fee_map, &v3), 0);
        let v4 = pool_key<T0, T1, T2>(v0, v1, v2);
        assert!(!0x2::table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, v4), 5);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_fee<T2>(arg1);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_tick_spacing<T2>(arg1);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::deploy_pool<T0, T1, T2>(v5, v6, arg2, arg0.fee_protocol, arg16, arg18);
        let v8 = PoolCreatedEvent{
            account      : 0x2::tx_context::sender(arg18),
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7),
            fee          : v5,
            tick_spacing : v6,
            fee_protocol : arg0.fee_protocol,
            sqrt_price   : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v8);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint<T0, T1, T2>(&mut v7, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v9 = PoolSimpleInfo{
            pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7),
            pool_key     : v4,
            coin_type_a  : v0,
            coin_type_b  : v1,
            fee_type     : v2,
            fee          : v5,
            tick_spacing : v6,
        };
        0x2::table::add<0x2::object::ID, PoolSimpleInfo>(&mut arg0.pools, v4, v9);
        0x2::transfer::public_share_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(v7);
    }

    public fun deploy_pool_and_mint_with_return_<T0, T1, T2>(arg0: &mut PoolConfig, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T2>, arg2: u128, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: u32, arg7: bool, arg8: u32, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock, arg16: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg17: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::object::ID) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg16);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 4);
        let v2 = 0x1::type_name::get<T2>();
        let v3 = 0x1::string::from_ascii(0x1::type_name::into_string(v2));
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg0.fee_map, &v3), 0);
        let v4 = pool_key<T0, T1, T2>(v0, v1, v2);
        assert!(!0x2::table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, v4), 5);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_fee<T2>(arg1);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_tick_spacing<T2>(arg1);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::deploy_pool<T0, T1, T2>(v5, v6, arg2, arg0.fee_protocol, arg15, arg17);
        let v8 = PoolCreatedEvent{
            account      : 0x2::tx_context::sender(arg17),
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7),
            fee          : v5,
            tick_spacing : v6,
            fee_protocol : arg0.fee_protocol,
            sqrt_price   : arg2,
        };
        0x2::event::emit<PoolCreatedEvent>(v8);
        let (v9, v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(&mut v7, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        let v12 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&v7);
        let v13 = PoolSimpleInfo{
            pool_id      : v12,
            pool_key     : v4,
            coin_type_a  : v0,
            coin_type_b  : v1,
            fee_type     : v2,
            fee          : v5,
            tick_spacing : v6,
        };
        0x2::table::add<0x2::object::ID, PoolSimpleInfo>(&mut arg0.pools, v4, v13);
        0x2::transfer::public_share_object<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(v7);
        (v9, v10, v11, v12)
    }

    public entry fun fake_swap<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: address, arg3: bool, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun get_pool_id<T0, T1, T2>(arg0: &mut PoolConfig) : 0x1::option::Option<0x2::object::ID> {
        let v0 = pool_key<T0, T1, T2>(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), 0x1::type_name::get<T2>());
        if (0x2::table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, v0)) {
            0x1::option::some<0x2::object::ID>(0x2::table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.pools, v0).pool_id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        init_(arg0);
    }

    fun init_(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig{
            id           : 0x2::object::new(arg0),
            fee_map      : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
            fee_protocol : 0,
            pools        : 0x2::table::new<0x2::object::ID, PoolSimpleInfo>(arg0),
        };
        0x2::transfer::share_object<PoolConfig>(v0);
        let v1 = PoolFactoryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolFactoryAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun init_acl_config(arg0: &PoolFactoryAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AclConfig{
            id  : 0x2::object::new(arg1),
            acl : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::new(arg1),
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::acl::set_roles(&mut v0.acl, 0x2::tx_context::sender(arg1), 1 << 0 | 1 << 1 | 1 << 2 | 1 << 3);
        0x2::transfer::share_object<AclConfig>(v0);
    }

    public entry fun migrate_position<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: vector<address>, arg4: address, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun modify_reward<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: vector<address>, arg8: vector<address>, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun modify_tick<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u32, arg3: bool, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        abort 0
    }

    public entry fun modify_tick_reward<T0, T1, T2>(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u32, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun pool_key<T0, T1, T2>(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0x2::object::ID {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg0));
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(arg1));
        let (v3, v4) = if (!compare_types(&v1, &v2)) {
            (v1, v2)
        } else {
            (v2, v1)
        };
        0x1::vector::append<u8>(&mut v0, v3);
        0x1::vector::append<u8>(&mut v0, v4);
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(arg2)));
        0x2::object::id_from_bytes(0x1::hash::sha2_256(v0))
    }

    public entry fun set_fee_protocol(arg0: &PoolFactoryAdminCap, arg1: &mut PoolConfig, arg2: u32, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        abort 0
    }

    public entry fun set_fee_protocol_v2(arg0: &AclConfig, arg1: &mut PoolConfig, arg2: u32, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 < 1000000, 1);
        arg1.fee_protocol = arg2;
        let v0 = SetFeeProtocolEvent{fee_protocol: arg2};
        0x2::event::emit<SetFeeProtocolEvent>(v0);
    }

    public entry fun set_fee_tier<T0>(arg0: &PoolFactoryAdminCap, arg1: &mut PoolConfig, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned) {
        abort 0
    }

    public entry fun set_fee_tier_v2<T0>(arg0: &AclConfig, arg1: &mut PoolConfig, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T0>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&arg1.fee_map, &v0), 3);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_fee<T0>(arg2);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::get_tick_spacing<T0>(arg2);
        assert!(v1 < 1000000, 1);
        assert!(v2 > 0 && v2 < 16384, 2);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg1.fee_map, v0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee::Fee<T0>>(arg2));
        let v3 = FeeAmountEnabledEvent{
            fee          : v1,
            tick_spacing : v2,
        };
        0x2::event::emit<FeeAmountEnabledEvent>(v3);
    }

    public entry fun toggle_pool_status_v2<T0, T1, T2>(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg2);
        check_pause_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::toggle_pool_status<T0, T1, T2>(arg1, arg3);
    }

    public entry fun update_nft_description(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_nft_description_v2(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::update_nft_description(arg1, arg2);
    }

    public entry fun update_nft_img_url(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_nft_img_url_v2(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::update_nft_img_url(arg1, arg2);
    }

    public entry fun update_nft_name(arg0: &PoolFactoryAdminCap, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun update_nft_name_v2(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x1::string::String, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::update_nft_name(arg1, arg2);
    }

    public entry fun update_pool_fee_protocol_v2<T0, T1, T2>(arg0: &AclConfig, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u32, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::check_version(arg3);
        check_clmm_manager_role(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 < 1000000, 1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::update_pool_fee_protocol<T0, T1, T2>(arg1, arg2);
        let v0 = SetFeeProtocolEvent{fee_protocol: arg2};
        0x2::event::emit<SetFeeProtocolEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

