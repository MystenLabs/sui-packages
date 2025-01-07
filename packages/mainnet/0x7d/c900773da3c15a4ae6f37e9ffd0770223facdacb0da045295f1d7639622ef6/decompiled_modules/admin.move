module 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolFeeCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_reward_manager(arg0: &AdminCap, arg1: &mut 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::GlobalConfig, arg2: address) {
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::set_reward_manager(arg1, arg2);
    }

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::GlobalConfig, arg1: &mut 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_version(arg0);
        let v0 = false;
        let v1 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg4));
        if (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::get_type_string<T2>() == 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::blue_reward_type()) {
            v0 = true;
            assert!(v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        };
        assert!(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg4)) || v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::update_reward_infos<T0, T1>(arg1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::timestamp_seconds(arg3));
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2, 0, v0);
    }

    public entry fun claim_protocol_fee<T0, T1>(arg0: &ProtocolFeeCap, arg1: &0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::GlobalConfig, arg2: &mut 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_version(arg1);
        let v0 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::get_protocol_fee_for_coin_a<T0, T1>(arg2);
        let v1 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::get_protocol_fee_for_coin_b<T0, T1>(arg2);
        assert!(arg3 <= v0, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::insufficient_amount());
        assert!(arg4 <= v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::insufficient_amount());
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::set_protocol_fee_amount<T0, T1>(arg2, v0 - arg3, v1 - arg4);
        let (v2, v3) = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::withdraw_balances<T0, T1>(arg2, arg3, arg4);
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::transfer_balance<T0>(v2, arg5, arg6);
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::transfer_balance<T1>(v3, arg5, arg6);
        let (v4, v5) = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::coin_reserves<T0, T1>(arg2);
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::events::emit_protocol_fee_collected(0x2::object::id<0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::Pool<T0, T1>>(arg2), 0x2::tx_context::sender(arg6), arg5, arg3, arg4, v4, v5, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::sequence_number<T0, T1>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ProtocolFeeCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v2);
        0x2::transfer::transfer<ProtocolFeeCap>(v1, v2);
    }

    public entry fun initialize_pool_reward<T0, T1, T2>(arg0: &0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::GlobalConfig, arg1: &mut 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T2>, arg5: 0x1::string::String, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_version(arg0);
        let v0 = false;
        let v1 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg9));
        if (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::get_type_string<T2>() == 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::blue_reward_type()) {
            v0 = true;
            assert!(v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        };
        assert!(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg9)) || v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        assert!(arg2 > 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::timestamp_seconds(arg8), 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::invalid_timestamp());
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::add_reward_info<T0, T1, T2>(arg1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::default_reward_info(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::get_type_string<T2>(), arg5, arg6, arg2));
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg4), arg3, arg7, v0);
    }

    public entry fun transer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::events::emit_admin_cap_transfer_event(arg1);
    }

    public entry fun transer_protocol_fee_cap(arg0: ProtocolFeeCap, arg1: address) {
        0x2::transfer::transfer<ProtocolFeeCap>(arg0, arg1);
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::events::emit_protocol_fee_cap_transfer_event(arg1);
    }

    public entry fun update_pool_reward_emission<T0, T1, T2>(arg0: &0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::GlobalConfig, arg1: &mut 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::Pool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_version(arg0);
        let v0 = false;
        let v1 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::config::verify_reward_manager(arg0, 0x2::tx_context::sender(arg6));
        if (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::get_type_string<T2>() == 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::blue_reward_type()) {
            v0 = true;
            assert!(v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        };
        assert!(0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::verify_pool_manager<T0, T1>(arg1, 0x2::tx_context::sender(arg6)) || v1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::not_authorized());
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::update_reward_infos<T0, T1>(arg1, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::utils::timestamp_seconds(arg5));
        0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(arg3), arg2, arg4, v0);
    }

    // decompiled from Move bytecode v6
}

