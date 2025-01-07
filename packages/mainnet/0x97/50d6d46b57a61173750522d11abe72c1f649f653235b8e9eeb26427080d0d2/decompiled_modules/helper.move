module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper {
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

    public(friend) fun get_i_ack_msg_hash(arg0: &u256, arg1: &u256, arg2: &0x1::string::String, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &bool, arg6: &0x1::string::String) : vector<u8> {
        let v0 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::new_writer(8);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_i_ack_method_name());
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, *arg6);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, *arg0);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, *arg1);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, *arg2);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, *arg3);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, *arg4);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bool(&mut v0, *arg5);
        let v1 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::into_bytes(v0);
        0x2::hash::keccak256(&v1)
    }

    public(friend) fun get_i_receive_msg_hash(arg0: &u256, arg1: &u256, arg2: &u256, arg3: &0x1::string::String, arg4: &address, arg5: &0x1::string::String, arg6: &vector<u8>, arg7: &0x1::string::String, arg8: &vector<u8>, arg9: &vector<u8>, arg10: &bool) : vector<u8> {
        let v0 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::new_writer(12);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants::get_i_receive_method_name());
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, *arg0);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, *arg1);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_u256(&mut v0, *arg2);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, *arg3);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_address(&mut v0, *arg4);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, *arg5);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, *arg6);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_string(&mut v0, *arg7);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, *arg8);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bytes(&mut v0, *arg9);
        0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::write_bool(&mut v0, *arg10);
        let v1 = 0x69a756550466d39bc11b010f3dbfb595fe7dcda9d18529546fcc566f9ad44021::writer::into_bytes(v0);
        0x2::hash::keccak256(&v1)
    }

    // decompiled from Move bytecode v6
}

