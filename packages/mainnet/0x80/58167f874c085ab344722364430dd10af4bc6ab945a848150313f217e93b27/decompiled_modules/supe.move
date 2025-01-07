module 0x8058167f874c085ab344722364430dd10af4bc6ab945a848150313f217e93b27::supe {
    struct SUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUPE>(arg0, 16105110192884003654, b"Supe", b"Supe", b"Pepe's crazy Uncle.", b"https://images.hop.ag/ipfs/QmVTdGQgnR3yih2NnNH6R9pnMgVAUaXnhuZRJ6oedCSFc6", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

