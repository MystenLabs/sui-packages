module 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::seal {
    fun has_suffix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 > v0) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            if (*0x1::vector::borrow<u8>(arg0, v0 - v1 + v2) != *0x1::vector::borrow<u8>(arg1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun id_matches(arg0: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::MemoryNamespace, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 < 8) {
            return false
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            v1 = v1 | (*0x1::vector::borrow<u8>(arg1, v0 - 8 + (v2 as u64)) as u64) << 8 * v2;
            v2 = v2 + 1;
        };
        if (v1 < 1 || v1 > 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::current_dek_version(arg0)) {
            return false
        };
        let v3 = namespace_seal_id(0x2::object::id<0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::MemoryNamespace>(arg0), v1);
        has_suffix(arg1, &v3)
    }

    public fun namespace_seal_id(arg0: 0x2::object::ID, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::versioning::ProtocolVersion, arg2: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::account::Account, arg3: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::MemoryNamespace, arg4: &0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::account::AccountRegistry, arg5: &0x2::tx_context::TxContext) {
        assert!(0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::effective_acl_bits(arg1, arg2, arg3, arg4, 0x2::tx_context::sender(arg5)) & 0x28178af32eeebf5eacd3e0fc162c4e646702b8f1e28e5c9c7e60d88f5458ddc2::namespace::read_bit() != 0, 100);
        assert!(id_matches(arg3, &arg0), 100);
    }

    // decompiled from Move bytecode v7
}

