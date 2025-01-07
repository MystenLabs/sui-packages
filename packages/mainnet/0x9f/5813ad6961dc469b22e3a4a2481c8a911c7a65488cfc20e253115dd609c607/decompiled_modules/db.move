module 0x9f5813ad6961dc469b22e3a4a2481c8a911c7a65488cfc20e253115dd609c607::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<DB>(arg0, 11884817143325997329, b"DataBunnyLLC", b"DB", b"The token representing DataBunnyLLC, a MSP startup based near Chicago. We aim to provide and maintain networking solutions to small and medium sized businesses in the Chicago area.", b"https://images.hop.ag/ipfs/QmQyBMs9nJJbPPR2tpwrStyr8RJzB2SRYDejfWQKEbRDPD", 0x1::string::utf8(b"https://x.com/DataBunnyLLC"), 0x1::string::utf8(b"https://www.databunnyllc.org"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

