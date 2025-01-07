module 0x8ae4e1230e7a8f136f07a7273a8811991af4f00e18bfc26d48f1f530244ca433::bgsn {
    struct BGSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGSN, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BGSN>(arg0, 749673463245133832, b"Big Snake", b"BGSN", b"Fun new cryptocurrency with a snake theme", b"https://images.hop.ag/ipfs/QmY2KLW2YRsyuDst6vLgdijjc8TQxAkorcV8wZZJhGRtkQ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

