module 0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter {
    struct SuilendAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct SuilendVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        obligation_owner_cap: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>,
        record: SuilendRecord,
        is_redeeming: bool,
    }

    struct SuilendAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuilendRecord has store {
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct SuilendState {
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Suilend has drop {
        dummy_field: bool,
    }

    public fun borrow<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Suilend, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::borrow_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap), arg4, arg5), arg6));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = &mut arg0.record.borrow;
        add_amount(v2, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v1);
        0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event::borrow_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg6)
    }

    public fun new<T0: drop>(arg0: &mut SuilendAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Suilend>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = SuilendRecord{
            borrow : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = SuilendVault{
            id                   : 0x2::object::new(arg2),
            main_vault_id        : 0x1::option::some<0x2::object::ID>(v3),
            obligation_owner_cap : 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(),
            record               : v4,
            is_redeeming         : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0x2::transfer::share_object<SuilendVault>(v5);
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

    entry fun add_whitelist<T0>(arg0: &mut SuilendAdapterRegistry, arg1: &SuilendAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::get<T0>());
    }

    fun check_and_extract_weight<T0: drop>(arg0: &SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Suilend>(arg1, &v0);
        if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut SuilendVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (!(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1)) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Suilend, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap), arg3, arg4, arg5, arg6, arg7));
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::into_string(v1);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, 0x1::type_name::into_string(v1), 0);
        0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event::claim_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0));
        new_single_asset<T0, T1>(arg0, v0, arg7)
    }

    public fun create_obligation<T0: drop>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        0x1::option::fill<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut arg0.obligation_owner_cap, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2, arg3));
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_suilend_state_supply() {
        abort 107
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_suilend_state_borrow() {
        abort 106
    }

    fun err_not_redeeming() {
        abort 109
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_obligation_owner_cap_existed() {
        abort 101
    }

    fun err_obligation_owner_cap_not_existed() {
        abort 102
    }

    fun err_redeeming() {
        abort 108
    }

    fun err_still_existed_reward() {
        abort 105
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut SuilendVault, arg1: &SuilendAdapterRegistry, arg2: &0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::Whitelist, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0x1::vector::empty<u64>();
        if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            let (v4, v5, v6, v7, v8) = update_and_get_value(arg2, arg3, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap));
            let v9 = v8;
            let v10 = v7;
            let v11 = v6;
            let v12 = v5;
            let v13 = v4;
            let v14 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v13) > 0) {
                let v15 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v13);
                let v16 = 0x1::vector::pop_back<u64>(&mut v12);
                0x1::vector::push_back<0x1::ascii::String>(&mut v2, v15);
                0x1::vector::push_back<u64>(&mut v3, v16);
                0x1::vector::push_back<bool>(&mut v1, true);
                let v17 = &mut v14;
                add_amount(v17, v15, v16);
            };
            arg0.record.reward = v14;
            let v18 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            let v19 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v11) > 0) {
                let v20 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v11);
                let v21 = 0x1::vector::pop_back<u64>(&mut v10);
                let v22 = 0x1::vector::pop_back<bool>(&mut v9);
                0x1::vector::push_back<0x1::ascii::String>(&mut v2, v20);
                0x1::vector::push_back<u64>(&mut v3, v21);
                0x1::vector::push_back<bool>(&mut v1, v22);
                if (v22) {
                    let v23 = &mut v18;
                    add_amount(v23, v20, (v21 as u64));
                    continue
                };
                let v24 = &mut v19;
                add_amount(v24, v20, (v21 as u64));
            };
            arg0.record.borrow = v19;
            arg0.record.supply = v18;
        };
        new_total_value_message<T0>(arg0, v2, v3, v1, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuilendAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = SuilendAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SuilendAdapterRegistry>(v0);
        0x2::transfer::public_transfer<SuilendAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Suilend>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &SuilendVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Suilend, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, bool>(&mut v1, &v3, b"is_sate_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &SuilendVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Suilend, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Suilend, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Suilend, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    public fun new_suilend_state<T0: drop>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0x2::tx_context::TxContext) : (SuilendState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::sub(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from(1), check_and_extract_weight<T0>(arg0, arg1));
        let v1 = SuilendState{
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
            add_amount(v6, v5, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::ceil(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v5))));
        };
        let v7 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.supply);
        while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
            let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
            let v9 = &mut v1.supply;
            add_amount(v9, v8, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::floor(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v8))));
        };
        (v1, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_total_value_message<T0: drop>(arg0: &SuilendVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Suilend, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &SuilendVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Suilend, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Suilend, T0, vector<u8>, 0x1::option::Option<0x2::object::ID>>(&mut v1, &v3, b"main_vault_id", arg0.main_vault_id);
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Suilend, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Suilend, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Suilend, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut SuilendAdapterRegistry, arg1: &SuilendAdapterAdminCap) {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun repay<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Suilend, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Suilend, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg5);
        let v2 = 0x2::coin::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::repay<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)), arg4, &mut v1, arg5);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0x1::type_name::into_string(v3);
        let (_, v6) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.borrow, &v4);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, 0x1::type_name::into_string(v3), v6 - v2);
        0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event::borrow_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v2 - 0x2::coin::value<T1>(&v1));
        new_single_asset<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v1), arg5)
    }

    fun stamp() : Suilend {
        Suilend{dummy_field: false}
    }

    public fun supply<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Suilend, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::from_balance<T1>(v0, arg5);
        let v2 = 0x2::coin::value<T1>(&v1);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap), arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, arg4, v1, arg5), arg5);
        let v3 = &mut arg0.record.supply;
        add_amount(v3, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v2);
        0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event::supply_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v2);
    }

    public fun unlock<T0: drop>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>) {
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Suilend>(arg1, &v0);
        if (*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun update_and_get_value(arg0: &0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::Whitelist, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) : (vector<0x1::ascii::String>, vector<u64>, vector<0x1::ascii::String>, vector<u64>, vector<bool>) {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<bool>();
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg2));
        let v6 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg1);
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5);
        let v8 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrows<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5);
        let v9 = 0;
        while (v9 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v7)) {
            let v10 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v7, v9);
            let v11 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_user_reward_manager_index(v10)));
            let v12 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(v10));
            let v13 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v12));
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::type_name::into_string(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_coin_type(v10)));
            0x1::vector::push_back<bool>(&mut v4, true);
            0x1::vector::push_back<u64>(&mut v3, ((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_ratio<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v12), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(v10)))) / 0x1::u256::pow(10, 18 - 9)) as u64));
            let v14 = 0;
            while (v14 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v11)) {
                if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v11, v14))) {
                    let v15 = 0x1::type_name::into_string(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v13, v14))));
                    0x1::vector::push_back<0x1::ascii::String>(&mut v0, v15);
                    0x1::vector::push_back<u64>(&mut v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v11, v14))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, 0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::decimal(arg0, v15))))));
                };
                v14 = v14 + 1;
            };
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v8)) {
            let v17 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Borrow>(v8, v16);
            let v18 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::rewards(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserRewardManager>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::user_reward_managers<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(v5), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_user_reward_manager_index(v17)));
            let v19 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::pool_rewards(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::deposits_pool_reward_manager<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(v6, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_reserve_array_index(v17))));
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, 0x1::type_name::into_string(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_coin_type(v17)));
            0x1::vector::push_back<bool>(&mut v4, false);
            0x1::vector::push_back<u64>(&mut v3, ((0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrow_borrowed_amount(v17)) / 0x1::u256::pow(10, 18 - 9)) as u64));
            let v20 = 0;
            while (v20 < 0x1::vector::length<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v18)) {
                if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v18, v20))) {
                    let v21 = 0x1::type_name::into_string(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::coin_type(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::PoolReward>>(v19, v20))));
                    0x1::vector::push_back<0x1::ascii::String>(&mut v0, v21);
                    0x1::vector::push_back<u64>(&mut v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::earned_rewards(0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>(0x1::vector::borrow<0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::liquidity_mining::UserReward>>(v18, v20))), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, 0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::decimal(arg0, v21))))));
                };
                v20 = v20 + 1;
            };
        };
        (v0, v1, v2, v3, v4)
    }

    public fun update_record_value(arg0: &mut SuilendVault, arg1: &0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::Whitelist, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            let (v0, v1, v2, v3, v4) = update_and_get_value(arg1, arg2, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap));
            let v5 = v4;
            let v6 = v3;
            let v7 = v2;
            let v8 = v1;
            let v9 = v0;
            let v10 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v9) > 0) {
                let v11 = &mut v10;
                add_amount(v11, 0x1::vector::pop_back<0x1::ascii::String>(&mut v9), 0x1::vector::pop_back<u64>(&mut v8));
            };
            arg0.record.reward = v10;
            let v12 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            let v13 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v7) > 0) {
                let v14 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v7);
                let v15 = 0x1::vector::pop_back<u64>(&mut v6);
                if (0x1::vector::pop_back<bool>(&mut v5)) {
                    let v16 = &mut v12;
                    add_amount(v16, v14, (v15 as u64));
                    continue
                };
                let v17 = &mut v13;
                add_amount(v17, v14, (v15 as u64));
            };
            arg0.record.borrow = v13;
            arg0.record.supply = v12;
        };
    }

    public fun verify_suilend_state<T0: drop>(arg0: &mut SuilendVault, arg1: SuilendState, arg2: &0x9d57f00f66159d88f9fb6afaf67a9a1d1bc01d5659ab0344c1cb0bf08219ee0d::whitelist::Whitelist, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Suilend, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        update_record_value(arg0, arg2, arg3);
        let SuilendState {
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
                err_less_than_suilend_state_supply();
            };
        };
        let v10 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v5);
        while (0x1::vector::length<0x1::ascii::String>(&v10) > 0) {
            let v11 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v10);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.borrow, &v11) > *0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v11)) {
                err_more_than_suilend_state_borrow();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg4)
    }

    public fun withdraw<T0: drop, T1>(arg0: &mut SuilendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Suilend>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>>, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Suilend, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap)) {
            err_obligation_owner_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, arg4, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T1>(arg2, arg3, 0x1::option::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&arg0.obligation_owner_cap), arg4, arg5, arg7), arg6, arg7), arg7));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = 0x1::type_name::into_string(v2);
        let (_, v5) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.supply, &v3);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.supply, 0x1::type_name::into_string(v2), v5 - v1);
        0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event::withdraw_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg7)
    }

    // decompiled from Move bytecode v7
}

