module 0x47e44a6c44436603a3e1f9cbbe91c47f92247fbd0254a696cd7da4627af381b9::hashes {
    public fun build_quorum_change_admin_payload(arg0: address, arg1: bool, arg2: u32, arg3: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bool(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_address(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"quorum_change_admin")), arg0), arg1), arg2), arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_allowlist_payload(arg0: address, arg1: bool, arg2: u32, arg3: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bool(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_address(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_allowlist")), arg0), arg1), arg2), arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_denylist_payload(arg0: address, arg1: bool, arg2: u32, arg3: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bool(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_address(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_denylist")), arg0), arg1), arg2), arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_dvn_signer_payload(arg0: vector<u8>, arg1: bool, arg2: u32, arg3: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bool(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_dvn_signer")), arg0), arg1), arg2), arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_pause_payload(arg0: bool, arg1: u32, arg2: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bool(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_pause")), arg0), arg1), arg2);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_ptb_builder_move_calls_payload(arg0: address, arg1: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg2: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg3: u32, arg4: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        let v1 = 0x2::bcs::to_bytes<vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>>(&arg1);
        let v2 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v1));
        let v3 = 0x2::bcs::to_bytes<vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>>(&arg2);
        let v4 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v3));
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_address(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_ptb_builder_move_calls")), arg0), 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_bytes(&v2)), 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_bytes(&v4)), arg3), arg4);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_set_quorum_payload(arg0: u64, arg1: u32, arg2: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"set_quorum")), arg0), arg1), arg2);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun build_verify_payload(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u32, arg5: u64) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_address(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u64(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v0, get_function_signature(b"verify")), arg0), arg1), arg2), arg3), arg4), arg5);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun create_quorum_change_admin_hash(arg0: address, arg1: bool, arg2: u32, arg3: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_quorum_change_admin_payload(arg0, arg1, arg2, arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_allowlist_hash(arg0: address, arg1: bool, arg2: u32, arg3: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_allowlist_payload(arg0, arg1, arg2, arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_denylist_hash(arg0: address, arg1: bool, arg2: u32, arg3: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_denylist_payload(arg0, arg1, arg2, arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_dvn_signer_hash(arg0: vector<u8>, arg1: bool, arg2: u32, arg3: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_dvn_signer_payload(arg0, arg1, arg2, arg3);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_pause_hash(arg0: bool, arg1: u32, arg2: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_pause_payload(arg0, arg1, arg2);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_ptb_builder_move_calls_hash(arg0: address, arg1: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg2: vector<0x19990ce226fbd54277f445ac32846c5635214176fe437397cf1915c10d83ed50::move_call::MoveCall>, arg3: u32, arg4: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_ptb_builder_move_calls_payload(arg0, arg1, arg2, arg3, arg4);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_set_quorum_hash(arg0: u64, arg1: u32, arg2: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_set_quorum_payload(arg0, arg1, arg2);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun create_verify_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: address, arg4: u32, arg5: u64) : 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::Bytes32 {
        let v0 = build_verify_payload(arg0, arg1, arg2, arg3, arg4, arg5);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun get_function_signature(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<vector<u8>>(&arg0);
        let v1 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::from_bytes(0x2::hash::keccak256(&v0));
        let v2 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::bytes32::to_bytes(&v1);
        let v3 = b"";
        let v4 = 0;
        while (v4 < 4) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

