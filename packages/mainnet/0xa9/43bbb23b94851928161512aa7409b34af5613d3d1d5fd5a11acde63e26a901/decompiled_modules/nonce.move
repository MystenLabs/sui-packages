module 0xa8f7b7893fd8edb8510b98e0cf19e9ea27b714c861113c79ca062ef96b2b378d::nonce {
    struct Nonce has key {
        id: 0x2::object::UID,
        counter: u64,
    }

    public fun bump(arg0: &mut Nonce) {
        arg0.counter = arg0.counter + 1;
    }

    public fun counter(arg0: &Nonce) : u64 {
        arg0.counter
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Nonce{
            id      : 0x2::object::new(arg0),
            counter : 0,
        };
        0x2::transfer::transfer<Nonce>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

