module 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory {
    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolSimpleInfo>,
        index: u64,
    }

    struct DenyCoinList has store, key {
        id: 0x2::object::UID,
        denied_list: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        allowed_list: 0x2::table::Table<0x1::type_name::TypeName, bool>,
    }

    struct PoolKey has copy, drop, store {
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct PermissionPairManager has store, key {
        id: 0x2::object::UID,
        allowed_pair_config: 0x2::table::Table<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>,
        pool_key_to_cap: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        cap_to_pool_key: 0x2::table::Table<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>,
        coin_type_to_cap: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct PoolCreationCap has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        tick_spacing: u32,
    }

    struct AddAllowedListEvent has copy, drop {
        coin_type: 0x1::string::String,
    }

    struct RemoveAllowedListEvent has copy, drop {
        coin_type: 0x1::string::String,
    }

    struct AddDeniedListEvent has copy, drop {
        coin_type: 0x1::string::String,
    }

    struct RemoveDeniedListEvent has copy, drop {
        coin_type: 0x1::string::String,
    }

    struct InitPermissionPairManagerEvent has copy, drop {
        manager_id: 0x2::object::ID,
        denied_list_id: 0x2::object::ID,
    }

    struct RegisterPermissionPairEvent has copy, drop {
        cap: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type: 0x1::string::String,
        coin_pair: 0x1::string::String,
        tick_spacing: u32,
    }

    struct UnregisterPermissionPairEvent has copy, drop {
        cap: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type: 0x1::string::String,
        coin_pair: 0x1::string::String,
        tick_spacing: u32,
    }

    struct AddAllowedPairConfigEvent has copy, drop {
        coin_type: 0x1::string::String,
        tick_spacing: u32,
    }

    struct RemoveAllowedPairConfigEvent has copy, drop {
        coin_type: 0x1::string::String,
        tick_spacing: u32,
    }

    struct MintPoolCreationCap has copy, drop {
        coin_type: 0x1::string::String,
        cap: 0x2::object::ID,
    }

    struct MintPoolCreationCapByAdmin has copy, drop {
        coin_type: 0x1::string::String,
        cap: 0x2::object::ID,
    }

    public fun add_allowed_list<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, DenyCoinList>(&mut arg1.id, 0x1::string::utf8(b"deny_coin_list"));
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&v1.allowed_list, v0), 14);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut v1.allowed_list, v0, true);
        let v2 = AddAllowedListEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<AddAllowedListEvent>(v2);
    }

    public fun add_allowed_pair_config<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<u32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::FeeTier>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::fee_tiers(arg0), &arg2), 17);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PermissionPairManager>(&mut arg1.id, 0x1::string::utf8(b"permission_pair_manager"));
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&v1.allowed_pair_config, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&mut v1.allowed_pair_config, v0, 0x2::vec_set::empty<u32>());
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&mut v1.allowed_pair_config, v0);
        assert!(!0x2::vec_set::contains<u32>(v2, &arg2), 18);
        0x2::vec_set::insert<u32>(v2, arg2);
        let v3 = AddAllowedPairConfigEvent{
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            tick_spacing : arg2,
        };
        0x2::event::emit<AddAllowedPairConfigEvent>(v3);
    }

    fun add_denied_coin<T0>(arg0: &mut Pools) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, DenyCoinList>(&mut arg0.id, 0x1::string::utf8(b"deny_coin_list"));
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&v1.denied_list, v0), 14);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut v1.denied_list, v0, true);
        let v2 = AddDeniedListEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<AddDeniedListEvent>(v2);
    }

    public fun add_denied_list<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        add_denied_coin<T0>(arg1);
    }

    public fun coin_types(arg0: &PoolSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_pool<T0, T1>(arg0: &mut Pools, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg1, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(create_pool_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Pools, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1> {
        assert!(arg3 > 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price() && arg3 < 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3);
        let v2 = new_pool_key<T0, T1>(arg2);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, v2), 1);
        let v3 = if (0x1::string::length(&arg4) == 0) {
            0x1::string::utf8(b"https://bq7bkvdje7gvgmv66hrxdy7wx5h5ggtrrnmt66rdkkehb64rvz3q.arweave.net/DD4VVGknzVMyvvHjceP2v0_TGnGLWT96I1KIcPuRrnc")
        } else {
            arg4
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::new<T0, T1>(arg2, arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::get_fee_rate(arg2, arg1), v3, arg0.index, arg5, arg6);
        arg0.index = arg0.index + 1;
        let v5 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&v4);
        let v6 = PoolSimpleInfo{
            pool_id      : v5,
            pool_key     : v2,
            coin_type_a  : v0,
            coin_type_b  : v1,
            tick_spacing : arg2,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolSimpleInfo>(&mut arg0.list, v2, v6);
        let v7 = CreatePoolEvent{
            pool_id      : v5,
            coin_type_a  : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b  : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing : arg2,
        };
        0x2::event::emit<CreatePoolEvent>(v7);
        v4
    }

    public(friend) fun create_pool_v2_<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: &0x2::coin::CoinMetadata<T0>, arg10: &0x2::coin::CoinMetadata<T1>, arg11: u64, arg12: u64, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        assert!(is_allowed_coin<T0>(arg1, arg9), 12);
        assert!(is_allowed_coin<T1>(arg1, arg10), 12);
        let v0 = create_pool_internal<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg14, arg15);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, &mut v0, arg5, arg6, arg15);
        let v2 = if (arg13) {
            arg11
        } else {
            arg12
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, &mut v0, &mut v1, v2, arg13, arg14);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        assert!(v4 > 0, 16);
        assert!(v5 > 0, 16);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(&v0) > 0, 16);
        if (arg13) {
            assert!(v5 <= arg12, 4);
        } else {
            assert!(v4 <= arg11, 5);
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, &mut v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v4, arg15)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v5, arg15)), v3);
        0x2::transfer::public_share_object<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(v0);
        (v1, arg7, arg8)
    }

    public fun create_pool_with_liquidity<T0, T1>(arg0: &mut Pools, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 19
    }

    public fun fetch_pools(arg0: &Pools, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolSimpleInfo> {
        if (arg2 == 0) {
            return 0x1::vector::empty<PoolSimpleInfo>()
        };
        let v0 = 0x1::vector::empty<PoolSimpleInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, PoolSimpleInfo>(&arg0.list)
        } else {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&arg1, 0);
            assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, v2), 10);
            0x1::option::some<0x2::object::ID>(v2)
        };
        let v3 = v1;
        let v4 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v3) && v4 < arg2) {
            let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::option::borrow<0x2::object::ID>(&v3));
            v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, PoolSimpleInfo>(v5);
            0x1::vector::push_back<PoolSimpleInfo>(&mut v0, *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_value<0x2::object::ID, PoolSimpleInfo>(v5));
            v4 = v4 + 1;
        };
        v0
    }

    public fun in_allowed_list<T0>(arg0: &Pools) : bool {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        0x2::table::contains<0x1::type_name::TypeName, bool>(&0x2::dynamic_object_field::borrow<0x1::string::String, DenyCoinList>(&arg0.id, 0x1::string::utf8(b"deny_coin_list")).allowed_list, 0x1::type_name::get<T0>())
    }

    public fun in_denied_list<T0>(arg0: &Pools) : bool {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        0x2::table::contains<0x1::type_name::TypeName, bool>(&0x2::dynamic_object_field::borrow<0x1::string::String, DenyCoinList>(&arg0.id, 0x1::string::utf8(b"deny_coin_list")).denied_list, 0x1::type_name::get<T0>())
    }

    public fun index(arg0: &Pools) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pools{
            id    : 0x2::object::new(arg0),
            list  : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Pools>(v0);
        let v1 = InitFactoryEvent{pools_id: 0x2::object::id<Pools>(&v0)};
        0x2::event::emit<InitFactoryEvent>(v1);
    }

    public entry fun init_manager_and_whitelist(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = PermissionPairManager{
            id                  : 0x2::object::new(arg2),
            allowed_pair_config : 0x2::table::new<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(arg2),
            pool_key_to_cap     : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg2),
            cap_to_pool_key     : 0x2::table::new<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(arg2),
            coin_type_to_cap    : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg2),
        };
        let v1 = 200;
        assert!(0x2::vec_map::contains<u32, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::FeeTier>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::fee_tiers(arg0), &v1), 17);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&v0.allowed_pair_config, 0x1::type_name::get<0x2::sui::SUI>()), 24);
        0x2::table::add<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&mut v0.allowed_pair_config, 0x1::type_name::get<0x2::sui::SUI>(), 0x2::vec_set::singleton<u32>(v1));
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"permission_pair_manager")), 23);
        0x2::dynamic_object_field::add<0x1::string::String, PermissionPairManager>(&mut arg1.id, 0x1::string::utf8(b"permission_pair_manager"), v0);
        let v2 = DenyCoinList{
            id           : 0x2::object::new(arg2),
            denied_list  : 0x2::table::new<0x1::type_name::TypeName, bool>(arg2),
            allowed_list : 0x2::table::new<0x1::type_name::TypeName, bool>(arg2),
        };
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"deny_coin_list")), 21);
        0x2::dynamic_object_field::add<0x1::string::String, DenyCoinList>(&mut arg1.id, 0x1::string::utf8(b"deny_coin_list"), v2);
        let v3 = InitPermissionPairManagerEvent{
            manager_id     : 0x2::object::id<PermissionPairManager>(&v0),
            denied_list_id : 0x2::object::id<DenyCoinList>(&v2),
        };
        0x2::event::emit<InitPermissionPairManagerEvent>(v3);
    }

    public fun is_allowed_coin<T0>(arg0: &mut Pools, arg1: &0x2::coin::CoinMetadata<T0>) : bool {
        in_allowed_list<T0>(arg0) || !in_denied_list<T0>(arg0)
    }

    public fun is_permission_pair<T0, T1>(arg0: &Pools, arg1: u32) : bool {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&0x2::dynamic_object_field::borrow<0x1::string::String, PermissionPairManager>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")).pool_key_to_cap, new_pool_key<T0, T1>(arg1))
    }

    public fun is_right_order<T0, T1>() : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v9 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v9 < v8) {
                    return false
                };
                if (v9 > v8) {
                    v7 = true;
                };
            };
            v6 = v6 + 1;
        };
        if (!v7) {
            if (v4 < v5) {
                return false
            };
            if (v4 == v5) {
                abort 3
            };
        };
        true
    }

    public fun mint_pool_creation_cap<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : PoolCreationCap {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = mint_pool_creation_cap_internal(arg1, v0, arg3);
        let v2 = MintPoolCreationCap{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            cap       : 0x2::object::id<PoolCreationCap>(&v1),
        };
        0x2::event::emit<MintPoolCreationCap>(v2);
        v1
    }

    public fun mint_pool_creation_cap_by_admin<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &mut 0x2::tx_context::TxContext) : PoolCreationCap {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        let v1 = mint_pool_creation_cap_internal(arg1, v0, arg2);
        let v2 = MintPoolCreationCapByAdmin{
            coin_type : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            cap       : 0x2::object::id<PoolCreationCap>(&v1),
        };
        0x2::event::emit<MintPoolCreationCapByAdmin>(v2);
        v1
    }

    fun mint_pool_creation_cap_internal(arg0: &mut Pools, arg1: 0x1::type_name::TypeName, arg2: &mut 0x2::tx_context::TxContext) : PoolCreationCap {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PermissionPairManager>(&mut arg0.id, 0x1::string::utf8(b"permission_pair_manager"));
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&v0.coin_type_to_cap, arg1), 11);
        let v1 = PoolCreationCap{
            id        : 0x2::object::new(arg2),
            coin_type : arg1,
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v0.coin_type_to_cap, arg1, 0x2::object::id<PoolCreationCap>(&v1));
        v1
    }

    public fun new_pool_key<T0, T1>(arg0: u32) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = 0;
        let v7 = false;
        while (v6 < v5) {
            let v8 = *0x1::vector::borrow<u8>(&v3, v6);
            if (!v7 && v6 < v4) {
                let v9 = *0x1::vector::borrow<u8>(&v1, v6);
                if (v9 < v8) {
                    abort 6
                };
                if (v9 > v8) {
                    v7 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v8);
            v6 = v6 + 1;
        };
        if (!v7) {
            assert!(v4 != v5, 3);
            assert!(v4 > v5, 6);
        };
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u32>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun permission_pair_cap<T0, T1>(arg0: &Pools, arg1: u32) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v0 = 0x2::dynamic_object_field::borrow<0x1::string::String, PermissionPairManager>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager"));
        let v1 = new_pool_key<T0, T1>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&v0.pool_key_to_cap, v1), 10);
        *0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&v0.pool_key_to_cap, v1)
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_key(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_key
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        assert!(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, arg1), 10);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.list, arg1)
    }

    public fun register_permission_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &PoolCreationCap, arg4: &mut 0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        register_permission_pair_internal<T0, T1>(arg1, arg3, arg2, arg4);
    }

    fun register_permission_pair_internal<T0, T1>(arg0: &mut Pools, arg1: &PoolCreationCap, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PermissionPairManager>(&mut arg0.id, 0x1::string::utf8(b"permission_pair_manager"));
        let v1 = 0x1::type_name::get<T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&v0.allowed_pair_config, v1), 7);
        assert!(0x2::vec_set::contains<u32>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&v0.allowed_pair_config, v1), &arg2), 8);
        assert!(0x1::type_name::get<T0>() == arg1.coin_type, 13);
        let (v2, v3, v4) = if (is_right_order<T0, T1>()) {
            (new_pool_key<T0, T1>(arg2), arg1.coin_type, v1)
        } else {
            (new_pool_key<T1, T0>(arg2), v1, arg1.coin_type)
        };
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&v0.pool_key_to_cap, v2), 9);
        let v5 = 0x2::object::id<PoolCreationCap>(arg1);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut v0.pool_key_to_cap, v2, v5);
        if (!0x2::table::contains<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(&v0.cap_to_pool_key, v5)) {
            0x2::table::add<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(&mut v0.cap_to_pool_key, v5, 0x2::table::new<0x2::object::ID, PoolKey>(arg3));
        };
        let v6 = PoolKey{
            coin_a       : v3,
            coin_b       : v4,
            tick_spacing : arg2,
        };
        0x2::table::add<0x2::object::ID, PoolKey>(0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(&mut v0.cap_to_pool_key, v5), v2, v6);
        let v7 = RegisterPermissionPairEvent{
            cap          : v5,
            pool_key     : v2,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(arg1.coin_type)),
            coin_pair    : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing : arg2,
        };
        0x2::event::emit<RegisterPermissionPairEvent>(v7);
    }

    public fun remove_allowed_list<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, DenyCoinList>(&mut arg1.id, 0x1::string::utf8(b"deny_coin_list"));
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&v1.allowed_list, v0), 15);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut v1.allowed_list, v0);
        let v2 = RemoveAllowedListEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<RemoveAllowedListEvent>(v2);
    }

    public fun remove_allowed_pair_config<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PermissionPairManager>(&mut arg1.id, 0x1::string::utf8(b"permission_pair_manager"));
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&v1.allowed_pair_config, v0), 25);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&mut v1.allowed_pair_config, v0);
        assert!(0x2::vec_set::contains<u32>(v2, &arg2), 8);
        0x2::vec_set::remove<u32>(v2, &arg2);
        if (0x2::vec_set::is_empty<u32>(v2)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::vec_set::VecSet<u32>>(&mut v1.allowed_pair_config, v0);
        };
        let v3 = RemoveAllowedPairConfigEvent{
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            tick_spacing : arg2,
        };
        0x2::event::emit<RemoveAllowedPairConfigEvent>(v3);
    }

    public fun remove_denied_list<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"deny_coin_list")), 20);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, DenyCoinList>(&mut arg1.id, 0x1::string::utf8(b"deny_coin_list"));
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&v1.denied_list, v0), 15);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut v1.denied_list, v0);
        let v2 = RemoveDeniedListEvent{coin_type: 0x1::string::from_ascii(0x1::type_name::into_string(v0))};
        0x2::event::emit<RemoveDeniedListEvent>(v2);
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        arg0.tick_spacing
    }

    public fun unregister_permission_pair<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &PoolCreationCap) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::checked_package_version(arg0);
        unregister_permission_pair_internal<T0, T1>(arg1, arg3, arg2);
    }

    fun unregister_permission_pair_internal<T0, T1>(arg0: &mut Pools, arg1: &PoolCreationCap, arg2: u32) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"permission_pair_manager")), 22);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, PermissionPairManager>(&mut arg0.id, 0x1::string::utf8(b"permission_pair_manager"));
        let v1 = if (is_right_order<T0, T1>()) {
            new_pool_key<T0, T1>(arg2)
        } else {
            new_pool_key<T1, T0>(arg2)
        };
        assert!(0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&v0.pool_key_to_cap, v1), 10);
        let v2 = 0x2::object::id<PoolCreationCap>(arg1);
        assert!(0x2::table::remove<0x2::object::ID, 0x2::object::ID>(&mut v0.pool_key_to_cap, v1) == v2, 13);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(&mut v0.cap_to_pool_key, v2);
        0x2::table::remove<0x2::object::ID, PoolKey>(v3, v1);
        if (0x2::table::is_empty<0x2::object::ID, PoolKey>(v3)) {
            0x2::table::destroy_empty<0x2::object::ID, PoolKey>(0x2::table::remove<0x2::object::ID, 0x2::table::Table<0x2::object::ID, PoolKey>>(&mut v0.cap_to_pool_key, v2));
        };
        let v4 = UnregisterPermissionPairEvent{
            cap          : v2,
            pool_key     : v1,
            coin_type    : 0x1::string::from_ascii(0x1::type_name::into_string(arg1.coin_type)),
            coin_pair    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            tick_spacing : arg2,
        };
        0x2::event::emit<UnregisterPermissionPairEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

