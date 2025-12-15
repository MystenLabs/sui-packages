module 0x28f8e20305d415d6e99c6333ce89bbe28a5177359b9c51e5d9917e530309b34e::contador {
    struct Contador has store, key {
        id: 0x2::object::UID,
        valor: u64,
    }

    public fun aidcionar(arg0: &mut Contador) {
        arg0.valor = arg0.valor + 1;
    }

    public fun criar(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Contador{
            id    : 0x2::object::new(arg0),
            valor : 0,
        };
        0x2::transfer::public_transfer<Contador>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

