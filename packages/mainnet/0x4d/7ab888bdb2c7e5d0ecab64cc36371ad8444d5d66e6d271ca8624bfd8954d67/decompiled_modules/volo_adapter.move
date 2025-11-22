module 0x4d7ab888bdb2c7e5d0ecab64cc36371ad8444d5d66e6d271ca8624bfd8954d67::volo_adapter {
    struct VoloAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VoloAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VoloAdapterVersion has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct VoloPass has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Volo has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut VoloAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Volo>, arg2: &VoloAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Volo>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = VoloPass{
            id            : 0x2::object::new(arg3),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v4.id));
        0x4d7ab888bdb2c7e5d0ecab64cc36371ad8444d5d66e6d271ca8624bfd8954d67::volo_adapter_event::new_volo_pass_event(*0x2::object::uid_as_inner(&v4.id), v3);
        0x2::transfer::share_object<VoloPass>(v4);
    }

    public fun add_version(arg0: &mut VoloAdapterVersion, arg1: &VoloAdapterAdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
        } else {
            err_version_already_existed();
        };
    }

    entry fun add_whitelist<T0>(arg0: &mut VoloAdapterRegistry, arg1: &VoloAdapterVersion, arg2: &VoloAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::with_defining_ids<T0>());
    }

    fun assert_version_not_allowed(arg0: &VoloAdapterVersion) {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
    }

    fun check_and_fill_main_vault_id(arg0: &mut VoloPass, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    fun err_already_registered() {
        abort 101
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_not_whitelisted_source() {
        abort 102
    }

    fun err_version_already_existed() {
        abort 103
    }

    fun err_version_not_allowed() {
        abort 105
    }

    fun err_version_not_existed() {
        abort 104
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut VoloPass, arg1: &VoloAdapterVersion, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Volo, T0> {
        assert_version_not_allowed(arg1);
        new_total_value_message<T0>(arg0, 0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VoloAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = VoloAdapterAdminCap{id: 0x2::object::new(arg0)};
        let v2 = VoloAdapterVersion{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<VoloAdapterVersion>(v2);
        0x2::transfer::share_object<VoloAdapterRegistry>(v0);
        0x2::transfer::public_transfer<VoloAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_version_allowed(arg0: &VoloAdapterVersion) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    fun new_single_asset<T0: drop, T1>(arg0: &VoloPass, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Volo, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<Volo, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<Volo, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &VoloPass, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<Volo, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<Volo, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Volo, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Volo, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Volo, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<Volo, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut VoloPass, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Volo, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Volo, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Volo, T1>(arg1, &v1)
    }

    public fun remove_version(arg0: &mut VoloAdapterVersion, arg1: &VoloAdapterAdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
        } else {
            err_version_not_existed();
        };
    }

    entry fun remove_whitelist<T0>(arg0: &mut VoloAdapterRegistry, arg1: &VoloAdapterVersion, arg2: &VoloAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun stake<T0: drop>(arg0: &mut VoloPass, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Volo, 0x2::sui::SUI>, arg2: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::StakePool, arg3: &mut 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::Metadata<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &VoloAdapterVersion, arg6: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<Volo, T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT> {
        assert_version_not_allowed(arg5);
        let v0 = pre_check_and_extract_asset<T0, 0x2::sui::SUI>(arg0, arg1);
        let v1 = 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::stake_pool::stake(arg2, arg3, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg6), arg6);
        0x4d7ab888bdb2c7e5d0ecab64cc36371ad8444d5d66e6d271ca8624bfd8954d67::volo_adapter_event::stake_event(0x2::object::id<VoloPass>(arg0), 0x2::balance::value<0x2::sui::SUI>(&v0), 0x2::coin::value<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(&v1));
        new_single_asset<T0, 0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(arg0, 0x2::coin::into_balance<0x549e8b69270defbfafd4f94e17ec44cdbdd99820b33bda2278dea3b9a32d3f55::cert::CERT>(v1), arg6)
    }

    fun stamp() : Volo {
        Volo{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

