module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::treasury_cap_reclaimer {
    struct TreasuryCapReclaimer<phantom T0> has store, key {
        id: 0x2::object::UID,
        token_id: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId,
    }

    public(friend) fun token_id<T0>(arg0: &TreasuryCapReclaimer<T0>) : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId {
        arg0.token_id
    }

    public(friend) fun create<T0>(arg0: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id::TokenId, arg1: &mut 0x2::tx_context::TxContext) : TreasuryCapReclaimer<T0> {
        TreasuryCapReclaimer<T0>{
            id       : 0x2::object::new(arg1),
            token_id : arg0,
        }
    }

    public(friend) fun destroy<T0>(arg0: TreasuryCapReclaimer<T0>) {
        let TreasuryCapReclaimer {
            id       : v0,
            token_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

