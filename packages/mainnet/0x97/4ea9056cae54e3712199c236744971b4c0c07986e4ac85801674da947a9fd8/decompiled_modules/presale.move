module 0x974ea9056cae54e3712199c236744971b4c0c07986e4ac85801674da947a9fd8::presale {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        raised: u64,
    }

    public entry fun create<T0: drop + store + key>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Presale<T0>{
            id     : 0x2::object::new(arg0),
            raised : 0,
        };
        0x2::transfer::transfer<Presale<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

