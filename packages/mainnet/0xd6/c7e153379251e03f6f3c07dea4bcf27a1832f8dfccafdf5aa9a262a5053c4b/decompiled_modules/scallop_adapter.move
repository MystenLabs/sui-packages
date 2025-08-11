module 0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter {
    struct ScallopAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct ScallopVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        obligation_key: 0x1::option::Option<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>,
        s_coins: 0x2::bag::Bag,
        record: ScallopRecord,
        is_redeeming: bool,
    }

    struct ScallopAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ScallopRecord has store {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct ScallopState {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Scallop has drop {
        dummy_field: bool,
    }

    public fun borrow<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Scallop, T0, T1> {
        if (0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_not_existed();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg2, arg4, 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key), arg3, arg5, arg6, arg7, arg8, arg9));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.borrow, &v2)) {
            let (_, v4) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.borrow, &v2);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, v2, v4 + v1);
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, v2, v1);
        };
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::borrow_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg9)
    }

    public fun new<T0: drop>(arg0: &mut ScallopAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Scallop>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = ScallopRecord{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = ScallopVault{
            id             : 0x2::object::new(arg2),
            main_vault_id  : 0x1::option::some<0x2::object::ID>(v3),
            obligation_key : 0x1::option::none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(),
            s_coins        : 0x2::bag::new(arg2),
            record         : v4,
            is_redeeming   : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::new_scallop_vault_event(*0x2::object::uid_as_inner(&v5.id), v3);
        0x2::transfer::share_object<ScallopVault>(v5);
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

    entry fun add_whitelist<T0>(arg0: &mut ScallopAdapterRegistry, arg1: &ScallopAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun check_and_extract_weight<T0: drop>(arg0: &ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>) : 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Scallop>(arg1, &v0);
        if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut ScallopVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_not_existed();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.reward, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v0);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, v0, 0);
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, v0, 0);
        };
        let v3 = 0x2::coin::into_balance<T1>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T1>(arg2, arg3, arg4, 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key), arg5, arg6, arg7));
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::claim_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v3));
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.s_coins, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.s_coins, v0), v3);
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.supply, &v0);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v0, 0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.s_coins, v0)));
        } else {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.s_coins, v0, v3);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v0, 0x2::balance::value<T1>(0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&arg0.s_coins, v0)));
        };
    }

    public fun claimable_value(arg0: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (vector<0x1::ascii::String>, vector<u64>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg2, arg1);
        if (!0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::is_incentive_account_exist(arg0, arg2)) {
            (v0, v1)
        } else {
            let v2 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::incentive_account(arg0, arg2);
            let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::pool_types(v2));
            while (0x1::vector::length<0x1::type_name::TypeName>(&v3) > 0) {
                let v4 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::account_pool_record(v2, 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v3));
                let v5 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::point_list(v4);
                let v6 = 0;
                while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(v5)) {
                    let v7 = 0x1::vector::borrow<0x1::type_name::TypeName>(v5, v6);
                    0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::type_name::into_string(*v7));
                    0x1::vector::push_back<u64>(&mut v1, 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::points(0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::pool_point(v4, *v7)));
                    v6 = v6 + 1;
                };
            };
            (v0, v1)
        }
    }

    public fun collateralize<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Scallop, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_not_existed();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.collateral, &v1)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.collateral, &v1);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.collateral, v1, v3 + 0x2::balance::value<T1>(&v0));
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.collateral, v1, 0x2::balance::value<T1>(&v0));
        };
        let v4 = 0x2::coin::from_balance<T1>(v0, arg5);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T1>(arg2, arg4, arg3, v4, arg5);
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::collateral_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::coin::value<T1>(&v4));
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_scallop_state_collateral() {
        abort 106
    }

    fun err_less_than_scallop_state_supply() {
        abort 109
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_scallop_state_borrow() {
        abort 108
    }

    fun err_not_redeeming() {
        abort 110
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_obligation_key_existed() {
        abort 101
    }

    fun err_obligation_key_not_existed() {
        abort 102
    }

    fun err_redeeming() {
        abort 105
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut ScallopVault, arg1: &ScallopAdapterRegistry, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0x1::vector::empty<u64>();
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            let v4 = 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, v4);
            let (v5, v6) = claimable_value(arg2, v4, arg3);
            let v7 = v6;
            let v8 = v5;
            let v9 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
                let v10 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
                let v11 = 0x1::vector::pop_back<u64>(&mut v7);
                0x1::vector::push_back<0x1::ascii::String>(&mut v2, v10);
                0x1::vector::push_back<u64>(&mut v3, v11);
                0x1::vector::push_back<bool>(&mut v1, true);
                let v12 = &mut v9;
                add_amount(v12, v10, v11);
            };
            arg0.record.reward = v9;
            let v13 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg3);
            let v14 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::type_name::TypeName>(&v13) > 0) {
                let v15 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v13);
                let v16 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg3, v15);
                0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::type_name::into_string(v15));
                0x1::vector::push_back<u64>(&mut v3, v16);
                0x1::vector::push_back<bool>(&mut v1, true);
                let v17 = &mut v14;
                add_amount(v17, 0x1::type_name::into_string(v15), v16);
            };
            arg0.record.collateral = v14;
            let v18 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg3);
            let v19 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::type_name::TypeName>(&v18) > 0) {
                let v20 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v18);
                let (v21, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg3, v20);
                0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::type_name::into_string(v20));
                0x1::vector::push_back<u64>(&mut v3, v21);
                0x1::vector::push_back<bool>(&mut v1, false);
                let v23 = &mut v19;
                add_amount(v23, 0x1::type_name::into_string(v20), v21);
            };
            arg0.record.borrow = v19;
        };
        let v24 = 0;
        let v25 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.supply);
        while (v24 < 0x1::vector::length<0x1::ascii::String>(&v25)) {
            let v26 = *0x1::vector::borrow<0x1::ascii::String>(&v25, v24);
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, v26);
            0x1::vector::push_back<u64>(&mut v3, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v26));
            0x1::vector::push_back<bool>(&mut v1, true);
            v24 = v24 + 1;
        };
        new_total_value_message<T0>(arg0, v2, v3, v1, arg4)
    }

    public fun get_borrow_info(arg0: &mut ScallopVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg1, 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key));
            let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg1);
            while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
                let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
                let (v3, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, v2);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(v2), v3);
            };
        };
        v0
    }

    public fun get_claimable_rewards_info(arg0: &mut ScallopVault, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            let v1 = 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg2, v1);
            let (v2, v3) = claimable_value(arg1, v1, arg2);
            let v4 = v3;
            let v5 = v2;
            while (0x1::vector::length<0x1::ascii::String>(&v5) > 0) {
                let v6 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v5);
                let v7 = 0x1::vector::pop_back<u64>(&mut v4);
                if (0x2::vec_map::contains<0x1::ascii::String, u64>(&v0, &v6)) {
                    let (_, v9) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v0, &v6);
                    0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, v6, v9 + v7);
                    continue
                };
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, v6, v7);
            };
        };
        v0
    }

    public fun get_collateral_info(arg0: &mut ScallopVault, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg1, 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key));
            let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg1);
            while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
                let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
                let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg1, v2);
                let v4 = 0x1::type_name::into_string(v2);
                if (0x2::vec_map::contains<0x1::ascii::String, u64>(&v0, &v4)) {
                    let v5 = 0x1::type_name::into_string(v2);
                    let (_, v7) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v0, &v5);
                    0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(v2), v3 + v7);
                    continue
                };
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0, 0x1::type_name::into_string(v2), v3);
            };
        };
        v0
    }

    public fun get_supply_info(arg0: &mut ScallopVault) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.record.supply
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = ScallopAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ScallopAdapterRegistry>(v0);
        0x2::transfer::public_transfer<ScallopAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Scallop>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &ScallopVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Scallop, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, bool>(&mut v1, &v3, b"is_state_generated", true);
        v1
    }

    public fun new_scallop_state<T0: drop>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &mut 0x2::tx_context::TxContext) : (ScallopState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::sub(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::from(1), check_and_extract_weight<T0>(arg0, arg1));
        let v1 = ScallopState{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.borrow);
        while (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v2);
            let v4 = &mut v1.borrow;
            add_amount(v4, v3, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::ceil(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v3))));
        };
        let v5 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.supply);
        while (0x1::vector::length<0x1::ascii::String>(&v5) > 0) {
            let v6 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v5);
            let v7 = &mut v1.supply;
            add_amount(v7, v6, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::floor(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v6))));
        };
        let v8 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.collateral);
        while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            let v10 = &mut v1.collateral;
            add_amount(v10, v9, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::floor(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v9))));
        };
        (v1, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_single_asset<T0: drop, T1>(arg0: &ScallopVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Scallop, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Scallop, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Scallop, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &ScallopVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Scallop, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &ScallopVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Scallop, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Scallop, T0, vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut v1, &v3, b"main_vault_id", arg0.main_vault_id);
        v1
    }

    public fun open_obligation<T0: drop>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg2, arg3);
        let v3 = v0;
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::new_scallop_position_event(*0x2::object::uid_as_inner(&arg0.id), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(&v3));
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg2, v3, v2);
        0x1::option::fill<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&mut arg0.obligation_key, v1);
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Scallop, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Scallop, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Scallop, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut ScallopAdapterRegistry, arg1: &ScallopAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun repay<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Scallop, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_not_existed();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (_, v4) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.borrow, &v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, v2, v4 - v1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg2, arg3, arg4, 0x2::coin::from_balance<T1>(v0, arg6), arg5, arg6);
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::repay_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
    }

    fun stamp() : Scallop {
        Scallop{dummy_field: false}
    }

    public fun supply<T0: drop, T1, T2>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Scallop, T1>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T2, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T2, T1>(arg4, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg2, arg3, 0x2::coin::from_balance<T1>(v0, arg6), arg5, arg6), arg6);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.s_coins, v2)) {
            let v3 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.s_coins, v2);
            0x2::balance::join<T2>(v3, 0x2::coin::into_balance<T2>(v1));
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.supply, &v2);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v2, 0x2::balance::value<T2>(v3));
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v2, 0x2::coin::value<T2>(&v1));
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.s_coins, v2, 0x2::coin::into_balance<T2>(v1));
        };
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::supply_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0));
    }

    public fun unlock<T0: drop>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>) {
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Scallop>(arg1, &v0);
        if (*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun update_record_value(arg0: &mut ScallopVault, arg1: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            let v0 = 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg2, v0);
            let (v1, v2) = claimable_value(arg1, v0, arg2);
            let v3 = v2;
            let v4 = v1;
            let v5 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v4) > 0) {
                let v6 = &mut v5;
                add_amount(v6, 0x1::vector::pop_back<0x1::ascii::String>(&mut v4), 0x1::vector::pop_back<u64>(&mut v3));
            };
            arg0.record.reward = v5;
            let v7 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral_types(arg2);
            let v8 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::type_name::TypeName>(&v7) > 0) {
                let v9 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v7);
                let v10 = &mut v8;
                add_amount(v10, 0x1::type_name::into_string(v9), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg2, v9));
            };
            arg0.record.collateral = v8;
            let v11 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg2);
            let v12 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::type_name::TypeName>(&v11) > 0) {
                let v13 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v11);
                let (_, v15) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg2, v13);
                let v16 = &mut v12;
                add_amount(v16, 0x1::type_name::into_string(v13), v15);
            };
            arg0.record.borrow = v12;
        };
    }

    public fun verify_scallop_state<T0: drop>(arg0: &mut ScallopVault, arg1: ScallopState, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Scallop, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_record_value(arg0, arg2, arg3);
        let ScallopState {
            collateral : v0,
            borrow     : v1,
            supply     : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v5);
        while (0x1::vector::length<0x1::ascii::String>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v6);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v7) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v7)) {
                err_less_than_scallop_state_collateral();
            };
        };
        let v8 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v3);
        while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v9) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v3, &v9)) {
                err_less_than_scallop_state_supply();
            };
        };
        let v10 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v4);
        while (0x1::vector::length<0x1::ascii::String>(&v10) > 0) {
            let v11 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v10);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.borrow, &v11) > *0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v11)) {
                err_more_than_scallop_state_borrow();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg4)
    }

    public fun withdraw<T0: drop, T1, T2>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T2, T1>, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Scallop, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T2>());
        message_pre_check<T0>(arg0, arg1);
        let v1 = 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg2, arg3, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T2, T1>(arg6, 0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.s_coins, v0)), arg7), arg7), arg4, arg7));
        if (0x2::balance::value<T1>(&v1) != 0) {
            let v2 = 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T2, T1>(arg6, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg2, arg3, 0x2::coin::from_balance<T1>(v1, arg7), arg4, arg7), arg7);
            if (0x2::bag::contains<0x1::ascii::String>(&arg0.s_coins, v0)) {
                let v3 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.s_coins, v0);
                0x2::balance::join<T2>(v3, 0x2::coin::into_balance<T2>(v2));
                let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.supply, &v0);
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v0, 0x2::balance::value<T2>(v3));
            } else {
                0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, v0, 0x2::coin::value<T2>(&v2));
                0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T2>>(&mut arg0.s_coins, v0, 0x2::coin::into_balance<T2>(v2));
            };
        } else {
            0x2::balance::destroy_zero<T1>(v1);
        };
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::withdraw_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), arg5);
        new_single_asset<T0, T1>(arg0, 0x2::balance::split<T1>(&mut v1, arg5), arg7)
    }

    public fun withdraw_collateral<T0: drop, T1>(arg0: &mut ScallopVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Scallop>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: u64, arg7: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Scallop, T0, T1> {
        if (0x1::option::is_none<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key)) {
            err_obligation_key_not_existed();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T1>(arg2, arg3, 0x1::option::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey>(&arg0.obligation_key), arg4, arg5, arg6, arg7, arg8, arg9));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let (_, v4) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.collateral, &v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.collateral, v2, v4 - v1);
        0xd6c7e153379251e03f6f3c07dea4bcf27a1832f8dfccafdf5aa9a262a5053c4b::scallop_adapter_event::withdraw_collateral_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg9)
    }

    // decompiled from Move bytecode v6
}

