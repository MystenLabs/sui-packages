module 0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::view_function {
    public(friend) fun get_share_data_bcs(arg0: &0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::Registry, arg1: address, arg2: vector<u64>) : vector<vector<u8>> {
        let v0 = vector[];
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v1 = 0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::get_user_share(arg0, 0x1::vector::pop_back<u64>(&mut arg2), arg1);
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<0x1::option::Option<0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::Share>>(&v1));
        };
        v0
    }

    public(friend) fun get_vault_data_bcs<T0: store + key>(arg0: &0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = 0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::registry_uid(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (0x2::dynamic_object_field::exists_<u64>(v0, v3)) {
                let v4 = 0x2::dynamic_object_field::borrow<u64, 0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::Vault>(v0, v3);
                0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::Vault>(v4));
                let v5 = 0xf6aa05ec1c5c8cb3ba927a0a3c4502d302692e54765677763f239da33aeec712::safu::vault_uid(v4);
                if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(v5, 0x1::ascii::string(b"typus_bid_receipt"))) {
                    let v6 = true;
                    0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<bool>(&v6));
                    0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<T0>(0x2::dynamic_object_field::borrow<0x1::ascii::String, T0>(v5, 0x1::ascii::string(b"typus_bid_receipt"))));
                } else {
                    let v7 = false;
                    0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<bool>(&v7));
                };
                0x1::vector::push_back<vector<u8>>(&mut v1, v2);
            };
        };
        v1
    }

    // decompiled from Move bytecode v6
}

