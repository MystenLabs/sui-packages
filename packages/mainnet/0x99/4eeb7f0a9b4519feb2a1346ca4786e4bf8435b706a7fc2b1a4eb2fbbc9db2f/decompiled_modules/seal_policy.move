module 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::seal_policy {
    fun assert_matching_memory_document_id(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = b"soul-memory:";
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0x2::object::id_to_bytes(&arg1);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(0x1::vector::length<u8>(&arg0) == v1 + 1 + v3 + 8 + 16, 1);
        let v4 = 0;
        while (v4 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v4) == *0x1::vector::borrow<u8>(&v0, v4), 0);
            v4 = v4 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v1) == 1, 0);
        let v5 = v1 + 1;
        v4 = 0;
        while (v4 < v3) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v5 + v4) == *0x1::vector::borrow<u8>(&v2, v4), 0);
            v4 = v4 + 1;
        };
        assert_u64_segment(&arg0, v5 + v3, arg2);
    }

    fun assert_matching_soul_document_id(arg0: vector<u8>, arg1: 0x2::object::ID) {
        let v0 = b"soul-seal:";
        let v1 = 0x1::vector::length<u8>(&v0);
        let v2 = 0x2::object::id_to_bytes(&arg1);
        let v3 = 0x1::vector::length<u8>(&v2);
        assert!(0x1::vector::length<u8>(&arg0) == v1 + 1 + v3 + 16, 1);
        let v4 = 0;
        while (v4 < v1) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v4) == *0x1::vector::borrow<u8>(&v0, v4), 0);
            v4 = v4 + 1;
        };
        assert!(*0x1::vector::borrow<u8>(&arg0, v1) == 1, 0);
        v4 = 0;
        while (v4 < v3) {
            assert!(*0x1::vector::borrow<u8>(&arg0, v1 + 1 + v4) == *0x1::vector::borrow<u8>(&v2, v4), 0);
            v4 = v4 + 1;
        };
    }

    fun assert_u64_segment(arg0: &vector<u8>, arg1: u64, arg2: u64) {
        let v0 = 56;
        let v1 = 0;
        while (v1 < 8) {
            assert!(*0x1::vector::borrow<u8>(arg0, arg1 + v1) == ((arg2 >> v0 & 255) as u8), 0);
            let v2 = if (v0 >= 8) {
                v0 - 8
            } else {
                0
            };
            v0 = v2;
            v1 = v1 + 1;
        };
    }

    entry fun seal_approve_granted_agent(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x2::object::ID, arg3: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_matching_soul_document_id(arg0, arg2);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1) == arg2, 2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg3, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_seal(), arg4, arg5);
    }

    entry fun seal_approve_memory_granted_agent(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::SoulMemory, arg3: u64, arg4: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::SoulGrant, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::SoulMemory>(arg2);
        assert_matching_memory_document_id(arg0, v0, arg3);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::soul_id(arg2) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 2);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::memory_id(arg1), &v0), 3);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::contains_entry(arg2, arg3), 4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::assert_active_with_scope(arg1, arg4, 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::grant::scope_memory(), arg5, arg6);
    }

    entry fun seal_approve_memory_owner(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::SoulMemory, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::SoulMemory>(arg2);
        assert_matching_memory_document_id(arg0, v0, arg3);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::soul_id(arg2) == 0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1), 2);
        assert!(0x1::option::contains<0x2::object::ID>(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::memory_id(arg1), &v0), 3);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::memory::contains_entry(arg2, arg3), 4);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg4));
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::SoulState, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        assert_matching_soul_document_id(arg0, arg2);
        assert!(0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::soul_id(arg1) == arg2, 2);
        0x994eeb7f0a9b4519feb2a1346ca4786e4bf8435b706a7fc2b1a4eb2fbbc9db2f::soul::assert_owner(arg1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

