module 0xf0f26da6f8125afa5aea75c23b2ce1b70a346aecad3618869375247faa53da1c::authority_receipt {
    struct AuthorityReceiptAnchorCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuthorityReceiptAnchored has copy, drop {
        org_id: vector<u8>,
        workspace_id: vector<u8>,
        receipt_id: vector<u8>,
        action_type: vector<u8>,
        principal_id_hash: vector<u8>,
        resource_id_hash: vector<u8>,
        decision: vector<u8>,
        receipt_hash: vector<u8>,
        evidence_digest: vector<u8>,
        created_at_ms: u64,
    }

    entry fun anchor_receipt(arg0: &AuthorityReceiptAnchorCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64) {
        assert_valid_anchor_fields(&arg1, &arg2, &arg3, &arg4, &arg5, &arg6, &arg7, &arg8, &arg9, arg10);
        let v0 = AuthorityReceiptAnchored{
            org_id            : arg1,
            workspace_id      : arg2,
            receipt_id        : arg3,
            action_type       : arg4,
            principal_id_hash : arg5,
            resource_id_hash  : arg6,
            decision          : arg7,
            receipt_hash      : arg8,
            evidence_digest   : arg9,
            created_at_ms     : arg10,
        };
        0x2::event::emit<AuthorityReceiptAnchored>(v0);
    }

    fun assert_sha256_digest(arg0: &vector<u8>, arg1: u64) {
        assert!(0x1::vector::length<u8>(arg0) == 71, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 115, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 1) == 104, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 2) == 97, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 3) == 50, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 4) == 53, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 5) == 54, arg1);
        assert!(*0x1::vector::borrow<u8>(arg0, 6) == 58, arg1);
        let v0 = 7;
        while (v0 < 71) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            assert!(v1 >= 48 && v1 <= 57 || v1 >= 97 && v1 <= 102, arg1);
            v0 = v0 + 1;
        };
    }

    public fun assert_valid_anchor_fields(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: &vector<u8>, arg8: &vector<u8>, arg9: u64) {
        assert!(0x1::vector::length<u8>(arg0) > 0, 0);
        assert!(0x1::vector::length<u8>(arg1) > 0, 1);
        assert!(0x1::vector::length<u8>(arg2) > 0, 2);
        assert!(0x1::vector::length<u8>(arg3) > 0, 3);
        assert!(0x1::vector::length<u8>(arg4) > 0, 4);
        assert!(0x1::vector::length<u8>(arg5) > 0, 5);
        assert!(0x1::vector::length<u8>(arg6) > 0, 6);
        assert!(0x1::vector::length<u8>(arg7) > 0, 7);
        assert!(0x1::vector::length<u8>(arg8) > 0, 8);
        assert!(arg9 > 0, 9);
        assert_sha256_digest(arg4, 10);
        assert_sha256_digest(arg5, 11);
        assert_sha256_digest(arg7, 12);
        assert_sha256_digest(arg8, 13);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorityReceiptAnchorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AuthorityReceiptAnchorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

