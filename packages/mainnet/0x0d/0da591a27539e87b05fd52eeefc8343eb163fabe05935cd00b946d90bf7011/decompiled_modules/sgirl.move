module 0xd0da591a27539e87b05fd52eeefc8343eb163fabe05935cd00b946d90bf7011::sgirl {
    struct SGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<SGIRL>(arg0, 14414303004122147886, b"Suigirl", b"Sgirl", b"Edgy water girl", b"https://images.hop.ag/ipfs/QmdxZGKHxVW1xo8RCphpBKLdNd82HmcWQRvTSa3ooRi9ZS", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

