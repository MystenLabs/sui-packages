module 0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter {
    struct ConsumePositionRecord {
        records: 0x2::vec_map::VecMap<u64, 0x2::object::ID>,
        asset_types: vector<0x1::ascii::String>,
        amounts: vector<u64>,
        is_positives: vector<bool>,
    }

    struct BluefinAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct BluefinVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        positions: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        record: BluefinRecord,
        is_redeeming: bool,
        is_fetching: bool,
    }

    struct BluefinAdapterVersion has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct BluefinAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BluefinRecord has store {
        liquidity: vector<Liquidity>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct BluefinState {
        liquidity: vector<Liquidity>,
    }

    struct Liquidity has copy, drop, store {
        pos0: u128,
    }

    struct Bluefin has drop {
        dummy_field: bool,
    }

    public fun swap<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bluefin, T1>, arg2: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bluefin, T2>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &BluefinAdapterVersion, arg12: &mut 0x2::tx_context::TxContext) : (0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T1>, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T2>) {
        assert_version_not_allowed(arg11);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = pre_check_and_extract_asset<T0, T2>(arg0, arg2);
        let (v2, v3) = if (arg5) {
            let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg10, arg3, arg4, v0, 0x2::balance::zero<T2>(), arg5, arg6, arg7, arg8, arg9);
            0x2::balance::join<T2>(&mut v1, v5);
            (v4, v1)
        } else {
            let (v6, v7) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T1, T2>(arg10, arg3, arg4, 0x2::balance::zero<T1>(), v1, arg5, arg6, arg7, arg8, arg9);
            0x2::balance::join<T1>(&mut v0, v6);
            (v0, v7)
        };
        let v8 = v3;
        let v9 = v2;
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::swap_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0), 0x2::balance::value<T2>(&v1), 0x2::balance::value<T1>(&v9), 0x2::balance::value<T2>(&v8));
        let v10 = new_single_asset<T0, T1>(arg0, v9, arg12);
        (v10, new_single_asset<T0, T2>(arg0, v8, arg12))
    }

    public fun new<T0: drop>(arg0: &mut BluefinAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: &BluefinAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bluefin>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = BluefinRecord{
            liquidity : 0x1::vector::empty<Liquidity>(),
            reward    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = BluefinVault{
            id            : 0x2::object::new(arg3),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            positions     : 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(),
            record        : v4,
            is_redeeming  : false,
            is_fetching   : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::new_bluefin_vault_event(*0x2::object::uid_as_inner(&v5.id), v3);
        0x2::transfer::share_object<BluefinVault>(v5);
    }

    public fun collect_fee<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &BluefinAdapterVersion, arg7: &mut 0x2::tx_context::TxContext) : (0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T1>, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T2>) {
        assert_version_not_allowed(arg6);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        message_pre_check<T0>(arg0, arg1);
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T1, T2>(arg5, arg3, arg4, 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg2));
        let v4 = v3;
        let v5 = v2;
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::collect_fee_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4), 0x2::balance::value<T1>(&v5), 0x2::balance::value<T2>(&v4));
        let v6 = new_single_asset<T0, T1>(arg0, v5, arg7);
        (v6, new_single_asset<T0, T2>(arg0, v4, arg7))
    }

    public fun open_position<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: u32, arg5: u32, arg6: &BluefinAdapterVersion, arg7: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg6);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T1, T2>(arg2, arg3, arg4, arg5, arg7);
        let v1 = Liquidity{pos0: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0)};
        0x1::vector::push_back<Liquidity>(&mut arg0.record.liquidity, v1);
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::new_bluefin_position_event<T1, T2>(*0x2::object::uid_as_inner(&arg0.id), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg3), arg4, arg5);
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, v0);
    }

    public fun remove_liquidity<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &BluefinAdapterVersion, arg8: &mut 0x2::tx_context::TxContext) : (0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T1>, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T2>) {
        assert_version_not_allowed(arg7);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg2);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T1, T2>(arg3, arg4, v0, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0);
        0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, arg2).pos0 = v7;
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::remove_liquidity_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4), 0x2::balance::value<T1>(&v6), 0x2::balance::value<T2>(&v5), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0) - v7, v7);
        let v8 = new_single_asset<T0, T1>(arg0, v6, arg8);
        (v8, new_single_asset<T0, T2>(arg0, v5, arg8))
    }

    public fun add_liquidity_with_fix_coin<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bluefin, T1>, arg2: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bluefin, T2>, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &BluefinAdapterVersion, arg10: &mut 0x2::tx_context::TxContext) : (0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T1>, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T2>) {
        assert_version_not_allowed(arg9);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = pre_check_and_extract_asset<T0, T2>(arg0, arg2);
        let v2 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg3);
        let (v3, v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T1, T2>(arg8, arg4, arg5, v2, v0, v1, arg6, arg7);
        if (0x2::balance::value<T1>(&v0) < v3 || 0x2::balance::value<T2>(&v1) < v4) {
            err_input_not_enough();
        };
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v2);
        0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, arg3).pos0 = v7;
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::add_liquidity_event<T1, T2>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg5), v3, v4, v7 - 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v2), v7);
        let v8 = new_single_asset<T0, T1>(arg0, v5, arg10);
        (v8, new_single_asset<T0, T2>(arg0, v6, arg10))
    }

    public fun add_version(arg0: &mut BluefinAdapterVersion, arg1: &BluefinAdapterAdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
        } else {
            err_version_already_existed();
        };
    }

    entry fun add_whitelist<T0>(arg0: &mut BluefinAdapterRegistry, arg1: &BluefinAdapterVersion, arg2: &BluefinAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::with_defining_ids<T0>());
    }

    fun assert_version_not_allowed(arg0: &BluefinAdapterVersion) {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
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

    fun check_and_extract_weight<T0: drop>(arg0: &BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bluefin>(arg1, &v0);
        if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut BluefinVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1, T2, T3>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: u64, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &BluefinAdapterVersion, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T3> {
        assert_version_not_allowed(arg6);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (arg0.is_fetching) {
            err_fetching();
        };
        let v0 = 0x1::type_name::with_defining_ids<T3>();
        message_pre_check<T0>(arg0, arg1);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T1, T2, T3>(arg5, arg3, arg4, 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.positions, arg2));
        let v2 = 0x1::type_name::into_string(v0);
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.reward, &v2)) {
            let v3 = 0x1::type_name::into_string(v0);
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v3);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, 0x1::type_name::into_string(v0), 0);
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, 0x1::type_name::into_string(v0), 0);
        };
        0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event::claim_event<T1, T2, T3>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4), 0x2::balance::value<T3>(&v1));
        new_single_asset<T0, T3>(arg0, v1, arg7)
    }

    public fun collect_total_value<T0: drop, T1, T2>(arg0: &mut BluefinVault, arg1: &BluefinAdapterRegistry, arg2: &mut ConsumePositionRecord, arg3: u64, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &BluefinAdapterVersion) {
        assert_version_not_allowed(arg5);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = 0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg3);
        if (0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>>(arg4) != 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v1)) {
            err_pool_not_matched();
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T1, T2>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T2>(arg4), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v1), false);
        let (v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(v1);
        0x1::vector::push_back<0x1::ascii::String>(&mut arg2.asset_types, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        0x1::vector::push_back<0x1::ascii::String>(&mut arg2.asset_types, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>()));
        0x1::vector::push_back<u64>(&mut arg2.amounts, v2 + v4);
        0x1::vector::push_back<u64>(&mut arg2.amounts, v3 + v5);
        0x1::vector::push_back<bool>(&mut arg2.is_positives, true);
        0x1::vector::push_back<bool>(&mut arg2.is_positives, true);
        consume_position_record(arg2, arg0, arg3);
    }

    fun consume_position_record(arg0: &mut ConsumePositionRecord, arg1: &BluefinVault, arg2: u64) {
        let (v0, v1) = 0x2::vec_map::remove<u64, 0x2::object::ID>(&mut arg0.records, &arg2);
        if (v1 != 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg1.positions, v0))) {
            err_position_id_not_matched();
        };
    }

    public fun create_consume_position_record(arg0: &mut BluefinVault, arg1: &BluefinAdapterVersion) : ConsumePositionRecord {
        assert_version_not_allowed(arg1);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x2::vec_map::empty<u64, 0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions)) {
            0x2::vec_map::insert<u64, 0x2::object::ID>(&mut v0, v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.reward);
        while (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v2);
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v3);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, v3, 0);
        };
        arg0.is_fetching = true;
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

    fun err_fetching() {
        abort 109
    }

    fun err_input_not_enough() {
        abort 108
    }

    fun err_less_than_bluefin_state_liquidity() {
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

    fun err_pool_not_matched() {
        abort 113
    }

    fun err_position_id_not_matched() {
        abort 103
    }

    fun err_redeeming() {
        abort 104
    }

    fun err_version_already_existed() {
        abort 110
    }

    fun err_version_not_allowed() {
        abort 112
    }

    fun err_version_not_existed() {
        abort 111
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut BluefinVault, arg1: &BluefinAdapterRegistry, arg2: ConsumePositionRecord, arg3: &BluefinAdapterVersion, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0> {
        assert_version_not_allowed(arg3);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let (v1, v2, v3) = burn_position_record(arg2);
        update_liquidity_record_value(arg0);
        arg0.is_fetching = false;
        new_total_value_message<T0>(arg0, v1, v2, v3, arg4)
    }

    public fun get_accrued_fee_info<T0, T1>(arg0: &BluefinVault, arg1: u64) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        let (v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::get_accrued_fee(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg1));
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v1);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v2);
        v0
    }

    public fun get_liquidity_info<T0, T1>(arg0: &BluefinVault, arg1: u64, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        let v1 = 0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, arg1);
        if (0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2) != 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v1)) {
            err_pool_not_matched();
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v1), false);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), v3);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BluefinAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = BluefinAdapterAdminCap{id: 0x2::object::new(arg0)};
        let v2 = BluefinAdapterVersion{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<BluefinAdapterVersion>(v2);
        0x2::transfer::share_object<BluefinAdapterRegistry>(v0);
        0x2::transfer::public_transfer<BluefinAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_version_allowed(arg0: &BluefinAdapterVersion) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    fun message_pre_check<T0: drop>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bluefin>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    public fun new_bluefin_state<T0: drop>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: &BluefinAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) : (BluefinState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0>) {
        assert_version_not_allowed(arg2);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = BluefinState{liquidity: 0x1::vector::empty<Liquidity>()};
        let v1 = arg0.record.liquidity;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Liquidity>(&v1)) {
            let v3 = Liquidity{pos0: (0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::to_scaled_val(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::sub(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from(1), check_and_extract_weight<T0>(arg0, arg1)), 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from_scaled_val((0x1::vector::borrow<Liquidity>(&v1, v2).pos0 as u256)))) as u128)};
            0x1::vector::push_back<Liquidity>(&mut v0.liquidity, v3);
            v2 = v2 + 1;
        };
        (v0, new_generated_state_proof_message<T0>(arg0, arg3))
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &BluefinVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bluefin, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, bool>(&mut v1, &v3, b"is_state_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &BluefinVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Bluefin, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Bluefin, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Bluefin, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &BluefinVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bluefin, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &BluefinVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Bluefin, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Bluefin, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v3, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Bluefin, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Bluefin, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Bluefin, T1>(arg1, &v1)
    }

    public fun remove_version(arg0: &mut BluefinAdapterVersion, arg1: &BluefinAdapterAdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
        } else {
            err_version_not_existed();
        };
    }

    entry fun remove_whitelist<T0>(arg0: &mut BluefinAdapterRegistry, arg1: &BluefinAdapterVersion, arg2: &BluefinAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Bluefin {
        Bluefin{dummy_field: false}
    }

    public fun unlock<T0: drop>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>, arg2: &BluefinAdapterVersion) {
        assert_version_not_allowed(arg2);
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut BluefinVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Bluefin>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Bluefin>(arg1, &v0);
        if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    fun update_liquidity_record_value(arg0: &mut BluefinVault) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions)) {
            0x1::vector::borrow_mut<Liquidity>(&mut arg0.record.liquidity, v0).pos0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.positions, v0));
            v0 = v0 + 1;
        };
    }

    public fun verify_bluefin_state<T0: drop>(arg0: &mut BluefinVault, arg1: BluefinState, arg2: &BluefinAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Bluefin, T0> {
        assert_version_not_allowed(arg2);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_liquidity_record_value(arg0);
        let BluefinState { liquidity: v0 } = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Liquidity>(&v0)) {
            let v2 = *0x1::vector::borrow<Liquidity>(&v0, v1);
            let v3 = *0x1::vector::borrow<Liquidity>(&arg0.record.liquidity, v1);
            if ((v3.pos0 as u256) < (v2.pos0 as u256) * 999 / 1000) {
                err_less_than_bluefin_state_liquidity();
            };
            v1 = v1 + 1;
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg3)
    }

    // decompiled from Move bytecode v7
}

