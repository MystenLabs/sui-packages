module 0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::authority_config {
    struct AuthorityConfig has key {
        id: 0x2::object::UID,
        authority_pubkey: vector<u8>,
    }

    public fun authority_pubkey(arg0: &AuthorityConfig) : &vector<u8> {
        &arg0.authority_pubkey
    }

    public(friend) fun init_authority_config(arg0: &0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorityConfig{
            id               : 0x2::object::new(arg1),
            authority_pubkey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<AuthorityConfig>(v0);
    }

    public fun update_authority_config(arg0: &0x87a91794a05066e7aab1e0d9f158d09305f63474685d4b89c0ba50e8c62b3dfd::admin::AdminCap, arg1: &mut AuthorityConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        arg1.authority_pubkey = arg2;
    }

    // decompiled from Move bytecode v7
}

