module 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::view_function {
    public(friend) fun get_user_share_data_bcs(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::Registry, arg2: vector<u64>, arg3: &0x2::tx_context::TxContext) : vector<vector<u8>> {
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::get_user_account_address(arg0, arg3);
        let v1 = vector[];
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg2);
            let (v3, v4, v5) = 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::get_vault_shares(arg1, v2);
            let v6 = 0x1::bcs::to_bytes<u64>(&v2);
            if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(v3, v0)) {
                0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<vector<u64>>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, vector<u64>>(v3, v0)));
                0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<vector<u64>>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key<address, vector<u64>>(v4, v0)));
            } else {
                let v7 = vector[];
                let v8 = 0;
                while (v8 < 10) {
                    0x1::vector::push_back<u64>(&mut v7, 0);
                    v8 = v8 + 1;
                };
                0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<vector<u64>>(&v7));
                let v9 = vector[];
                let v10 = 0;
                while (v10 < v5) {
                    0x1::vector::push_back<u64>(&mut v9, 0);
                    v10 = v10 + 1;
                };
                0x1::vector::append<u8>(&mut v6, 0x1::bcs::to_bytes<vector<u64>>(&v9));
            };
            0x1::vector::push_back<vector<u8>>(&mut v1, v6);
        };
        v1
    }

    public(friend) fun get_vault_data_bcs(arg0: &0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::registry_uid(arg0);
        let v1 = 0x1::vector::empty<vector<u8>>();
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (0x2::dynamic_object_field::exists_<u64>(v0, v2)) {
                0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::bcs::to_bytes<0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::Vault>(0x2::dynamic_object_field::borrow<u64, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge::Vault>(v0, v2)));
            };
        };
        v1
    }

    // decompiled from Move bytecode v6
}

