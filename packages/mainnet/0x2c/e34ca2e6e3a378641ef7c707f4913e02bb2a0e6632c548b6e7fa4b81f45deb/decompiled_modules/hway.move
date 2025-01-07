module 0x2ce34ca2e6e3a378641ef7c707f4913e02bb2a0e6632c548b6e7fa4b81f45deb::hway {
    struct HWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HWAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<HWAY>(arg0, 12967821721788830190, b"HOPFROG WHERE ARE YOU", b"HWAY", b"HOPFROG WHERE ARE YOU", b"https://images.hop.ag/ipfs/QmS5NNTaNcD6MoMPk5VWCaoCiEV6hhoYPF5DDDKrKmiETg", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

