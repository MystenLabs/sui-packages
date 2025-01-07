module 0x6e639ae87f4383f6f7ffabdbe19696115a399dd99de2e516fe1c8af398528373::peace {
    struct Guardian<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct PEACE has drop {
        dummy_field: bool,
    }

    public fun create_guardian<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : Guardian<T0> {
        Guardian<T0>{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_guardian<PEACE>(arg0, arg1);
        0x2::transfer::transfer<Guardian<PEACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

