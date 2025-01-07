module 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_lp_farm {
    struct LotusLPFarm<phantom T0> has store, key {
        id: 0x2::object::UID,
        td_farm_keys: 0x2::vec_set::VecSet<0x1::ascii::String>,
        td_farms: 0x2::bag::Bag,
        td_farm_admin_caps: 0x2::bag::Bag,
        allowed_deposit_asset: 0x2::vec_set::VecSet<0x1::ascii::String>,
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

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : (LotusLPFarm<T0>, LotusLPFarmCap) {
        let v0 = LotusLPFarm<T0>{
            id                    : 0x2::object::new(arg0),
            td_farm_keys          : 0x2::vec_set::empty<0x1::ascii::String>(),
            td_farms              : 0x2::bag::new(arg0),
            td_farm_admin_caps    : 0x2::bag::new(arg0),
            allowed_deposit_asset : 0x2::vec_set::empty<0x1::ascii::String>(),
        };
        let v1 = LotusLPFarmCap{
            id      : 0x2::object::new(arg0),
            farm_id : 0x2::object::id<LotusLPFarm<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun collect_incentive_rewards_to_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::LotusDBVault<T0>, arg2: 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::collect_incentive_rewards_to_vault<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
    }

    public fun add_allowed_deposit_asset<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.allowed_deposit_asset, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
    }

    public fun add_incentivized_db_vault_to_td_farm_with_ticket<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::LotusDBVault<T0>, arg2: &mut LotusLPFarmCreatePoolTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg2.td_farm_keys, &v0), 1);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg2.td_farm_keys, v0);
        0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::add_to_td_farm<T0, T1>(arg1, 0x2::bag::borrow_mut<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), (arg2.usd_value as u32), arg3);
    }

    public fun add_td_farm<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &LotusLPFarmCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_farm_cap<T0>(arg0, arg1);
        let (v0, v1) = 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::create<T1>(0x2::balance::zero<T1>(), arg2, arg3);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg0.td_farm_keys, &v2), 0);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.td_farm_keys, v2);
        0x2::bag::add<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v2, v0);
        0x2::bag::add<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&mut arg0.td_farm_admin_caps, v2, v1);
    }

    fun assert_deposit_asset_type<T0, T1>(arg0: &LotusLPFarm<T0>) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.allowed_deposit_asset, &v0), 4);
    }

    fun assert_farm_cap<T0>(arg0: &LotusLPFarm<T0>, arg1: &LotusLPFarmCap) {
        assert!(0x2::object::id<LotusLPFarm<T0>>(arg0) == arg1.farm_id, 9223372951682809855);
    }

    public fun create_incentivized_db_vault<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::oracle_ag::OracleAggregator, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::LotusDBVault<T0>, 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::LotusDBVaultCap, LotusLPFarmCreatePoolTicket) {
        0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::oracle_ag::assert_price_object_type<T1>(arg3, arg4);
        let (v0, v1) = 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::new<T0>(arg1, arg6);
        let v2 = v0;
        let v3 = 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::oracle_ag::calc_usd_value<T1>(arg3, arg4, 0x2::coin::value<T1>(&arg2), arg5);
        0x1::debug::print<u64>(&v3);
        assert_deposit_asset_type<T0, T1>(arg0);
        0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::deposit<T1, T0>(&mut v2, arg2, arg6);
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
        0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::change_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg2, arg3);
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
        0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::get_unlock_per_second<T1>(0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&arg0.td_farms, v0))
    }

    public fun top_up_incentive_balance<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::top_up_balance<T1>(0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&arg0.td_farm_admin_caps, v0), 0x2::bag::borrow_mut<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v0), 0x2::coin::into_balance<T1>(arg1), arg2);
    }

    public fun top_up_to_td_pool<T0, T1>(arg0: &mut LotusLPFarm<T0>, arg1: &mut 0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::LotusDBVault<T0>, arg2: &mut 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::pool::TopUpTicket, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::bag::borrow<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::AdminCap>(&arg0.td_farm_admin_caps, v0);
        0xaf3531b92b7556a462a5501f2f0a9a4b5899ed7ba5d38c67e43062bbc8d61d01::lotus_db_vault::td_pool_top_up<T0, T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0xd3721cbf3fc8cb049b60f802559f7a8857b2d87db6f06c4aa03533d7a9639064::farm::Farm<T1>>(&mut arg0.td_farms, v0), arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

