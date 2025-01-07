module 0x557f7c54f7b3b44537842ccccd57a08b5d02c001f8a7a91097293daed8bf8f5e::multichain_signer {
    struct SigningKey has key {
        id: 0x2::object::UID,
        sequence_number: u64,
        signature_algorithm: u8,
    }

    struct KeyCreateRequest has copy, drop {
        key: 0x2::object::ID,
        signature_algorithm: u8,
    }

    struct KeyDeleteRequest has copy, drop {
        key: 0x2::object::ID,
        sequence_number: u64,
    }

    struct SigningRequest has copy, drop {
        key: 0x2::object::ID,
        signature_algorithm: u8,
        sequence_number: u64,
        msg: vector<u8>,
    }

    public fun delete_key(arg0: SigningKey) {
        let SigningKey {
            id                  : v0,
            sequence_number     : v1,
            signature_algorithm : _,
        } = arg0;
        let v3 = v0;
        let v4 = KeyDeleteRequest{
            key             : 0x2::object::uid_to_inner(&v3),
            sequence_number : v1 + 1,
        };
        0x2::event::emit<KeyDeleteRequest>(v4);
        0x2::object::delete(v3);
    }

    public fun make_key(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : SigningKey {
        let v0 = SigningKey{
            id                  : 0x2::object::new(arg1),
            sequence_number     : 0,
            signature_algorithm : arg0,
        };
        let v1 = KeyCreateRequest{
            key                 : 0x2::object::uid_to_inner(&v0.id),
            signature_algorithm : v0.signature_algorithm,
        };
        0x2::event::emit<KeyCreateRequest>(v1);
        v0
    }

    public fun request_sign(arg0: &mut SigningKey, arg1: vector<u8>) {
        arg0.sequence_number = arg0.sequence_number + 1;
        let v0 = SigningRequest{
            key                 : 0x2::object::uid_to_inner(&arg0.id),
            signature_algorithm : arg0.signature_algorithm,
            sequence_number     : arg0.sequence_number,
            msg                 : arg1,
        };
        0x2::event::emit<SigningRequest>(v0);
    }

    // decompiled from Move bytecode v6
}

