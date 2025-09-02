module 0xb9d09040e0769e8e7eb54a7e0b46ac0a30f8d484723fe16e29e3bad01a5460eb::spring_sui_adapter {
    struct SpringSuiAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct SpringSuiAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SpringSuiPass has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct SpringSui has drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: &mut SpringSuiAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, SpringSui>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, SpringSui>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = SpringSuiPass{
            id            : 0x2::object::new(arg2),
            main_vault_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v4.id));
        0xb9d09040e0769e8e7eb54a7e0b46ac0a30f8d484723fe16e29e3bad01a5460eb::spring_sui_adapter_event::new_spring_sui_vault_event(*0x2::object::uid_as_inner(&v4.id), v3);
        0x2::transfer::share_object<SpringSuiPass>(v4);
    }

    fun check_and_fill_main_vault_id(arg0: &mut SpringSuiPass, arg1: 0x2::object::ID) {
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpringSuiAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = SpringSuiAdapterAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<SpringSuiAdapterRegistry>(v0);
        0x2::transfer::public_transfer<SpringSuiAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun new_single_asset<T0: drop, T1>(arg0: &SpringSuiPass, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<SpringSui, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<SpringSui, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<SpringSui, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut SpringSuiPass, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, SpringSui, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, SpringSui, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, SpringSui, T1>(arg1, &v1)
    }

    public fun stake_sui<T0: drop>(arg0: &mut SpringSuiPass, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, SpringSui, 0x2::sui::SUI>, arg2: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<SpringSui, T0, 0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI> {
        let v0 = pre_check_and_extract_asset<T0, 0x2::sui::SUI>(arg0, arg1);
        let v1 = 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(arg2, arg3, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4), arg4);
        0xb9d09040e0769e8e7eb54a7e0b46ac0a30f8d484723fe16e29e3bad01a5460eb::spring_sui_adapter_event::stake_sui_event(0x2::object::id<SpringSuiPass>(arg0), 0x2::balance::value<0x2::sui::SUI>(&v0), 0x2::coin::value<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(&v1));
        new_single_asset<T0, 0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(arg0, 0x2::coin::into_balance<0x83556891f4a0f233ce7b05cfe7f957d4020492a34f5405b2cb9377d060bef4bf::spring_sui::SPRING_SUI>(v1), arg4)
    }

    fun stamp() : SpringSui {
        SpringSui{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

