module 0xb159d84bde0df1771804bb2c0ffca4094df514cd7db0cca604556104c4360737::cetus_adapter {
    struct ConsumePositionRecord {
        records: 0x2::vec_map::VecMap<u64, 0x2::object::ID>,
        asset_types: vector<0x1::ascii::String>,
        amounts: vector<u64>,
        is_positives: vector<bool>,
    }

    struct CetusAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct CetusVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        record: CetusRecord,
        is_redeeming: bool,
    }

    struct CetusAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CetusRecord has store {
        liquidity: vector<Liquidity>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct CetusState {
        liquidity: vector<Liquidity>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Liquidity has copy, drop, store {
        pos0: u128,
    }

    struct Cetus has drop {
        dummy_field: bool,
    }

    public fun swap<T0: drop, T1, T2>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T1>, arg2: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T2>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: bool, arg6: bool, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T1>, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T2>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = pre_check_and_extract_asset<T0, T2>(arg0, arg2);
        let v2 = if (arg5) {
            0x2::balance::value<T1>(&v0)
        } else {
            0x2::balance::value<T2>(&v1)
        };
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T2>(arg3, arg4, arg5, arg6, v2, arg7, arg8);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (arg5) {
        };
        let (v9, v10) = if (arg5) {
            (0x2::balance::split<T1>(&mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v6)), 0x2::balance::zero<T2>())
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T2>(&v6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T2>(arg3, arg4, v9, v10, v6);
        0x2::balance::join<T1>(&mut v0, v8);
        0x2::balance::join<T2>(&mut v1, v7);
        0xb159d84bde0df1771804bb2c0ffca4094df514cd7db0cca604556104c4360737::cetus_adapter_event::swap_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0), 0x2::balance::value<T2>(&v1), 0x2::balance::value<T1>(&v0), 0x2::balance::value<T2>(&v1));
        let v11 = new_single_asset<T0, T1>(arg0, v0, arg9);
        (v11, new_single_asset<T0, T2>(arg0, v1, arg9))
    }

    public fun new<T0: drop>(arg0: &mut CetusAdapterRegistry, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Cetus>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = Liquidity{pos0: 0};
        let v5 = CetusRecord{
            liquidity : 0x1::vector::singleton<Liquidity>(v4),
            reward    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v6 = CetusVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            positions     : 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            record        : v5,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v6.id));
        0x2::transfer::share_object<CetusVault>(v6);
    }

    public fun add_liquidity<T0: drop, T1, T2>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T1>, arg2: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T2>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: u128, arg7: &0x2::clock::Clock) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = pre_check_and_extract_asset<T0, T2>(arg0, arg2);
        let v2 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, arg3);
        0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, arg3).pos0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T2>(arg4, arg5, v0, v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T1, T2>(arg4, arg5, v2, arg6, arg7));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        0xb159d84bde0df1771804bb2c0ffca4094df514cd7db0cca604556104c4360737::cetus_adapter_event::add_liquidity_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5), 0x2::balance::value<T1>(&v0), 0x2::balance::value<T2>(&v1), v3 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2), v3);
    }

    public fun open_position<T0: drop, T1, T2>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T1, T2>(arg2, arg3, arg4, arg5, arg6);
        let v1 = Liquidity{pos0: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0)};
        0x1::vector::push_back<Liquidity>(&mut arg0.record.liquidity, v1);
        0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, v0);
    }

    public fun remove_liquidity<T0: drop, T1, T2>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T1>, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T2>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, arg2);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T1, T2>(arg3, arg4, v0, arg5, arg6);
        0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, arg2).pos0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0);
        let v3 = new_single_asset<T0, T1>(arg0, v1, arg7);
        (v3, new_single_asset<T0, T2>(arg0, v2, arg7))
    }

    fun add_amount(arg0: &mut 0x2::vec_map::VecMap<0x1::ascii::String, u64>, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = 0x2::vec_map::keys<0x1::ascii::String, u64>(arg0);
        let v1 = if (0x1::vector::contains<0x1::ascii::String>(&v0, &arg1)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(arg0, &arg1);
            v3
        } else {
            0
        };
        0x2::vec_map::insert<0x1::ascii::String, u64>(arg0, arg1, v1 + arg2);
    }

    public fun add_liquidity_with_fix_coin<T0: drop, T1, T2>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T1>, arg2: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T2>, arg3: u64, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T1>, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T2>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = pre_check_and_extract_asset<T0, T2>(arg0, arg2);
        let v2 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.positions, arg3);
        let v3 = if (arg6) {
            0x2::balance::value<T1>(&v0)
        } else {
            0x2::balance::value<T2>(&v1)
        };
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T1, T2>(arg4, arg5, v2, v3, arg6, arg7);
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T1, T2>(&v4);
        if (0x2::balance::value<T1>(&v0) < v5 || 0x2::balance::value<T2>(&v1) < v6) {
            err_input_not_enough();
        };
        0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, arg3).pos0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T1, T2>(arg4, arg5, 0x2::balance::split<T1>(&mut v0, v5), 0x2::balance::split<T2>(&mut v1, v6), v4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2);
        0xb159d84bde0df1771804bb2c0ffca4094df514cd7db0cca604556104c4360737::cetus_adapter_event::add_liquidity_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>>(arg5), v5, v6, v7 - 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v2), v7);
        let v8 = new_single_asset<T0, T1>(arg0, v0, arg8);
        (v8, new_single_asset<T0, T2>(arg0, v1, arg8))
    }

    entry fun add_whitelist<T0>(arg0: &mut CetusAdapterRegistry, arg1: &CetusAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun burn_position_record(arg0: ConsumePositionRecord) : (vector<0x1::ascii::String>, vector<u64>, vector<bool>) {
        let ConsumePositionRecord {
            records      : v0,
            asset_types  : v1,
            amounts      : v2,
            is_positives : v3,
        } = arg0;
        0x2::vec_map::destroy_empty<u64, 0x2::object::ID>(v0);
        (v1, v2, v3)
    }

    fun check_and_extract_weight<T0: drop>(arg0: &CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>) : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Cetus>(arg1, &v0);
        if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut CetusVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1, T2, T3>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T3> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v0);
        abort 1111
    }

    public fun claimable_value<T0, T1>(arg0: &CetusVault, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : (vector<0x1::ascii::String>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg1));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_rewards<T0, T1>(arg1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, arg2)));
        while (0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v2) > 0) {
            let v4 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&mut v2);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(&v4)));
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::pop_back<u64>(&mut v3));
        };
        (v0, v1)
    }

    public fun collect_total_value<T0: drop, T1, T2>(arg0: &CetusVault, arg1: &CetusAdapterRegistry, arg2: &mut ConsumePositionRecord, arg3: u64, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let (v1, v2) = claimable_value<T1, T2>(arg0, arg4, arg3);
        let v3 = v2;
        let v4 = v1;
        while (0x1::vector::length<0x1::ascii::String>(&v4) > 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg2.asset_types, 0x1::vector::pop_back<0x1::ascii::String>(&mut v4));
            0x1::vector::push_back<u64>(&mut arg2.amounts, 0x1::vector::pop_back<u64>(&mut v3));
            0x1::vector::push_back<bool>(&mut arg2.is_positives, true);
        };
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T1, T2>(arg4, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, arg3)));
        0x1::vector::push_back<0x1::ascii::String>(&mut arg2.asset_types, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        0x1::vector::push_back<0x1::ascii::String>(&mut arg2.asset_types, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
        0x1::vector::push_back<u64>(&mut arg2.amounts, v5);
        0x1::vector::push_back<u64>(&mut arg2.amounts, v6);
        0x1::vector::push_back<bool>(&mut arg2.is_positives, true);
        0x1::vector::push_back<bool>(&mut arg2.is_positives, true);
        consume_position_record(arg2, arg0, arg3);
    }

    fun consume_position_record(arg0: &mut ConsumePositionRecord, arg1: &CetusVault, arg2: u64) {
        let (v0, v1) = 0x2::vec_map::remove<u64, 0x2::object::ID>(&mut arg0.records, &arg2);
        if (v1 != 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions, v0))) {
            err_position_id_not_matched();
        };
    }

    public fun create_consume_position_record(arg0: &CetusVault) : ConsumePositionRecord {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x2::vec_map::empty<u64, 0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions)) {
            0x2::vec_map::insert<u64, 0x2::object::ID>(&mut v0, v1, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, v1)));
            v1 = v1 + 1;
        };
        ConsumePositionRecord{
            records      : v0,
            asset_types  : 0x1::vector::empty<0x1::ascii::String>(),
            amounts      : 0x1::vector::empty<u64>(),
            is_positives : 0x1::vector::empty<bool>(),
        }
    }

    fun err_already_registered() {
        abort 101
    }

    fun err_input_not_enough() {
        abort 108
    }

    fun err_less_than_cetus_state_liquidity() {
        abort 105
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_not_redeeming() {
        abort 107
    }

    fun err_not_whitelisted_source() {
        abort 102
    }

    fun err_position_id_not_matched() {
        abort 103
    }

    fun err_redeeming() {
        abort 104
    }

    fun err_still_existed_reward() {
        abort 106
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut CetusVault, arg1: &CetusAdapterRegistry, arg2: ConsumePositionRecord, arg3: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let (v1, v2, v3) = burn_position_record(arg2);
        update_record_value(arg0);
        new_total_value_message<T0>(arg0, v1, v2, v3, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = CetusAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<CetusAdapterRegistry>(v0);
        0x2::transfer::public_transfer<CetusAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Cetus>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    public fun new_cetus_state<T0: drop>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>, arg2: &mut 0x2::tx_context::TxContext) : (CetusState, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = CetusState{
            liquidity : 0x1::vector::empty<Liquidity>(),
            reward    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.reward);
        while (0x1::vector::length<0x1::ascii::String>(&v1) > 0) {
            let v2 = &mut v0.reward;
            add_amount(v2, 0x1::vector::pop_back<0x1::ascii::String>(&mut v1), 0);
        };
        let v3 = arg0.record.liquidity;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Liquidity>(&v3)) {
            0x1::vector::borrow_mut<Liquidity>(&mut v0.liquidity, v4).pos0 = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::to_scaled_val(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::sub(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(1), check_and_extract_weight<T0>(arg0, arg1)), 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from_scaled_val(0x1::vector::borrow<Liquidity>(&v3, v4).pos0)));
            v4 = v4 + 1;
        };
        (v0, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &CetusVault, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Cetus, T0>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, bool>(&mut v1, &v3, b"is_sate_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &CetusVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Cetus, T0, T1> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::new<Cetus, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::set_extra_info<Cetus, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &CetusVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Cetus, T0>(&v0, arg4);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &CetusVault, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Cetus, T0>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Cetus, T0, vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut v1, &v3, b"main_vault_id", arg0.main_vault_id);
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Cetus, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::borrow_extra_info_mut<T0, Cetus, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::burn<T0, Cetus, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut CetusAdapterRegistry, arg1: &CetusAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Cetus {
        Cetus{dummy_field: false}
    }

    public fun unlock<T0: drop>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>) {
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut CetusVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Cetus>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Cetus>(arg1, &v0);
        if (*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun update_record_value(arg0: &mut CetusVault) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions)) {
            0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, v0).pos0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.positions, v0));
            v0 = v0 + 1;
        };
    }

    public fun verify_scallop_state<T0: drop>(arg0: &mut CetusVault, arg1: CetusState, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Cetus, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_record_value(arg0);
        let CetusState {
            liquidity : v0,
            reward    : v1,
        } = arg1;
        let v2 = v1;
        let v3 = v0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<Liquidity>(&v3)) {
            let v5 = *0x1::vector::borrow<Liquidity>(&v3, v4);
            let v6 = *0x1::vector::borrow<Liquidity>(&arg0.record.liquidity, v4);
            if (v6.pos0 < v5.pos0) {
                err_less_than_cetus_state_liquidity();
            };
            v4 = v4 + 1;
        };
        let v7 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v2);
        while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
            let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v8) != 0) {
                err_still_existed_reward();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

