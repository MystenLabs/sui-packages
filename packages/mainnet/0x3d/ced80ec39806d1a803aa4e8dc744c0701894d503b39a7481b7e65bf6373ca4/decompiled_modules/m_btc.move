module 0x3dced80ec39806d1a803aa4e8dc744c0701894d503b39a7481b7e65bf6373ca4::m_btc {
    struct M_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_BTC>(arg0, 6, b"M-BTC", b"Merlin BTC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<M_BTC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

