module 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin {
    struct OutcomeCoin has key {
        id: 0x2::object::UID,
    }

    public fun new_outcome_coin(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<OutcomeCoin>, 0x2::coin_registry::MetadataCap<OutcomeCoin>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<OutcomeCoin>(arg0, 6, 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"https://example.com/outcomea.png"), arg1);
        (v1, 0x2::coin_registry::finalize<OutcomeCoin>(v0, arg1))
    }

    // decompiled from Move bytecode v6
}

