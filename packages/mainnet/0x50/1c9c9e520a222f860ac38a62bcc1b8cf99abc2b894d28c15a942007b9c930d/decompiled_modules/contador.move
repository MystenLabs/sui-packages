module 0x501c9c9e520a222f860ac38a62bcc1b8cf99abc2b894d28c15a942007b9c930d::contador {
    struct Contador has store, key {
        id: 0x2::object::UID,
        valor: u64,
    }

    public fun aidcionar(arg0: &mut Contador) {
        arg0.valor = arg0.valor + 1;
    }

    public fun criar(arg0: &mut 0x2::tx_context::TxContext) : Contador {
        Contador{
            id    : 0x2::object::new(arg0),
            valor : 0,
        }
    }

    // decompiled from Move bytecode v6
}

