module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_system {
    public fun dapp_key<T0: copy + drop>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun set_pausable(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_admin(arg0, arg1) == 0x2::tx_context::sender(arg3));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_pausable(arg0, arg1, arg2, arg3);
    }

    public fun delete_record<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: T0, arg2: vector<vector<u8>>, arg3: 0x1::ascii::String) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<T0>(arg0, arg1, arg2, arg3);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
    }

    public fun ensure_has_not_record<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<T0>(arg0, arg1, arg2);
    }

    public fun ensure_has_record<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<T0>(arg0, arg1, arg2);
    }

    public fun get_field<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: u8) : vector<u8> {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<T0>(arg0, arg1, arg2, arg3)
    }

    public fun get_record<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : vector<u8> {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<T0>(arg0, arg1, arg2)
    }

    public fun has_record<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>) : bool {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<T0>(arg0, arg1, arg2)
    }

    public fun set_field<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: T0, arg2: 0x1::ascii::String, arg3: vector<vector<u8>>, arg4: u8, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg5);
        charge_fee(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>(), arg3, v0, 1, arg6);
    }

    public fun set_record<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: T0, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: 0x1::ascii::String, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        charge_fee(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>(), arg2, arg3, 1, arg6);
    }

    public fun accept_ownership(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, arg1);
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_pending_admin(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_pending_ownership_transfer_error(v0 != @0x0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(v0 == 0x2::tx_context::sender(arg2));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_admin(arg0, arg1, v0, arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_pending_admin(arg0, arg1, @0x0, arg2);
    }

    public(friend) fun calculate_bytes_size_and_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u256) : (u256, u256) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::get_struct(arg0, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg2)) {
            v1 = v1 + 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg2, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg3)) {
            v1 = v1 + 0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg3, v3));
            v3 = v3 + 1;
        };
        ((v1 as u256) * arg4, ((v1 as u256) * 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::byte_fee(&v0) + 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::base_fee(&v0)) * arg4)
    }

    public(friend) fun charge_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = calculate_bytes_size_and_fee(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::get_struct(arg0, arg1);
        let v3 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::total_recharged(&v2);
        let v4 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::free_credit(&v2);
        if (v4 >= v1) {
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_free_credit(&mut v2, v4 - v1);
        } else {
            let v5 = v1 - v4;
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::insufficient_credit_error(v3 >= v5);
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_free_credit(&mut v2, 0);
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_total_recharged(&mut v2, v3 - v5);
        };
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_total_bytes_size(&mut v2, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::total_bytes_size(&v2) + v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_total_paid(&mut v2, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::total_paid(&v2) + v1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_total_set_count(&mut v2, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::total_set_count(&v2) + arg4);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::set_struct(arg0, arg1, v2, arg5);
    }

    public fun create_dapp<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: T0, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new();
        if (!0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::eq<T0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(&arg1, &v0)) {
            0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::dapp_already_initialized_error(!0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::has(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>()));
            initialize_metadata<T0>(arg0, arg2, arg3, arg4, arg5);
            initialize_fee_state<T0>(arg0, arg5);
        };
    }

    public fun delegate<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 101
    }

    public fun ensure_dapp_admin<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: address) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_admin(arg0, v0) == arg1);
    }

    public fun ensure_latest_version<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: u32) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::not_latest_version_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_version(arg0, v0) == arg1);
    }

    public fun ensure_not_pausable<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::dapp_already_paused_error(!0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_pausable(arg0, v0));
    }

    public(friend) fun initialize_dapp_proxy<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
    }

    public(friend) fun initialize_fee_state<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::get(arg0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::set(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>(), v1, v2, v0, 0, 0, 0, 0, arg1);
    }

    public(friend) fun initialize_metadata<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_package_id<T0>());
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>(), arg1, arg2, 0x1::ascii::string(b""), 0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<0x1::ascii::String>(), v0, 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg4), @0x0, 1, false, arg4);
    }

    public fun is_delegated<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub) : bool {
        abort 103
    }

    public fun propose_ownership(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_admin(arg0, arg1) == 0x2::tx_context::sender(arg3));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_pending_admin(arg0, arg1, arg2, arg3);
    }

    public fun recharge_credit<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: T0, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::get_admin(arg0));
        let v1 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::get_struct(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_total_recharged(&mut v1, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::total_recharged(&v1) + (0x2::coin::value<0x2::sui::SUI>(&arg2) as u256));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::set_struct(arg0, v0, v1, arg3);
    }

    public fun set_dapp_free_credit(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::ensure_has(arg0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_config::get_admin(arg0) == 0x2::tx_context::sender(arg3));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, arg1);
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::get_struct(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::update_free_credit(&mut v0, arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state::set_struct(arg0, arg1, v0, arg3);
    }

    public fun set_metadata(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<0x1::ascii::String>, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_admin(arg0, arg1) == 0x2::tx_context::sender(arg7));
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_struct(arg0, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::update_name(&mut v0, arg2);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::update_description(&mut v0, arg3);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::update_website_url(&mut v0, arg4);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::update_cover_url(&mut v0, arg5);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::update_partners(&mut v0, arg6);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_struct(arg0, arg1, v0, arg7);
    }

    public fun set_storage<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) {
        abort 100
    }

    public fun undelegate<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &mut 0x2::tx_context::TxContext) {
        abort 102
    }

    public(friend) fun upgrade_dapp<T0: copy + drop>(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: address, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::type_info::get_type_name_string<T0>();
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::ensure_has(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::no_permission_error(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_admin(arg0, v0) == 0x2::tx_context::sender(arg3));
        let v1 = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_package_ids(arg0, v0);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::invalid_package_id_error(!0x1::vector::contains<address>(&v1, &arg1));
        0x1::vector::push_back<address>(&mut v1, arg1);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::errors::invalid_version_error(arg2 > 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::get_version(arg0, v0));
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_package_ids(arg0, v0, v1, arg3);
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_metadata::set_version(arg0, v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

