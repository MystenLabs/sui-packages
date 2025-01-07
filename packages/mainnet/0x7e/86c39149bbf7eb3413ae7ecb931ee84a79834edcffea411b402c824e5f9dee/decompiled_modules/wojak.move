module 0x7e86c39149bbf7eb3413ae7ecb931ee84a79834edcffea411b402c824e5f9dee::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<WOJAK>(arg0, 13233678394842689780, b"wojak", b"wojak", b"Wojak is back on sui", b"https://images.hop.ag/ipfs/QmRUWfPZGvSjYnPFiFgphZedfyS8dVNg8Rq7Dcv8d48HsP", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

