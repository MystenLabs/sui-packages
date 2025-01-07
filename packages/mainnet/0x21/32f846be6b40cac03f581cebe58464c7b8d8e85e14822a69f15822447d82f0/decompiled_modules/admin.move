module 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_reward_manager(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: address) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::set_reward_manager(arg1, arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_reward_manager_update_event(arg2, true);
    }

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg4));
        assert!(v0 || 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg4)), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        assert!(0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::get_type_string<T2>() != 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::blue_reward_type() || v0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_reward_infos<T0, T1>(arg1, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::timestamp_seconds(arg3));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2);
    }

    public entry fun claim_pool_creation_fee<T0>(arg0: &ProtocolFeeCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::get_config_id(arg1);
        let v1 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::get_type_string<T0>();
        assert!(arg2 > 0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::zero_amount());
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(v0, v1), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::fee_coin_not_supported());
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(v0, v1);
        let v3 = 0x2::balance::value<T0>(v2);
        assert!(v3 >= arg2, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::insufficient_amount());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(0x2::balance::split<T0>(v2, arg2), arg3, arg4);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_pool_creation_fee_claimed(v1, arg2, arg3, v3, 0x2::balance::value<T0>(v2));
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &ProtocolFeeCap, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::get_protocol_fee_for_coin_a<T0, T1>(arg2);
        let v1 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::get_protocol_fee_for_coin_b<T0, T1>(arg2);
        assert!(arg3 <= v0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::insufficient_amount());
        assert!(arg4 <= v1, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::insufficient_amount());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::set_protocol_fee_amount<T0, T1>(arg2, v0 - arg3, v1 - arg4);
        let (v2, v3) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::withdraw_balances<T0, T1>(arg2, arg3, arg4);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v2, arg5, arg6);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v3, arg5, arg6);
        let (v4, v5) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::coin_reserves<T0, T1>(arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_protocol_fee_collected(0x2::object::id<0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>>(arg2), 0x2::tx_context::sender(arg6), arg5, arg3, arg4, v4, v5, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::increase_sequence_number<T0, T1>(arg2));
    }

    public entry fun increase_observation_cardinality_next<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: u64) {
        assert!(arg2 < 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::max_observation_cardinality(), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::invalid_observation_cardinality());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::increase_observation_cardinality_next<T0, T1>(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ProtocolFeeCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v2);
        0x2::transfer::transfer<ProtocolFeeCap>(v1, v2);
    }

    public entry fun initialize_pool_reward<T0, T1, T2>(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg9));
        assert!(v0 || 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg9)), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        let v1 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::get_type_string<T2>();
        assert!(v1 != 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::blue_reward_type() || v0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        assert!(arg7 == 0x2::coin::value<T2>(&arg4), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::reward_amount_and_provided_balance_do_not_match());
        assert!(arg2 > 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::timestamp_seconds(arg8), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::invalid_timestamp());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::add_reward_info<T0, T1, T2>(arg1, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::default_reward_info(v1, arg5, arg6, arg2));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg4), arg3);
    }

    public entry fun remove_reward_manager(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: address) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::remove_reward_manager(arg1, arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_reward_manager_update_event(arg2, false);
    }

    public entry fun set_pool_creation_fee<T0>(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::get_config_id(arg1);
        let v1 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::pool_creation_fee_dynamic_key();
        let v2 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::get_type_string<T0>();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v0, v1)) {
            0x2::dynamic_field::add<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(v0, v1, 0x2::table::new<0x1::string::String, u64>(arg3));
        };
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::table::Table<0x1::string::String, u64>>(v0, v1);
        if (!0x2::table::contains<0x1::string::String, u64>(v3, v2)) {
            0x2::table::add<0x1::string::String, u64>(v3, v2, 0);
        };
        let v4 = 0x2::table::borrow_mut<0x1::string::String, u64>(v3, v2);
        *v4 = arg2;
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_pool_creation_fee_update_event(v2, *v4, arg2);
    }

    public entry fun set_pool_manager<T0, T1>(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::set_manager<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun transer_admin_cap(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: AdminCap, arg2: address) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_admin_cap_transfer_event(arg2);
    }

    public entry fun transer_protocol_fee_cap(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: ProtocolFeeCap, arg2: address) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        0x2::transfer::transfer<ProtocolFeeCap>(arg1, arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_protocol_fee_cap_transfer_event(arg2);
    }

    public entry fun update_pool_pause_status<T0, T1>(arg0: &AdminCap, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: bool) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg1);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_pause_status<T0, T1>(arg2, arg3);
    }

    public entry fun update_pool_reward_emission<T0, T1, T2>(arg0: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_version(arg0);
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg6));
        assert!(v0 || 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg6)), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        assert!(0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::get_type_string<T2>() != 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::blue_reward_type() || v0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::not_authorized());
        assert!(arg4 == 0x2::coin::value<T2>(&arg3), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::reward_amount_and_provided_balance_do_not_match());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_reward_infos<T0, T1>(arg1, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::timestamp_seconds(arg5));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg3), arg2);
    }

    public entry fun update_protocol_fee_share<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg2: u64) {
        assert!(arg2 <= 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::constants::max_protocol_fee_share(), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::invalid_protocol_fee_share());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::set_protocol_fee_share<T0, T1>(arg1, arg2);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_protocol_fee_share_updated_event(0x2::object::id<0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>>(arg1), 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::protocol_fee_share<T0, T1>(arg1), arg2, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::increase_sequence_number<T0, T1>(arg1));
    }

    public entry fun update_supported_version(arg0: &AdminCap, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig) {
        let (v0, v1) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::increase_version(arg1);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::events::emit_supported_version_update_event(v0, v1);
    }

    // decompiled from Move bytecode v6
}

