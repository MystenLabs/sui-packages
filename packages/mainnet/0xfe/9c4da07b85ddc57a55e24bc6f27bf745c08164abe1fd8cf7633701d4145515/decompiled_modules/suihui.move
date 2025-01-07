module 0xfe9c4da07b85ddc57a55e24bc6f27bf745c08164abe1fd8cf7633701d4145515::suihui {
    struct SUIHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUI>(arg0, 6, b"SUIHUI", b"SUIHUI", b"The first $HUI on $SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/Qmc7VRGYen2ZET1Vi1gf5punGbL2EQCH7vzYvwSiFcvKhn")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIHUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIHUI>(10315162492215444439, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

