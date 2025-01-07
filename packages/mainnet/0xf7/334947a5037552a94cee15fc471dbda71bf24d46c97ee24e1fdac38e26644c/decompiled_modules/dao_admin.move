module 0xf7334947a5037552a94cee15fc471dbda71bf24d46c97ee24e1fdac38e26644c::dao_admin {
    struct DaoAdmin<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) : DaoAdmin<T0> {
        DaoAdmin<T0>{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

