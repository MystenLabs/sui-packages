module 0x50ca4284132926d9b278e694cb50cbe64752d4683169cdeb98e105cc85c51858::dgem {
    struct DGEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGEM, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DGEM>(arg0, 13267477776377243805, b"Dovegem", b"DGEM ", b"An adorable cat visits the planet earth with bags of gems for all and sundry", b"https://images.hop.ag/ipfs/QmRudSJViyqpYQHhAED7DKxEoUFMFGxSXL2CpQQPSjRqw1", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

