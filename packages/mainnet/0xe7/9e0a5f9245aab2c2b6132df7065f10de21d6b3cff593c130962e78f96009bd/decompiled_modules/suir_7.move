module 0xe79e0a5f9245aab2c2b6132df7065f10de21d6b3cff593c130962e78f96009bd::suir_7 {
    struct SUIR_7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIR_7, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SUIR_7>(arg0, 12840051278318683000, b"Suinaldo", b"SUIR7", b"THE TOP SCORER LAND ON CHAIN", b"https://images.hop.ag/ipfs/QmbamQpcyo5YJ5s9XihCYDxSiVbtXpt8VAXWV4TBM8p7i2", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

