module 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::token_gate_policy {
    struct TokenGatePolicy has store, key {
        id: 0x2::object::UID,
        form_id: address,
        token_type: 0x1::string::String,
        required_balance: u64,
        enabled: bool,
        creator: address,
    }

    struct TokenGatePolicyCreated has copy, drop {
        policy_id: address,
        form_id: address,
        token_type: 0x1::string::String,
        required_balance: u64,
    }

    public fun create_token_gate_policy(arg0: address, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenGatePolicy{
            id               : 0x2::object::new(arg3),
            form_id          : arg0,
            token_type       : 0x1::string::utf8(arg1),
            required_balance : arg2,
            enabled          : false,
            creator          : 0x2::tx_context::sender(arg3),
        };
        let v1 = TokenGatePolicyCreated{
            policy_id        : 0x2::object::uid_to_address(&v0.id),
            form_id          : v0.form_id,
            token_type       : v0.token_type,
            required_balance : v0.required_balance,
        };
        0x2::event::emit<TokenGatePolicyCreated>(v1);
        0x2::transfer::public_transfer<TokenGatePolicy>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun disable_gate(arg0: &mut TokenGatePolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.enabled = false;
    }

    public fun enable_gate(arg0: &mut TokenGatePolicy, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        arg0.enabled = true;
    }

    public fun is_enabled(arg0: &TokenGatePolicy) : bool {
        arg0.enabled
    }

    public fun policy_id(arg0: &TokenGatePolicy) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    // decompiled from Move bytecode v7
}

