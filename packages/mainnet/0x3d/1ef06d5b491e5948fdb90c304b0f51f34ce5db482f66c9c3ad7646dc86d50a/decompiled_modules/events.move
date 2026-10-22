module 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::events {
    struct AddedTrustedSigner has copy, drop {
        verifier_id: 0x2::object::ID,
        public_key: vector<u8>,
        expires_at_ms: u64,
    }

    struct UpdatedTrustedSigner has copy, drop {
        verifier_id: 0x2::object::ID,
        public_key: vector<u8>,
        previous_expires_at_ms: u64,
        expires_at_ms: u64,
    }

    struct RemovedTrustedSigner has copy, drop {
        verifier_id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    public(friend) fun emit_added_trusted_signer(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = AddedTrustedSigner{
            verifier_id   : arg0,
            public_key    : arg1,
            expires_at_ms : arg2,
        };
        0x2::event::emit<AddedTrustedSigner>(v0);
    }

    public(friend) fun emit_removed_trusted_signer(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = RemovedTrustedSigner{
            verifier_id : arg0,
            public_key  : arg1,
        };
        0x2::event::emit<RemovedTrustedSigner>(v0);
    }

    public(friend) fun emit_updated_trusted_signer(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64, arg3: u64) {
        let v0 = UpdatedTrustedSigner{
            verifier_id            : arg0,
            public_key             : arg1,
            previous_expires_at_ms : arg2,
            expires_at_ms          : arg3,
        };
        0x2::event::emit<UpdatedTrustedSigner>(v0);
    }

    // decompiled from Move bytecode v7
}

