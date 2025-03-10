module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::connections {
    public(friend) fun get_fee(arg0: &0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : u64 {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        if (0x1::string::as_bytes(&v0) == &v1) {
            0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_connection::get_fee(arg0, arg1, arg2, arg3)
        } else {
            let v3 = get_connection_type(&arg1);
            let v4 = b"cluster";
            assert!(0x1::string::as_bytes(&v3) == &v4, 0);
            0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_connection::get_fee(arg0, arg1, arg2, arg3)
        }
    }

    public(friend) fun send_message(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: u128, arg5: vector<u8>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        if (0x1::string::as_bytes(&v0) == &v1) {
            0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_connection::send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        } else {
            let v2 = get_connection_type(&arg1);
            let v3 = b"cluster";
            assert!(0x1::string::as_bytes(&v2) == &v3, 0);
            0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_connection::send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun get_connection_type(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"-");
        0x1::string::substring(arg0, 0, 0x1::string::index_of(arg0, &v0))
    }

    public(friend) fun register(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_connection_type(&arg1);
        let v1 = b"centralized";
        if (0x1::string::as_bytes(&v0) == &v1) {
            0x2::bag::add<0x1::string::String, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_state::State>(arg0, arg1, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::centralized_connection::connect());
        } else {
            let v2 = get_connection_type(&arg1);
            let v3 = b"cluster";
            assert!(0x1::string::as_bytes(&v2) == &v3, 0);
            0x2::transfer::public_transfer<0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::AdminCap>(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::create_admin_cap(arg1, arg2), 0x2::tx_context::sender(arg2));
            0x2::bag::add<0x1::string::String, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_state::State>(arg0, arg1, 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::cluster_connection::connect());
        };
    }

    // decompiled from Move bytecode v6
}

