module 0x737d5e8e2df6ebded49b047c4c6fcc0a2226e094001d0127c79a7a8eba5bd338::simple_policy {
    struct AccessToken has store, key {
        id: 0x2::object::UID,
        owner: address,
        nonce: vector<u8>,
    }

    fun check_policy(arg0: vector<u8>, arg1: &AccessToken) : bool {
        compute_key_id(arg1.owner, arg1.nonce) == arg0
    }

    fun compute_key_id(arg0: address, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        v0
    }

    public fun create_token(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AccessToken {
        AccessToken{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
            nonce : arg0,
        }
    }

    entry fun create_token_entry(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_token(arg0, arg1);
        0x2::transfer::transfer<AccessToken>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &AccessToken) {
        assert!(check_policy(arg0, arg1), 1);
    }

    // decompiled from Move bytecode v6
}

