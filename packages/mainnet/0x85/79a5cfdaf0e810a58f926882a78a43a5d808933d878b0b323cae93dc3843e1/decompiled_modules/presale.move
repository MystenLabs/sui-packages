module 0x8579a5cfdaf0e810a58f926882a78a43a5d808933d878b0b323cae93dc3843e1::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        raised: u64,
        presale_tokens: 0x2::coin::Coin<T0>,
    }

    public entry fun create<T0: drop + store + key>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id             : 0x2::object::new(arg2),
            raised         : 0,
            presale_tokens : 0x2::coin::mint<T0>(arg0, arg1, arg2),
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

