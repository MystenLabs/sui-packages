module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::exchange {
    entry fun set_account_type(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_account_type(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_type(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_account_type(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v2), v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_account_type_updated_event(v2, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_fee_tier(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, v4, v5, _, v7) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_fee_tier(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_account_fee_tier(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v7 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"fee"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_fee_tier(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v2), v3, v4, v5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_fee_tier_updated_event(v2, v3, v4, v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    public entry fun deposit_to_asset_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(arg2 != @0x0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero_address());
        assert!(0x2::coin::value<T0>(arg4) > 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero());
        let (v0, v1) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::deposit_to_asset_bank<T0>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg0), arg1, arg2, arg3, arg4, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_asset_bank_deposit_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg0), arg1, 0x2::tx_context::sender(arg5), arg2, v1, v0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg0));
    }

    entry fun apply_funding_rate(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg3);
        let (v0, _, v2, _, v4, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_apply_funding_rate(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v4 >= arg3 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v6 = if (v5 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()) {
            0x1::option::none<0x1::string::String>()
        } else {
            0x1::option::some<0x1::string::String>(v5)
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::apply_funding_rate(arg0, v6, v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg1, arg2);
    }

    entry fun authorize_liquidator(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_authorize_liquidator(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_authorizing_liquidator(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::authorize_liquidator(arg0, v2, v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_bankrupt_liquidator_authorized_event(v2, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun prune_table(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_prune_table(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_pruning_table(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::prune_table(arg0, v2, v3, arg4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_table_pruned_event(v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_gas_fee(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, _, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_gas_fee(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_fee(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v4 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::set_gas_fee(arg0, v2);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_gas_fee_updated_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_gas_pool(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, _, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_gas_pool(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_gas_pool(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v2 != @0x0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero_address());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v4 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::set_gas_pool(arg0, v2);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_gas_pool_updated_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_gas_pool(arg0), v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun adjust_leverage(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg6);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_adjust_leverage(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v7 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        let v8 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v1);
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Leverage Adjustment");
        assert!(v9 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v8, v9), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v2);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v10) && !0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v10), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        let v11 = if (v3 > 0) {
            if (v3 <= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_div(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_imr(v10))) {
                v3 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_leverage());
        let v12 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(v8);
        let (v13, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v12, v2);
        assert!(v13, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::position_does_not_exist());
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v8, v2);
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v8, v2);
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let (v19, v20) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_mutable_position_for_perpetual(&mut v15, v2, true);
        let (_, v22, v23, v24, v25, v26, _, v28) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(v19);
        let v29 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_div(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v22, v23), v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v19, v22, v23, v29, v3, v24, 0);
        if (v3 > v25) {
            verify_notion(v19, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(v6, v2)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v10), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v8), false, 0);
        };
        let v30 = v29 + v28;
        if (v30 >= v26) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v18, v30 - v26, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin_to_asset_vector(&mut v16, v30 - v26, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v6, v7, &v18, &v17, &v18, &v17, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_withdraw(), true);
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v16, v26 - v30, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin_to_asset_vector(&mut v18, v26 - v30, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v6, v7, &v16, &v15, &v16, &v15, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_adjust_leverage(), true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v1), &v18, &v15, v20, true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_leverage_adjusted_event(v1, *v19, v18, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun adjust_margin(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg6);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, _, v6) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_adjust_margin(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v6 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v7 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v2);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v7) && !0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v7), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        let v8 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        let v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v1);
        let v11 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Margin Adjustment");
        assert!(v11 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v10, v11), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v12 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(v10);
        let (v13, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v12, v2);
        assert!(v13, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::position_does_not_exist());
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v10, v2);
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v10, v2);
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v10, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v10, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let (v19, v20) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_mutable_position_for_perpetual(&mut v15, v2, true);
        let (_, v22, v23, v24, v25, v26, _, v28) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(v19);
        let v29 = v26;
        let v30 = if (v3) {
            let v31 = if (v28 > v4) {
                v28 - v4
            } else {
                v29 = v26 + v4 - v28;
                0
            };
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v19, v22, v23, v29, v25, v24, v31);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v18, v4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v8, v9, &v18, &v17, &v18, &v17, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_withdraw(), true);
            *v19
        } else {
            let v32 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::mul_div_uint(v22, v23, v25);
            let v33 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
            let v34 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::compute_position_pnl(v33, v19);
            let v35 = if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gt_uint(v34, 0)) {
                0
            } else {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::value(v34)
            };
            let v36 = if (v32 < v26) {
                v26 - v32
            } else {
                0
            };
            if (v35 < v36) {
                v36 = v36 - v35;
            } else {
                v36 = 0;
            };
            assert!(v4 <= v36, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_margin());
            let v37 = v26 - v4;
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v19, v22, v23, v37, v25, v24, v28);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin_to_asset_vector(&mut v18, v4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            let v38 = 0x1::vector::empty<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>();
            0x1::vector::push_back<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::DepositedAsset>(&mut v38, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::create_deposited_asset(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v37));
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v33, v9, &v38, &v15, &v16, &v15, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_remove_margin(), true);
            *v19
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v1), &v18, &v15, v20, true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_margin_adjusted_event(v1, v4, v3, v30, v18, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun assert_user_only_has_isolated_or_cross_position(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account, arg1: 0x1::string::String, arg2: bool) {
        let v0 = if (arg2) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_cross_positions(arg0)
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(arg0)
        };
        let v1 = v0;
        let (v2, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v1, arg1);
        assert!(!v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::opening_both_isolated_cross_positions_not_allowed());
    }

    entry fun authorize_account(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_authorization(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::create_user_account(arg0, v1);
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Authorize Account");
        assert!(v6 == @0x0 || v6 == v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v7 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v1);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_authorized_user(v7, v2, v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_authorized_accounts_updated_event(v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_authorized_accounts(v7), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_authorized_accounts(v7), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun batch_trade(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<address>, arg2: vector<address>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<address>, arg14: vector<address>, arg15: vector<0x1::string::String>, arg16: vector<u64>, arg17: vector<u64>, arg18: vector<u64>, arg19: vector<bool>, arg20: vector<bool>, arg21: vector<u64>, arg22: vector<u64>, arg23: vector<vector<u8>>, arg24: vector<vector<u8>>, arg25: vector<u64>, arg26: vector<0x1::string::String>, arg27: vector<u64>, arg28: vector<u8>, arg29: vector<u8>, arg30: u64) {
        batch_trade_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg24, arg25, arg26, arg27, 0x1::option::none<u64>(), arg28, arg29, arg30);
    }

    fun batch_trade_internal(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<address>, arg2: vector<address>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<vector<u8>>, arg12: vector<address>, arg13: vector<address>, arg14: vector<0x1::string::String>, arg15: vector<u64>, arg16: vector<u64>, arg17: vector<u64>, arg18: vector<bool>, arg19: vector<bool>, arg20: vector<u64>, arg21: vector<u64>, arg22: vector<vector<u8>>, arg23: vector<u64>, arg24: vector<0x1::string::String>, arg25: vector<u64>, arg26: 0x1::option::Option<u64>, arg27: vector<u8>, arg28: vector<u8>, arg29: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg27, arg29);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg24, arg25);
        let (v0, v1, v2, v3, v4, v5, v6) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_tables_from_ids(arg0);
        let v7 = 0x1::option::get_with_default<u64>(&arg26, v6);
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(&arg1)) {
            let v10 = *0x1::vector::borrow<vector<u8>>(&arg11, v9);
            let v11 = *0x1::vector::borrow<address>(&arg2, v9);
            let v12 = *0x1::vector::borrow<0x1::string::String>(&arg3, v9);
            let v13 = *0x1::vector::borrow<u64>(&arg4, v9);
            let v14 = *0x1::vector::borrow<u64>(&arg6, v9);
            let v15 = *0x1::vector::borrow<bool>(&arg7, v9);
            let v16 = *0x1::vector::borrow<bool>(&arg8, v9);
            let v17 = *0x1::vector::borrow<u64>(&arg10, v9);
            let v18 = *0x1::vector::borrow<vector<u8>>(&arg22, v9);
            let v19 = *0x1::vector::borrow<address>(&arg12, v9);
            let v20 = *0x1::vector::borrow<address>(&arg13, v9);
            let v21 = *0x1::vector::borrow<u64>(&arg17, v9);
            let v22 = *0x1::vector::borrow<bool>(&arg18, v9);
            let v23 = *0x1::vector::borrow<bool>(&arg19, v9);
            let v24 = *0x1::vector::borrow<u64>(&arg21, v9);
            let v25 = *0x1::vector::borrow<u64>(&arg23, v9);
            assert!(v11 != v20, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
            assert!(v12 == *0x1::vector::borrow<0x1::string::String>(&arg14, v9), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetuals_mismatch());
            assert!(v15 != v22, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::orders_must_be_opposite());
            assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::check_if_perp_exists(v2, v12), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetual_does_not_exists());
            assert!(v19 == *0x1::vector::borrow<address>(&arg1, v9) && v19 == v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
            let v26 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_table(v2, v12);
            let v27 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v26);
            let v28 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v26);
            let v29 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_fee_pool_address(v26);
            let v30 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_accounts_table(v1, v11);
            let v31 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_accounts_table(v1, v20);
            pre_trade_checks(v2, v3, v30, v26, v16, v15, v25);
            pre_trade_checks(v2, v3, v31, v26, v23, v22, v25);
            validate_order(v30, v16, v15, false, v13, *0x1::vector::borrow<u64>(&arg5, v9), *0x1::vector::borrow<u64>(&arg9, v9), v17, v25, v13, v14, arg29, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::filled_order_quantity_from_table(v0, v10), v26);
            validate_order(v31, v23, v22, true, *0x1::vector::borrow<u64>(&arg15, v9), *0x1::vector::borrow<u64>(&arg16, v9), *0x1::vector::borrow<u64>(&arg20, v9), v24, v25, v13, v21, arg29, 0x1::option::none<vector<u8>>(), 0x1::option::none<vector<u8>>(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::filled_order_quantity_from_table(v0, v18), v26);
            let (v32, v33, v34, v35, v36, v37, v38, _, _, v41, v42) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths_internal(v2, v3, v26, v30, v13, v25, v14, v15, v16, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>(), v7);
            let v43 = v38;
            let v44 = v37;
            let v45 = v35;
            let (v46, v47, v48, v49, v50, v51, v52, _, v54, v55, v56) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths_internal(v2, v3, v26, v31, v13, v25, v21, v22, v23, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::some<bool>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::is_first_fill_in_table(v0, v18)), v7);
            let v57 = v52;
            let v58 = v51;
            let v59 = v49;
            verify_notion(&v44, v28, v27, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v30), v42, v41);
            verify_notion(&v58, v28, v27, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v31), v56, v55);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v1, v11), &v43, &v45, v36, v16);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v1, v20), &v57, &v59, v50, v23);
            let v60 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v1, v29);
            if (v32 > 0) {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v60, v34, v33);
            };
            if (v46 > 0) {
                0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v60, v48, v47);
            };
            v8 = v8 + v54;
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill_internal(v0, v10, v25, v17);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill_internal(v0, v18, v25, v24);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_trade_executed_event(v12, v11, v20, v10, v18, v44, v58, v43, v57, v32, v46, v33, v47, v34, v48, v25, v13, v22, v54, arg28, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
            v9 = v9 + 1;
        };
        let v61 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v1, v4);
        if (v8 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v61, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v8);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg27, arg28);
    }

    entry fun batch_trade_with_provided_gas_fee(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<address>, arg2: vector<address>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<vector<u8>>, arg12: vector<vector<u8>>, arg13: vector<address>, arg14: vector<address>, arg15: vector<0x1::string::String>, arg16: vector<u64>, arg17: vector<u64>, arg18: vector<u64>, arg19: vector<bool>, arg20: vector<bool>, arg21: vector<u64>, arg22: vector<u64>, arg23: vector<vector<u8>>, arg24: vector<vector<u8>>, arg25: vector<u64>, arg26: vector<0x1::string::String>, arg27: vector<u64>, arg28: u64, arg29: vector<u8>, arg30: vector<u8>, arg31: u64) {
        batch_trade_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg24, arg25, arg26, arg27, 0x1::option::some<u64>(arg28), arg29, arg30, arg31);
    }

    entry fun close_position(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_close_position(arg1);
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v1);
        let v7 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Close Position For Delisted Market");
        assert!(v7 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v6, v7), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v8 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v2);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v8), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::not_delisted());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v8), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position(v6, v2, v3);
        let (_, v11, _, v13, v14, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v9);
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v8);
        let (_, _, _, v22, v23, v24, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v2, v1, v18, v11, v14, !v13, v3, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_close_position(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        assert!(v24 == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::bad_debt());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_delisted_market_position_closed_event(v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg6), v1, v22, v23, v18, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun deleverage(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, _, v10) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_adl(arg1);
        assert!(v2 != v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_adl(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"adl") == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v11 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v6);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v11) && !0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v11), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v10 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(v8 >= arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::expired());
        let v12 = if (v7 >= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_min_trade_qty(v11)) {
            if (v7 <= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_max_trade_qty(v11)) {
                v7 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_step_size(v11) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        let v13 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v14 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v2);
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v3);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_bankrupt(v15, v6, v4, v13, v14), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::not_bankrupt());
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position(v15, v6, v4);
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position(v16, v6, v5);
        let (_, v20, _, v22, v23, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v17);
        let (_, v28, v29, v30, v31, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v18);
        assert!(v30 != v22, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::orders_must_be_opposite());
        assert!(v7 <= v20 && v7 <= v28, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_position_size());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gt_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::compute_position_pnl(v13, &v18), 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::negative_pnl());
        pre_trade_checks(v13, v14, v16, v11, v5, !v30, v7);
        let (v35, _, v37, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_bankruptcy_and_purchase_price(v15, v6, v4, v13, v14);
        let v40 = if (v30) {
            if (v35 > v29) {
                v35
            } else {
                v29
            }
        } else if (v35 < v29) {
            v35
        } else {
            v29
        };
        let v41 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v7, v40), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::adl_fee_rate());
        let (_, _, _, v45, v46, _, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v6, v2, v40, v7, v23, !v22, v4, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_deleverage(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let (_, _, _, v54, v55, _, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v6, v3, v40, v7, v31, !v30, v5, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_deleverage(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let v60 = v55;
        if (v41 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v60, v41, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_insurance_pool_address(v11)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v41);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_adl_executed_event(v6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg6), v2, v3, v45, v54, v46, v60, v7, v35, v37, !v30, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0), v40, v41);
    }

    entry fun deposit_to_internal_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: u128, arg3: vector<u8>) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_current_ids_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1);
        let (v1, v2, v3, v4, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::remove_deposit<T0>(v0, arg2);
        let v6 = v3;
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::merge_coin_into_balance<T0>(v0, v5, v4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_deposit(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_address(arg1), v4, v1, v2, v3, arg2, false), arg3);
        let v7 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_accounts_table_from_ids(arg0);
        if (!0x2::table::contains<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v7, v2)) {
            0x2::table::add<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v7, v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::initialize(v2));
        };
        let v8 = 0x2::table::borrow_mut<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v7, v2);
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let v10 = 0;
        while (v10 < 0x1::vector::length<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position>(&v9) && v6 > 0) {
            let v11 = 0x1::vector::borrow_mut<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position>(&mut v9, v10);
            let (_, v13, v14, v15, v16, v17, _, v19) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(v11);
            let v20 = if (v6 >= v19) {
                v6 = v6 - v19;
                0
            } else {
                let v20 = v19 - v6;
                v6 = 0;
                v20
            };
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v11, v13, v14, v17, v16, v15, v20);
            v10 = v10 + 1;
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account_cross_positions(v8, v9);
        if (v6 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v8, v4, v6);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_deposit_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v2, v4, v6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets(v8), arg3, arg2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun liquidate(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, _, v12) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_liquidation(arg1);
        let v13 = v5;
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_liquidate(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(v2 != v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v12 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(v10 >= arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::expired());
        let v14 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v2);
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v3);
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v15);
        assert_user_only_has_isolated_or_cross_position(v15, v4, !v7);
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_account_position(v14, v4, v6);
        let v18 = if (v6) {
            v4
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v19 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v14, v18);
        let (_, v21, _, v23, v24, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v17);
        let v28 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v4);
        let v29 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_insurance_pool_ratio(v28);
        let v30 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v28);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v28), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        if (!v8 && v5 > v21) {
            v13 = v21;
        };
        assert!(v13 <= v21, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::all_or_nothing());
        assert!(v13 >= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_min_trade_qty(v28) && v13 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_step_size(v28) == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        assert!(!0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_isolated_only(v28) || !v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::isolated_only_market());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v15, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::is_whitelisted_liquidator(arg0, v3), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::unauthorized_liquidator());
        let v31 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v32 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_liquidateable(v14, v4, v6, v31, v32), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::not_liquidateable());
        pre_trade_checks(v31, v32, v15, v28, !v7, v23, v13);
        let (v33, v34, v35, v36, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_bankruptcy_and_purchase_price(v14, v4, v6, v31, v32);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_most_positive_pnl(&v19, v31, v4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_position_for_liquidation());
        let (v38, v39) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::calculate_liquidation_premium_portions(v23, v34, v35, v13, v36, v29);
        if (v39 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_insurance_pool_address(v28)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v39);
        };
        let (_, _, _, v43, v44, v45, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v4, v2, v34, v13, v24, !v23, v6, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_liquidate(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let v49 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v38, true), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v45, true));
        let (_, _, _, v53, v54, _, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v4, v3, v35, v13, v9, v23, !v7, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_liquidate(), 0x1::option::some<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(v49), 0x1::option::none<bool>());
        let v59 = v53;
        verify_notion(&v59, v35, v30, v16, false, 0);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_liquidation_executed_event(v4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg6), v2, v3, v43, v59, v44, v54, v13, v34, v33, v35, v23, v49, v39, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun pre_trade_checks(arg0: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>, arg1: &0x2::table::Table<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::Asset>, arg2: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account, arg3: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual, arg4: bool, arg5: bool, arg6: u64) {
        let v0 = if (arg4) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_symbol(arg3)
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(arg2, v0);
        let v2 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(arg2, v0);
        let v3 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_account_value(&v2, &v1, arg0, arg1);
        if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_total_margin_required(&v1, arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::imr_threshold())), 0)) {
            let (v4, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_symbol(arg3));
            assert!(v4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(1));
            let (_, v7, _, v9, _, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(0x1::vector::borrow<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position>(&v1, v5));
            assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_reducing_trade(v9, v7, arg5, arg6), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(1));
        };
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gte_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_total_margin_required(&v1, arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::mmr_threshold())), 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(3));
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gte_uint(v3, 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(4));
    }

    entry fun remove_tainted_asset<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: u128, arg3: vector<u8>) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        let (v0, v1, v2, v3, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::remove_deposit<T0>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_deposit(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_address(arg1), v3, v0, v1, v2, arg2, true), arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_removed_tainted_deposit_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v0, v1, v3, v2, arg2, arg3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_funding_rate(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg1, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_funding_rate(arg1);
        let v6 = v3;
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::payload_type_setting_funding_rate(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_payload_type());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"funding"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(v2 % 3600000 == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_funding_time());
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = 0x1::vector::empty<u64>();
        while (0x1::vector::length<vector<u8>>(&v6) > 0) {
            let (v9, v10, v11, v12) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_market_details(0x1::vector::pop_back<vector<u8>>(&mut v6));
            let v13 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_perpetual_from_ids(arg0, v9);
            assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v13) && !0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v13), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::update_funding_rate(v13, v10, v11, v2);
            0x1::vector::push_back<0x1::string::String>(&mut v7, v9);
            0x1::vector::push_back<u64>(&mut v8, v12);
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_funding_rate_update_event(v9, v10, v11, v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, v7, v8);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
    }

    entry fun trade(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<0x1::string::String>, arg7: vector<u64>, arg8: vector<u8>, arg9: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_trade(arg1, arg2, arg5, arg9);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, v0, arg9);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg6, arg7);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, _, v12) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_order(arg1);
        let (v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, _, v24) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_order(arg2);
        let (v25, v26, v27, v28, v29, v30, v31) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_tables_from_ids(arg0);
        assert!(v3 != v15, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
        assert!(v4 == v16, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetuals_mismatch());
        assert!(v8 != v20, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::orders_must_be_opposite());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::check_if_perp_exists(v27, v4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetual_does_not_exists());
        assert!(v14 == v2 && v14 == v30, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        let v32 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_table(v27, v4);
        let v33 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v32);
        let v34 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v32);
        let v35 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_fee_pool_address(v32);
        let v36 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_accounts_table(v26, v3);
        let v37 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_accounts_table(v26, v15);
        pre_trade_checks(v27, v28, v36, v32, v9, v8, arg5);
        pre_trade_checks(v27, v28, v37, v32, v21, v20, arg5);
        validate_order(v36, v9, v8, false, v5, v6, v10, v12, arg5, v5, v7, arg9, 0x1::option::some<vector<u8>>(arg1), 0x1::option::some<vector<u8>>(arg3), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::filled_order_quantity_from_table(v25, v1), v32);
        validate_order(v37, v21, v20, true, v17, v18, v22, v24, arg5, v5, v19, arg9, 0x1::option::some<vector<u8>>(arg2), 0x1::option::some<vector<u8>>(arg4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::filled_order_quantity_from_table(v25, v13), v32);
        let (v38, v39, v40, v41, v42, v43, v44, _, _, v47, v48) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths_internal(v27, v28, v32, v36, v5, arg5, v7, v8, v9, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>(), v31);
        let v49 = v44;
        let v50 = v43;
        let v51 = v41;
        let (v52, v53, v54, v55, v56, v57, v58, _, v60, v61, v62) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths_internal(v27, v28, v32, v37, v5, arg5, v19, v20, v21, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::some<bool>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::is_first_fill_in_table(v25, v13)), v31);
        let v63 = v58;
        let v64 = v57;
        let v65 = v55;
        verify_notion(&v50, v34, v33, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v36), v48, v47);
        verify_notion(&v64, v34, v33, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_institution(v37), v62, v61);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v26, v3), &v49, &v51, v42, v9);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v26, v15), &v63, &v65, v56, v21);
        let v66 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v26, v35);
        if (v38 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v66, v40, v39);
        };
        if (v52 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v66, v54, v53);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill_internal(v25, v1, arg5, v12);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill_internal(v25, v13, arg5, v24);
        let v67 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_accounts_table(v26, v29);
        if (v60 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v67, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v60);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, v0, arg8);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_trade_executed_event(v4, v3, v15, v1, v13, v50, v64, v49, v63, v38, v52, v39, v53, v40, v54, arg5, v5, v20, v60, arg8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun validate_order(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account, arg1: bool, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x1::option::Option<vector<u8>>, arg13: 0x1::option::Option<vector<u8>>, arg14: u64, arg15: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual) {
        assert!(arg7 >= arg11 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert_user_only_has_isolated_or_cross_position(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_symbol(arg15), arg1);
        let (_, _, _, _, v4, v5, v6, v7, v8, v9, _, v11, v12, _, _, _, _, _, _, v19, v20, v21, v22, _, v24) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::perpetual_values(arg15);
        assert!(arg11 >= v19 && v21, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        assert!(!v20, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetual_delisted());
        let v25 = if (arg8 >= v6) {
            if (arg8 <= v7) {
                arg8 % v4 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v25, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        let v26 = if (arg9 >= v8) {
            if (arg9 <= v9) {
                arg9 % v5 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v26, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_trade_price());
        let v27 = if (arg2) {
            v22 + 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v22, v11)
        } else {
            v22 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v22, v12)
        };
        assert!(!arg3 || arg2 && arg9 <= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::round_to_tick_size_based_on_direction(v27, v5, arg2) || arg9 >= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::round_to_tick_size_based_on_direction(v27, v5, arg2), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::mtb_breached());
        assert!(arg6 >= arg11, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::expired());
        if (0x1::option::is_some<vector<u8>>(&arg12) && 0x1::option::is_some<vector<u8>>(&arg13)) {
            let v28 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(0x1::option::extract<vector<u8>>(&mut arg12), 0x1::option::extract<vector<u8>>(&mut arg13), b"Bluefin Pro Order");
            assert!(v28 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(arg0, v28), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        };
        assert!(arg4 == 0 || arg2 && arg9 <= arg4 || arg9 >= arg4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_fill_price());
        assert!(arg14 + arg8 <= arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::order_overfill());
        assert!(!v24 || arg1 == true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::isolated_only_market());
        assert!(!arg1 || arg10 > 0 && arg10 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_leverage());
    }

    fun verify_notion(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg1: u64, arg2: vector<u64>, arg3: bool, arg4: bool, arg5: u64) {
        let (_, v1, _, v3, _, _, v6, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(arg0);
        if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_reduced_position(arg4, arg5, v3, v1)) {
            return
        };
        let v8 = 0x1::vector::length<u64>(&arg2);
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::round(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::calculate_effective_leverage(arg0, 0x1::option::none<u64>()), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint());
        let v10 = v9;
        if (v9 == 0) {
            v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint();
        };
        let v11 = v10 / 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint();
        let v12 = v11;
        if (v11 > v8) {
            v12 = v8;
        };
        let v13 = if (v6) {
            v12 - 1
        } else if (arg3) {
            0
        } else {
            v8 - 1
        };
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v1, arg1) <= *0x1::vector::borrow<u64>(&arg2, v13), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::max_allowed_oi_open());
    }

    entry fun withdraw_from_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_current_ids_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg7);
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg1);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg4, arg5);
        let v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v2 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        let (v3, v4, v5, v6, _, v8) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_withdrawal(arg2);
        assert!(v6 > 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::can_not_be_zero());
        assert!(v8 >= arg7 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0x2::object::id_from_address(v3) == v0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_eds());
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg2, arg3, b"Bluefin Pro Withdrawal");
        assert!(v9 == @0x0 || v9 == v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v5);
        let v11 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v10, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let v12 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v10, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        assert!(v6 <= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_max_withdrawable_amount(&v11, &v12, v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_funds());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v11, v6, v4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v1, v2, &v11, &v12, &v11, &v12, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_withdraw(), true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account_cross_assets(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v5), v11);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::withdraw_from_asset_bank<T0>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1), v4, v5, v6, arg8);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg3, arg6);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_withdraw_event(v0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v5, v4, v6, v11, arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    // decompiled from Move bytecode v6
}

