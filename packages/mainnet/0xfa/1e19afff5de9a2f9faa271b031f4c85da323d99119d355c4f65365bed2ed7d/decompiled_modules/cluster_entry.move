module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_entry {
    entry fun claim_fees(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::claim_fees(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1)), arg2);
    }

    entry fun get_fee(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: &0x2::tx_context::TxContext) : u64 {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_fee(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1), &arg2, arg3)
    }

    entry fun get_receipt(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128, arg4: &0x2::tx_context::TxContext) : bool {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_receipt(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1), arg2, arg3)
    }

    entry fun get_validators(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_validators(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1))
    }

    entry fun get_validators_threshold(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) : u64 {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_validator_threshold(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1))
    }

    public entry fun receive_message(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: u128, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 404
    }

    entry fun recieve_message_with_signatures(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: u128, arg4: vector<u8>, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1));
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::verify_signatures(v0, arg2, arg3, arg4, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_net_id(arg0), arg5);
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::check_save_receipt(v0, arg2, arg3);
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::main::handle_message(arg0, arg1, arg2, arg4, arg6);
    }

    entry fun set_fee(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::set_fee(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1)), arg2, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    entry fun set_validator_threshold(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::AdminCap, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::validate_admin_cap(arg1, arg2);
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::set_validator_threshold(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), arg2), arg3);
    }

    entry fun set_validators(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::AdminCap, arg2: 0x1::string::String, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::validate_admin_cap(arg1, arg2);
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::set_validators(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

