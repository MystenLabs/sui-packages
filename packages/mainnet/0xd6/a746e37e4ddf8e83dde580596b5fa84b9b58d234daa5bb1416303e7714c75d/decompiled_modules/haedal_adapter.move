module 0xd6a746e37e4ddf8e83dde580596b5fa84b9b58d234daa5bb1416303e7714c75d::haedal_adapter {
    struct HaedalAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct HaedalAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HaedalVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        is_redeeming: bool,
    }

    struct Haedal has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut HaedalAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, Haedal>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, Haedal>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = HaedalVault{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::none<0x2::object::ID>(),
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v4.id));
        0xd6a746e37e4ddf8e83dde580596b5fa84b9b58d234daa5bb1416303e7714c75d::haedal_adapter_event::new_haedal_vault_event(*0x2::object::uid_as_inner(&v4.id), v3);
        0x2::transfer::share_object<HaedalVault>(v4);
    }

    fun check_and_fill_main_vault_id(arg0: &mut HaedalVault, arg1: 0x2::object::ID) {
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

    fun err_redeeming() {
        abort 103
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut HaedalVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Haedal, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, Haedal, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, Haedal, T1>(arg1, &v1)
    }

    public fun stake_sui<T0: drop>(arg0: &mut HaedalVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, Haedal, 0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = pre_check_and_extract_asset<T0, 0x2::sui::SUI>(arg0, arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::interface::request_stake(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), arg4, arg5);
        0xd6a746e37e4ddf8e83dde580596b5fa84b9b58d234daa5bb1416303e7714c75d::haedal_adapter_event::stake_sui_event(0x2::object::id<HaedalVault>(arg0), v1, v1 / 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg3));
    }

    fun stamp() : Haedal {
        Haedal{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

