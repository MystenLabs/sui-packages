module 0xe34fe999fe04d533fe8f8e0edeafce96a1bf626ff248ac96e8db1131f3a244b2::credential {
    struct Credential has key {
        id: 0x2::object::UID,
        issuer: address,
        subject: address,
        institution: vector<u8>,
        credential_type: vector<u8>,
        program: vector<u8>,
        revoked: bool,
        blob_id: vector<u8>,
        content_hash: vector<u8>,
    }

    public entry fun issue_credential(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Credential{
            id              : 0x2::object::new(arg6),
            issuer          : 0x2::tx_context::sender(arg6),
            subject         : arg0,
            institution     : arg1,
            credential_type : arg2,
            program         : arg3,
            revoked         : false,
            blob_id         : arg4,
            content_hash    : arg5,
        };
        0x2::transfer::transfer<Credential>(v0, 0x2::tx_context::sender(arg6));
    }

    public entry fun revoke_credential(arg0: &mut Credential, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.issuer == 0x2::tx_context::sender(arg1), 1);
        arg0.revoked = true;
    }

    fun vector_equal_u8(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun verify_credential(arg0: &Credential, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        if (!arg0.revoked) {
            if (vector_equal_u8(&arg0.blob_id, arg1)) {
                vector_equal_u8(&arg0.content_hash, arg2)
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

