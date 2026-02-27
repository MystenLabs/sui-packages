module 0xd85b585358a3832e91b09e364e57051d52f21123c51ec9b61584ed09e2905852::auth {
    struct EscrowAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new() : EscrowAuth {
        EscrowAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

