module 0x32a59b9af13639981831decfb88789c43767cd69338c7b5dd0d042f779812763::bib {
    struct BIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIB, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BIB>(arg0, 15532969658813099559, b"Bibbi", b"$Bib", b"The cutest bird to be ever found", b"https://images.hop.ag/ipfs/QmP16XDHd1aozn2sUB6BBtSd9yCQUnjfYFFRxyGtEhGCnu", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

