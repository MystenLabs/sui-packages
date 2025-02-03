module 0x6d2c0ee013f266f9b9f088cb830292d24cec816a4461be3e0e61459e7e4e796::xbird {
    struct XBIRD has drop {
        dummy_field: bool,
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"Closed Loop Token of BIRDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://birds.dog/logo.svg"))), arg1)
    }

    fun init(arg0: XBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = createPegToken<XBIRD>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XBIRD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

