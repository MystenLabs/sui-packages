module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::trusted_chains {
    struct TrustedChain has drop, store {
        dummy_field: bool,
    }

    struct TrustedChains has store {
        trusted_chains: 0x2::bag::Bag,
    }

    public(friend) fun add(arg0: &mut TrustedChains, arg1: 0x1::ascii::String) {
        assert!(0x1::ascii::length(&arg1) > 0, 13906834346142072833);
        assert!(!0x2::bag::contains<0x1::ascii::String>(&arg0.trusted_chains, arg1), 13906834350437171203);
        let v0 = TrustedChain{dummy_field: false};
        0x2::bag::add<0x1::ascii::String, TrustedChain>(&mut arg0.trusted_chains, arg1, v0);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::trusted_chain_added(arg1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TrustedChains {
        TrustedChains{trusted_chains: 0x2::bag::new(arg0)}
    }

    public(friend) fun remove(arg0: &mut TrustedChains, arg1: 0x1::ascii::String) {
        assert!(0x1::ascii::length(&arg1) > 0, 13906834380501811201);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.trusted_chains, arg1), 13906834384797040645);
        0x2::bag::remove<0x1::ascii::String, TrustedChain>(&mut arg0.trusted_chains, arg1);
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::events::trusted_chain_removed(arg1);
    }

    public(friend) fun is_trusted(arg0: &TrustedChains, arg1: 0x1::ascii::String) : bool {
        0x2::bag::contains<0x1::ascii::String>(&arg0.trusted_chains, arg1)
    }

    // decompiled from Move bytecode v6
}

