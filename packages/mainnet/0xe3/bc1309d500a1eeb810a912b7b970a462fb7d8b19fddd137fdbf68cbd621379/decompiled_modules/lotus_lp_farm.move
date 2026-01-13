module 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_lp_farm {
    struct LotusLPFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
        td_farms: 0x2::bag::Bag,
        td_farm_admin_caps: 0x2::bag::Bag,
        allowed_deposit_asset: 0x2::vec_set::VecSet<0x1::ascii::String>,
        banned_vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        vault_td_farm_member_ids: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        vault_tvls: 0x2::vec_map::VecMap<0x2::object::ID, u64>,
        allowed_db_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        max_tvl: u64,
        min_vault_usd_value: u64,
    }

    struct LotusLPFarmCap has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
    }

    struct LotusLPFarmCreateVaultTicket {
        key_id: 0x2::object::ID,
        usd_value: u64,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
    }

    struct LotusLPFarmCloseVaultTicket {
        key_id: 0x2::object::ID,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
    }

    struct LotusLPFarmUpdatePoolWeightTicket {
        key_id: 0x2::object::ID,
        td_farm_id: 0x2::object::ID,
        vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CreateLPFarmEvent has copy, drop {
        farm_id: 0x2::object::ID,
        farm_cap_id: 0x2::object::ID,
    }

    struct UpdateLPFarmEvent has copy, drop {
        farm_id: 0x2::object::ID,
        event_type: u8,
    }

    struct CreateIncentivizedDBVaultEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        allowed_db_pool_id: 0x2::object::ID,
        base_deposit_type: 0x1::type_name::TypeName,
        base_deposit_value: u64,
        quote_deposit_type: 0x1::type_name::TypeName,
        quote_deposit_value: u64,
        vault_id: 0x2::object::ID,
        vault_creator_cap_id: 0x2::object::ID,
        vault_trade_cap_id: 0x2::object::ID,
    }

    struct TopUpFarmIncentiveEvent has copy, drop {
        farm_id: 0x2::object::ID,
        td_farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        top_up_value: u64,
    }

    struct UpdateVaultWeightEvent has copy, drop {
        farm_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        usd_value: u64,
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
            banned_vault_ids         : 0x2::vec_set::empty<0x2::object::ID>(),
            vault_ids                : 0x2::vec_set::empty<0x2::object::ID>(),
            vault_td_farm_member_ids : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            vault_tvls               : 0x2::vec_map::empty<0x2::object::ID, u64>(),
            allowed_db_pools         : 0x2::vec_set::empty<0x2::object::ID>(),
            max_tvl                  : 18446744073709551615,
            min_vault_usd_value      : 0,
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

    public fun remove_farm_key_from_td_farm<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, arg2: &mut LotusLPFarmCloseVaultTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::remove_farm_key_from_td_farm<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg3);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg2.td_farm_keys, v0);
    }

    public fun add_allowed_db_pool<T0, T1, T2>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>) {
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_db_pools, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg2));
        let v0 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 3,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v0);
    }

    public fun add_allowed_deposit_asset<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.allowed_deposit_asset, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v0 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 1,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v0);
    }

    public fun add_banned_vault<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>) {
        let v0 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg2);
        assert_farm_cap<T0>(arg0, arg1);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.banned_vault_ids, &v0)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.banned_vault_ids, v0);
        };
        let v1 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 5,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v1);
    }

    public fun add_incentivized_db_vault_to_td_farm_with_ticket<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, arg2: &mut LotusLPFarmCreateVaultTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg2.td_farm_keys, &v0), 1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg2.td_farm_keys, v0);
        0x1::debug::print<u64>(&arg2.usd_value);
        let v1 = ((arg2.usd_value / 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::consts::GET_TD_WEIGHT_SCALE()) as u32);
        let v2 = v1;
        if (v1 == 0) {
            v2 = 1;
        };
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::add_to_td_farm<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), v2, arg3);
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
        assert!(0x2::object::id<LotusLPFarm<T0>>(arg0) == arg1.farm_id, 13906836936007352319);
    }

    public fun close_vault_permissionless<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>) : LotusLPFarmCloseVaultTicket {
        let v0 = 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::get_shareholder_address_vec<T0>(arg1);
        assert!(0x1::vector::length<address>(&v0) == 0, 9);
        new_close_vault_ticket<T0>(arg0)
    }

    public fun create_incentivized_db_vault<T0, T1, T2>(arg0: &mut LotusLPFarm<T0>, arg1: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_config::LotusConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::OracleAggregator, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVaultCap, 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVaultCap, LotusLPFarmCreateVaultTicket) {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>>(arg2);
        assert_allowed_db_pool<T0>(arg0, v0);
        assert_deposit_asset_type<T0, T1>(arg0);
        assert_deposit_asset_type<T0, T2>(arg0);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::assert_price_object_type<T1>(arg5, arg6);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::assert_price_object_type<T2>(arg5, arg7);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_config::assert_current_version(arg1);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_config::assert_protocol_status_ok(arg1);
        let v1 = 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::calc_usd_value<T1>(arg5, arg6, 0x2::coin::value<T1>(&arg3), arg8) + 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::calc_usd_value<T2>(arg5, arg7, 0x2::coin::value<T2>(&arg4), arg8);
        let (v2, v3, v4) = 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::new_for_pooling<T0>(v0, v1, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.vault_ids, 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(&v7));
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_td_farm_member_ids, 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(&v7), 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::get_td_farm_member_key_id<T0>(&v7));
        assert!(v1 >= arg0.min_vault_usd_value, 7);
        let v8 = 0x1::string::utf8(b"Create Incentivized DB Vault at initial value: ");
        0x1::debug::print<0x1::string::String>(&v8);
        0x1::debug::print<u64>(&v1);
        assert_deposit_asset_type<T0, T1>(arg0);
        assert_deposit_asset_type<T0, T2>(arg0);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::deposit<T1, T0>(&mut v7, arg3, arg9);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::deposit<T2, T0>(&mut v7, arg4, arg9);
        assert!(get_vault_tvls_sum<T0>(arg0) + v1 <= arg0.max_tvl, 6);
        0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.vault_tvls, 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(&v7), v1);
        let v9 = CreateIncentivizedDBVaultEvent{
            farm_id              : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            balance_manager_id   : 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::balance_manager_id<T0>(&v7),
            allowed_db_pool_id   : v0,
            base_deposit_type    : 0x1::type_name::get<T1>(),
            base_deposit_value   : 0x2::coin::value<T1>(&arg3),
            quote_deposit_type   : 0x1::type_name::get<T2>(),
            quote_deposit_value  : 0x2::coin::value<T2>(&arg4),
            vault_id             : 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(&v7),
            vault_creator_cap_id : 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVaultCap>(&v6),
            vault_trade_cap_id   : 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVaultCap>(&v5),
        };
        0x2::event::emit<CreateIncentivizedDBVaultEvent>(v9);
        (v7, v6, v5, new_create_pool_ticket<T0>(arg0, v1))
    }

    public fun create_update_vault_weight_ticket<T0, T1>(arg0: &LotusLPFarm<T0>) : LotusLPFarmUpdatePoolWeightTicket {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        LotusLPFarmUpdatePoolWeightTicket{
            key_id     : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            td_farm_id : 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0)),
            vault_ids  : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun destroy_close_vault_ticket<T0>(arg0: &mut LotusLPFarm<T0>, arg1: LotusLPFarmCloseVaultTicket) {
        assert!(arg1.key_id == 0x2::object::id<LotusLPFarm<T0>>(arg0), 1);
        assert!(0x2::vec_set::size<0x1::ascii::String>(&arg1.td_farm_keys) == 0x2::vec_set::size<0x1::ascii::String>(&arg0.td_farm_keys), 2);
        let LotusLPFarmCloseVaultTicket {
            key_id       : _,
            td_farm_keys : _,
        } = arg1;
    }

    public fun destroy_create_pool_ticket<T0>(arg0: &mut LotusLPFarm<T0>, arg1: LotusLPFarmCreateVaultTicket) {
        assert!(arg1.key_id == 0x2::object::id<LotusLPFarm<T0>>(arg0), 1);
        assert!(0x2::vec_set::size<0x1::ascii::String>(&arg1.td_farm_keys) == 0x2::vec_set::size<0x1::ascii::String>(&arg0.td_farm_keys), 2);
        let LotusLPFarmCreateVaultTicket {
            key_id       : _,
            usd_value    : _,
            td_farm_keys : _,
        } = arg1;
    }

    public fun destroy_update_vault_weight_ticket<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: LotusLPFarmUpdatePoolWeightTicket) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        let v1 = 0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&arg0.td_farms, v0);
        assert!(arg1.key_id == 0x2::object::id<LotusLPFarm<T0>>(arg0), 10);
        assert!(arg1.td_farm_id == 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(v1), 10);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg1.vault_ids) == 0x2::vec_set::size<0x2::object::ID>(&arg0.vault_ids), 2);
        let v2 = 0;
        while (v2 < 0x2::vec_set::size<0x2::object::ID>(&arg1.vault_ids)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(0x2::vec_set::keys<0x2::object::ID>(&arg0.vault_ids), v2);
            assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.vault_ids, &v3), 10);
            v2 = v2 + 1;
        };
        let LotusLPFarmUpdatePoolWeightTicket {
            key_id     : _,
            td_farm_id : _,
            vault_ids  : _,
        } = arg1;
    }

    public fun get_max_tvl<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        arg0.max_tvl
    }

    public fun get_min_vault_usd_value<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        arg0.min_vault_usd_value
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

    fun new_close_vault_ticket<T0>(arg0: &LotusLPFarm<T0>) : LotusLPFarmCloseVaultTicket {
        LotusLPFarmCloseVaultTicket{
            key_id       : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            td_farm_keys : 0x2::vec_set::empty<0x1::ascii::String>(),
        }
    }

    fun new_create_pool_ticket<T0>(arg0: &LotusLPFarm<T0>, arg1: u64) : LotusLPFarmCreateVaultTicket {
        LotusLPFarmCreateVaultTicket{
            key_id       : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            usd_value    : arg1,
            td_farm_keys : 0x2::vec_set::empty<0x1::ascii::String>(),
        }
    }

    public fun remove_allowed_db_pool<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: 0x2::object::ID) {
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_db_pools, &arg2);
        let v0 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 4,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v0);
    }

    public fun remove_allowed_deposit_asset<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert_farm_cap<T0>(arg0, arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.allowed_deposit_asset, &v0);
        let v1 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 2,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v1);
    }

    public fun remove_banned_vault<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>) {
        let v0 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg2);
        assert_farm_cap<T0>(arg0, arg1);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.banned_vault_ids, &v0);
        let v1 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 6,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v1);
    }

    public fun set_farm_unlock_rate<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_farm_cap<T0>(arg0, arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::change_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
        let v1 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 10,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v1);
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

    public fun top_up_to_td_pool<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, arg2: &mut 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::td_pool_top_up<T0, T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg1, arg2, arg3);
    }

    public fun update_max_tvl<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64) {
        assert_farm_cap<T0>(arg0, arg1);
        arg0.max_tvl = arg2;
        let v0 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 11,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v0);
    }

    public fun update_min_vault_usd_value<T0>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64) {
        assert_farm_cap<T0>(arg0, arg1);
        arg0.min_vault_usd_value = arg2;
        let v0 = UpdateLPFarmEvent{
            farm_id    : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            event_type : 12,
        };
        0x2::event::emit<UpdateLPFarmEvent>(v0);
    }

    public fun update_vault_weight_with_ticket<T0, T1, T2, T3>(arg0: &mut LotusLPFarm<T0>, arg1: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::OracleAggregator, arg7: &mut LotusLPFarmUpdatePoolWeightTicket, arg8: &0x2::clock::Clock) {
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::assert_db_pool<T0, T2, T3>(arg1, arg2);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::assert_price_object_type<T2>(arg6, arg3);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::assert_price_object_type<T3>(arg6, arg4);
        0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::assert_price_object_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, arg5);
        assert!(arg7.key_id == 0x2::object::id<LotusLPFarm<T0>>(arg0), 10);
        let v0 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1);
        let (v1, v2) = if (0x2::vec_set::contains<0x2::object::ID>(&arg0.banned_vault_ids, &v0)) {
            (0, 1)
        } else {
            let v3 = 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::get_total_usd_value<T0, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg8);
            (v3, ((v3 / 0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::consts::GET_TD_WEIGHT_SCALE()) as u32))
        };
        if (v2 == 0) {
            v2 = 1;
        };
        let v4 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1);
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::debug::print<0x1::ascii::String>(&v5);
        let v6 = 0x2::bag::length(&arg0.td_farms);
        0x1::debug::print<u64>(&v6);
        let v7 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v5);
        assert!(arg7.td_farm_id == 0x2::object::id<0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(v7), 10);
        0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::change_member_weight<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v5), v7, *0x2::vec_map::get<0x2::object::ID, 0x2::object::ID>(&arg0.vault_td_farm_member_ids, &v4), v2, arg8);
        let v8 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1);
        if (0x2::vec_map::contains<0x2::object::ID, u64>(&arg0.vault_tvls, &v8)) {
            let v9 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1);
            *0x2::vec_map::get_mut<0x2::object::ID, u64>(&mut arg0.vault_tvls, &v9) = v1;
        } else {
            0x2::vec_map::insert<0x2::object::ID, u64>(&mut arg0.vault_tvls, 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1), v1);
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg7.vault_ids, 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1));
        let v10 = UpdateVaultWeightEvent{
            farm_id   : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            vault_id  : 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1),
            usd_value : v1,
        };
        0x2::event::emit<UpdateVaultWeightEvent>(v10);
    }

    public fun update_zero_weight_oor_vault<T0, T1, T2, T3>(arg0: &mut LotusLPFarm<T0>, arg1: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::oracle_ag::OracleAggregator, arg6: &0x2::clock::Clock) {
        if (!0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::is_strategy_in_range<T0, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6)) {
            let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
            assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
            let v1 = 0x2::object::id<0xe3bc1309d500a1eeb810a912b7b970a462fb7d8b19fddd137fdbf68cbd621379::lotus_db_vault::LotusDBVault<T0>>(arg1);
            0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::change_member_weight<T1>(0x2::bag::borrow<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0x24cb7217bd01527c82e452e1ac8357774618ed1576029ee2b35f7b78d413c700::farm::Farm<T1>>(&mut arg0.td_farms, v0), *0x2::vec_map::get<0x2::object::ID, 0x2::object::ID>(&arg0.vault_td_farm_member_ids, &v1), 1, arg6);
        };
    }

    // decompiled from Move bytecode v6
}

