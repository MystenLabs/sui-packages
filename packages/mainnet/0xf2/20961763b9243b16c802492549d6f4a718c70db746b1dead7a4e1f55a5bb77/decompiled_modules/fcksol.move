module 0xf220961763b9243b16c802492549d6f4a718c70db746b1dead7a4e1f55a5bb77::fcksol {
    struct FCKSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKSOL>(arg0, 6, b"fcksol", b"Fuck Sol", b"Fuck Sol, SUI Supremacy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmTPxkdrNWGsdxYrFuQ2vVqWbq34UHkkfpH5VrKX3Sdc52")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<FCKSOL>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<FCKSOL>(14505670495211954466, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

