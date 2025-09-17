module 0xe506cdb0ecf053a0676539aab1164dafc932ba5c02200b12e27f9145f344c9af::typus_adapter {
    struct TypusAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct TypusVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        lp: 0x2::bag::Bag,
        lp_record: TypusLpRecord,
        is_redeeming: bool,
    }

    struct TypusAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TypusLpRecord has store {
        lp: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct Typus has drop {
        dummy_field: bool,
    }

    struct TypusState {
        lp: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    public fun new<T0: drop>(arg0: &mut TypusAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Typus>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = TypusLpRecord{lp: 0x2::vec_map::empty<0x1::ascii::String, u64>()};
        let v5 = TypusVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            lp            : 0x2::bag::new(arg2),
            lp_record     : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0xe506cdb0ecf053a0676539aab1164dafc932ba5c02200b12e27f9145f344c9af::typus_adapter_event::new_typus_vault_event(*0x2::object::uid_as_inner(&v5.id), v3);
        0x2::transfer::share_object<TypusVault>(v5);
    }

    entry fun add_whitelist<T0>(arg0: &mut TypusAdapterRegistry, arg1: &TypusAdapterAdminCap) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::with_defining_ids<T0>());
    }

    fun check_and_extract_weight<T0: drop>(arg0: &TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>) : 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Typus>(arg1, &v0);
        if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut TypusVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun deposit<T0: drop, T1, T2>(arg0: &mut TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Typus, T1>, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg3: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg4: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps::TreasuryCaps, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::mint_lp<T1, T2>(arg2, arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T1>(v0, arg8), arg7, arg8);
        let v2 = 0x1::type_name::with_defining_ids<T2>();
        let v3 = 0x1::type_name::into_string(v2);
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.lp_record.lp, &v3)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.lp, v2), 0x2::coin::into_balance<T2>(v1));
            let v4 = 0x1::type_name::into_string(v2);
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.lp_record.lp, &v4);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.lp_record.lp, 0x1::type_name::into_string(v2), 0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.lp, v2)));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.lp, v2, 0x2::coin::into_balance<T2>(v1));
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.lp_record.lp, 0x1::type_name::into_string(v2), 0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.lp, v2)));
        };
        0xe506cdb0ecf053a0676539aab1164dafc932ba5c02200b12e27f9145f344c9af::typus_adapter_event::deposit_event(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v0), 0x2::coin::value<T2>(&v1));
    }

    fun err_already_registered() {
        abort 101
    }

    fun err_less_than_typus_state_lp() {
        abort 105
    }

    fun err_lp_not_found() {
        abort 104
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_not_whitelisted_source() {
        abort 102
    }

    fun err_redeeming() {
        abort 103
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut TypusVault, arg1: &TypusAdapterRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = 0x1::vector::empty<0x1::ascii::String>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.lp_record.lp);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::ascii::String>(&v4)) {
            let v6 = *0x1::vector::borrow<0x1::ascii::String>(&v4, v5);
            0x1::vector::push_back<0x1::ascii::String>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.lp_record.lp, &v6));
            0x1::vector::push_back<bool>(&mut v3, true);
            v5 = v5 + 1;
        };
        new_total_value_message<T0>(arg0, v1, v2, v3, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TypusAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = TypusAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TypusAdapterRegistry>(v0);
        0x2::transfer::public_transfer<TypusAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun message_pre_check<T0: drop>(arg0: &mut TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Typus>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &TypusVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Typus, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, bool>(&mut v1, &v3, b"is_state_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &TypusVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Typus, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Typus, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Typus, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &TypusVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Typus, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    public fun new_typus_state<T0: drop>(arg0: &mut TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>, arg2: &mut 0x2::tx_context::TxContext) : (TypusState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0>) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = TypusState{lp: 0x2::vec_map::empty<0x1::ascii::String, u64>()};
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.lp_record.lp);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::ascii::String>(&v1, v2);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0.lp, v3, 0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::floor(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::mul_u64(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::sub(0xb6cb55601fd59efd9e3ab08cb0b9e8af4ecc45ca6a7ee03339799978ba3e6445::float::from(1), check_and_extract_weight<T0>(arg0, arg1)), *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.lp_record.lp, &v3))));
            v2 = v2 + 1;
        };
        (v0, new_generated_state_proof_message<T0>(arg0, arg2))
    }

    fun new_verified_message<T0: drop>(arg0: &TypusVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Typus, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Typus, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v3, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Typus, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Typus, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Typus, T1>(arg1, &v1)
    }

    entry fun remove_whitelist<T0>(arg0: &mut TypusAdapterRegistry, arg1: &TypusAdapterAdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : Typus {
        Typus{dummy_field: false}
    }

    public fun verify_typus_state<T0: drop>(arg0: &mut TypusVault, arg1: TypusState, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Typus, T0> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let TypusState { lp: v0 } = arg1;
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v0);
        while (0x1::vector::length<0x1::ascii::String>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v1);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.lp_record.lp, &v2) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v0, &v2)) {
                err_less_than_typus_state_lp();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg2)
    }

    public fun withdraw<T0: drop, T1, T2>(arg0: &mut TypusVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Typus>, arg2: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::admin::Version, arg3: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::Registry, arg4: &mut 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps::TreasuryCaps, arg5: &0x855eb2d260ee42b898266e6df90bfd3c4ed821ccb253a352c159c223244a4b8a::oracle::Oracle, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Typus, T0, T1> {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.lp, v0)) {
            err_lp_not_found();
        };
        0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::redeem<T2>(arg2, arg3, arg6, 0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.lp, v0), arg7), arg8, arg9);
        let v1 = 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::lp_pool::claim<0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::tlp::TLP, T1>(arg2, arg3, arg6, arg4, arg5, arg8, arg9);
        let v2 = 0x1::type_name::into_string(v0);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.lp_record.lp, &v2);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.lp_record.lp, 0x1::type_name::into_string(v0), 0x2::balance::value<T2>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.lp, v0)));
        0xe506cdb0ecf053a0676539aab1164dafc932ba5c02200b12e27f9145f344c9af::typus_adapter_event::withdraw_event(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), arg7, 0x2::coin::value<T1>(&v1));
        new_single_asset<T0, T1>(arg0, 0x2::coin::into_balance<T1>(v1), arg9)
    }

    // decompiled from Move bytecode v6
}

