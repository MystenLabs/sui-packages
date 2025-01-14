module 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_lp_farm {
    struct LotusLPFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
        td_farms: 0x2::bag::Bag,
        td_farm_admin_caps: 0x2::bag::Bag,
        allowed_deposit_asset: 0x2::vec_set::VecSet<0x1::ascii::String>,
        vault_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
        vault_td_farm_member_ids: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
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
        };
        let v1 = LotusLPFarmCap{
            id      : 0x2::object::new(arg0),
            farm_id : 0x2::object::id<LotusLPFarm<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun collect_incentive_rewards_to_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>, arg2: 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::collect_incentive_rewards_to_vault<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
    }

    public fun add_allowed_deposit_asset<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.allowed_deposit_asset, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
    }

    public fun add_incentivized_db_vault_to_td_farm_with_ticket<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>, arg2: &mut LotusLPFarmCreatePoolTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg2.td_farm_keys, &v0), 1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg2.td_farm_keys, v0);
        0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::add_to_td_farm<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), (arg2.usd_value as u32), arg3);
    }

    public fun add_td_farm<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_farm_cap<T0>(arg0, arg1);
        let (v0, v1) = 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::create<T1>(0x2::balance::zero<T1>(), arg2, arg3);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v2), 0);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.td_farm_keys, v2);
        0x2::bag::add<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v2, v0);
        0x2::bag::add<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&mut arg0.td_farm_admin_caps, v2, v1);
    }

    fun assert_deposit_asset_type<T0, T1>(arg0: &LotusLPFarm<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.allowed_deposit_asset, &v0), 4);
    }

    fun assert_farm_cap<T0>(arg0: &LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert!(0x2::object::id<LotusLPFarm<T0>>(arg0) == arg1.farm_id, 9223373402654375935);
    }

    public fun create_incentivized_db_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::oracle_ag::OracleAggregator, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>, 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVaultCap, LotusLPFarmCreatePoolTicket) {
        0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::oracle_ag::assert_price_object_type<T1>(arg3, arg4);
        let (v0, v1) = 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::new<T0>(arg1, arg6);
        let v2 = v0;
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.vault_ids, 0x2::object::id<0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>>(&v2));
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.vault_td_farm_member_ids, 0x2::object::id<0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>>(&v2), 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::get_td_farm_member_key_id<T0>(&v2));
        let v3 = 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::oracle_ag::calc_usd_value<T1>(arg3, arg4, 0x2::coin::value<T1>(&arg2), arg5);
        0x1::debug::print<u64>(&v3);
        assert_deposit_asset_type<T0, T1>(arg0);
        0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::deposit<T1, T0>(&mut v2, arg2, arg6);
        (v2, v1, new_create_pool_ticket<T0>(arg0, v3))
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

    public fun lp_token_receipt_mark_on_ticket<T0>(arg0: &mut LotusLPFarmCreatePoolTicket) : u64 {
        arg0.lp_token_to_mint = 0;
        arg0.lp_token_to_mint
    }

    public fun new_create_pool_ticket<T0>(arg0: &LotusLPFarm<T0>, arg1: u64) : LotusLPFarmCreatePoolTicket {
        LotusLPFarmCreatePoolTicket{
            key_id           : 0x2::object::id<LotusLPFarm<T0>>(arg0),
            usd_value        : arg1,
            lp_token_to_mint : arg1,
            td_farm_keys     : 0x2::vec_set::empty<0x1::ascii::String>(),
        }
    }

    public fun set_farm_unlock_rate<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::change_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
    }

    public fun td_farm_contains<T0, T1>(arg0: &LotusLPFarm<T0>) : bool {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0)
    }

    public fun td_farm_length<T0>(arg0: &LotusLPFarm<T0>) : u64 {
        0x2::vec_set::size<0x1::ascii::String>(&arg0.td_farm_keys)
    }

    public fun td_farm_unlock_rate<T0, T1>(arg0: &LotusLPFarm<T0>) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v0), 4);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::get_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&arg0.td_farms, v0))
    }

    public fun top_up_incentive_balance<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::top_up_balance<T1>(0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public fun top_up_to_td_pool<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>, arg2: &mut 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::td_pool_top_up<T0, T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg1, arg2, arg3);
    }

    public fun update_vault_weight_permissionless<T0, T1, T2, T3>(arg0: &mut LotusLPFarm<T0>, arg1: &0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::oracle_ag::OracleAggregator, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::LotusDBVault<T0>>(arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x1::debug::print<0x1::ascii::String>(&v1);
        let v2 = 0x2::bag::length(&arg0.td_farms);
        0x1::debug::print<u64>(&v2);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::change_member_weight<T1>(0x2::bag::borrow<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::AdminCap>(&arg0.td_farm_admin_caps, v1), 0x2::bag::borrow_mut<0x1::ascii::String, 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm::Farm<T1>>(&mut arg0.td_farms, v1), *0x2::vec_map::get<0x2::object::ID, 0x2::object::ID>(&arg0.vault_td_farm_member_ids, &v0), (0xe032c689ea68b8b0d83d31d40202aba45b175e97696da61a95179313490002c9::lotus_db_vault::get_total_usd_value<T0, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7) as u32), arg7);
    }

    // decompiled from Move bytecode v6
}

