module 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::view_function {
    public(friend) fun get_share_data_bcs(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::Registry, arg1: address, arg2: vector<u64>) : vector<vector<u8>> {
        let v0 = vector[];
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v1 = 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::get_user_share(arg0, 0x1::vector::pop_back<u64>(&mut arg2), arg1);
            0x1::vector::push_back<vector<u8>>(&mut v0, 0x1::bcs::to_bytes<0x1::option::Option<0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::Share>>(&v1));
        };
        v0
    }

    public(friend) fun get_vault_data_bcs(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::Registry, arg1: vector<u64>) : vector<vector<u8>> {
        let v0 = 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::registry_uid(arg0);
        let v1 = vector[];
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg1);
            if (0x2::dynamic_object_field::exists_<u64>(v0, v2)) {
                0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::bcs::to_bytes<0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::Vault>(0x2::dynamic_object_field::borrow<u64, 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu::Vault>(v0, v2)));
            };
        };
        v1
    }

    // decompiled from Move bytecode v6
}

