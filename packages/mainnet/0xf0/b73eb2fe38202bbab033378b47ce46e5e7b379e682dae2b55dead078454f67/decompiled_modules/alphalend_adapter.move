module 0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter {
    struct AlphalendAdapterRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct AlphalendVault has key {
        id: 0x2::object::UID,
        main_vault_id: 0x1::option::Option<0x2::object::ID>,
        position_cap: 0x1::option::Option<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>,
        markets: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        record: AlphalendRecord,
        is_redeeming: bool,
    }

    struct AlphalendAdapterAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AlphalendAdapterVersion has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
    }

    struct AlphalendRecord has store {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        reward: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct AlphalendState {
        collateral: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        borrow: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct AlphaLend has drop {
        dummy_field: bool,
    }

    public fun borrow<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &AlphalendAdapterVersion, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, T1> {
        assert_version_not_allowed(arg6);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg3, arg4, arg5, arg7), arg5, arg7));
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v3 = &mut arg0.record.borrow;
        add_amount(v3, v2, v1);
        fill_market(arg0, v2, arg3);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::borrow_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg7)
    }

    public fun new<T0: drop>(arg0: &mut AlphalendAdapterRegistry, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &AlphalendAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        let v1 = stamp();
        let v2 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, AlphaLend>(arg1, &v1);
        let v3 = 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v2, b"main_vault_id");
        0x2::bag::destroy_empty(v2);
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.map, &v3)) {
            err_already_registered();
        };
        let v4 = AlphalendRecord{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            reward     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v5 = AlphalendVault{
            id            : 0x2::object::new(arg3),
            main_vault_id : 0x1::option::some<0x2::object::ID>(v3),
            position_cap  : 0x1::option::none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(),
            markets       : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            record        : v4,
            is_redeeming  : false,
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.map, v3, *0x2::object::uid_as_inner(&v5.id));
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::new_alphalend_vault_event(*0x2::object::uid_as_inner(&v5.id), v3);
        0x2::transfer::share_object<AlphalendVault>(v5);
    }

    public fun add_collateral<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, AlphaLend, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &AlphalendAdapterVersion, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg5);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v3 = &mut arg0.record.collateral;
        add_amount(v3, v2, v1);
        fill_market(arg0, v2, arg3);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg3, 0x2::coin::from_balance<T1>(v0, arg6), arg4, arg6);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::collateral_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
    }

    public fun create_position<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &AlphalendAdapterVersion, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_not_allowed(arg3);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::create_position(arg2, arg4);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::new_alphalend_position_event(*0x2::object::uid_as_inner(&arg0.id), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v0));
        0x1::option::fill<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&mut arg0.position_cap, v0);
    }

    public fun remove_collateral<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &AlphalendAdapterVersion, arg7: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, T1> {
        assert_version_not_allowed(arg6);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg3, arg4, arg5), arg5, arg7));
        let v1 = 0x2::balance::value<T1>(&v0);
        reduce_record_collateral<T1>(arg0, v1);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::withdraw_collateral_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, T1>(arg0, v0, arg7)
    }

    public fun repay<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, AlphaLend, T1>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &AlphalendAdapterVersion, arg6: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, T1> {
        assert_version_not_allowed(arg5);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        let v0 = pre_check_and_extract_asset<T0, T1>(arg0, arg1);
        let v1 = 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::repay<T1>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg3, 0x2::coin::from_balance<T1>(v0, arg6), arg4, arg6));
        let v2 = 0x2::balance::value<T1>(&v0) - 0x2::balance::value<T1>(&v1);
        reduce_record_borrow<T1>(arg0, v2);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::repay_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v2);
        new_single_asset<T0, T1>(arg0, v1, arg6)
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

    public fun add_version(arg0: &mut AlphalendAdapterVersion, arg1: &AlphalendAdapterAdminCap, arg2: u64) {
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::insert<u64>(&mut arg0.versions, arg2);
        } else {
            err_version_already_existed();
        };
    }

    entry fun add_whitelist<T0>(arg0: &mut AlphalendAdapterRegistry, arg1: &AlphalendAdapterVersion, arg2: &AlphalendAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, 0x1::type_name::with_defining_ids<T0>());
    }

    public fun alphalend_state_borrow(arg0: &AlphalendState) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.borrow
    }

    public fun alphalend_state_collateral(arg0: &AlphalendState) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.collateral
    }

    public fun alphalend_state_supply(arg0: &AlphalendState) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.supply
    }

    fun assert_version_not_allowed(arg0: &AlphalendAdapterVersion) {
        if (!is_version_allowed(arg0)) {
            err_version_not_allowed();
        };
    }

    public fun borrow_sui<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &AlphalendAdapterVersion, arg8: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, 0x2::sui::SUI> {
        assert_version_not_allowed(arg7);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::borrow<0x2::sui::SUI>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg4, arg5, arg6, arg8), arg3, arg6, arg8));
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>());
        let v3 = &mut arg0.record.borrow;
        add_amount(v3, v2, v1);
        fill_market(arg0, v2, arg4);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::borrow_event<0x2::sui::SUI>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, 0x2::sui::SUI>(arg0, v0, arg8)
    }

    fun check_and_extract_weight<T0: drop>(arg0: &AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>) : 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, AlphaLend>(arg1, &v0);
        if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::Float>(&mut v1, b"weight")
    }

    fun check_and_fill_main_vault_id(arg0: &mut AlphalendVault, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.main_vault_id)) {
            arg0.main_vault_id = 0x1::option::some<0x2::object::ID>(arg1);
        } else if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != arg1) {
            err_main_vault_id_not_matched();
        };
    }

    public fun claim<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &AlphalendAdapterVersion, arg6: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, T1> {
        assert_version_not_allowed(arg5);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T1>(arg2, arg3, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg4, arg6);
        let v2 = 0x2::coin::into_balance<T1>(v0);
        0x2::balance::join<T1>(&mut v2, 0x2::coin::into_balance<T1>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T1>(arg2, v1, arg4, arg6)));
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.reward, &v3)) {
            let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.reward, &v3);
        };
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.reward, v3, 0);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::claim_event<T1>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), 0x2::balance::value<T1>(&v2));
        new_single_asset<T0, T1>(arg0, v2, arg6)
    }

    fun err_already_registered() {
        abort 103
    }

    fun err_less_than_alphalend_state_collateral() {
        abort 106
    }

    fun err_less_than_alphalend_state_supply() {
        abort 109
    }

    fun err_main_vault_id_not_matched() {
        abort 100
    }

    fun err_more_than_alphalend_state_borrow() {
        abort 108
    }

    fun err_not_redeeming() {
        abort 110
    }

    fun err_not_whitelisted_source() {
        abort 104
    }

    fun err_position_cap_existed() {
        abort 101
    }

    fun err_position_cap_not_existed() {
        abort 102
    }

    fun err_redeeming() {
        abort 105
    }

    fun err_version_already_existed() {
        abort 111
    }

    fun err_version_not_allowed() {
        abort 113
    }

    fun err_version_not_existed() {
        abort 112
    }

    public fun fetch_total_value<T0: drop>(arg0: &mut AlphalendVault, arg1: &AlphalendAdapterRegistry, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &AlphalendAdapterVersion, arg5: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0> {
        assert_version_not_allowed(arg4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelist, &v0)) {
            err_not_whitelisted_source();
        };
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v1 = 0x1::vector::empty<bool>();
        let v2 = 0x1::vector::empty<0x1::ascii::String>();
        let v3 = 0x1::vector::empty<u64>();
        if (0x1::option::is_some<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap));
            let v5 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.markets);
            let v6 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            let v7 = 0x2::vec_map::empty<0x1::ascii::String, u64>();
            while (0x1::vector::length<0x1::ascii::String>(&v5) > 0) {
                let v8 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v5);
                let v9 = *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.markets, &v8);
                let v10 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg2, v9, v4, arg3);
                if (v10 > 0) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v2, v8);
                    0x1::vector::push_back<u64>(&mut v3, v10);
                    0x1::vector::push_back<bool>(&mut v1, true);
                    let v11 = &mut v6;
                    add_amount(v11, v8, v10);
                };
                let v12 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg2, v9, v4, arg3);
                if (v12 > 0) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v2, v8);
                    0x1::vector::push_back<u64>(&mut v3, v12);
                    0x1::vector::push_back<bool>(&mut v1, false);
                    let v13 = &mut v7;
                    add_amount(v13, v8, v12);
                };
            };
            arg0.record.collateral = v6;
            arg0.record.borrow = v7;
        };
        let v14 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.reward);
        let v15 = 0;
        while (v15 < 0x1::vector::length<0x1::ascii::String>(&v14)) {
            let v16 = *0x1::vector::borrow<0x1::ascii::String>(&v14, v15);
            0x1::vector::push_back<0x1::ascii::String>(&mut v2, v16);
            0x1::vector::push_back<u64>(&mut v3, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.reward, &v16));
            0x1::vector::push_back<bool>(&mut v1, true);
            v15 = v15 + 1;
        };
        new_total_value_message<T0>(arg0, v2, v3, v1, arg5)
    }

    fun fill_market(arg0: &mut AlphalendVault, arg1: 0x1::ascii::String, arg2: u64) {
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.markets, &arg1)) {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.markets, arg1, arg2);
        };
    }

    public fun get_borrow_info_from_record(arg0: &AlphalendVault) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.record.borrow
    }

    public fun get_collateral_info_from_record(arg0: &AlphalendVault) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.record.collateral
    }

    public fun get_supply_info_from_record(arg0: &AlphalendVault) : 0x2::vec_map::VecMap<0x1::ascii::String, u64> {
        arg0.record.supply
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AlphalendAdapterRegistry{
            id        : 0x2::object::new(arg0),
            map       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = AlphalendAdapterAdminCap{id: 0x2::object::new(arg0)};
        let v2 = AlphalendAdapterVersion{
            id       : 0x2::object::new(arg0),
            versions : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<AlphalendAdapterVersion>(v2);
        0x2::transfer::share_object<AlphalendAdapterRegistry>(v0);
        0x2::transfer::public_transfer<AlphalendAdapterAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_version_allowed(arg0: &AlphalendAdapterVersion) : bool {
        let v0 = 1;
        0x2::vec_set::contains<u64>(&arg0.versions, &v0)
    }

    fun message_pre_check<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, AlphaLend>(arg1, &v0);
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"));
        0x2::bag::destroy_empty(v1);
    }

    public fun new_alphalend_state<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &AlphalendAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) : (AlphalendState, 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0>) {
        assert_version_not_allowed(arg2);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let v0 = 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::sub(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::from(1), check_and_extract_weight<T0>(arg0, arg1));
        let v1 = AlphalendState{
            collateral : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            borrow     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply     : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.borrow);
        while (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v2);
            let v4 = &mut v1.borrow;
            add_amount(v4, v3, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::ceil(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.borrow, &v3))));
        };
        let v5 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.supply);
        while (0x1::vector::length<0x1::ascii::String>(&v5) > 0) {
            let v6 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v5);
            let v7 = &mut v1.supply;
            add_amount(v7, v6, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::floor(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v6))));
        };
        let v8 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.record.collateral);
        while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            let v10 = &mut v1.collateral;
            add_amount(v10, v9, 0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::floor(0x8e2270177d325fb4d6c841a6ebfda4738953bf861348f423fb99b4c1c1f7acd7::float::mul_u64(v0, *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v9))));
        };
        (v1, new_generated_state_proof_message<T0>(arg0, arg3))
    }

    fun new_generated_state_proof_message<T0: drop>(arg0: &AlphalendVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<AlphaLend, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, bool>(&mut v1, &v3, b"is_state_generated", true);
        v1
    }

    fun new_single_asset<T0: drop, T1>(arg0: &AlphalendVault, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, T1> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::new<AlphaLend, T0, T1>(&v0, arg1, arg2);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::set_extra_info<AlphaLend, T0, T1, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_total_value_message<T0: drop>(arg0: &AlphalendVault, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<AlphaLend, T0>(&v0, arg4);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun new_verified_message<T0: drop>(arg0: &AlphalendVault, arg1: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0> {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::new<AlphaLend, T0>(&v0, arg1);
        let v2 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::set_info<AlphaLend, T0, vector<u8>, 0x2::object::ID>(&mut v1, &v3, b"main_vault_id", *0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id));
        v1
    }

    fun pre_check_and_extract_asset<T0: drop, T1>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<T0, AlphaLend, T1>) : 0x2::balance::Balance<T1> {
        let v0 = stamp();
        check_and_fill_main_vault_id(arg0, 0x2::bag::remove<vector<u8>, 0x2::object::ID>(0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::borrow_extra_info_mut<T0, AlphaLend, T1>(&mut arg1, &v0), b"main_vault_id"));
        let v1 = stamp();
        0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::burn<T0, AlphaLend, T1>(arg1, &v1)
    }

    fun reduce_record_borrow<T0>(arg0: &mut AlphalendVault, arg1: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.borrow, &v0)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.borrow, &v0);
            v3
        } else {
            0
        };
        let v4 = if (v1 >= arg1) {
            v1 - arg1
        } else {
            0
        };
        if (v4 > 0) {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.borrow, v0, v4);
        };
    }

    fun reduce_record_collateral<T0>(arg0: &mut AlphalendVault, arg1: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.record.collateral, &v0)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.record.collateral, &v0);
            v3
        } else {
            0
        };
        let v4 = if (v1 >= arg1) {
            v1 - arg1
        } else {
            0
        };
        if (v4 > 0) {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.record.collateral, v0, v4);
        };
    }

    public fun remove_collateral_sui<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &AlphalendAdapterVersion, arg8: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::asset::Asset<AlphaLend, T0, 0x2::sui::SUI> {
        assert_version_not_allowed(arg7);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        if (0x1::option::is_none<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap)) {
            err_position_cap_not_existed();
        };
        message_pre_check<T0>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<0x2::sui::SUI>(arg2, 0x1::option::borrow<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&arg0.position_cap), arg4, arg5, arg6), arg3, arg6, arg8));
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        reduce_record_collateral<0x2::sui::SUI>(arg0, v1);
        0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event::withdraw_collateral_event<0x2::sui::SUI>(*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id), v1);
        new_single_asset<T0, 0x2::sui::SUI>(arg0, v0, arg8)
    }

    public fun remove_version(arg0: &mut AlphalendAdapterVersion, arg1: &AlphalendAdapterAdminCap, arg2: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.versions, &arg2)) {
            0x2::vec_set::remove<u64>(&mut arg0.versions, &arg2);
        } else {
            err_version_not_existed();
        };
    }

    entry fun remove_whitelist<T0>(arg0: &mut AlphalendAdapterRegistry, arg1: &AlphalendAdapterVersion, arg2: &AlphalendAdapterAdminCap) {
        assert_version_not_allowed(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    fun stamp() : AlphaLend {
        AlphaLend{dummy_field: false}
    }

    public fun unlock<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>, arg2: &AlphalendAdapterVersion) {
        assert_version_not_allowed(arg2);
        if (!arg0.is_redeeming) {
            err_not_redeeming();
        };
        unlock_<T0>(arg0, arg1);
    }

    fun unlock_<T0: drop>(arg0: &mut AlphalendVault, arg1: 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<T0, AlphaLend>) {
        let v0 = stamp();
        let v1 = 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::burn_and_get_info<T0, AlphaLend>(arg1, &v0);
        if (*0x1::option::borrow<0x2::object::ID>(&arg0.main_vault_id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id")) {
            err_main_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_unlocked")) {
            arg0.is_redeeming = false;
        };
        0x2::bag::destroy_empty(v1);
    }

    public fun verify_alphalend_state<T0: drop>(arg0: &mut AlphalendVault, arg1: AlphalendState, arg2: &AlphalendAdapterVersion, arg3: &mut 0x2::tx_context::TxContext) : 0x777766ca12cd15f493bc72b315288b6552aead358620425172fc9c284b747a0f::message::Message<AlphaLend, T0> {
        assert_version_not_allowed(arg2);
        if (arg0.is_redeeming) {
            err_redeeming();
        };
        let AlphalendState {
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
            if ((*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.collateral, &v7) as u128) < (*0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v7) as u128) * 999 / 1000) {
                err_less_than_alphalend_state_collateral();
            };
        };
        let v8 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v3);
        while (0x1::vector::length<0x1::ascii::String>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v8);
            if ((*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.supply, &v9) as u128) < (*0x2::vec_map::get<0x1::ascii::String, u64>(&v3, &v9) as u128) * 999 / 1000) {
                err_less_than_alphalend_state_supply();
            };
        };
        let v10 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v4);
        while (0x1::vector::length<0x1::ascii::String>(&v10) > 0) {
            let v11 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v10);
            if ((*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.record.borrow, &v11) as u128) > (*0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v11) as u128) * 1001 / 1000) {
                err_more_than_alphalend_state_borrow();
            };
        };
        arg0.is_redeeming = true;
        new_verified_message<T0>(arg0, arg3)
    }

    // decompiled from Move bytecode v7
}

