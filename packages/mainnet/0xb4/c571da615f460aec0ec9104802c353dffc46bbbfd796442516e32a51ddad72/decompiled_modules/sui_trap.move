module 0xb4c571da615f460aec0ec9104802c353dffc46bbbfd796442516e32a51ddad72::sui_trap {
    struct Container has key {
        id: 0x2::object::UID,
        held: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun always_abort() {
        abort 13897264291423191041
    }

    public entry fun wrap_and_send(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{
            id   : 0x2::object::new(arg2),
            held : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<Container>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

