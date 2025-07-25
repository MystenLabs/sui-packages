module 0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter {
    struct NaviAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct NaviVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        account_cap: 0x1::option::Option<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>,
        record: NaviRecord,
        is_redeeming: bool,
    }

    struct NaviAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NaviRecord has store {
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct NaviState {
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Navi has drop {
        dummy_field: bool,
    }

    public fun borrow<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u64, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Navi, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::borrow_with_account_cap<T1>(arg9, arg7, arg2, arg3, arg8, arg4, arg5, arg6, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = &mut arg0.record.borrow;
        add_amount(v2, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v1);
        0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter_event::borrow_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg10)
    }

    public fun new<T0: drop>(arg0: &mut NaviAdapterRegistry, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Navi>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = NaviRecord{
            borrow : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = NaviVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            account_cap   : 0x1::option::none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(),
            record        : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0x2::transfer::share_object<NaviVault>(v5);
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

    entry fun add_whitelist<T0>(arg0: &mut NaviAdapterRegistry, arg1: &NaviAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun check_and_extract_weight<T0: drop>(arg0: &NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>) : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Navi>(arg1, &v0);
        if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut NaviVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T1>, arg6: vector<0x1::ascii::String>, arg7: vector<address>, arg8: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Navi, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T1>(arg2, arg4, arg3, arg5, arg6, arg7, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap));
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::into_string(v1);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, 0x1::type_name::into_string(v1), 0);
        0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter_event::claim_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0));
        new_single_asset<T0, T1>(arg0, v0, arg8)
    }

    public fun claimable_value(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) : (vector<0x1::ascii::String>, vector<u64>) {
        let (_, v1, v2, _, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::parse_claimable_rewards(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg3, arg2, arg1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(arg0)));
        let v5 = v2;
        if (0x1::vector::length<u256>(&v5) > 0) {
            abort 11111
        };
        (v1, 0x1::vector::empty<u64>())
    }

    public fun create_account_cap<T0: drop>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        0x1::option::fill<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut arg0.account_cap, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg2));
    }

    fun err_account_cap_existed() {
        abort 101
    }

    fun err_account_cap_not_existed() {
        abort 102
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_navi_state_supply() {
        abort 107
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_navi_state_borrow() {
        abort 106
    }

    fun err_not_redeeming() {
        abort 109
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_redeeming() {
        abort 108
    }

    fun err_still_existed_reward() {
        abort 105
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut NaviVault, arg1: &NaviAdapterRegistry, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        if (0x1::option::is_some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            let v4 = 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap);
            let (v5, v6) = claimable_value(v4, arg2, arg3, arg4);
            let v7 = v6;
            let v8 = v5;
            let v9 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
                let v10 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
                let v11 = 0x1::vector::pop_back<u64>(&mut v7);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v10);
                0x1::vector::push_back<u64>(&mut v2, v11);
                0x1::vector::push_back<bool>(&mut v3, true);
                let v12 = &mut v9;
                add_amount(v12, v10, v11);
            };
            arg0.record.reward = v9;
            let (v13, v14) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg3, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v4));
            let v15 = v14;
            let v16 = v13;
            let v17 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<u8>(&v16) > 0) {
                let v18 = 0x1::vector::pop_back<u8>(&mut v16);
                let v19 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v18);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v19);
                let v20 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, v18, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v4));
                0x1::vector::push_back<u64>(&mut v2, (v20 as u64));
                0x1::vector::push_back<bool>(&mut v3, true);
                let v21 = &mut v17;
                add_amount(v21, v19, (v20 as u64));
            };
            arg0.record.supply = v17;
            let v22 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<u8>(&v15) > 0) {
                let v23 = 0x1::vector::pop_back<u8>(&mut v15);
                let v24 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg3, v23);
                0x1::vector::push_back<0x1::ascii::String>(&mut v1, v24);
                let v25 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, v23, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v4));
                0x1::vector::push_back<u64>(&mut v2, (v25 as u64));
                0x1::vector::push_back<bool>(&mut v3, false);
                let v26 = &mut v22;
                add_amount(v26, v24, (v25 as u64));
            };
            arg0.record.borrow = v22;
        };
        new_total_value_message<T0>(arg0, v1, v2, v3, arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = NaviAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<NaviAdapterRegistry>(v0);
        0x2::transfer::public_transfer<NaviAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Navi>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &NaviVault, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Navi, T0>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, bool>(&mut v1, &v3, b"is_sate_generated", true);
        v1
    }

    public fun new_navi_state<T0: drop>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &mut 0x2::tx_context::TxContext) : (NaviState, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::sub(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(1), check_and_extract_weight<T0>(arg0, arg1));
        let v1 = NaviState{
            borrow : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.reward);
        while (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = &mut v1.reward;
            add_amount(v3, 0x1::vector::pop_back<0x1::ascii::String>(&mut v2), 0);
        };
        let v4 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.borrow);
        while (0x1::vector::length<0x1::ascii::String>(&v4) > 0) {
            let v5 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v4);
            let v6 = &mut v1.borrow;
            add_amount(v6, v5, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::ceil(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v5))));
        };
        let v7 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.supply);
        while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
            let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
            let v9 = &mut v1.supply;
            add_amount(v9, v8, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v8))));
        };
        (v1, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_single_asset<T0: drop, T1>(arg0: &NaviVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Navi, T0, T1> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::new<Navi, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::set_extra_info<Navi, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &NaviVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Navi, T0>(&v0, arg4);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &NaviVault, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<Navi, T0>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<Navi, T0, vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut v1, &v3, b"main_vault_id", arg0.main_vault_id);
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Navi, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::borrow_extra_info_mut<T0, Navi, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::burn<T0, Navi, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut NaviAdapterRegistry, arg1: &NaviAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun repay<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Navi, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Navi, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::repay_with_account_cap<T1>(arg8, arg6, arg2, arg3, arg7, 0x2::coin::from_balance<T1>(v0, arg9), arg4, arg5, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap));
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x1::type_name::into_string(v3);
        let (_, v6) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.borrow, &v4);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, 0x1::type_name::into_string(v3), v6 - v1);
        0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter_event::repay_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1 - 0x2::balance::value<T1>(&v2));
        new_single_asset<T0, T1>(arg0, v2, arg9)
    }

    fun stamp() : Navi {
        Navi{dummy_field: false}
    }

    public fun supply<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T0, Navi, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: u8, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg8);
        let v2 = 0x2::coin::value<T1>(&v1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T1>(arg7, arg2, arg3, arg4, v1, arg5, arg6, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap));
        let v3 = &mut arg0.record.supply;
        add_amount(v3, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v2);
        0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter_event::supply_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v2);
    }

    public fun unlock<T0: drop>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>) {
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, Navi>(arg1, &v0);
        if (*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun update_record_value(arg0: &mut NaviVault, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0x2::clock::Clock) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            let v0 = 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap);
            let (v1, v2) = claimable_value(v0, arg1, arg2, arg3);
            let v3 = v2;
            let v4 = v1;
            let v5 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v4) > 0) {
                let v6 = &mut v5;
                add_amount(v6, 0x1::vector::pop_back<0x1::ascii::String>(&mut v4), 0x1::vector::pop_back<u64>(&mut v3));
            };
            arg0.record.reward = v5;
            let (v7, v8) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_assets(arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v0));
            let v9 = v8;
            let v10 = v7;
            let v11 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<u8>(&v10) > 0) {
                let v12 = 0x1::vector::pop_back<u8>(&mut v10);
                let v13 = &mut v11;
                add_amount(v13, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, v12), (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg2, v12, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v0)) as u64));
            };
            let v14 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<u8>(&v9) > 0) {
                let v15 = 0x1::vector::pop_back<u8>(&mut v9);
                let v16 = &mut v14;
                add_amount(v16, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, v15), (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg2, v15, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(v0)) as u64));
            };
            arg0.record.borrow = v14;
        };
    }

    public fun verify_navi_state<T0: drop>(arg0: &mut NaviVault, arg1: NaviState, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<Navi, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_record_value(arg0, arg2, arg3, arg4);
        let NaviState {
            borrow : v0,
            supply : v1,
            reward : v2,
        } = arg1;
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v3);
        while (0x1::vector::length<0x1::ascii::String>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v6);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v7) != 0) {
                err_still_existed_reward();
            };
        };
        let v8 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v4);
        while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v9) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v9)) {
                err_less_than_navi_state_supply();
            };
        };
        let v10 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v5);
        while (0x1::vector::length<0x1::ascii::String>(&v10) > 0) {
            let v11 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v10);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.borrow, &v11) > *0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v11)) {
                err_more_than_navi_state_borrow();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg5)
    }

    public fun withdraw<T0: drop, T1>(arg0: &mut NaviVault, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, Navi>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<Navi, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap)) {
            err_account_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T1>(arg9, arg6, arg2, arg3, arg8, arg7, arg4, arg5, 0x1::option::borrow<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&arg0.account_cap));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x1::type_name::into_string(v2);
        let (_, v5) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.supply, &v3);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, 0x1::type_name::into_string(v2), v5 - v1);
        0x4ff84fd6fb7c639aca973705c5178c9ff4a17149a7c1ca87d6c2e7721db51326::navi_adapter_event::withdraw_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg10)
    }

    // decompiled from Move bytecode v6
}

