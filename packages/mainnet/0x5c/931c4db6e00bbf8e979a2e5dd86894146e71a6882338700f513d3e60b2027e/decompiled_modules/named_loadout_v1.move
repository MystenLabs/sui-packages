module 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::named_loadout_v1 {
    struct CipherRefV1 has copy, drop, store {
        blob_object_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        sha256: vector<u8>,
        byte_length: u64,
    }

    struct CaptureV1 has copy, drop, store {
        equipment_id: 0x2::object::ID,
        revision: u64,
        commitment: vector<u8>,
    }

    struct ReceiptV1 has copy, drop, store {
        request_id: vector<u8>,
        revision: u64,
        ciphertext: CipherRefV1,
        capture: 0x1::option::Option<CaptureV1>,
    }

    struct HeadV1 has copy, drop, store {
        version: u8,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        owner: address,
        ownership_epoch: u64,
        revision: u64,
        ciphertext: CipherRefV1,
        receipts: vector<ReceiptV1>,
    }

    struct SealScopeV1 has drop {
        domain: 0x1::string::String,
        version: u8,
        soul_id: 0x2::object::ID,
        state_id: 0x2::object::ID,
        owner: address,
        ownership_epoch: u64,
    }

    fun assert_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 3);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != 0) {
                v0 = true;
            };
            v1 = v1 + 1;
        };
        assert!(v0, 3);
    }

    fun assert_reference(arg0: &CipherRefV1, arg1: &vector<u8>) {
        assert_hash(arg1);
        assert_hash(&arg0.sha256);
        let v0 = if (arg0.blob_object_id != 0x2::object::id_from_address(@0x0)) {
            if (arg0.byte_length > 0) {
                arg0.byte_length <= 16777216
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x1::string::as_bytes(&arg0.blob_id);
        assert!(0x1::vector::length<u8>(v1) == 43, 3);
        let v2 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            assert!(0x1::vector::contains<u8>(&v2, 0x1::vector::borrow<u8>(v1, v3)), 3);
            v3 = v3 + 1;
        };
        let v4 = b"AEIMQUYcgkosw048";
        assert!(0x1::vector::contains<u8>(&v4, 0x1::vector::borrow<u8>(v1, 42)), 3);
    }

    fun assert_scope(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::assert_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0) == arg1, 0);
    }

    fun commit(arg0: &mut 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: u64, arg2: vector<u8>, arg3: CipherRefV1, arg4: 0x1::option::Option<CaptureV1>) : u64 {
        let v0 = current_head(arg0);
        let v1 = if (0x1::option::is_some<HeadV1>(&v0)) {
            0x1::option::borrow<HeadV1>(&v0).revision
        } else {
            0
        };
        assert!(v1 == arg1 && v1 < 18446744073709551615, 2);
        assert_reference(&arg3, &arg2);
        let v2 = v1 + 1;
        let v3 = if (0x1::option::is_some<HeadV1>(&v0)) {
            0x1::option::borrow<HeadV1>(&v0).receipts
        } else {
            0x1::vector::empty<ReceiptV1>()
        };
        let v4 = v3;
        if (0x1::vector::length<ReceiptV1>(&v4) == 32) {
            0x1::vector::remove<ReceiptV1>(&mut v4, 0);
        };
        let v5 = ReceiptV1{
            request_id : arg2,
            revision   : v2,
            ciphertext : arg3,
            capture    : arg4,
        };
        0x1::vector::push_back<ReceiptV1>(&mut v4, v5);
        let v6 = HeadV1{
            version         : 1,
            soul_id         : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0),
            state_id        : 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0),
            owner           : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::current_owner(arg0),
            ownership_epoch : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0),
            revision        : v2,
            ciphertext      : arg3,
            receipts        : v4,
        };
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::replace_named_loadout_head_v1<HeadV1>(arg0, v6);
        v2
    }

    public fun current_head(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState) : 0x1::option::Option<HeadV1> {
        if (!0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::has_named_loadout_head_v1(arg0)) {
            return 0x1::option::none<HeadV1>()
        };
        let v0 = 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::named_loadout_head_v1<HeadV1>(arg0);
        let v1 = if (v0.version == 1) {
            if (v0.soul_id == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0)) {
                if (v0.state_id == 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0)) {
                    if (v0.revision > 0) {
                        if (0x1::vector::length<ReceiptV1>(&v0.receipts) > 0) {
                            if (0x1::vector::length<ReceiptV1>(&v0.receipts) <= 32) {
                                v0.ownership_epoch <= 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        if (v0.ownership_epoch < 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::ownership_epoch(arg0)) {
            return 0x1::option::none<HeadV1>()
        };
        assert!(v0.owner == 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::current_owner(arg0), 1);
        0x1::option::some<HeadV1>(*v0)
    }

    public fun current_revision(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState) : u64 {
        let v0 = current_head(arg0);
        if (0x1::option::is_some<HeadV1>(&v0)) {
            0x1::option::borrow<HeadV1>(&v0).revision
        } else {
            0
        }
    }

    public fun receipt(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: vector<u8>) : 0x1::option::Option<ReceiptV1> {
        let v0 = current_head(arg0);
        if (0x1::option::is_none<HeadV1>(&v0)) {
            return 0x1::option::none<ReceiptV1>()
        };
        let v1 = &0x1::option::borrow<HeadV1>(&v0).receipts;
        let v2 = 0;
        while (v2 < 0x1::vector::length<ReceiptV1>(v1)) {
            if (0x1::vector::borrow<ReceiptV1>(v1, v2).request_id == arg1) {
                return 0x1::option::some<ReceiptV1>(*0x1::vector::borrow<ReceiptV1>(v1, v2))
            };
            v2 = v2 + 1;
        };
        0x1::option::none<ReceiptV1>()
    }

    public fun receipt_revision(arg0: &ReceiptV1) : u64 {
        arg0.revision
    }

    fun replay(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: &vector<u8>, arg2: &CipherRefV1, arg3: &0x1::option::Option<CaptureV1>) : 0x1::option::Option<u64> {
        let v0 = receipt(arg0, *arg1);
        if (0x1::option::is_none<ReceiptV1>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0x1::option::borrow<ReceiptV1>(&v0);
        assert!(v1.ciphertext == *arg2 && v1.capture == *arg3, 4);
        0x1::option::some<u64>(v1.revision)
    }

    public fun save(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::ProtocolGate, arg1: &mut 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg2: &0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8, arg3: &0x361ac91b6ed180cb56565b9b67b96b9609a6bf94e38bee062a206aa7bee051c3::protocol_config_v8::ProtocolConfigV8, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::object::ID, arg8: 0x1::string::String, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: &0x2::tx_context::TxContext) : u64 {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::assert_live(arg0);
        assert_scope(arg1, arg4, arg13);
        let v0 = CipherRefV1{
            blob_object_id : arg7,
            blob_id        : arg8,
            sha256         : arg9,
            byte_length    : arg10,
        };
        let v1 = CaptureV1{
            equipment_id : 0x2::object::id<0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::MakerLoadoutV8>(arg2),
            revision     : arg11,
            commitment   : arg12,
        };
        let v2 = 0x1::option::some<CaptureV1>(v1);
        let v3 = replay(arg1, &arg6, &v0, &v2);
        if (0x1::option::is_some<u64>(&v3)) {
            return 0x1::option::destroy_some<u64>(v3)
        };
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::animacraft_equipment_adapter_v8::assert_equipment_read_v8(arg1, arg2, arg3, arg13);
        assert!(0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::loadout_revision_v8(arg2) == arg11 && *0x3756f1b2788909abd22c7ed471999c8407be97e6c834cd4e32c8e7dcb67102ca::runtime_v8::loadout_commitment_v8(arg2) == arg12, 5);
        assert_hash(&arg12);
        commit(arg1, arg5, arg6, v0, v2)
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::ProtocolGate, arg2: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::assert_live(arg1);
        assert_scope(arg2, arg3, arg4);
        assert!(arg0 == seal_id(arg2, 0x2::tx_context::sender(arg4), arg3), 6);
    }

    public fun seal_id(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg1: address, arg2: u64) : vector<u8> {
        let v0 = SealScopeV1{
            domain          : 0x1::string::utf8(b"soulidity/private-named-loadouts/seal-id/v1"),
            version         : 1,
            soul_id         : 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::soul_id(arg0),
            state_id        : 0x2::object::id<0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState>(arg0),
            owner           : arg1,
            ownership_epoch : arg2,
        };
        0x1::hash::sha2_256(0x1::bcs::to_bytes<SealScopeV1>(&v0))
    }

    public fun update(arg0: &0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::ProtocolGate, arg1: &mut 0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::soul::SoulState, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: 0x2::object::ID, arg6: 0x1::string::String, arg7: vector<u8>, arg8: u64, arg9: &0x2::tx_context::TxContext) : u64 {
        0x5c931c4db6e00bbf8e979a2e5dd86894146e71a6882338700f513d3e60b2027e::protocol_gate::assert_live(arg0);
        assert_scope(arg1, arg2, arg9);
        let v0 = CipherRefV1{
            blob_object_id : arg5,
            blob_id        : arg6,
            sha256         : arg7,
            byte_length    : arg8,
        };
        let v1 = 0x1::option::none<CaptureV1>();
        let v2 = replay(arg1, &arg4, &v0, &v1);
        if (0x1::option::is_some<u64>(&v2)) {
            return 0x1::option::destroy_some<u64>(v2)
        };
        commit(arg1, arg3, arg4, v0, v1)
    }

    // decompiled from Move bytecode v7
}

