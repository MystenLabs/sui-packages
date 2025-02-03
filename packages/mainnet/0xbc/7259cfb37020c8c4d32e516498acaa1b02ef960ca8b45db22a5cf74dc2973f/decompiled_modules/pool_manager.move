module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::pool_manager {
    struct PoolManagerInfo has store, key {
        id: 0x2::object::UID,
        app_infos: 0x2::table::Table<u16, AppInfo>,
        pool_infos: 0x2::table::Table<u16, PoolInfo>,
        pool_catalog: PoolCatalog,
    }

    struct AppInfo has store {
        app_liquidity: 0x2::table::Table<u16, Liquidity>,
    }

    struct PoolInfo has store {
        name: 0x1::ascii::String,
        reserve: Liquidity,
        alpha_1: u256,
        total_weight: u256,
        pools: 0x2::table::Table<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>,
    }

    struct Liquidity has store {
        value: u256,
    }

    struct PoolLiquidity has store {
        value: u256,
        lambda_1: u256,
        equilibrium_fee: u256,
        weight: u256,
    }

    struct PoolCatalog has store {
        pool_to_id: 0x2::table::Table<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u16>,
        id_to_pools: 0x2::table::Table<u16, vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>>,
    }

    struct AddLiquidity has copy, drop {
        pool_address: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress,
        amount: u256,
        equilibrium_reward: u256,
    }

    struct RemoveLiquidity has copy, drop {
        pool_address: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress,
        amount: u256,
        equilibrium_fee: u256,
    }

    public(friend) fun add_liquidity(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg2: u16, arg3: u256) : (u256, u256) {
        assert!(exist_certain_pool(arg0, arg1), 3);
        let v0 = get_id_by_pool(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<u16, PoolInfo>(&mut arg0.pool_infos, v0);
        let v2 = 0x2::table::borrow_mut<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&mut v1.pools, arg1);
        let v3 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::equilibrium_fee::calculate_equilibrium_reward(v1.reserve.value, v2.value, arg3, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::equilibrium_fee::calculate_expected_ratio(v1.total_weight, v2.weight), v2.equilibrium_fee, v2.lambda_1);
        let v4 = arg3 + v3;
        let v5 = &mut 0x2::table::borrow_mut<u16, AppInfo>(&mut arg0.app_infos, v0).app_liquidity;
        if (!0x2::table::contains<u16, Liquidity>(v5, arg2)) {
            let v6 = Liquidity{value: v4};
            0x2::table::add<u16, Liquidity>(v5, arg2, v6);
        } else {
            let v7 = 0x2::table::borrow_mut<u16, Liquidity>(v5, arg2);
            v7.value = v7.value + v4;
        };
        v1.reserve.value = v1.reserve.value + arg3;
        v2.value = v2.value + arg3;
        v2.equilibrium_fee = v2.equilibrium_fee - v3;
        let v8 = AddLiquidity{
            pool_address       : arg1,
            amount             : arg3,
            equilibrium_reward : v3,
        };
        0x2::event::emit<AddLiquidity>(v8);
        (v4, v3)
    }

    public fun exist_certain_pool(arg0: &PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress) : bool {
        0x2::table::contains<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u16>(&arg0.pool_catalog.pool_to_id, arg1)
    }

    public fun exist_pool_id(arg0: &PoolManagerInfo, arg1: u16) : bool {
        0x2::table::contains<u16, PoolInfo>(&arg0.pool_infos, arg1)
    }

    public fun find_pool_by_chain(arg0: &mut PoolManagerInfo, arg1: u16, arg2: u16) : 0x1::option::Option<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress> {
        abort 0
    }

    public fun get_app_liquidity(arg0: &PoolManagerInfo, arg1: u16, arg2: u16) : u256 {
        assert!(exist_pool_id(arg0, arg1), 1);
        let v0 = &0x2::table::borrow<u16, AppInfo>(&arg0.app_infos, arg1).app_liquidity;
        if (0x2::table::contains<u16, Liquidity>(v0, arg2)) {
            0x2::table::borrow<u16, Liquidity>(v0, arg2).value
        } else {
            0
        }
    }

    public fun get_default_alpha_1() : u256 {
        600000000000000000000000000
    }

    public fun get_default_lambda_1() : u256 {
        5000000000000000000000000
    }

    public fun get_id_by_pool(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress) : u16 {
        assert!(exist_certain_pool(arg0, arg1), 3);
        *0x2::table::borrow<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u16>(&mut arg0.pool_catalog.pool_to_id, arg1)
    }

    public fun get_pool_equilibrium_fee(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress) : u256 {
        assert!(exist_certain_pool(arg0, arg1), 3);
        let v0 = get_id_by_pool(arg0, arg1);
        0x2::table::borrow<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&0x2::table::borrow<u16, PoolInfo>(&arg0.pool_infos, v0).pools, arg1).equilibrium_fee
    }

    public fun get_pool_liquidity(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress) : u256 {
        assert!(exist_certain_pool(arg0, arg1), 3);
        let v0 = get_id_by_pool(arg0, arg1);
        0x2::table::borrow<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&0x2::table::borrow<u16, PoolInfo>(&arg0.pool_infos, v0).pools, arg1).value
    }

    public fun get_pool_name_by_id(arg0: &mut PoolManagerInfo, arg1: u16) : 0x1::ascii::String {
        assert!(exist_pool_id(arg0, arg1), 1);
        0x2::table::borrow<u16, PoolInfo>(&mut arg0.pool_infos, arg1).name
    }

    public fun get_pool_total_weight(arg0: &mut PoolManagerInfo, arg1: u16) : u256 {
        assert!(exist_pool_id(arg0, arg1), 1);
        0x2::table::borrow<u16, PoolInfo>(&arg0.pool_infos, arg1).total_weight
    }

    public fun get_pool_weight(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress) : u256 {
        assert!(exist_certain_pool(arg0, arg1), 3);
        let v0 = get_id_by_pool(arg0, arg1);
        0x2::table::borrow<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&0x2::table::borrow<u16, PoolInfo>(&arg0.pool_infos, v0).pools, arg1).weight
    }

    public fun get_pools_by_id(arg0: &mut PoolManagerInfo, arg1: u16) : vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress> {
        assert!(exist_pool_id(arg0, arg1), 1);
        *0x2::table::borrow<u16, vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>>(&mut arg0.pool_catalog.id_to_pools, arg1)
    }

    public fun get_token_liquidity(arg0: &mut PoolManagerInfo, arg1: u16) : u256 {
        assert!(exist_pool_id(arg0, arg1), 1);
        0x2::table::borrow<u16, PoolInfo>(&arg0.pool_infos, arg1).reserve.value
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolCatalog{
            pool_to_id  : 0x2::table::new<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u16>(arg0),
            id_to_pools : 0x2::table::new<u16, vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>>(arg0),
        };
        let v1 = PoolManagerInfo{
            id           : 0x2::object::new(arg0),
            app_infos    : 0x2::table::new<u16, AppInfo>(arg0),
            pool_infos   : 0x2::table::new<u16, PoolInfo>(arg0),
            pool_catalog : v0,
        };
        0x2::transfer::share_object<PoolManagerInfo>(v1);
    }

    public fun register_pool(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut PoolManagerInfo, arg2: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg3: u16) {
        assert!(exist_pool_id(arg1, arg3), 1);
        assert!(!exist_certain_pool(arg1, arg2), 2);
        let v0 = &mut arg1.pool_catalog;
        0x2::table::add<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, u16>(&mut v0.pool_to_id, arg2, arg3);
        0x1::vector::push_back<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>(0x2::table::borrow_mut<u16, vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>>(&mut v0.id_to_pools, arg3), arg2);
        let v1 = PoolLiquidity{
            value           : 0,
            lambda_1        : 5000000000000000000000000,
            equilibrium_fee : 0,
            weight          : 0,
        };
        0x2::table::add<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&mut 0x2::table::borrow_mut<u16, PoolInfo>(&mut arg1.pool_infos, arg3).pools, arg2, v1);
    }

    public fun register_pool_id(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut PoolManagerInfo, arg2: 0x1::ascii::String, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!exist_pool_id(arg1, arg3), 0);
        let v0 = PoolInfo{
            name         : arg2,
            reserve      : zero_liquidity(),
            alpha_1      : 600000000000000000000000000,
            total_weight : 0,
            pools        : 0x2::table::new<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(arg4),
        };
        0x2::table::add<u16, PoolInfo>(&mut arg1.pool_infos, arg3, v0);
        0x2::table::add<u16, vector<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>>(&mut arg1.pool_catalog.id_to_pools, arg3, 0x1::vector::empty<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress>());
        let v1 = AppInfo{app_liquidity: 0x2::table::new<u16, Liquidity>(arg4)};
        0x2::table::add<u16, AppInfo>(&mut arg1.app_infos, arg3, v1);
    }

    public(friend) fun remove_liquidity(arg0: &mut PoolManagerInfo, arg1: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg2: u16, arg3: u256) : (u256, u256) {
        assert!(exist_certain_pool(arg0, arg1), 3);
        let v0 = get_id_by_pool(arg0, arg1);
        let v1 = 0x2::table::borrow_mut<u16, PoolInfo>(&mut arg0.pool_infos, v0);
        let v2 = 0x2::table::borrow_mut<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&mut v1.pools, arg1);
        assert!(v2.value >= arg3, 6);
        let v3 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::equilibrium_fee::calculate_equilibrium_fee(v1.reserve.value, v2.value, arg3, 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::equilibrium_fee::calculate_expected_ratio(v1.total_weight, v2.weight), v1.alpha_1, v2.lambda_1);
        let v4 = arg3 - v3;
        let v5 = &mut 0x2::table::borrow_mut<u16, AppInfo>(&mut arg0.app_infos, v0).app_liquidity;
        assert!(0x2::table::contains<u16, Liquidity>(v5, arg2), 4);
        let v6 = 0x2::table::borrow_mut<u16, Liquidity>(v5, arg2);
        assert!(v6.value >= arg3, 5);
        v6.value = v6.value - arg3;
        v1.reserve.value = v1.reserve.value - v4;
        v2.value = v2.value - v4;
        v2.equilibrium_fee = v2.equilibrium_fee + v3;
        let v7 = RemoveLiquidity{
            pool_address    : arg1,
            amount          : arg3,
            equilibrium_fee : v3,
        };
        0x2::event::emit<RemoveLiquidity>(v7);
        (v4, v3)
    }

    public fun set_equilibrium_alpha(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut PoolManagerInfo, arg2: u16, arg3: u256) {
        assert!(exist_pool_id(arg1, arg2), 1);
        0x2::table::borrow_mut<u16, PoolInfo>(&mut arg1.pool_infos, arg2).alpha_1 = arg3;
    }

    public fun set_equilibrium_lambda(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut PoolManagerInfo, arg2: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg3: u256) {
        assert!(exist_certain_pool(arg1, arg2), 3);
        let v0 = get_id_by_pool(arg1, arg2);
        0x2::table::borrow_mut<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&mut 0x2::table::borrow_mut<u16, PoolInfo>(&mut arg1.pool_infos, v0).pools, arg2).lambda_1 = arg3;
    }

    public fun set_pool_weight(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut PoolManagerInfo, arg2: 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, arg3: u256) {
        assert!(exist_certain_pool(arg1, arg2), 3);
        let v0 = get_id_by_pool(arg1, arg2);
        let v1 = 0x2::table::borrow_mut<u16, PoolInfo>(&mut arg1.pool_infos, v0);
        let v2 = 0x2::table::borrow_mut<0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::dola_address::DolaAddress, PoolLiquidity>(&mut v1.pools, arg2);
        v1.total_weight = v1.total_weight - v2.weight + arg3;
        v2.weight = arg3;
    }

    public fun zero_liquidity() : Liquidity {
        Liquidity{value: 0}
    }

    // decompiled from Move bytecode v6
}

