module 0x83c8964934a1b273087681033eaa62c9ad2e85fed05aa22a5e508fd9e1215a40::coin {
    struct Outcome has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<Outcome>, 0x2::coin_registry::MetadataCap<Outcome>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<Outcome>(arg0, 6, 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"OutcomeA"), 0x1::string::utf8(b"https://example.com/outcomea.png"), arg1);
        (v1, 0x2::coin_registry::finalize<Outcome>(v0, arg1))
    }

    // decompiled from Move bytecode v6
}

