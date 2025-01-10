module 0x5ef40f3f04ef9373e1238fd59192a3f9787940f8f2232571fc9092021bfce27::test_one {
    struct Pipisa has store, key {
        id: 0x2::object::UID,
        length: u64,
        width: u64,
    }

    public entry fun grow_pipisa(arg0: &mut Pipisa, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) / 100000000;
        arg0.length = arg0.length + v0;
        arg0.width = arg0.width + v0 / 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::address::from_u256(21191008618190185438256436847326602874326757637836654303888079732481058468383));
    }

    public entry fun mint_pipisa(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pipisa{
            id     : 0x2::object::new(arg0),
            length : 10,
            width  : 3,
        };
        0x2::transfer::public_transfer<Pipisa>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

