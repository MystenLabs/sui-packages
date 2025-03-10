module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_entry {
    entry fun claim_fees(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: &mut 0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::claim_fees(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1)), arg2);
    }

    entry fun get_fee(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: &0x2::tx_context::TxContext) : u64 {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_fee(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1), &arg2, arg3)
    }

    entry fun get_receipt(arg0: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u128, arg4: &0x2::tx_context::TxContext) : bool {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_receipt(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_state(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states(arg0), arg1), arg2, arg3)
    }

    public entry fun receive_message(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: u128, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::check_save_receipt(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1)), arg2, arg3);
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::main::handle_message(arg0, arg1, arg2, arg4, arg5);
    }

    entry fun set_fee(arg0: &mut 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::Storage, arg1: &0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::set_fee(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::get_state_mut(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::get_connection_states_mut(arg0), 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::xcall_state::connection_id(arg1)), arg2, arg3, arg4, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

