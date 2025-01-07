module 0xe3c1f1104d1d413ad884ed6d136a70c78565d83b5a65a07cb1f1e86aab48f36::helper {
    public(friend) fun get_handler_info(arg0: &vector<u8>) : (address, address) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v2));
            v2 = v2 + 1;
        };
        v2 = 32;
        while (v2 < 64) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(arg0, v2));
            v2 = v2 + 1;
        };
        (0x2::address::from_bytes(v0), 0x2::address::from_bytes(v1))
    }

    public(friend) fun get_i_relay_message_msg_hash(arg0: u64, arg1: vector<u8>, arg2: u256, arg3: 0x1::string::String, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) : vector<u8> {
        let v0 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::new_writer(7);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, (arg0 as u256));
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg1);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, arg2);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, arg3);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg4);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg6);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg5);
        let v1 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::into_bytes(v0);
        0x2::hash::keccak256(&v1)
    }

    public(friend) fun get_i_relay_msg_hash(arg0: u64, arg1: vector<u8>, arg2: u256, arg3: 0x1::string::String, arg4: address, arg5: vector<u8>) : vector<u8> {
        let v0 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::new_writer(6);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, (arg0 as u256));
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg1);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, arg2);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, arg3);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_address(&mut v0, arg4);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, arg5);
        let v1 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::into_bytes(v0);
        0x2::hash::keccak256(&v1)
    }

    public(friend) fun get_user_balances_key(arg0: address, arg1: &0x1::string::String) : vector<u8> {
        let v0 = *0x1::string::as_bytes(arg1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0));
        0x2::hash::keccak256(&v0)
    }

    // decompiled from Move bytecode v6
}

