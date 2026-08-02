module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_owner_proof_v6 {
    struct AnimacraftSoulOwnerProofV6 has drop {
        soul_id: 0x2::object::ID,
        soul_state_id: 0x2::object::ID,
        owner: address,
        ownership_epoch: u64,
    }

    public(friend) fun new(arg0: &0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState, arg1: &0x2::tx_context::TxContext) : AnimacraftSoulOwnerProofV6 {
        0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::assert_owner(arg0, 0x2::tx_context::sender(arg1));
        assert!(!0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::is_listed(arg0), 0);
        AnimacraftSoulOwnerProofV6{
            soul_id         : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::soul_id(arg0),
            soul_state_id   : 0x2::object::id<0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::SoulState>(arg0),
            owner           : 0x2::tx_context::sender(arg1),
            ownership_epoch : 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::soul::ownership_epoch(arg0),
        }
    }

    public fun owner(arg0: &AnimacraftSoulOwnerProofV6) : address {
        arg0.owner
    }

    public fun ownership_epoch(arg0: &AnimacraftSoulOwnerProofV6) : u64 {
        arg0.ownership_epoch
    }

    public fun soul_id(arg0: &AnimacraftSoulOwnerProofV6) : 0x2::object::ID {
        arg0.soul_id
    }

    public fun soul_state_id(arg0: &AnimacraftSoulOwnerProofV6) : 0x2::object::ID {
        arg0.soul_state_id
    }

    // decompiled from Move bytecode v7
}

