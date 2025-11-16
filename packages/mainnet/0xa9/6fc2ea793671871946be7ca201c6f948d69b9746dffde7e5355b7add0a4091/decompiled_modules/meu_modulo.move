module 0xa96fc2ea793671871946be7ca201c6f948d69b9746dffde7e5355b7add0a4091::meu_modulo {
    struct MeuObjeto has store, key {
        id: 0x2::object::UID,
        numero: u64,
    }

    public entry fun mintar(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MeuObjeto{
            id     : 0x2::object::new(arg0),
            numero : 1,
        };
        0x2::transfer::transfer<MeuObjeto>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

