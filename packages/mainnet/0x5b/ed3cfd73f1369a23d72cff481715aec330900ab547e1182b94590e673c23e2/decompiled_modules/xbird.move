module 0x5bed3cfd73f1369a23d72cff481715aec330900ab547e1182b94590e673c23e2::xbird {
    struct XBIRD has drop {
        dummy_field: bool,
    }

    fun createPegToken<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        0x2::coin::create_currency<T0>(arg0, 6, b"XBIRD", b"XBIRD", b"Closed Loop Token of BIRDS", 0x1::option::none<0x2::url::Url>(), arg1)
    }

    fun init(arg0: XBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = createPegToken<XBIRD>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XBIRD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

