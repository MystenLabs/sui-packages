module 0x5db0c8a5b645c9d3f2bcfdc57b79af4e072147c068da65cf0e89cfe46f5f6fc1::authority_config {
    struct AuthorityConfig has key {
        id: 0x2::object::UID,
        authority_pubkey: vector<u8>,
    }

    public fun authority_pubkey(arg0: &AuthorityConfig) : &vector<u8> {
        &arg0.authority_pubkey
    }

    public(friend) fun init_authority_config(arg0: &0x5db0c8a5b645c9d3f2bcfdc57b79af4e072147c068da65cf0e89cfe46f5f6fc1::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthorityConfig{
            id               : 0x2::object::new(arg1),
            authority_pubkey : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<AuthorityConfig>(v0);
    }

    public fun update_authority_config(arg0: &0x5db0c8a5b645c9d3f2bcfdc57b79af4e072147c068da65cf0e89cfe46f5f6fc1::admin::AdminCap, arg1: &mut AuthorityConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0);
        arg1.authority_pubkey = arg2;
    }

    // decompiled from Move bytecode v7
}

