module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::factory {
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

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        tick_spacing: u32,
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

    public fun add_allowed_list<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun add_allowed_pair_config<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun add_denied_list<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun coin_types(arg0: &PoolSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        abort 0
    }

    public fun create_pool<T0, T1>(arg0: &mut Pools, arg1: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun create_pool_with_liquidity<T0, T1>(arg0: &mut Pools, arg1: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun fetch_pools(arg0: &Pools, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolSimpleInfo> {
        abort 0
    }

    public fun in_allowed_list<T0>(arg0: &Pools) : bool {
        abort 0
    }

    public fun in_denied_list<T0>(arg0: &Pools) : bool {
        abort 0
    }

    public fun index(arg0: &Pools) : u64 {
        abort 0
    }

    public fun is_allowed_coin<T0>(arg0: &mut Pools, arg1: &0x2::coin::CoinMetadata<T0>) : bool {
        abort 0
    }

    public fun is_permission_pair<T0, T1>(arg0: &Pools, arg1: u32) : bool {
        abort 0
    }

    public fun mint_pool_creation_cap<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : PoolCreationCap {
        abort 0
    }

    public fun mint_pool_creation_cap_by_admin<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &mut 0x2::tx_context::TxContext) : PoolCreationCap {
        abort 0
    }

    public fun new_pool_key<T0, T1>(arg0: u32) : 0x2::object::ID {
        abort 0
    }

    public fun permission_pair_cap<T0, T1>(arg0: &Pools, arg1: u32) : 0x2::object::ID {
        abort 0
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        abort 0
    }

    public fun pool_key(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        abort 0
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        abort 0
    }

    public fun register_permission_pair<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &PoolCreationCap, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun remove_allowed_list<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun remove_allowed_pair_config<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun remove_denied_list<T0>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: &0x2::tx_context::TxContext) {
        abort 0
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        abort 0
    }

    public fun unregister_permission_pair<T0, T1>(arg0: &0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: &PoolCreationCap) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

