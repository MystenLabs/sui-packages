module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::exchange {
    entry fun set_account_type(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_account_type(arg1);
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_account_type(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v2), v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_account_type_updated_event(v2, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_fee_tier(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, v4, v5, _, v7) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_fee_tier(arg1);
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v7 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"fee"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_fee_tier(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v2), v3, v4, v5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_fee_tier_updated_event(v2, v3, v4, v5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun deposit_to_asset_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg1: 0x1::string::String, arg2: address, arg3: u64, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) {
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
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_authorize_liquidator(arg1);
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::authorize_liquidator(arg0, v2, v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_bankrupt_liquidator_authorized_event(v2, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun prune_table(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_prune_table(arg1);
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::prune_table(arg0, v2, v3, arg4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_table_pruned_event(v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_gas_fee(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, _, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_gas_fee(arg1);
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v4 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_operator_address(arg0, b"guardian"), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::set_gas_fee(arg0, v2);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_gas_fee_updated_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_gas_pool(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, _, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_gas_pool(arg1);
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
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg6);
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
        let (_, v22, v23, v24, _, v26, _, v28) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(v19);
        let v29 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_div(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v22, v23), v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v19, v22, v23, v29, v3, v24, 0);
        verify_notion(v19, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(0x2::table::borrow<0x1::string::String, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual>(v6, v2)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v10));
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
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg6);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, _, v6) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_adjust_margin(arg1);
        let v7 = v4;
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v6 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v8 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v2);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v8) && !0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_delist_status(v8), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v10 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        let v11 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v1);
        let v12 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Margin Adjustment");
        assert!(v12 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v11, v12), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        let v13 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(v11);
        let (v14, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v13, v2);
        assert!(v14, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::position_does_not_exist());
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v11, v2);
        let v17 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v11, v2);
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v11, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let v19 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v11, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
        let (v20, v21) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_mutable_position_for_perpetual(&mut v16, v2, true);
        let (_, v23, v24, v25, v26, v27, _, v29) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(v20);
        if (v3) {
            let v30 = if (v29 > v4) {
                v7 = 0;
                v29 - v4
            } else {
                v7 = v4 - v29;
                0
            };
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v20, v23, v24, v27 + v7, v26, v25, v30);
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_position_values(v20, v23, v24, v27 - v4, v26, v25, v29);
        };
        if (v3) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v19, v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin_to_asset_vector(&mut v17, v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v9, v10, &v19, &v18, &v19, &v18, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_withdraw(), true);
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v17, v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin_to_asset_vector(&mut v19, v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string());
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v9, v10, &v17, &v16, &v17, &v16, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_remove_margin(), true);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v1), &v19, &v16, v21, true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_margin_adjusted_event(v1, v7, v3, *v20, v19, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun assert_user_only_has_isolated_or_cross_position(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: address, arg2: 0x1::string::String, arg3: bool) {
        let v0 = if (arg3) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_cross_positions(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, arg1))
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, arg1))
        };
        let v1 = v0;
        let (v2, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v1, arg2);
        assert!(!v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::opening_both_isolated_cross_positions_not_allowed());
    }

    entry fun authorize_account(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_authorization(arg1);
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg4 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Authorize Account");
        assert!(v6 == @0x0 || v6 == v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::set_authorized_user(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v1), v2, v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_user_authorized_event(v1, v2, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
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
        assert!(v0 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v5 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v9 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position(v6, v2, v3);
        let (_, v11, _, v13, v14, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v9);
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v8);
        let (_, _, _, v22, v23, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v2, v1, v18, v11, v14, !v13, v3, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_close_position(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_delisted_market_position_closed_event(v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg6), v1, v22, v23, v18, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun deleverage(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, _, v10) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_adl(arg1);
        assert!(v2 != v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
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
        let (_, v28, _, v30, v31, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v18);
        assert!(v30 != v22, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::orders_must_be_opposite());
        assert!(v7 <= v20 && v7 <= v28, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::insufficient_position_size());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gt_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::compute_position_pnl(v13, &v18), 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::negative_pnl());
        pre_trade_checks(arg0, v3, v6, v5, !v30, v7);
        let (v35, _, v37, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_bankruptcy_and_purchase_price(v15, v6, v4, v13, v14);
        let (_, _, _, v43, v44, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v6, v2, v35, v7, v23, !v22, v4, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_deleverage(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let (_, _, _, v50, v51, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v6, v3, v35, v7, v31, !v30, v5, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_deleverage(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_adl_executed_event(v6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg6), v2, v3, v43, v50, v44, v51, v7, v35, v37, !v30, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun deposit_to_internal_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: u128, arg3: vector<u8>) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_current_ids_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1);
        let (v1, v2, v3, v4, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::remove_deposit<T0>(v0, arg2);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::merge_coin_into_balance<T0>(v0, v5, v4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_deposit(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_address(arg1), v4, v1, v2, v3, arg2, false), arg3);
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_accounts_table_from_ids(arg0);
        if (!0x2::table::contains<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v6, v2)) {
            0x2::table::add<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v6, v2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::initialize(v2));
        };
        let v7 = 0x2::table::borrow_mut<address, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Account>(v6, v2);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v7, v4, v3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_deposit_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v2, v4, v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets(v7), arg3, arg2, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun liquidate(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<0x1::string::String>, arg4: vector<u64>, arg5: vector<u8>, arg6: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg3, arg4);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, _, v12) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_liquidation(arg1);
        let v13 = v5;
        assert_user_only_has_isolated_or_cross_position(arg0, v3, v4, !v7);
        assert!(v2 != v3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
        assert!(v1 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        assert!(v12 >= arg6 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        assert!(v10 >= arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::expired());
        let v14 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v2);
        let v15 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, v3);
        let v16 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_account_position(v14, v4, v6);
        let v17 = if (v6) {
            v4
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v18 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_positions_vector(v14, v17);
        let (_, v20, _, v22, v23, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(&v16);
        let v27 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v4);
        let v28 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_insurance_pool_ratio(v27);
        let v29 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v27);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_trading_status(v27), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        if (!v8 && v5 > v20) {
            v13 = v20;
        };
        assert!(v13 <= v20, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::all_or_nothing());
        let v30 = if (v13 >= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_min_trade_qty(v27)) {
            if (v13 <= 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_max_trade_qty(v27)) {
                v13 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_step_size(v27) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v30, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        assert!(!0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_isolated_only(v27) || !v7, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::isolated_only_market());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v15, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, v0)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::is_whitelisted_liquidator(arg0, v3), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::unauthorized_liquidator());
        let v31 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v32 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::is_liquidateable(v14, v4, v6, v31, v32), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::not_liquidateable());
        pre_trade_checks(arg0, v3, v4, !v7, v22, v13);
        let (v33, v34, v35, v36, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_bankruptcy_and_purchase_price(v14, v4, v6, v31, v32);
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_most_positive_pnl(&v18, v31, v4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_position_for_liquidation());
        let (v38, v39) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::calculate_liquidation_premium_portions(v22, v34, v35, v13, v36, v28);
        if (v39 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_insurance_pool_address(v27)), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v39);
        };
        let (_, _, _, v43, v44, v45, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v4, v2, v34, v13, v23, !v22, v6, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_liquidate(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let v47 = if (v38 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v38, true)
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::from(v45, false)
        };
        let (_, _, _, v51, v52, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v4, v3, v35, v13, v9, v22, !v7, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_liquidate(), 0x1::option::some<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(v47), 0x1::option::none<bool>());
        let v55 = v51;
        verify_notion(&v55, v35, v29);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg2, arg5);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_liquidation_executed_event(v4, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg6), v2, v3, v43, v55, v44, v52, v13, v34, v33, v35, v22, v47, v39, arg5, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun pre_trade_checks(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: address, arg2: 0x1::string::String, arg3: bool, arg4: bool, arg5: u64) {
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, arg1);
        let v1 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_table_from_ids(arg0);
        let v2 = if (arg3) {
            arg2
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::empty_string()
        };
        let v3 = if (arg3) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_isolated_positions(v0)
        } else {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_cross_positions(v0)
        };
        let v4 = v3;
        let v5 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_assets_vector(v0, v2);
        let v6 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_account_value(&v5, &v4, v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_assets_table_from_ids(arg0));
        if (0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::lt_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(v6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_total_margin_required(&v4, v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::imr_threshold())), 0)) {
            let (v7, v8) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_open_position(&v4, arg2);
            if (v7) {
                let (_, v10, _, v12, _, _, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(0x1::vector::borrow<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position>(&v4, v8));
                assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::is_reducing_trade(v12, v10, arg4, arg5), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(1));
            };
        };
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gte_uint(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::sub_uint(v6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_total_margin_required(&v4, v1, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::mmr_threshold())), 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(3));
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::gte_uint(v6, 0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::health_check_failed(4));
    }

    entry fun remove_tainted_asset<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: u128, arg3: vector<u8>) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        let (v0, v1, v2, v3, v4) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::remove_deposit<T0>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_deposit(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_address(arg1), v3, v0, v1, v2, arg2, true), arg3);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_removed_tainted_deposit_event(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v0, v1, v3, v2, arg2, arg3, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    entry fun set_funding_rate(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg2, arg4);
        let (v0, v1, v2, v3, _, v5) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_set_funding_rate(arg1);
        let v6 = v3;
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
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::enc_trade(arg3, arg4, arg5, arg9);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, v0, arg9);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_oracle_prices(arg0, arg6, arg7);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, _, v12) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_order(arg1);
        let (v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, _, v24) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler::dec_order(arg2);
        assert!(v3 != v15, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::self_trade());
        assert!(v4 == v16, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetuals_mismatch());
        assert!(v8 != v20, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::orders_must_be_opposite());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::check_if_perp_exists_in_ids(arg0, v4), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetual_does_not_exists());
        assert!(v14 == v2 && v14 == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_address(arg0), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        pre_trade_checks(arg0, v3, v4, v9, v8, arg5);
        pre_trade_checks(arg0, v15, v16, v21, v20, arg5);
        assert_user_only_has_isolated_or_cross_position(arg0, v3, v4, v9);
        assert_user_only_has_isolated_or_cross_position(arg0, v15, v16, v21);
        let v25 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v4);
        let v26 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::max_allowed_oi_open(v25);
        let v27 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_oracle_price(v25);
        validate_order(arg0, arg1, arg3, v1, v3, v9, v8, false, v5, v6, v10, v12, arg5, v5, v7, arg9, v25);
        validate_order(arg0, arg2, arg4, v13, v15, v21, v20, true, v17, v18, v22, v24, arg5, v5, v19, arg9, v25);
        let (v28, v29, v30, v31, v32, _, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v4, v3, v5, arg5, v7, v8, v9, true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::none<bool>());
        let v35 = v31;
        let (v36, v37, v38, v39, v40, _, v42) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::apply_maths(arg0, v16, v15, v5, arg5, v19, v20, v21, false, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_trade(), 0x1::option::none<0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signed_number::Number>(), 0x1::option::some<bool>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::is_first_fill(arg0, v13)));
        let v43 = v39;
        verify_notion(&v35, v27, v26);
        verify_notion(&v43, v27, v26);
        let v44 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::get_fee_pool_address(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_perpetual_from_ids(arg0, v4)));
        if (v28 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v44, v30, v29);
        };
        if (v36 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v44, v38, v37);
        };
        let v45 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_gas_pool(arg0));
        if (v42 > 0) {
            0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::add_margin(v45, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::usdc_token_symbol(), v42);
        };
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill(arg0, v1, arg5, v12);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::update_order_fill(arg0, v13, arg5, v24);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, v0, arg8);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_trade_executed_event(v4, v3, v15, v1, v13, v35, v43, v32, v40, v28, v36, v29, v37, v30, v38, arg5, v5, v20, v42, arg8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    fun validate_order(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::Perpetual) {
        assert!(arg11 >= arg15 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::lifespan(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::exceeds_lifespan());
        let v0 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_immutable_account_from_ids(arg0, arg4);
        let (_, _, _, _, v5, v6, v7, v8, v9, v10, _, v12, v13, _, _, _, _, _, _, v20, v21, v22, v23, _, v25) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::perpetual::perpetual_values(arg16);
        assert!(arg15 >= v20 && v22, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::trading_not_permitted());
        assert!(!v21, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::perpetual_delisted());
        let v26 = if (arg12 >= v7) {
            if (arg12 <= v8) {
                arg12 % v5 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v26, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_quantity());
        let v27 = if (arg13 >= v9) {
            if (arg13 <= v10) {
                arg13 % v6 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v27, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_trade_price());
        assert!(!arg7 || arg6 && arg13 <= v23 + 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v23, v12) || arg13 >= v23 - 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v23, v13), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::mtb_breached());
        assert!(arg10 >= arg15, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::expired());
        let v28 = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::signature::verify(arg1, arg2, b"Bluefin Pro Order");
        assert!(v28 == @0x0 || 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::has_permission(v0, v28), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_permission());
        assert!(arg8 == 0 || arg6 && arg13 <= arg8 || arg13 >= arg8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_fill_price());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::filled_order_quantity(arg0, arg3) + arg12 <= arg9, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::order_overfill());
        assert!(!v25 || arg5 == true, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::isolated_only_market());
        assert!(!arg5 || arg14 > 0 && arg14 % 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() == 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_leverage());
    }

    fun verify_notion(arg0: &0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::Position, arg1: u64, arg2: vector<u64>) {
        let (_, v1, _, _, v4, _, v6, _) = 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::get_position_values(arg0);
        let v8 = 0x1::vector::length<u64>(&arg2);
        let v9 = if (v6) {
            v4 / 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::base_uint() - 1
        } else {
            v8 - 1
        };
        assert!(v9 < v8, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::no_max_allowed_oi_open_for_selected_leverage());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::utils::base_mul(v1, arg1) <= *0x1::vector::borrow<u64>(&arg2, v9), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::max_allowed_oi_open());
    }

    entry fun withdraw_from_bank<T0>(arg0: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::InternalDataStore, arg1: &mut 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ExternalDataStore, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_version(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_eds_version(arg1) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::get_version(), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::version_mismatch());
        assert!(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_current_ids_id(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::errors::invalid_internal_data_store());
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::validate_tx_replay(arg0, arg3, arg7);
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
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::sub_margin_from_asset_vector(&mut v11, v6, v4);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::margining_engine::verify_health(v1, v2, &v11, &v12, &v11, &v12, 0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::action_withdraw(), true);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::account::update_account_cross_assets(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_mutable_account_from_ids(arg0, v5), v11);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bank::withdraw_from_asset_bank<T0>(0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_asset_bank(arg1), v4, v5, v6, arg8);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::compute_and_update_sequence_hash(arg0, arg3, arg6);
        0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::events::emit_withdraw_event(v0, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::get_ids_id(arg0), v5, v4, v6, v11, arg6, 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::eds_increment_sequence_number(arg1), 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::data_store::ids_increment_sequence_number(arg0));
    }

    // decompiled from Move bytecode v6
}

