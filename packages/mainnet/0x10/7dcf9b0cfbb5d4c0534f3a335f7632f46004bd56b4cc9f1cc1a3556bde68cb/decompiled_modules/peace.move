module 0x107dcf9b0cfbb5d4c0534f3a335f7632f46004bd56b4cc9f1cc1a3556bde68cb::peace {
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

