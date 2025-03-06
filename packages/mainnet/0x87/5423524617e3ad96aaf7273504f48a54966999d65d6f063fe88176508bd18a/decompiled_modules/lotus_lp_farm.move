module 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_lp_farm {
    struct LotusLPFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
        td_farms: 0x2::bag::Bag,
        td_farm_admin_caps: 0x2::bag::Bag,
        allowed_deposit_asset: 0x2::vec_set::VecSet<0x1::ascii::String>,
        vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        vault_td_farm_member_ids: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        vault_tvls: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        allowed_db_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        max_tvl: u64,
    }

    struct LotusLPFarmCap has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
    }

    struct LotusLPFarmCreatePoolTicket {
        key_id: 0x2::object::ID,
        usd_value: u64,
        lp_token_to_mint: u64,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
    }

    struct LotusLPFarmUpdatePoolWeightTicket {
        key_id: 0x2::object::ID,
        vault_by_td_farm: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x1::ascii::String>>,
    }

    struct CreateLPFarmEvent has copy, drop {
        farm_id: 0x2::object::ID,
        farm_cap_id: 0x2::object::ID,
    }

    struct CreateIncentivizedDBVaultEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        allowed_db_pool_id: 0x2::object::ID,
        init_deposit_type: 0x1::type_name::TypeName,
        init_deposit_value: u64,
        vault_id: 0x2::object::ID,
        vault_cap_id: 0x2::object::ID,
    }

    struct TopUpFarmIncentiveEvent has copy, drop {
        farm_id: 0x2::object::ID,
        td_farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        top_up_value: u64,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : (LotusLPFarm<T0>, LotusLPFarmCap) {
        let v0 = LotusLPFarm<T0>{
            id                       : 0x2::object::new(arg0),
            td_farm_keys             : 0x2::vec_set::empty<0x1::ascii::String>(),
            td_farms                 : 0x2::bag::new(arg0),
            td_farm_admin_caps       : 0x2::bag::new(arg0),
            allowed_deposit_asset    : 0x2::vec_set::empty<0x1::ascii::String>(),
            vault_ids                : 0x2::vec_set::empty<0x2::object::ID>(),
            vault_td_farm_member_ids : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            vault_tvls               : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            allowed_db_pools         : 0x2::vec_set::empty<0x2::object::ID>(),
            max_tvl                  : 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::consts::GET_MAX_U64(),
        };
        let v1 = LotusLPFarmCap{
            id      : 0x2::object::new(arg0),
            farm_id : 0x2::object::id<LotusLPFarm<T0>>(&v0),
        };
        let v2 = CreateLPFarmEvent{
            farm_id     : 0x2::object::id<LotusLPFarm<T0>>(&v0),
            farm_cap_id : 0x2::object::id<LotusLPFarmCap>(&v1),
        };
        0x2::event::emit<CreateLPFarmEvent>(v2);
        (v0, v1)
    }

    public fun collect_incentive_rewards_to_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>, arg2: 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::collect_incentive_rewards_to_vault<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
    }

    public fun add_allowed_db_pool<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: 0x2::object::ID) {
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_db_pools, arg2);
    }

    public fun add_allowed_deposit_asset<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.allowed_deposit_asset, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
    }

    public fun add_incentivized_db_vault_to_td_farm_with_ticket<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>, arg2: &mut LotusLPFarmCreatePoolTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg2.td_farm_keys, &v0), 1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg2.td_farm_keys, v0);
        0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::add_to_td_farm<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), ((arg2.usd_value / 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::consts::GET_TD_WEIGHT_SCALE()) as u32), arg3);
    }

    public fun add_td_farm<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_farm_cap<T0>(arg0, arg1);
        let (v0, v1) = 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::create<T1>(0x2::balance::zero<T1>(), arg2, arg3);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v2), 0);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.td_farm_keys, v2);
        0x2::bag::add<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v2, v0);
        0x2::bag::add<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&mut arg0.td_farm_admin_caps, v2, v1);
    }

    fun assert_allowed_db_pool<T0>(arg0: &LotusLPFarm<T0>, arg1: 0x2::object::ID) {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_db_pools, &arg1), 5);
    }

    fun assert_deposit_asset_type<T0, T1>(arg0: &LotusLPFarm<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.allowed_deposit_asset, &v0), 4);
    }

    fun assert_farm_cap<T0>(arg0: &LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert!(0x2::object::id<LotusLPFarm<T0>>(arg0) == arg1.farm_id, 9223373926640386047);
    }

    public fun create_incentivized_db_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::oracle_ag::OracleAggregator, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>, 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVaultCap, LotusLPFarmCreatePoolTicket) {
        assert_allowed_db_pool<T0>(arg0, arg1);
        0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::oracle_ag::assert_price_object_type<T1>(arg3, arg4);
        let (v0, v1) = 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::new<T0>(arg1, arg6);
        let v2 = v1;
        let v3 = v0;
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.vault_ids, 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(&v3));
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_td_farm_member_ids, 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(&v3), 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::get_td_farm_member_key_id<T0>(&v3));
        let v4 = 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::oracle_ag::calc_usd_value<T1>(arg3, arg4, 0x2::coin::value<T1>(&arg2), arg5);
        let v5 = 0x1::string::utf8(b"Create Incentivized DB Vault at initial value: ");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&v4);
        assert_deposit_asset_type<T0, T1>(arg0);
        0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::deposit<T1, T0>(&mut v3, arg2, arg6);
        assert!(get_vault_tvls_sum<T0>(arg0) + v4 <= arg0.max_tvl, 6);
        let v6 = CreateIncentivizedDBVaultEvent{
            farm_id            : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            balance_manager_id : 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::balance_manager_id<T0>(&v3),
            allowed_db_pool_id : arg1,
            init_deposit_type  : 0x1::type_name::get<T1>(),
            init_deposit_value : v4,
            vault_id           : 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(&v3),
            vault_cap_id       : 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVaultCap>(&v2),
        };
        0x2::event::emit<CreateIncentivizedDBVaultEvent>(v6);
        (v3, v2, new_create_pool_ticket<T0>(arg0, v4))
    }

    public fun destroy_create_pool_ticket<T0>(arg0: &mut LotusLPFarm<T0>, arg1: LotusLPFarmCreatePoolTicket) {
        assert!(arg1.key_id == 0x2::object::id<LotusLPFarm<T0>>(arg0), 1);
        assert!(0x2::vec_set::size<0x1::ascii::String>(&arg1.td_farm_keys) == 0x2::vec_set::size<0x1::ascii::String>(&arg0.td_farm_keys), 2);
        let LotusLPFarmCreatePoolTicket {
            key_id           : _,
            usd_value        : _,
            lp_token_to_mint : _,
            td_farm_keys     : _,
        } = arg1;
    }

    public fun get_max_tvl<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        arg0.max_tvl
    }

    public fun get_vault_tvls_sum<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x2::object::ID, u64>(&arg0.vault_tvls)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<0x2::object::ID, u64>(&arg0.vault_tvls, v1);
            v0 = v0 + *v3;
            v1 = v1 + 1;
        };
        v0
    }

    public fun lp_token_receipt_mark_on_ticket<T0>(arg0: &mut LotusLPFarmCreatePoolTicket) : u64 {
        arg0.lp_token_to_mint = 0;
        arg0.lp_token_to_mint
    }

    fun new_create_pool_ticket<T0>(arg0: &LotusLPFarm<T0>, arg1: u64) : LotusLPFarmCreatePoolTicket {
        LotusLPFarmCreatePoolTicket{
            key_id           : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            usd_value        : arg1,
            lp_token_to_mint : arg1,
            td_farm_keys     : 0x2::vec_set::empty<0x1::ascii::String>(),
        }
    }

    public fun set_farm_unlock_rate<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_farm_cap<T0>(arg0, arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::change_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
    }

    public fun td_farm_contains<T0, T1>(arg0: &LotusLPFarm<T0>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0)
    }

    public fun td_farm_final_unlock_ts_sec<T0, T1>(arg0: &LotusLPFarm<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::get_final_unlock_ts_sec<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0))
    }

    public fun td_farm_length<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        0x2::vec_set::size<0x1::ascii::String>(&arg0.td_farm_keys)
    }

    public fun td_farm_remaining_unlock<T0, T1>(arg0: &LotusLPFarm<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::get_remaining_unlock<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0), arg1)
    }

    public fun td_farm_unlock_rate<T0, T1>(arg0: &LotusLPFarm<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::get_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0))
    }

    public fun td_farm_unlock_start_ts_sec<T0, T1>(arg0: &LotusLPFarm<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::get_unlock_start_ts_sec<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0))
    }

    public fun top_up_incentive_balance<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0);
        let v2 = TopUpFarmIncentiveEvent{
            farm_id      : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            td_farm_id   : 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(v1),
            coin_type    : 0x1::type_name::get<T1>(),
            top_up_value : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<TopUpFarmIncentiveEvent>(v2);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::top_up_balance<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), v1, 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public fun top_up_to_td_pool<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>, arg2: &mut 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::td_pool_top_up<T0, T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg1, arg2, arg3);
    }

    public fun update_max_tvl<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64) {
        assert_farm_cap<T0>(arg0, arg1);
        arg0.max_tvl = arg2;
    }

    public fun update_vault_weight_permissionless<T0, T1, T2, T3>(arg0: &mut LotusLPFarm<T0>, arg1: &0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::oracle_ag::OracleAggregator, arg7: &0x2::clock::Clock) {
        let v0 = 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::get_total_usd_value<T0, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(arg1);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::debug::print<0x1::ascii::String>(&v2);
        let v3 = 0x2::bag::length(&arg0.td_farms);
        0x1::debug::print<u64>(&v3);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::change_member_weight<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v2), 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v2), *0x2::vec_map::get<0x2::object::ID, 0x2::object::ID>(&arg0.vault_td_farm_member_ids, &v1), ((v0 / 0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::consts::GET_TD_WEIGHT_SCALE()) as u32), arg7);
        let v4 = 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(arg1);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.vault_tvls, &v4)) {
            let v5 = 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(arg1);
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.vault_tvls, &v5) = v0;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.vault_tvls, 0x2::object::id<0x875423524617e3ad96aaf7273504f48a54966999d65d6f063fe88176508bd18a::lotus_db_vault::LotusDBVault<T0>>(arg1), v0);
        };
    }

    // decompiled from Move bytecode v6
}

