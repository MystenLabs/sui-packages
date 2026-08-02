module 0xa43cc9a94caa904a97316d97c08804369ee8fbe3335d2ddae154022d7d6e5d5d::animacraft_soul_binding_v5 {
    struct AnimacraftSoulBindingProofV5 has drop {
        minted_by_soulidity: bool,
    }

    public(friend) fun new() : AnimacraftSoulBindingProofV5 {
        AnimacraftSoulBindingProofV5{minted_by_soulidity: true}
    }

    // decompiled from Move bytecode v7
}

