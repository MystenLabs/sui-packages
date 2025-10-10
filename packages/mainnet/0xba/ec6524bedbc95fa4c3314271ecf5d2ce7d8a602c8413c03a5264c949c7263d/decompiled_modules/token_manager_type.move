module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_manager_type {
    struct TokenManagerType has copy, drop {
        token_manager_type: u256,
    }

    public(friend) fun from_u256(arg0: u256) : TokenManagerType {
        assert!(arg0 <= 4, 13906834393387040774);
        TokenManagerType{token_manager_type: arg0}
    }

    public fun lock_unlock() : TokenManagerType {
        from_u256(2)
    }

    public fun mint_burn() : TokenManagerType {
        from_u256(4)
    }

    public(friend) fun native_interchain_token() : TokenManagerType {
        from_u256(0)
    }

    public(friend) fun to_u256(arg0: TokenManagerType) : u256 {
        let TokenManagerType { token_manager_type: v0 } = arg0;
        v0
    }

    // decompiled from Move bytecode v6
}

