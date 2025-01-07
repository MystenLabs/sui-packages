module 0x1a7c64b53d4d8b14a541c62108ba8ca1333f55db9c44917e83173400a1e59cd2::sin {
    struct SIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SIN>(arg0, 17570229810745224049, b"STRANGERS IN THE NIGHT", b"SIN", x"f09f92b2", b"https://images.hop.ag/ipfs/QmdezcRvnkrazLE2aFUYqDE1PR5ad6XzEsThKHTixvFGW3", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

